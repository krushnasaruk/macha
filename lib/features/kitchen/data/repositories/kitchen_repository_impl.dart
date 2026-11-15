import 'package:cafe_os/features/kitchen/data/datasources/kitchen_local_data_source.dart';
import 'package:cafe_os/features/kitchen/domain/repositories/kitchen_repository.dart';
import 'package:cafe_os/features/orders/domain/models/order_and_table_models.dart';
import 'package:cafe_os/features/orders/domain/repositories/orders_repository.dart';
import 'package:cafe_os/features/orders/domain/state_machine/order_lifecycle.dart';

class KitchenRepositoryImpl implements KitchenRepository {
  final KitchenLocalDataSource _localDataSource;
  final OrdersRepository _ordersRepository;

  KitchenRepositoryImpl({
    required KitchenLocalDataSource localDataSource,
    required OrdersRepository ordersRepository,
  })  : _localDataSource = localDataSource,
        _ordersRepository = ordersRepository;

  @override
  Stream<List<KitchenStation>> watchStations(String branchId) {
    return _localDataSource.watchStations(branchId).map(
          (list) => list
              .map(
                (s) => KitchenStation(
                  id: s.id,
                  tenantId: s.tenantId,
                  branchId: s.branchId,
                  name: s.name,
                  code: s.code,
                  isActive: s.isActive,
                  sortOrder: s.sortOrder,
                ),
              )
              .toList(),
        );
  }

  @override
  Stream<List<KitchenTicket>> watchTickets({
    required String branchId,
    String? stationId,
  }) {
    return _localDataSource.watchKitchenOrders(branchId).asyncMap((orders) async {
      final List<KitchenTicket> tickets = [];

      for (final o in orders) {
        String? tableName;
        if (o.tableId != null) {
          final table = await _localDataSource.getTable(o.tableId!);
          tableName = table?.name;
        }

        final itemsData = await _localDataSource.getOrderItems(o.id);
        final List<KitchenTicketItem> ticketItems = [];

        for (final item in itemsData) {
          // Check station routing if stationId specified
          if (stationId != null) {
            final itemStationId = await _localDataSource.getProductStationId(item.productId);
            if (itemStationId != null && itemStationId != stationId) {
              continue; // Skip item not routed to this station
            }
          }

          final mods = await _localDataSource.getItemModifiers(item.id);
          ticketItems.add(
            KitchenTicketItem(
              orderItemId: item.id,
              productId: item.productId,
              productName: item.productName,
              quantity: item.quantity,
              variantName: item.variantName,
              modifierNames: mods.map((m) => m.modifierName).toList(),
              notes: item.notes,
              isReady: item.status == 'ready',
            ),
          );
        }

        if (ticketItems.isNotEmpty) {
          tickets.add(
            KitchenTicket(
              orderId: o.id,
              orderNumber: o.orderNumber,
              tableId: o.tableId,
              tableName: tableName,
              orderType: o.orderType,
              status: OrderLifecycleStatus.fromString(o.status),
              createdAt: o.createdAt,
              items: ticketItems,
              notes: o.notes,
              stationId: stationId,
            ),
          );
        }
      }

      return tickets;
    });
  }

  @override
  Future<void> bumpTicket({
    required String orderId,
    required OrderLifecycleStatus targetStatus,
    required String changedBy,
  }) async {
    await _ordersRepository.updateOrderStatus(
      orderId: orderId,
      newStatus: targetStatus,
      changedBy: changedBy,
      notes: 'Bumped in Kitchen Display',
    );
  }

  @override
  Future<void> recallTicket({
    required String orderId,
    required OrderLifecycleStatus previousStatus,
    required String changedBy,
  }) async {
    await _ordersRepository.updateOrderStatus(
      orderId: orderId,
      newStatus: previousStatus,
      changedBy: changedBy,
      notes: 'Recalled in Kitchen Display',
    );
  }

  @override
  Future<void> toggleItemReady({
    required String orderItemId,
    required bool isReady,
  }) async {
    await _localDataSource.updateOrderItemReady(orderItemId, isReady);
  }
}
