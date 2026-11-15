import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

abstract class BranchLocalDataSource {
  Future<List<BranchesTableData>> getBranches(String tenantId);
  Stream<List<BranchesTableData>> watchBranches(String tenantId);
  Future<BranchesTableData?> getBranchById(String branchId);
  Future<void> saveBranchWithOutbox({
    required BranchesTableCompanion branch,
    required SyncOutboxTableCompanion outbox,
  });
  Future<void> upsertBranchesFromRemote(List<BranchesTableCompanion> branches);
}

class BranchLocalDataSourceImpl implements BranchLocalDataSource {
  final AppDatabase _db;

  BranchLocalDataSourceImpl(this._db);

  @override
  Future<List<BranchesTableData>> getBranches(String tenantId) {
    return (_db.select(_db.branchesTable)
          ..where((t) => t.tenantId.equals(tenantId) & t.isActive.equals(true)))
        .get();
  }

  @override
  Stream<List<BranchesTableData>> watchBranches(String tenantId) {
    return (_db.select(_db.branchesTable)
          ..where((t) => t.tenantId.equals(tenantId) & t.isActive.equals(true)))
        .watch();
  }

  @override
  Future<BranchesTableData?> getBranchById(String branchId) {
    return (_db.select(_db.branchesTable)..where((t) => t.id.equals(branchId)))
        .getSingleOrNull();
  }

  @override
  Future<void> saveBranchWithOutbox({
    required BranchesTableCompanion branch,
    required SyncOutboxTableCompanion outbox,
  }) {
    // Atomic local transaction: local entity write + outbox enqueue in one transaction (ADR-D1)
    return _db.transaction(() async {
      await _db.into(_db.branchesTable).insertOnConflictUpdate(branch);
      await _db.into(_db.syncOutboxTable).insert(outbox);
    });
  }

  @override
  Future<void> upsertBranchesFromRemote(List<BranchesTableCompanion> branches) {
    return _db.batch((batch) {
      batch.insertAllOnConflictUpdate(_db.branchesTable, branches);
    });
  }
}
