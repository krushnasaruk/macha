import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

class TableLocalDataSource {
  final AppDatabase _db;

  TableLocalDataSource(this._db);

  Stream<List<DiningTablesTableData>> watchTables(String branchId) {
    return (_db.select(_db.diningTablesTable)
          ..where((t) => t.branchId.equals(branchId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<List<DiningTablesTableData>> getTables(String branchId) {
    return (_db.select(_db.diningTablesTable)
          ..where((t) => t.branchId.equals(branchId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Future<DiningTablesTableData?> getTable(String tableId) {
    return (_db.select(_db.diningTablesTable)..where((t) => t.id.equals(tableId)))
        .getSingleOrNull();
  }

  Future<void> upsertTable(DiningTablesTableCompanion table) {
    return _db.into(_db.diningTablesTable).insertOnConflictUpdate(table);
  }

  Future<void> updateTableStatus(
    String tableId,
    String status, {
    Value<String?> currentSessionId = const Value.absent(),
  }) async {
    await (_db.update(_db.diningTablesTable)..where((t) => t.id.equals(tableId))).write(
      DiningTablesTableCompanion(
        status: Value(status),
        currentSessionId: currentSessionId,
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> createSession(TableSessionsTableCompanion session) {
    return _db.into(_db.tableSessionsTable).insert(session);
  }

  Future<TableSessionsTableData?> getSession(String sessionId) {
    return (_db.select(_db.tableSessionsTable)..where((s) => s.id.equals(sessionId)))
        .getSingleOrNull();
  }

  Future<TableSessionsTableData?> getActiveSession(String tableId) {
    return (_db.select(_db.tableSessionsTable)
          ..where((s) => s.tableId.equals(tableId) & s.status.equals('active')))
        .getSingleOrNull();
  }

  Future<void> closeSession(String sessionId, String closedBy, DateTime closedAt) async {
    await (_db.update(_db.tableSessionsTable)..where((s) => s.id.equals(sessionId))).write(
      TableSessionsTableCompanion(
        status: const Value('closed'),
        closedBy: Value(closedBy),
        closedAt: Value(closedAt),
      ),
    );
  }
}
