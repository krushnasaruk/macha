import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/datasources/billing_local_data_source.dart';
import 'package:cafe_os/features/billing/data/datasources/billing_remote_data_source.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';

class FakeConnectivityService implements ConnectivityService {
  @override
  bool isOnline;
  FakeConnectivityService([this.isOnline = true]);
  @override
  Stream<bool> get onConnectivityChanged => Stream.value(isOnline);
  @override
  void dispose() {}
}

class FakeBillingRemoteDataSource implements BillingRemoteDataSource {
  int rpcCallCount = 0;

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
    rpcCallCount++;
    return {
      'success': true,
      'invoice_id': 'inv_$operationId',
      'invoice_number': 'KHD-A-FY26-27-00001',
    };
  }
}

void main() {
  late AppDatabase db;
  late BillingLocalDataSource localDataSource;
  late FakeBillingRemoteDataSource remoteDataSource;
  late FakeConnectivityService connectivity;
  late BillingRepositoryImpl repository;

  const testTenant = Tenant(
    id: 'tenant_demo_001',
    name: 'Artisan Roast',
    currency: 'INR',
    timezone: 'Asia/Kolkata',
  );

  const testBranch = Branch(
    id: 'branch_khd_01',
    tenantId: 'tenant_demo_001',
    name: 'Kharadi High Street',
    code: 'KHD',
  );

  const testEmployee = Employee(
    id: 'emp_cashier_01',
    tenantId: 'tenant_demo_001',
    branchId: 'branch_khd_01',
    name: 'Vikram Mehta',
    email: 'vikram@artisanroast.com',
    role: UserRole.cashier,
  );

  const testDevice = RegisteredDevice(
    id: 'dev_pos_01',
    tenantId: 'tenant_demo_001',
    branchId: 'branch_khd_01',
    deviceSeries: 'A',
    name: 'Counter POS 1',
  );

  const sessionIdentity = SessionIdentity(
    tenant: testTenant,
    branch: testBranch,
    employee: testEmployee,
    device: testDevice,
  );

  setUp(() {
    db = AppDatabase.memory(NativeDatabase.memory());
    localDataSource = BillingLocalDataSourceImpl(db);
    remoteDataSource = FakeBillingRemoteDataSource();
    connectivity = FakeConnectivityService(false); // Test offline-first

    repository = BillingRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      currentIdentity: sessionIdentity,
      connectivity: connectivity,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Billing Repository & Offline Settlement (T4.5 - T4.10, ADR-D1, ADR-D3)', () {
    test('Cash drawer session can be opened, tracks expected cash, and closes with variance', () async {
      // 1. Open session with ₹2,000 opening float
      final session = await repository.openCashSession(const Money.fromRupees(2000));
      expect(session.status, 'open');
      expect(session.openingFloat, const Money.fromRupees(2000));
      expect(session.expectedCash, const Money.fromRupees(2000));
      expect(session.variance, Money.zero);

      // Verify active session retrieval
      final active = await repository.getActiveCashSession();
      expect(active, isNotNull);
      expect(active!.id, session.id);

      // 2. Record Cash In (+₹500 petty cash)
      await repository.recordCashMovement(
        sessionId: session.id,
        type: 'cash_in',
        amount: const Money.fromRupees(500),
        reason: 'Added coins float',
      );

      final sessionAfterIn = await repository.getActiveCashSession();
      expect(sessionAfterIn!.expectedCash, const Money.fromRupees(2500));

      // 3. Record Cash Out (-₹200 milk purchase)
      await repository.recordCashMovement(
        sessionId: session.id,
        type: 'cash_out',
        amount: const Money.fromRupees(200),
        reason: 'Local milk purchase',
      );

      final sessionAfterOut = await repository.getActiveCashSession();
      expect(sessionAfterOut!.expectedCash, const Money.fromRupees(2300));

      // 4. Close session with actual counted ₹2,350 (+₹50 overage)
      final closed = await repository.closeCashSession(
        sessionId: session.id,
        actualCash: const Money.fromRupees(2350),
        notes: 'Shift completed successfully',
      );

      expect(closed.status, 'closed');
      expect(closed.closingCashActual, const Money.fromRupees(2350));
      expect(closed.variance, const Money.fromRupees(50)); // +₹50 overage

      // Verify no active session remains
      final noneActive = await repository.getActiveCashSession();
      expect(noneActive, isNull);
    });

    test('createAndSettleOrder atomically creates order, invoice, payment, cash movement, and outbox row offline', () async {
      // 1. Open active cash drawer session
      final session = await repository.openCashSession(const Money.fromRupees(1000));

      // 2. Build cart: 2 items of ₹150 + 5% GST (750 paise tax each)
      // Total payable = 2 * 15000 + 1500 = 31500 paise (₹315.00)
      const cart = CartState(
        items: [
          CartItem(
            id: 'line_1',
            productId: 'prod_latte',
            productName: 'Caffe Latte',
            unitPrice: Money.fromPaise(15000),
            quantity: 2,
            taxRateBps: 500,
            isTaxInclusive: false,
          ),
        ],
        orderType: OrderType.dineIn,
        customerName: 'Aarav Patel',
      );

      // 3. Settle offline cash payment
      final invoice = await repository.createAndSettleOrder(
        cart: cart,
        paymentMethod: 'cash',
        tendered: const Money.fromRupees(500),
        changeDue: const Money.fromPaise(18500), // ₹185.00 change
        cashSessionId: session.id,
      );

      // 4. Verify Invoice Details & Numbering Format per ADR-D3
      // Expected: KHD-A-{fiscal_year}-00001
      expect(invoice.invoiceNumber, startsWith('KHD-A-'));
      expect(invoice.invoiceNumber, endsWith('-00001'));
      expect(invoice.sequenceNumber, 1);
      expect(invoice.subtotal, const Money.fromPaise(30000));
      expect(invoice.totalTax, const Money.fromPaise(1500));
      expect(invoice.finalTotal, const Money.fromPaise(31500));
      expect(invoice.customerName, 'Aarav Patel');
      expect(invoice.items.length, 1);
      expect(invoice.payments.length, 1);
      expect(invoice.payments.first.method, 'cash');

      // 5. Verify local Drift database persistence (ADR-D1)
      final invoicesInDb = await repository.getInvoices();
      expect(invoicesInDb.length, 1);
      expect(invoicesInDb.first.id, invoice.id);

      final fullInvoice = await repository.getInvoiceById(invoice.id);
      expect(fullInvoice, isNotNull);
      expect(fullInvoice!.items.length, 1);
      expect(fullInvoice.payments.length, 1);

      // 6. Verify Outbox Row written in same transaction (ADR-D1)
      final outboxRows = await db.select(db.syncOutboxTable).get();
      expect(outboxRows.length, 1);
      final invoiceOutbox = outboxRows.firstWhere((r) => r.entityType == 'invoices');
      expect(invoiceOutbox.entityId, invoice.id);
      expect(invoiceOutbox.operation, 'INSERT');

      // 7. Verify cash drawer expected balance increased by ₹315.00 (from ₹1000 to ₹1315)
      final updatedSession = await repository.getActiveCashSession();
      expect(updatedSession!.expectedCash, const Money.fromPaise(131500));

      // 8. Subsequent invoice increments sequence monotonically
      final secondInvoice = await repository.createAndSettleOrder(
        cart: cart,
        paymentMethod: 'cash',
      );
      expect(secondInvoice.sequenceNumber, 2);
      expect(secondInvoice.invoiceNumber, endsWith('-00002'));
    });

    test('Refund creates reversal record and cash movement without altering original invoice (T4.10)', () async {
      final session = await repository.openCashSession(const Money.fromRupees(2000));

      const cart = CartState(
        items: [
          CartItem(
            id: 'l1',
            productId: 'p1',
            productName: 'Cold Brew',
            unitPrice: Money.fromPaise(10000),
            quantity: 1,
            taxRateBps: 0,
          ),
        ],
      );

      final invoice = await repository.createAndSettleOrder(
        cart: cart,
        paymentMethod: 'cash',
        cashSessionId: session.id,
      );

      // Process partial refund of ₹50.00
      final refund = await repository.processRefund(
        invoiceId: invoice.id,
        amount: const Money.fromPaise(5000),
        reason: 'Incorrect syrup added',
        refundMethod: 'cash',
        cashSessionId: session.id,
      );

      expect(refund.invoiceId, invoice.id);
      expect(refund.amount, const Money.fromPaise(5000));
      expect(refund.refundMethod, 'cash');

      // Original invoice remains untouched (immutable financial snapshot)
      final originalInvoice = await repository.getInvoiceById(invoice.id);
      expect(originalInvoice!.finalTotal, const Money.fromPaise(10000));
      expect(originalInvoice.status, 'issued');

      // Drawer expected cash decreased by refund amount
      final updatedSession = await repository.getActiveCashSession();
      // ₹2000 float + ₹100 sale - ₹50 refund = ₹2050
      expect(updatedSession!.expectedCash, const Money.fromPaise(205000));
    });

    test('Hold and resume cart saves and restores carts reliably (T4.2)', () async {
      const cart = CartState(
        items: [
          CartItem(
            id: 'line_hold_1',
            productId: 'p_cake',
            productName: 'Tiramisu',
            unitPrice: Money.fromPaise(25000),
            quantity: 1,
          ),
        ],
        tableId: 'tbl_4',
        customerName: 'Rohan',
      );

      // Save to held carts
      await repository.holdCart(label: 'Table 4 - Rohan', cart: cart);

      final heldList = await repository.getHeldCarts();
      expect(heldList.length, 1);
      expect(heldList.first['label'], 'Table 4 - Rohan');

      // Remove held cart when resumed
      final holdId = heldList.first['id'] as String;
      await repository.removeHeldCart(holdId);

      final emptyHeldList = await repository.getHeldCarts();
      expect(emptyHeldList, isEmpty);
    });
  });
}
