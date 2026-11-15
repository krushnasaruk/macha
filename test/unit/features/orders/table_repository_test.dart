import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/errors/app_failure.dart';
import 'package:cafe_os/features/orders/data/datasources/table_local_data_source.dart';
import 'package:cafe_os/features/orders/data/repositories/table_repository_impl.dart';
import 'package:cafe_os/features/orders/domain/models/order_and_table_models.dart';

void main() {
  late AppDatabase db;
  late TableLocalDataSource localDataSource;
  late TableRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.memory(NativeDatabase.memory());
    localDataSource = TableLocalDataSource(db);
    repository = TableRepositoryImpl(db: db, localDataSource: localDataSource);

    // Seed test branch and tenant
    await db.into(db.tenantsTable).insert(
          TenantsTableCompanion.insert(
            id: 't_demo',
            name: 'Demo Café',
            slug: 'demo-cafe',
            updatedAt: DateTime.now(),
          ),
        );

    await db.into(db.branchesTable).insert(
          BranchesTableCompanion.insert(
            id: 'b_main',
            tenantId: 't_demo',
            name: 'Main Branch',
            code: 'MAIN',
            updatedAt: DateTime.now(),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  group('TableRepository & Session Lifecycle (T5.4, Milestone M2)', () {
    test('saveTable and watchTables retrieves tables by branch', () async {
      final table = DiningTable(
        id: 'tbl_1',
        tenantId: 't_demo',
        branchId: 'b_main',
        name: 'Table 1',
        capacity: 4,
        floorZone: TableFloorZone.indoor,
        status: TableStatus.vacant,
        qrToken: 'qr_tbl1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repository.saveTable(table);

      final tables = await repository.getTables('b_main');
      expect(tables.length, 1);
      expect(tables.first.name, 'Table 1');
      expect(tables.first.status, TableStatus.vacant);

      // Verify outbox entry created atomically
      final outbox = await db.select(db.syncOutboxTable).get();
      expect(outbox.length, 1);
      expect(outbox.first.entityType, 'dining_tables');
      expect(outbox.first.operation, 'UPSERT');
    });

    test('openSession seats guests, updates table to occupied, and enqueues outbox', () async {
      final table = DiningTable(
        id: 'tbl_2',
        tenantId: 't_demo',
        branchId: 'b_main',
        name: 'Table 2',
        capacity: 4,
        floorZone: TableFloorZone.indoor,
        status: TableStatus.vacant,
        qrToken: 'qr_tbl2',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await repository.saveTable(table);

      final session = await repository.openSession(
        tableId: 'tbl_2',
        guestCount: 3,
        openedBy: 'Alice',
        notes: 'Anniversary couple',
      );

      expect(session.guestCount, 3);
      expect(session.openedBy, 'Alice');
      expect(session.status, 'active');

      final updatedTable = await repository.getTable('tbl_2');
      expect(updatedTable?.status, TableStatus.occupied);
      expect(updatedTable?.currentSessionId, session.id);

      // Attempting to open an already occupied table throws ValidationFailure
      expect(
        () => repository.openSession(
          tableId: 'tbl_2',
          guestCount: 2,
          openedBy: 'Bob',
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('transferTable moves session and active orders from Table A to Table B', () async {
      // Create Table A (Occupied) and Table B (Vacant)
      await repository.saveTable(
        DiningTable(
          id: 'tbl_a',
          tenantId: 't_demo',
          branchId: 'b_main',
          name: 'Table A',
          capacity: 2,
          qrToken: 'qr_a',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await repository.saveTable(
        DiningTable(
          id: 'tbl_b',
          tenantId: 't_demo',
          branchId: 'b_main',
          name: 'Table B',
          capacity: 4,
          qrToken: 'qr_b',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final session = await repository.openSession(
        tableId: 'tbl_a',
        guestCount: 2,
        openedBy: 'Alice',
      );

      // Perform transfer
      await repository.transferTable(
        fromTableId: 'tbl_a',
        toTableId: 'tbl_b',
        performedBy: 'Alice',
      );

      final tableA = await repository.getTable('tbl_a');
      final tableB = await repository.getTable('tbl_b');

      expect(tableA?.status, TableStatus.vacant);
      expect(tableA?.currentSessionId, isNull);

      expect(tableB?.status, TableStatus.occupied);
      expect(tableB?.currentSessionId, session.id);
    });

    test('mergeTables combines guest count, closes source session, and vacates source table', () async {
      // Create two occupied tables
      await repository.saveTable(
        DiningTable(
          id: 'tbl_source',
          tenantId: 't_demo',
          branchId: 'b_main',
          name: 'Source 1',
          capacity: 2,
          qrToken: 'qr_s1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await repository.saveTable(
        DiningTable(
          id: 'tbl_target',
          tenantId: 't_demo',
          branchId: 'b_main',
          name: 'Target 2',
          capacity: 4,
          qrToken: 'qr_t2',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      await repository.openSession(tableId: 'tbl_source', guestCount: 2, openedBy: 'Staff');
      final targetSession = await repository.openSession(tableId: 'tbl_target', guestCount: 3, openedBy: 'Staff');

      await repository.mergeTables(
        sourceTableId: 'tbl_source',
        targetTableId: 'tbl_target',
        performedBy: 'Staff',
      );

      final sourceTable = await repository.getTable('tbl_source');
      final targetTable = await repository.getTable('tbl_target');

      expect(sourceTable?.status, TableStatus.vacant);
      expect(sourceTable?.currentSessionId, isNull);

      expect(targetTable?.status, TableStatus.occupied);

      // Target session has merged guest count (2 + 3 = 5)
      final sessionInDb = await localDataSource.getSession(targetSession.id);
      expect(sessionInDb?.guestCount, 5);
    });

    test('closeSession closes session and resets table to vacant', () async {
      await repository.saveTable(
        DiningTable(
          id: 'tbl_close',
          tenantId: 't_demo',
          branchId: 'b_main',
          name: 'Table Close',
          capacity: 4,
          qrToken: 'qr_c',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final session = await repository.openSession(
        tableId: 'tbl_close',
        guestCount: 4,
        openedBy: 'Staff',
      );

      await repository.closeSession(
        tableId: 'tbl_close',
        sessionId: session.id,
        closedBy: 'Staff',
      );

      final table = await repository.getTable('tbl_close');
      expect(table?.status, TableStatus.vacant);
      expect(table?.currentSessionId, isNull);

      final sessionData = await localDataSource.getSession(session.id);
      expect(sessionData?.status, 'closed');
      expect(sessionData?.closedBy, 'Staff');
      expect(sessionData?.closedAt, isNotNull);
    });
  });
}
