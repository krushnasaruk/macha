import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MenuRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchCategories(String tenantId);
  Future<Map<String, dynamic>> upsertCategory(Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> fetchProducts(String tenantId);
  Future<Map<String, dynamic>> upsertProduct(Map<String, dynamic> data);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final SupabaseClient? _client;

  MenuRemoteDataSourceImpl([this._client]);

  SupabaseClient get client => _client ?? Supabase.instance.client;

  @override
  Future<List<Map<String, dynamic>>> fetchCategories(String tenantId) async {
    final response = await client
        .from('categories')
        .select()
        .eq('tenant_id', tenantId)
        .order('sort_order');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<Map<String, dynamic>> upsertCategory(Map<String, dynamic> data) async {
    final response = await client.from('categories').upsert(data).select().single();
    return Map<String, dynamic>.from(response);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProducts(String tenantId) async {
    final response = await client
        .from('products')
        .select('*, product_variants(*), product_modifier_groups(*, modifier_groups(*, modifiers(*)))')
        .eq('tenant_id', tenantId);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<Map<String, dynamic>> upsertProduct(Map<String, dynamic> data) async {
    final response = await client.from('products').upsert(data).select().single();
    return Map<String, dynamic>.from(response);
  }
}
