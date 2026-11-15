import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/datasources/billing_local_data_source.dart';
import 'package:cafe_os/features/billing/data/datasources/billing_remote_data_source.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';
import 'package:cafe_os/features/billing/domain/repositories/billing_repository.dart';

final billingLocalDataSourceProvider = Provider<BillingLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BillingLocalDataSourceImpl(db);
});

final billingRemoteDataSourceProvider = Provider<BillingRemoteDataSource>((ref) {
  return BillingRemoteDataSourceImpl();
});

final billingRepositoryProvider = Provider<BillingRepository>((ref) {
  final local = ref.watch(billingLocalDataSourceProvider);
  final remote = ref.watch(billingRemoteDataSourceProvider);
  final identity = ref.watch(currentIdentityNotifier);
  final connectivity = ref.watch(connectivityServiceProvider);
  return BillingRepositoryImpl(
    localDataSource: local,
    remoteDataSource: remote,
    currentIdentity: identity,
    connectivity: connectivity,
  );
});

class BillingRepositoryImpl implements BillingRepository {
  final BillingLocalDataSource _localDataSource;
  final BillingRemoteDataSource _remoteDataSource;
  final SessionIdentity _currentIdentity;
  final ConnectivityService _connectivity;

  BillingRepositoryImpl({
    required BillingLocalDataSource localDataSource,
    required BillingRemoteDataSource remoteDataSource,
    required SessionIdentity currentIdentity,
    required ConnectivityService connectivity,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _currentIdentity = currentIdentity,
        _connectivity = connectivity;

  @override
  Future<Invoice> createAndSettleOrder({
    required CartState cart,
    required String paymentMethod,
    Money? tendered,
    Money? changeDue,
    String? cashSessionId,
  }) async {
    // 1. Write atomically to Drift (SQLite) and write Outbox record (ADR-D1)
    final invoice = await _localDataSource.createAndSettleOrderLocally(
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
      branchCode: _currentIdentity.branch.code,
      deviceSeries: _currentIdentity.device.deviceSeries,
      employeeId: _currentIdentity.employee.id,
      cart: cart,
      paymentMethod: paymentMethod,
      tendered: tendered,
      changeDue: changeDue,
      cashSessionId: cashSessionId,
    );

    // 2. If online, fire background RPC push (ADR-D6)
    if (_connectivity.isOnline) {
      _remoteDataSource.placeOrderAndSettleRpc(
        operationId: invoice.id,
        tenantId: _currentIdentity.tenant.id,
        branchId: _currentIdentity.branch.id,
        deviceSeries: _currentIdentity.device.deviceSeries,
        fiscalYear: invoice.fiscalYear,
        orderId: invoice.orderId ?? '',
        orderNumber: 'ORD-${invoice.sequenceNumber}',
        orderType: cart.orderType.name,
        tableId: cart.tableId,
        customerName: cart.customerName,
        customerPhone: cart.customerPhone,
        subtotalPaise: invoice.subtotal.paise,
        discountPaise: invoice.discount.paise,
        taxPaise: invoice.totalTax.paise,
        roundingPaise: invoice.rounding.paise,
        finalTotalPaise: invoice.finalTotal.paise,
        createdBy: _currentIdentity.employee.id,
        paymentMethod: paymentMethod,
        tenderedPaise: tendered?.paise,
        changeDuePaise: changeDue?.paise,
        cashSessionId: cashSessionId,
      ).ignore();
    }

    return invoice;
  }

  @override
  Future<List<Invoice>> getInvoices({String? branchId}) {
    return _localDataSource.getInvoices(
      tenantId: _currentIdentity.tenant.id,
      branchId: branchId ?? _currentIdentity.branch.id,
    );
  }

  @override
  Future<Invoice?> getInvoiceById(String id) {
    return _localDataSource.getInvoiceById(id);
  }

  @override
  Future<void> holdCart({required String label, required CartState cart}) {
    final id = 'hold_${DateTime.now().millisecondsSinceEpoch}';
    return _localDataSource.saveHeldCart(
      id: id,
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
      label: label,
      cart: cart,
      employeeId: _currentIdentity.employee.id,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getHeldCarts() {
    return _localDataSource.getHeldCarts(
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
    );
  }

  @override
  Future<void> removeHeldCart(String id) {
    return _localDataSource.removeHeldCart(id);
  }

  @override
  Future<CashSessionRecord?> getActiveCashSession() {
    return _localDataSource.getActiveCashSession(
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
      deviceId: _currentIdentity.device.id,
    );
  }

  @override
  Future<CashSessionRecord> openCashSession(Money openingFloat) {
    final id = 'cs_${DateTime.now().millisecondsSinceEpoch}';
    return _localDataSource.openCashSession(
      id: id,
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
      deviceId: _currentIdentity.device.id,
      openingFloat: openingFloat,
      openedBy: _currentIdentity.employee.id,
    );
  }

  @override
  Future<void> recordCashMovement({
    required String sessionId,
    required String type,
    required Money amount,
    String? reason,
  }) {
    final id = 'cm_${DateTime.now().millisecondsSinceEpoch}';
    return _localDataSource.recordCashMovement(
      id: id,
      sessionId: sessionId,
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
      type: type,
      amount: amount,
      reason: reason,
      performedBy: _currentIdentity.employee.id,
    );
  }

  @override
  Future<CashSessionRecord> closeCashSession({
    required String sessionId,
    required Money actualCash,
    String? notes,
  }) {
    return _localDataSource.closeCashSession(
      sessionId: sessionId,
      actualCash: actualCash,
      closedBy: _currentIdentity.employee.id,
      notes: notes,
    );
  }

  @override
  Future<RefundRecord> processRefund({
    required String invoiceId,
    String? paymentId,
    required Money amount,
    required String reason,
    required String refundMethod,
    String? cashSessionId,
  }) {
    final id = 'ref_${DateTime.now().millisecondsSinceEpoch}';
    return _localDataSource.createRefund(
      id: id,
      tenantId: _currentIdentity.tenant.id,
      branchId: _currentIdentity.branch.id,
      invoiceId: invoiceId,
      paymentId: paymentId,
      amount: amount,
      reason: reason,
      approvedBy: _currentIdentity.employee.id,
      refundMethod: refundMethod,
      cashSessionId: cashSessionId,
    );
  }
}
