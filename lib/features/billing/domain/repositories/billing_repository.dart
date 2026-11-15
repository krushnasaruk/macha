import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';

abstract class BillingRepository {
  Future<Invoice> createAndSettleOrder({
    required CartState cart,
    required String paymentMethod,
    Money? tendered,
    Money? changeDue,
    String? cashSessionId,
  });

  Future<List<Invoice>> getInvoices({String? branchId});
  Future<Invoice?> getInvoiceById(String id);

  Future<void> holdCart({required String label, required CartState cart});
  Future<List<Map<String, dynamic>>> getHeldCarts();
  Future<void> removeHeldCart(String id);

  Future<CashSessionRecord?> getActiveCashSession();
  Future<CashSessionRecord> openCashSession(Money openingFloat);
  Future<void> recordCashMovement({
    required String sessionId,
    required String type, // cash_in or cash_out
    required Money amount,
    String? reason,
  });
  Future<CashSessionRecord> closeCashSession({
    required String sessionId,
    required Money actualCash,
    String? notes,
  });

  Future<RefundRecord> processRefund({
    required String invoiceId,
    String? paymentId,
    required Money amount,
    required String reason,
    required String refundMethod,
    String? cashSessionId,
  });
}
