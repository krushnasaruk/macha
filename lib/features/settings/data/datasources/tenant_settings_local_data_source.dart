import '../../../../core/database/app_database.dart';

abstract class TenantSettingsLocalDataSource {
  Future<TenantSettingsTableData?> getSettings(String tenantId);
  Stream<TenantSettingsTableData?> watchSettings(String tenantId);
  Future<void> saveSettingsWithOutbox({
    required TenantSettingsTableCompanion settings,
    required SyncOutboxTableCompanion outbox,
  });
}

class TenantSettingsLocalDataSourceImpl implements TenantSettingsLocalDataSource {
  final AppDatabase _db;

  TenantSettingsLocalDataSourceImpl(this._db);

  @override
  Future<TenantSettingsTableData?> getSettings(String tenantId) {
    return (_db.select(_db.tenantSettingsTable)
          ..where((t) => t.tenantId.equals(tenantId)))
        .getSingleOrNull();
  }

  @override
  Stream<TenantSettingsTableData?> watchSettings(String tenantId) {
    return (_db.select(_db.tenantSettingsTable)
          ..where((t) => t.tenantId.equals(tenantId)))
        .watchSingleOrNull();
  }

  @override
  Future<void> saveSettingsWithOutbox({
    required TenantSettingsTableCompanion settings,
    required SyncOutboxTableCompanion outbox,
  }) {
    return _db.transaction(() async {
      await _db.into(_db.tenantSettingsTable).insertOnConflictUpdate(settings);
      await _db.into(_db.syncOutboxTable).insert(outbox);
    });
  }
}
