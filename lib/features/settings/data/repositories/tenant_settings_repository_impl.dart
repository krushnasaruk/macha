import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../domain/repositories/tenant_settings_repository.dart';
import '../datasources/tenant_settings_local_data_source.dart';
import '../datasources/tenant_settings_remote_data_source.dart';

class TenantSettingsRepositoryImpl implements TenantSettingsRepository {
  final TenantSettingsLocalDataSource _localDataSource;
  final TenantSettingsRemoteDataSource _remoteDataSource;
  final ConnectivityService _connectivityService;
  final Uuid _uuid;

  TenantSettingsRepositoryImpl({
    required TenantSettingsLocalDataSource localDataSource,
    required TenantSettingsRemoteDataSource remoteDataSource,
    required ConnectivityService connectivityService,
    Uuid? uuid,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _connectivityService = connectivityService,
        _uuid = uuid ?? const Uuid();

  @override
  Future<TenantSettingsTableData?> getSettings(String tenantId) {
    return _localDataSource.getSettings(tenantId);
  }

  @override
  Stream<TenantSettingsTableData?> watchSettings(String tenantId) {
    return _localDataSource.watchSettings(tenantId);
  }

  @override
  Future<void> saveSettings({
    required String tenantId,
    required String currency,
    required String timezone,
    String? gstin,
    required String invoicePrefix,
    int fiscalYearStartMonth = 4,
    String roundOffStrategy = 'HALF_UP',
  }) async {
    final now = DateTime.now();
    final operationUuid = _uuid.v4();

    final settingsCompanion = TenantSettingsTableCompanion.insert(
      tenantId: tenantId,
      currency: Value(currency),
      timezone: Value(timezone),
      gstin: Value(gstin),
      invoicePrefix: Value(invoicePrefix),
      fiscalYearStartMonth: Value(fiscalYearStartMonth),
      roundOffStrategy: Value(roundOffStrategy),
      updatedAt: now,
    );

    final payloadJson = jsonEncode({
      'tenant_id': tenantId,
      'currency': currency,
      'timezone': timezone,
      'gstin': gstin,
      'invoice_prefix': invoicePrefix,
      'fiscal_year_start_month': fiscalYearStartMonth,
      'round_off_strategy': roundOffStrategy,
      'updated_at': now.toIso8601String(),
    });

    final outboxCompanion = SyncOutboxTableCompanion.insert(
      id: _uuid.v4(),
      tenantId: tenantId,
      branchId: '',
      operationUuid: operationUuid,
      entityType: 'tenant_settings',
      entityId: tenantId,
      operation: 'UPSERT',
      payload: payloadJson,
      createdAt: now,
      status: const Value('pending'),
    );

    // 1. Atomic local transaction (ADR-D1)
    await _localDataSource.saveSettingsWithOutbox(
      settings: settingsCompanion,
      outbox: outboxCompanion,
    );

    // 2. Best-effort online sync
    if (_connectivityService.isOnline) {
      try {
        await _remoteDataSource.upsertSettings({
          'tenant_id': tenantId,
          'currency': currency,
          'timezone': timezone,
          'gstin': gstin,
          'invoice_prefix': invoicePrefix,
          'fiscal_year_start_month': fiscalYearStartMonth,
          'round_off_strategy': roundOffStrategy,
          'updated_at': now.toIso8601String(),
        });
      } catch (_) {
        // Outbox keeps pending row
      }
    }
  }

  @override
  Future<void> syncSettings(String tenantId) async {
    if (!_connectivityService.isOnline) return;

    try {
      final remoteData = await _remoteDataSource.fetchSettings(tenantId);
      if (remoteData != null) {
        final companion = TenantSettingsTableCompanion.insert(
          tenantId: remoteData['tenant_id'] as String,
          currency: Value(remoteData['currency'] as String? ?? 'INR'),
          timezone: Value(remoteData['timezone'] as String? ?? 'Asia/Kolkata'),
          gstin: Value(remoteData['gstin'] as String?),
          invoicePrefix: Value(remoteData['invoice_prefix'] as String? ?? 'INV'),
          fiscalYearStartMonth: Value(remoteData['fiscal_year_start_month'] as int? ?? 4),
          roundOffStrategy: Value(remoteData['round_off_strategy'] as String? ?? 'HALF_UP'),
          updatedAt: DateTime.tryParse(remoteData['updated_at'] as String? ?? '') ?? DateTime.now(),
        );

        // Save locally without outbox
        await _localDataSource.saveSettingsWithOutbox(
          settings: companion,
          outbox: SyncOutboxTableCompanion.insert(
            id: _uuid.v4(),
            tenantId: tenantId,
            branchId: '',
            operationUuid: _uuid.v4(),
            entityType: 'tenant_settings',
            entityId: tenantId,
            operation: 'PULL_SYNC',
            payload: '{}',
            createdAt: DateTime.now(),
            status: const Value('synced'),
          ),
        );
      }
    } catch (_) {
      // Offline fallback
    }
  }
}

final tenantSettingsLocalDataSourceProvider = Provider<TenantSettingsLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TenantSettingsLocalDataSourceImpl(db);
});

final tenantSettingsRemoteDataSourceProvider = Provider<TenantSettingsRemoteDataSource>((ref) {
  return TenantSettingsRemoteDataSourceImpl();
});

final tenantSettingsRepositoryProvider = Provider<TenantSettingsRepository>((ref) {
  return TenantSettingsRepositoryImpl(
    localDataSource: ref.watch(tenantSettingsLocalDataSourceProvider),
    remoteDataSource: ref.watch(tenantSettingsRemoteDataSourceProvider),
    connectivityService: ref.watch(connectivityServiceProvider),
  );
});
