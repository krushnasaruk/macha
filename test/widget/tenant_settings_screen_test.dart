import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/settings/data/datasources/tenant_settings_local_data_source.dart';
import 'package:cafe_os/features/settings/data/datasources/tenant_settings_remote_data_source.dart';
import 'package:cafe_os/features/settings/data/repositories/tenant_settings_repository_impl.dart';
import 'package:cafe_os/features/settings/presentation/tenant_settings_screen.dart';

class MockRemoteDataSource implements TenantSettingsRemoteDataSource {
  @override
  Future<Map<String, dynamic>?> fetchSettings(String tenantId) async => null;

  @override
  Future<Map<String, dynamic>> upsertSettings(Map<String, dynamic> settingsData) async => settingsData;
}

void main() {
  testWidgets('TenantSettingsScreen displays fields and saves settings', (tester) async {
    final db = AppDatabase.memory(NativeDatabase.memory());
    addTearDown(db.close);

    final localDataSource = TenantSettingsLocalDataSourceImpl(db);
    final remoteDataSource = MockRemoteDataSource();
    final repo = TenantSettingsRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      connectivityService: FakeConnectivityService(false),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tenantSettingsRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          home: TenantSettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tenant & Billing Settings'), findsOneWidget);
    expect(find.text('Operating Currency'), findsOneWidget);
    expect(find.text('GSTIN (Goods and Services Tax ID)'), findsOneWidget);
    expect(find.text('Save Configuration'), findsOneWidget);

    // Tap Save Configuration
    await tester.tap(find.text('Save Configuration'));
    await tester.pumpAndSettle();

    // Verify settings were saved in database
    final saved = await repo.getSettings('tenant_demo_001');
    expect(saved, isNotNull);
    expect(saved!.currency, 'INR');
  });
}
