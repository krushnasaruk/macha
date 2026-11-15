import '../../../../core/database/app_database.dart';

abstract class TenantSettingsRepository {
  Future<TenantSettingsTableData?> getSettings(String tenantId);
  Stream<TenantSettingsTableData?> watchSettings(String tenantId);
  Future<void> saveSettings({
    required String tenantId,
    required String currency,
    required String timezone,
    String? gstin,
    required String invoicePrefix,
    int fiscalYearStartMonth = 4,
    String roundOffStrategy = 'HALF_UP',
  });
  Future<void> syncSettings(String tenantId);
}
