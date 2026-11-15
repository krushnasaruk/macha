import 'package:drift/drift.dart';

@DataClassName('DiningTablesTableData')
class DiningTablesTable extends Table {
  @override
  String get tableName => 'dining_tables';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get name => text()();
  IntColumn get capacity => integer().withDefault(const Constant(4))();
  TextColumn get floorZone => text().withDefault(const Constant('indoor'))();
  TextColumn get status => text().withDefault(const Constant('vacant'))(); // vacant, occupied, billed, reserved
  TextColumn get currentSessionId => text().nullable()();
  TextColumn get qrToken => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TableSessionsTableData')
class TableSessionsTable extends Table {
  @override
  String get tableName => 'table_sessions';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get tableId => text()();
  IntColumn get guestCount => integer().withDefault(const Constant(2))();
  TextColumn get status => text().withDefault(const Constant('active'))(); // active, settled, closed
  TextColumn get openedBy => text()();
  TextColumn get closedBy => text().nullable()();
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('KitchenStationsTableData')
class KitchenStationsTable extends Table {
  @override
  String get tableName => 'kitchen_stations';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get name => text()(); // e.g. Espresso Bar, Bakery, Hot Kitchen
  TextColumn get code => text()(); // BAR, BAKE, HOT
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProductStationRoutingTableData')
class ProductStationRoutingTable extends Table {
  @override
  String get tableName => 'product_station_routing';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get productId => text()();
  TextColumn get stationId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrderStatusHistoryTableData')
class OrderStatusHistoryTable extends Table {
  @override
  String get tableName => 'order_status_history';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get tenantId => text()();
  TextColumn get fromStatus => text()();
  TextColumn get toStatus => text()();
  TextColumn get changedBy => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
