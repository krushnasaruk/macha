import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.memory(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift AppDatabase Bootstrap', () {
    test('creates tables and inserts outbox record atomically', () async {
      final now = DateTime.now();

      await db.into(db.syncOutboxTable).insert(
            SyncOutboxTableCompanion.insert(
              id: 'outbox_1',
              tenantId: 'tenant_demo_001',
              branchId: 'branch_khd_01',
              operationUuid: 'op_uuid_001',
              entityType: 'order',
              entityId: 'ord_1001',
              operation: 'RPC_PLACE_ORDER',
              payload: '{"items": 2}',
              createdAt: now,
            ),
          );

      final outboxItems = await db.select(db.syncOutboxTable).get();
      expect(outboxItems.length, 1);
      expect(outboxItems.first.operationUuid, 'op_uuid_001');
      expect(outboxItems.first.status, 'pending');
      expect(outboxItems.first.retryCount, 0);
    });

    test('stores and retrieves app config metadata', () async {
      final now = DateTime.now();
      await db.into(db.appConfigTable).insert(
            AppConfigTableCompanion.insert(
              configKey: 'device_series',
              configValue: 'A1',
              updatedAt: now,
            ),
          );

      final config = await (db.select(db.appConfigTable)
            ..where((t) => t.configKey.equals('device_series')))
          .getSingle();

      expect(config.configValue, 'A1');
    });
  });
}
