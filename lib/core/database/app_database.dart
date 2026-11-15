import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'connection/connection.dart' as impl;
import 'tables/billing_tables.dart';
import 'tables/menu_tables.dart';
import 'tables/platform_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/table_and_kitchen_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  SyncOutboxTable,
  SyncStateTable,
  AppConfigTable,
  TenantsTable,
  TenantSettingsTable,
  BranchesTable,
  EmployeesTable,
  DevicesTable,
  AuditLogsTable,
  CategoriesTable,
  TaxCategoriesTable,
  ProductsTable,
  ProductVariantsTable,
  ModifierGroupsTable,
  ModifiersTable,
  ProductModifierGroupsTable,
  ProductBranchAvailabilityTable,
  OrdersTable,
  OrderItemsTable,
  OrderItemModifiersTable,
  InvoicesTable,
  PaymentsTable,
  RefundsTable,
  CashSessionsTable,
  CashMovementsTable,
  CartHoldTable,
  DiningTablesTable,
  TableSessionsTable,
  KitchenStationsTable,
  ProductStationRoutingTable,
  OrderStatusHistoryTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? impl.connect());

  /// In-memory constructor for unit tests.
  AppDatabase.memory(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Schema migrations will be handled here sequentially.
      },
    );
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
