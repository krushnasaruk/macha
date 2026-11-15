import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TenantSettingsRemoteDataSource {
  Future<Map<String, dynamic>?> fetchSettings(String tenantId);
  Future<Map<String, dynamic>> upsertSettings(Map<String, dynamic> settingsData);
}

class TenantSettingsRemoteDataSourceImpl implements TenantSettingsRemoteDataSource {
  final SupabaseClient? _client;

  TenantSettingsRemoteDataSourceImpl([this._client]);

  SupabaseClient get client => _client ?? Supabase.instance.client;

  @override
  Future<Map<String, dynamic>?> fetchSettings(String tenantId) async {
    final response = await client
        .from('tenant_settings')
        .select()
        .eq('tenant_id', tenantId)
        .maybeSingle();
    return response != null ? Map<String, dynamic>.from(response) : null;
  }

  @override
  Future<Map<String, dynamic>> upsertSettings(Map<String, dynamic> settingsData) async {
    final response = await client
        .from('tenant_settings')
        .upsert(settingsData)
        .select()
        .single();
    return Map<String, dynamic>.from(response);
  }
}
