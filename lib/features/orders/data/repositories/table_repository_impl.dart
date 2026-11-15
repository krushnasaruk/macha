import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/app_failure.dart';
import '../../domain/models/order_and_table_models.dart';
import '../../domain/repositories/table_repository.dart';
import '../datasources/table_local_data_source.dart';

class TableRepositoryImpl implements TableRepository {
  final AppDatabase _db;
  final TableLocalDataSource _localDataSource;
  final Uuid _uuid;

  TableRepositoryImpl({
    required AppDatabase db,
    required TableLocalDataSource localDataSource,
    Uuid? uuid,
  })  : _db = db,
        _localDataSource = localDataSource,
        _uuid = uuid ?? const Uuid();

  DiningTable _mapToDomain(DiningTablesTableData d) {
    return DiningTable(
      id: d.id,
      tenantId: d.tenantId,
      branchId: d.branchId,
      name: d.name,
      capacity: d.capacity,
      floorZone: TableFloorZone.fromString(d.floorZone),
      status: TableStatus.fromString(d.status),
      currentSessionId: d.currentSessionId,
      qrToken: d.qrToken,
      sortOrder: d.sortOrder,
      createdAt: d.createdAt,
      updatedAt: d.updatedAt,
    );
  }

  @override
  Stream<List<DiningTable>> watchTables(String branchId) {
    return _localDataSource.watchTables(branchId).map(
          (list) => list.map(_mapToDomain).toList(),
        );
  }

  @override
  Future<List<DiningTable>> getTables(String branchId) async {
    final list = await _localDataSource.getTables(branchId);
    return list.map(_mapToDomain).toList();
  }

  @override
  Future<DiningTable?> getTable(String tableId) async {
    final data = await _localDataSource.getTable(tableId);
    if (data == null) return null;
    return _mapToDomain(data);
  }

  @override
  Future<void> saveTable(DiningTable table) async {
    final opUuid = _uuid.v4();
    final now = DateTime.now();

    await _db.transaction(() async {
      await _localDataSource.upsertTable(
        DiningTablesTableCompanion(
          id: Value(table.id),
          tenantId: Value(table.tenantId),
          branchId: Value(table.branchId),
          name: Value(table.name),
          capacity: Value(table.capacity),
          floorZone: Value(table.floorZone.name),
          status: Value(table.status.name),
          currentSessionId: Value(table.currentSessionId),
          qrToken: Value(table.qrToken),
          sortOrder: Value(table.sortOrder),
          createdAt: Value(table.createdAt),
          updatedAt: Value(now),
        ),
      );

      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: table.tenantId,
          branchId: table.branchId,
          operationUuid: opUuid,
          entityType: 'dining_tables',
          entityId: table.id,
          operation: 'UPSERT',
          payload: jsonEncode({
            'id': table.id,
            'tenant_id': table.tenantId,
            'branch_id': table.branchId,
            'name': table.name,
            'capacity': table.capacity,
            'floor_zone': table.floorZone.name,
            'status': table.status.name,
            'current_session_id': table.currentSessionId,
            'qr_token': table.qrToken,
            'sort_order': table.sortOrder,
          }),
          createdAt: now,
        ),
      );
    });
  }

  @override
  Future<TableSession> openSession({
    required String tableId,
    required int guestCount,
    required String openedBy,
    String? notes,
  }) async {
    final table = await _localDataSource.getTable(tableId);
    if (table == null) {
      throw const NotFoundFailure('Table not found');
    }
    if (table.status == TableStatus.occupied.name) {
      throw const ValidationFailure('Table is already occupied');
    }

    final sessionId = _uuid.v4();
    final now = DateTime.now();
    final opUuid = _uuid.v4();

    final session = TableSession(
      id: sessionId,
      tenantId: table.tenantId,
      branchId: table.branchId,
      tableId: table.id,
      guestCount: guestCount,
      status: 'active',
      openedBy: openedBy,
      openedAt: now,
      closedAt: null,
      notes: notes,
    );

    await _db.transaction(() async {
      await _localDataSource.createSession(
        TableSessionsTableCompanion.insert(
          id: sessionId,
          tenantId: table.tenantId,
          branchId: table.branchId,
          tableId: table.id,
          guestCount: Value(guestCount),
          status: const Value('active'),
          openedBy: openedBy,
          openedAt: Value(now),
          notes: Value(notes),
        ),
      );

      await _localDataSource.updateTableStatus(
        table.id,
        TableStatus.occupied.name,
        currentSessionId: Value(sessionId),
      );

      // Enqueue outbox for session
      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: table.tenantId,
          branchId: table.branchId,
          operationUuid: opUuid,
          entityType: 'table_sessions',
          entityId: sessionId,
          operation: 'INSERT',
          payload: jsonEncode({
            'id': sessionId,
            'tenant_id': table.tenantId,
            'branch_id': table.branchId,
            'table_id': table.id,
            'guest_count': guestCount,
            'status': 'active',
            'opened_by': openedBy,
            'opened_at': now.toIso8601String(),
            'notes': notes,
          }),
          createdAt: now,
        ),
      );

      // Enqueue outbox for table status update
      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: table.tenantId,
          branchId: table.branchId,
          operationUuid: _uuid.v4(),
          entityType: 'dining_tables',
          entityId: table.id,
          operation: 'UPDATE',
          payload: jsonEncode({
            'status': TableStatus.occupied.name,
            'current_session_id': sessionId,
          }),
          createdAt: now,
        ),
      );
    });

    return session;
  }

  @override
  Future<void> transferTable({
    required String fromTableId,
    required String toTableId,
    required String performedBy,
  }) async {
    final fromTable = await _localDataSource.getTable(fromTableId);
    if (fromTable == null) throw const NotFoundFailure('Source table not found');
    if (fromTable.status != TableStatus.occupied.name || fromTable.currentSessionId == null) {
      throw const ValidationFailure('Source table is not occupied');
    }

    final toTable = await _localDataSource.getTable(toTableId);
    if (toTable == null) throw const NotFoundFailure('Destination table not found');
    if (toTable.status == TableStatus.occupied.name) {
      throw const ValidationFailure('Destination table is already occupied');
    }

    final now = DateTime.now();
    final sessionId = fromTable.currentSessionId!;

    await _db.transaction(() async {
      // Move session to target table
      await (_db.update(_db.tableSessionsTable)..where((s) => s.id.equals(sessionId))).write(
        TableSessionsTableCompanion(
          tableId: Value(toTableId),
        ),
      );

      // Re-assign active orders
      await (_db.update(_db.ordersTable)
            ..where((o) => o.tableId.equals(fromTableId) & o.status.isNotIn(['completed', 'cancelled'])))
          .write(
        OrdersTableCompanion(
          tableId: Value(toTableId),
          updatedAt: Value(now),
        ),
      );

      // Set source table vacant
      await _localDataSource.updateTableStatus(
        fromTableId,
        TableStatus.vacant.name,
        currentSessionId: const Value(null),
      );

      // Set destination table occupied
      await _localDataSource.updateTableStatus(
        toTableId,
        TableStatus.occupied.name,
        currentSessionId: Value(sessionId),
      );

      // Outbox log
      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: fromTable.tenantId,
          branchId: fromTable.branchId,
          operationUuid: _uuid.v4(),
          entityType: 'table_transfer',
          entityId: sessionId,
          operation: 'TRANSFER',
          payload: jsonEncode({
            'session_id': sessionId,
            'from_table_id': fromTableId,
            'to_table_id': toTableId,
            'performed_by': performedBy,
          }),
          createdAt: now,
        ),
      );
    });
  }

  @override
  Future<void> mergeTables({
    required String sourceTableId,
    required String targetTableId,
    required String performedBy,
  }) async {
    final sourceTable = await _localDataSource.getTable(sourceTableId);
    if (sourceTable == null) throw const NotFoundFailure('Source table not found');
    if (sourceTable.status != TableStatus.occupied.name || sourceTable.currentSessionId == null) {
      throw const ValidationFailure('Source table is not occupied');
    }

    final targetTable = await _localDataSource.getTable(targetTableId);
    if (targetTable == null) throw const NotFoundFailure('Target table not found');
    if (targetTable.status != TableStatus.occupied.name || targetTable.currentSessionId == null) {
      throw const ValidationFailure('Target table must also be occupied to merge');
    }

    final sourceSession = await _localDataSource.getSession(sourceTable.currentSessionId!);
    final targetSession = await _localDataSource.getSession(targetTable.currentSessionId!);
    final now = DateTime.now();

    await _db.transaction(() async {
      // Re-route active orders to target table
      await (_db.update(_db.ordersTable)
            ..where((o) => o.tableId.equals(sourceTableId) & o.status.isNotIn(['completed', 'cancelled'])))
          .write(
        OrdersTableCompanion(
          tableId: Value(targetTableId),
          updatedAt: Value(now),
        ),
      );

      // Update target session guest count
      if (sourceSession != null && targetSession != null) {
        final mergedGuests = targetSession.guestCount + sourceSession.guestCount;
        await (_db.update(_db.tableSessionsTable)..where((s) => s.id.equals(targetSession.id))).write(
          TableSessionsTableCompanion(
            guestCount: Value(mergedGuests),
          ),
        );
      }

      // Close source session
      await _localDataSource.closeSession(
        sourceTable.currentSessionId!,
        performedBy,
        now,
      );

      // Set source table vacant
      await _localDataSource.updateTableStatus(
        sourceTableId,
        TableStatus.vacant.name,
        currentSessionId: const Value(null),
      );

      // Outbox log
      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: sourceTable.tenantId,
          branchId: sourceTable.branchId,
          operationUuid: _uuid.v4(),
          entityType: 'table_merge',
          entityId: targetTable.id,
          operation: 'MERGE',
          payload: jsonEncode({
            'source_table_id': sourceTableId,
            'target_table_id': targetTableId,
            'source_session_id': sourceTable.currentSessionId,
            'target_session_id': targetTable.currentSessionId,
            'performed_by': performedBy,
          }),
          createdAt: now,
        ),
      );
    });
  }

  @override
  Future<void> closeSession({
    required String tableId,
    required String sessionId,
    required String closedBy,
  }) async {
    final table = await _localDataSource.getTable(tableId);
    if (table == null) throw const NotFoundFailure('Table not found');

    final now = DateTime.now();

    await _db.transaction(() async {
      await _localDataSource.closeSession(sessionId, closedBy, now);
      await _localDataSource.updateTableStatus(
        tableId,
        TableStatus.vacant.name,
        currentSessionId: const Value(null),
      );

      await _db.into(_db.syncOutboxTable).insert(
        SyncOutboxTableCompanion.insert(
          id: _uuid.v4(),
          tenantId: table.tenantId,
          branchId: table.branchId,
          operationUuid: _uuid.v4(),
          entityType: 'table_sessions',
          entityId: sessionId,
          operation: 'CLOSE',
          payload: jsonEncode({
            'session_id': sessionId,
            'table_id': tableId,
            'closed_by': closedBy,
            'closed_at': now.toIso8601String(),
          }),
          createdAt: now,
        ),
      );
    });
  }
}
