import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/settings/data/datasources/tenant_settings_local_data_source.dart';
import 'package:cafe_os/features/settings/data/datasources/tenant_settings_remote_data_source.dart';
import 'package:cafe_os/features/settings/data/repositories/tenant_settings_repository_impl.dart';

class MockTenantSettingsRemoteDataSource implements TenantSettingsRemoteDataSource {
  Map<String, dynamic>? remoteSettings;

  @override
  Future<Map<String, dynamic>?> fetchSettings(String tenantId) async {
    return remoteSettings;
  }

  @override
  Future<Map<String, dynamic>> upsertSettings(Map<String, dynamic> settingsData) async {
    remoteSettings = settingsData;
    return settingsData;
  }
}

void main() {
  late AppDatabase db;
  late TenantSettingsLocalDataSource localDataSource;
  late MockTenantSettingsRemoteDataSource remoteDataSource;
  late TenantSettingsRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.memory(NativeDatabase.memory());
    localDataSource = TenantSettingsLocalDataSourceImpl(db);
    remoteDataSource = MockTenantSettingsRemoteDataSource();
    repository = TenantSettingsRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      connectivityService: FakeConnectivityService(false),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Tenant Settings Repository (ADR-D1 & D3)', () {
    test('saveSettings atomically writes settings and outbox entry', () async {
      await repository.saveSettings(
        tenantId: 'tenant_demo_001',
        currency: 'INR',
        timezone: 'Asia/Kolkata',
        gstin: '27AABCA1234F1Z5',
        invoicePrefix: 'INV-KHD',
        fiscalYearStartMonth: 4,
        roundOffStrategy: 'HALF_UP',
      );

      final settings = await repository.getSettings('tenant_demo_001');
      expect(settings, isNotNull);
      expect(settings!.currency, 'INR');
      expect(settings.gstin, '27AABCA1234F1Z5');
      expect(settings.invoicePrefix, 'INV-KHD');

      // Check outbox
      final outboxItems = await db.select(db.syncOutboxTable).get();
      expect(outboxItems.length, 1);
      expect(outboxItems.first.entityType, 'tenant_settings');
      expect(outboxItems.first.status, 'pending');
    });
  });
}
