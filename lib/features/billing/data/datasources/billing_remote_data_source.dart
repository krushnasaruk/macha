import 'package:cafe_os/core/network/supabase_config.dart';

abstract class BillingRemoteDataSource {
  Future<Map<String, dynamic>?> placeOrderAndSettleRpc({
    required String operationId,
    required String tenantId,
    required String branchId,
    required String deviceSeries,
    required String fiscalYear,
    required String orderId,
    required String orderNumber,
    required String orderType,
    String? tableId,
    String? customerName,
    String? customerPhone,
    required int subtotalPaise,
    required int discountPaise,
    required int taxPaise,
    required int roundingPaise,
    required int finalTotalPaise,
    required String createdBy,
    required String paymentMethod,
    int? tenderedPaise,
    int? changeDuePaise,
    String? cashSessionId,
  });
}

class BillingRemoteDataSourceImpl implements BillingRemoteDataSource {
  @override
  Future<Map<String, dynamic>?> placeOrderAndSettleRpc({
    required String operationId,
    required String tenantId,
    required String branchId,
    required String deviceSeries,
    required String fiscalYear,
    required String orderId,
    required String orderNumber,
    required String orderType,
    String? tableId,
    String? customerName,
    String? customerPhone,
    required int subtotalPaise,
    required int discountPaise,
    required int taxPaise,
    required int roundingPaise,
    required int finalTotalPaise,
    required String createdBy,
    required String paymentMethod,
    int? tenderedPaise,
    int? changeDuePaise,
    String? cashSessionId,
  }) async {
    try {
      final client = SupabaseConfig.client;
      final response = await client.rpc('place_order_and_settle', params: {
        'p_operation_id': operationId,
        'p_tenant_id': tenantId,
        'p_branch_id': branchId,
        'p_device_series': deviceSeries,
        'p_fiscal_year': fiscalYear,
        'p_order_id': orderId,
        'p_order_number': orderNumber,
        'p_order_type': orderType,
        'p_table_id': tableId,
        'p_customer_name': customerName,
        'p_customer_phone': customerPhone,
        'p_subtotal_paise': subtotalPaise,
        'p_discount_paise': discountPaise,
        'p_tax_paise': taxPaise,
        'p_rounding_paise': roundingPaise,
        'p_final_total_paise': finalTotalPaise,
        'p_created_by': createdBy,
        'p_payment_method': paymentMethod,
        'p_tendered_paise': tenderedPaise,
        'p_change_due_paise': changeDuePaise,
        'p_cash_session_id': cashSessionId,
      });

      if (response is Map<String, dynamic>) {
        return response;
      }
      return null;
    } catch (_) {
      // Offline or network error: local-first transaction is already saved and outbox enqueued
      return null;
    }
  }
}
