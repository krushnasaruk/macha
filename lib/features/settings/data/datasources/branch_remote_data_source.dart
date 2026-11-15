import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BranchRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchBranches(String tenantId);
  Future<Map<String, dynamic>> upsertBranch(Map<String, dynamic> branchData);
}

class BranchRemoteDataSourceImpl implements BranchRemoteDataSource {
  final SupabaseClient? _client;

  BranchRemoteDataSourceImpl([this._client]);

  SupabaseClient get client => _client ?? Supabase.instance.client;

  @override
  Future<List<Map<String, dynamic>>> fetchBranches(String tenantId) async {
    final response = await client
        .from('branches')
        .select()
        .eq('tenant_id', tenantId)
        .order('name');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<Map<String, dynamic>> upsertBranch(Map<String, dynamic> branchData) async {
    final response = await client
        .from('branches')
        .upsert(branchData)
        .select()
        .single();
    return Map<String, dynamic>.from(response);
  }
}
