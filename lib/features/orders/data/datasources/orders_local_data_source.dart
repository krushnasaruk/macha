import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

class OrdersLocalDataSource {
  final AppDatabase _db;

  OrdersLocalDataSource(this._db);

  Stream<List<OrdersTableData>> watchOrders({
    required String branchId,
    String? statusFilter,
    DateTime? fromDate,
    DateTime? toDate,
    String? searchQuery,
  }) {
    var query = _db.select(_db.ordersTable)..where((o) => o.branchId.equals(branchId));

    if (statusFilter != null && statusFilter.isNotEmpty) {
      query = query..where((o) => o.status.equals(statusFilter));
    }

    if (fromDate != null) {
      query = query..where((o) => o.createdAt.isBiggerOrEqualValue(fromDate));
    }

    if (toDate != null) {
      query = query..where((o) => o.createdAt.isSmallerOrEqualValue(toDate));
    }

    query = query..orderBy([(o) => OrderingTerm.desc(o.createdAt)]);

    return query.watch().map((orders) {
      if (searchQuery == null || searchQuery.trim().isEmpty) return orders;
      final q = searchQuery.toLowerCase().trim();
      return orders.where((o) {
        final orderNum = o.orderNumber.toLowerCase();
        final customerName = o.customerName?.toLowerCase() ?? '';
        final phone = o.customerPhone ?? '';
        return orderNum.contains(q) || customerName.contains(q) || phone.contains(q);
      }).toList();
    });
  }

  Future<OrdersTableData?> getOrderById(String orderId) {
    return (_db.select(_db.ordersTable)..where((o) => o.id.equals(orderId))).getSingleOrNull();
  }

  Future<List<OrderItemsTableData>> getOrderItems(String orderId) {
    return (_db.select(_db.orderItemsTable)..where((i) => i.orderId.equals(orderId))).get();
  }

  Future<List<OrderItemModifiersTableData>> getOrderItemModifiers(String orderItemId) {
    return (_db.select(_db.orderItemModifiersTable)..where((m) => m.orderItemId.equals(orderItemId))).get();
  }

  Future<List<OrderStatusHistoryTableData>> getOrderStatusHistory(String orderId) {
    return (_db.select(_db.orderStatusHistoryTable)
          ..where((h) => h.orderId.equals(orderId))
          ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
        .get();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    required DateTime updatedAt,
  }) async {
    await (_db.update(_db.ordersTable)..where((o) => o.id.equals(orderId))).write(
      OrdersTableCompanion(
        status: Value(status),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<void> insertStatusHistory(OrderStatusHistoryTableCompanion entry) {
    return _db.into(_db.orderStatusHistoryTable).insert(entry);
  }

  Future<void> updateOrderItemStatus({
    required String orderItemId,
    required String status,
  }) async {
    await (_db.update(_db.orderItemsTable)..where((i) => i.id.equals(orderItemId))).write(
      OrderItemsTableCompanion(
        status: Value(status),
      ),
    );
  }

  Stream<List<OrdersTableData>> watchKitchenOrders(String branchId) {
    return (_db.select(_db.ordersTable)
          ..where((o) =>
              o.branchId.equals(branchId) &
              o.status.isIn(['confirmed', 'preparing', 'ready']))
          ..orderBy([(o) => OrderingTerm.asc(o.createdAt)]))
        .watch();
  }
}
