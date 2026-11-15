import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/settings/data/datasources/branch_local_data_source.dart';
import 'package:cafe_os/features/settings/data/datasources/branch_remote_data_source.dart';
import 'package:cafe_os/features/settings/data/repositories/branch_repository_impl.dart';

class MockRemoteDataSource implements BranchRemoteDataSource {
  final List<Map<String, dynamic>> remoteData = [];

  @override
  Future<List<Map<String, dynamic>>> fetchBranches(String tenantId) async {
    return remoteData.where((b) => b['tenant_id'] == tenantId).toList();
  }

  @override
  Future<Map<String, dynamic>> upsertBranch(Map<String, dynamic> branchData) async {
    remoteData.removeWhere((b) => b['id'] == branchData['id']);
    remoteData.add(branchData);
    return branchData;
  }
}

void main() {
  late AppDatabase db;
  late BranchLocalDataSource localDataSource;
  late MockRemoteDataSource remoteDataSource;
  late BranchRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.memory(NativeDatabase.memory());
    localDataSource = BranchLocalDataSourceImpl(db);
    remoteDataSource = MockRemoteDataSource();
    repository = BranchRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      connectivityService: FakeConnectivityService(false),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Branch Repository & Outbox Pattern (ADR-D1)', () {
    test('saveBranch atomically writes branch and outbox mutation in local-first transaction', () async {
      await repository.saveBranch(
        id: 'branch_test_01',
        tenantId: 'tenant_demo_001',
        name: 'Viman Nagar Express',
        code: 'VMN',
        address: 'Phoenix Mall, Pune',
        phone: '+91 9876543210',
        isDefault: false,
      );

      // Verify branch is in local SQLite database
      final branches = await repository.getBranches('tenant_demo_001');
      expect(branches.length, 1);
      expect(branches.first.id, 'branch_test_01');
      expect(branches.first.name, 'Viman Nagar Express');
      expect(branches.first.code, 'VMN');

      // Verify outbox row was written atomically
      final outboxRows = await db.select(db.syncOutboxTable).get();
      expect(outboxRows.length, 1);
      final outbox = outboxRows.first;
      expect(outbox.entityType, 'branch');
      expect(outbox.entityId, 'branch_test_01');
      expect(outbox.operation, 'UPSERT');
      expect(outbox.status, 'pending');
      expect(outbox.operationUuid, isNotEmpty);
    });

    test('repository round-trip preserves branch data', () async {
      await repository.saveBranch(
        id: 'branch_roundtrip_01',
        tenantId: 'tenant_demo_001',
        name: 'Aundh Corner',
        code: 'ANDH',
        isDefault: true,
      );

      final branch = await repository.getBranch('branch_roundtrip_01');
      expect(branch, isNotNull);
      expect(branch!.name, 'Aundh Corner');
      expect(branch.isDefault, isTrue);
    });
  });
}
