import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../domain/repositories/branch_repository.dart';
import '../datasources/branch_local_data_source.dart';
import '../datasources/branch_remote_data_source.dart';

class BranchRepositoryImpl implements BranchRepository {
  final BranchLocalDataSource _localDataSource;
  final BranchRemoteDataSource _remoteDataSource;
  final ConnectivityService _connectivityService;
  final Uuid _uuid;

  BranchRepositoryImpl({
    required BranchLocalDataSource localDataSource,
    required BranchRemoteDataSource remoteDataSource,
    required ConnectivityService connectivityService,
    Uuid? uuid,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _connectivityService = connectivityService,
        _uuid = uuid ?? const Uuid();

  @override
  Future<List<BranchesTableData>> getBranches(String tenantId) {
    return _localDataSource.getBranches(tenantId);
  }

  @override
  Stream<List<BranchesTableData>> watchBranches(String tenantId) {
    return _localDataSource.watchBranches(tenantId);
  }

  @override
  Future<BranchesTableData?> getBranch(String branchId) {
    return _localDataSource.getBranchById(branchId);
  }

  @override
  Future<void> saveBranch({
    required String id,
    required String tenantId,
    required String name,
    required String code,
    String? address,
    String? phone,
    bool isDefault = false,
  }) async {
    final now = DateTime.now();
    final operationUuid = _uuid.v4();

    final branchCompanion = BranchesTableCompanion.insert(
      id: id,
      tenantId: tenantId,
      name: name,
      code: code,
      address: Value(address),
      phone: Value(phone),
      isDefault: Value(isDefault),
      isActive: const Value(true),
      updatedAt: now,
    );

    final payloadJson = jsonEncode({
      'id': id,
      'tenant_id': tenantId,
      'name': name,
      'code': code,
      'address': address,
      'phone': phone,
      'is_default': isDefault,
      'is_active': true,
      'updated_at': now.toIso8601String(),
    });

    final outboxCompanion = SyncOutboxTableCompanion.insert(
      id: _uuid.v4(),
      tenantId: tenantId,
      branchId: id,
      operationUuid: operationUuid,
      entityType: 'branch',
      entityId: id,
      operation: 'UPSERT',
      payload: payloadJson,
      createdAt: now,
      status: const Value('pending'),
    );

    // 1. Atomic local transaction (ADR-D1)
    await _localDataSource.saveBranchWithOutbox(
      branch: branchCompanion,
      outbox: outboxCompanion,
    );

    // 2. Best-effort online sync if connectivity is present
    if (_connectivityService.isOnline) {
      try {
        await _remoteDataSource.upsertBranch({
          'id': id,
          'tenant_id': tenantId,
          'name': name,
          'code': code,
          'address': address,
          'phone': phone,
          'is_default': isDefault,
          'is_active': true,
          'updated_at': now.toIso8601String(),
        });
      } catch (_) {
        // Safe to ignore: outbox row remains 'pending' for sync worker to deliver
      }
    }
  }

  @override
  Future<void> syncBranches(String tenantId) async {
    if (!_connectivityService.isOnline) return;

    try {
      final remoteList = await _remoteDataSource.fetchBranches(tenantId);
      final companions = remoteList.map((data) {
        return BranchesTableCompanion.insert(
          id: data['id'] as String,
          tenantId: data['tenant_id'] as String,
          name: data['name'] as String,
          code: data['code'] as String,
          address: Value(data['address'] as String?),
          phone: Value(data['phone'] as String?),
          isDefault: Value(data['is_default'] as bool? ?? false),
          isActive: Value(data['is_active'] as bool? ?? true),
          updatedAt: DateTime.tryParse(data['updated_at'] as String? ?? '') ?? DateTime.now(),
        );
      }).toList();

      await _localDataSource.upsertBranchesFromRemote(companions);
    } catch (_) {
      // Offline fallback: keep cached local state
    }
  }
}

final branchLocalDataSourceProvider = Provider<BranchLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BranchLocalDataSourceImpl(db);
});

final branchRemoteDataSourceProvider = Provider<BranchRemoteDataSource>((ref) {
  return BranchRemoteDataSourceImpl();
});

final branchRepositoryProvider = Provider<BranchRepository>((ref) {
  return BranchRepositoryImpl(
    localDataSource: ref.watch(branchLocalDataSourceProvider),
    remoteDataSource: ref.watch(branchRemoteDataSourceProvider),
    connectivityService: ref.watch(connectivityServiceProvider),
  );
});
