import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../domain/models/order_and_table_models.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/state_machine/order_lifecycle.dart';
import '../datasources/orders_local_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final AppDatabase _db;
  final OrdersLocalDataSource _localDataSource;
  final Uuid _uuid;

  OrdersRepositoryImpl({
    required AppDatabase db,
    required OrdersLocalDataSource localDataSource,
    Uuid? uuid,
  })  : _db = db,
        _localDataSource = localDataSource,
        _uuid = uuid ?? const Uuid();

  Future<OrderSummary> _buildOrderSummary(OrdersTableData o) async {
    final itemsData = await _localDataSource.getOrderItems(o.id);
    final historyData = await _localDataSource.getOrderStatusHistory(o.id);

    // Get Table name if tableId present
    String? tableName;
    if (o.tableId != null) {
      final table = await (_db.select(_db.diningTablesTable)..where((t) => t.id.equals(o.tableId!))).getSingleOrNull();
      tableName = table?.name;
    }

    // Build items
    final List<OrderItemSummary> items = [];
    for (final item in itemsData) {
      final mods = await _localDataSource.getOrderItemModifiers(item.id);
      items.add(
        OrderItemSummary(
          id: item.id,
          productId: item.productId,
          productName: item.productName,
          variantName: item.variantName,
          quantity: item.quantity,
          unitPricePaise: item.unitPricePaise,
          lineTotalPaise: item.lineTotalPaise,
          notes: item.notes,
          status: item.status,
          modifierNames: mods.map((m) => m.modifierName).toList(),
        ),
      );
    }

    // Build history
    final history = historyData
        .map(
          (h) => OrderStatusHistoryEntry(
            id: h.id,
            orderId: h.orderId,
            fromStatus: OrderLifecycleStatus.fromString(h.fromStatus),
            toStatus: OrderLifecycleStatus.fromString(h.toStatus),
            changedBy: h.changedBy,
            notes: h.notes,
            createdAt: h.createdAt,
          ),
        )
        .toList();

    return OrderSummary(
      id: o.id,
      tenantId: o.tenantId,
      branchId: o.branchId,
      orderNumber: o.orderNumber,
      orderType: o.orderType,
      status: OrderLifecycleStatus.fromString(o.status),
      source: o.source,
      tableId: o.tableId,
      tableName: tableName,
      customerName: o.customerName,
      customerPhone: o.customerPhone,
      notes: o.notes,
      subtotalPaise: o.subtotalPaise,
      discountPaise: o.discountPaise,
      taxPaise: o.taxPaise,
      roundingPaise: o.roundingPaise,
      finalTotalPaise: o.finalTotalPaise,
      createdBy: o.createdBy,
      createdAt: o.createdAt,
      updatedAt: o.updatedAt,
      items: items,
      history: history,
    );
  }

  @override
  Stream<List<OrderSummary>> watchOrders({
    required String branchId,
    OrderLifecycleStatus? statusFilter,
    DateTime? fromDate,
    DateTime? toDate,
    String? searchQuery,
  }) {
    return _localDataSource
        .watchOrders(
          branchId: branchId,
          statusFilter: statusFilter?.name,
          fromDate: fromDate,
          toDate: toDate,
          searchQuery: searchQuery,
        )
        .asyncMap((orders) async {
          final summaries = await Future.wait(orders.map(_buildOrderSummary));
          return summaries;
        });
  }

  @override
  Future<OrderSummary?> getOrder(String orderId) async {
    final order = await _localDataSource.getOrderById(orderId);
    if (order == null) return null;
    return _buildOrderSummary(order);
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderLifecycleStatus newStatus,
    required String changedBy,
    String? notes,
  }) async {
    final order = await _localDataSource.getOrderById(orderId);
    if (order == null) throw const NotFoundFailure('Order not found');

    final currentStatus = OrderLifecycleStatus.fromString(order.status);
    OrderLifecycleStateMachine.transition(
      from: currentStatus,
      to: newStatus,
      changedBy: changedBy,
      orderId: orderId,
      notes: notes,
    );

    final now = DateTime.now();
    final opUuid = _uuid.v4();

    await _db.transaction(() async {
      await _localDataSource.updateOrderStatus(
        orderId: orderId,
        status: newStatus.name,
        updatedAt: now,
      );

      final historyId = _uuid.v4();
      await _localDataSource.insertStatusHistory(
        OrderStatusHistoryTableCompanion.insert(
          id: historyId,
          orderId: orderId,
          tenantId: order.tenantId,
          fromStatus: currentStatus.name,
          toStatus: newStatus.name,
          changedBy: changedBy,
          notes: Value(notes),
          createdAt: Value(now),
        ),
      );

      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: order.tenantId,
          branchId: order.branchId,
          operationUuid: opUuid,
          entityType: 'orders',
          entityId: orderId,
          operation: 'UPDATE_STATUS',
          payload: jsonEncode({
            'order_id': orderId,
            'from_status': currentStatus.name,
            'to_status': newStatus.name,
            'changed_by': changedBy,
            'notes': notes,
            'timestamp': now.toIso8601String(),
          }),
          createdAt: now,
        ),
      );
    });
  }

  @override
  Future<void> cancelOrder({
    required String orderId,
    required String reason,
    required String cancelledBy,
  }) async {
    await updateOrderStatus(
      orderId: orderId,
      newStatus: OrderLifecycleStatus.cancelled,
      changedBy: cancelledBy,
      notes: reason,
    );
  }

  @override
  Future<void> updateOrderItemStatus({
    required String orderItemId,
    required String newStatus,
  }) async {
    await _localDataSource.updateOrderItemStatus(
      orderItemId: orderItemId,
      status: newStatus,
    );
  }
}
