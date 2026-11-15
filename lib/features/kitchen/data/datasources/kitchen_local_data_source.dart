import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

class KitchenLocalDataSource {
  final AppDatabase _db;

  KitchenLocalDataSource(this._db);

  Stream<List<KitchenStationsTableData>> watchStations(String branchId) {
    return (_db.select(_db.kitchenStationsTable)
          ..where((s) => s.branchId.equals(branchId) & s.isActive.equals(true))
          ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]))
        .watch();
  }

  Future<List<KitchenStationsTableData>> getStations(String branchId) {
    return (_db.select(_db.kitchenStationsTable)
          ..where((s) => s.branchId.equals(branchId) & s.isActive.equals(true))
          ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]))
        .get();
  }

  Future<void> upsertStation(KitchenStationsTableCompanion station) {
    return _db.into(_db.kitchenStationsTable).insertOnConflictUpdate(station);
  }

  Stream<List<OrdersTableData>> watchKitchenOrders(String branchId) {
    return (_db.select(_db.ordersTable)
          ..where((o) =>
              o.branchId.equals(branchId) &
              o.status.isIn(['confirmed', 'preparing', 'ready']))
          ..orderBy([(o) => OrderingTerm.asc(o.createdAt)]))
        .watch();
  }

  Future<List<OrderItemsTableData>> getOrderItems(String orderId) {
    return (_db.select(_db.orderItemsTable)..where((i) => i.orderId.equals(orderId))).get();
  }

  Future<List<OrderItemModifiersTableData>> getItemModifiers(String orderItemId) {
    return (_db.select(_db.orderItemModifiersTable)..where((m) => m.orderItemId.equals(orderItemId))).get();
  }

  Future<String?> getProductStationId(String productId) async {
    final route = await (_db.select(_db.productStationRoutingTable)
          ..where((r) => r.productId.equals(productId)))
        .getSingleOrNull();
    return route?.stationId;
  }

  Future<void> updateOrderItemReady(String orderItemId, bool isReady) async {
    await (_db.update(_db.orderItemsTable)..where((i) => i.id.equals(orderItemId))).write(
      OrderItemsTableCompanion(
        status: Value(isReady ? 'ready' : 'preparing'),
      ),
    );
  }

  Future<DiningTablesTableData?> getTable(String tableId) {
    return (_db.select(_db.diningTablesTable)..where((t) => t.id.equals(tableId))).getSingleOrNull();
  }
}
