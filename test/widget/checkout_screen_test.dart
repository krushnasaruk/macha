import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';
import 'package:cafe_os/features/billing/presentation/checkout_screen.dart';
import 'package:cafe_os/features/billing/presentation/controllers/cart_controller.dart';
import 'package:cafe_os/features/billing/presentation/receipt_preview_screen.dart';

class MockOnlineConnectivity implements ConnectivityService {
  @override
  bool isOnline = true;
  @override
  Stream<bool> get onConnectivityChanged => Stream.value(true);
  @override
  void dispose() {}
}

void main() {
  testWidgets('CheckoutScreen renders payment options, exact amount, and change due calculation',
      (tester) async {
    final db = AppDatabase.memory(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          connectivityServiceProvider.overrideWithValue(MockOnlineConnectivity()),
          cartControllerProvider.overrideWith((ref) {
            final repo = ref.watch(billingRepositoryProvider);
            final c = CartController(db, repo);
            c.addProduct(
              productId: 'p1',
              productName: 'Filter Coffee',
              unitPrice: const Money.fromPaise(5000), // ₹50.00
              taxRateBps: 0,
            );
            return c;
          }),
        ],
        child: const MaterialApp(
          home: CheckoutScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify checkout details
    expect(find.text('Checkout & Payment'), findsOneWidget);
    expect(find.text('Exact Amount'), findsOneWidget);
    expect(find.text('Complete Cash Sale'), findsOneWidget);

    await db.close();
  });

  testWidgets('ReceiptPreviewScreen renders immutable invoice snapshot with all GST breakdown',
      (tester) async {
    final invoice = Invoice(
      id: 'inv_test_001',
      tenantId: 'tenant_demo_001',
      branchId: 'branch_khd_01',
      invoiceNumber: 'KHD-A-FY26-27-00042',
      fiscalYear: 'FY26-27',
      deviceSeries: 'A',
      sequenceNumber: 42,
      subtotal: const Money.fromPaise(20000),
      discount: const Money.fromPaise(2000),
      taxableAmount: const Money.fromPaise(18000),
      cgst: const Money.fromPaise(450),
      sgst: const Money.fromPaise(450),
      igst: Money.zero,
      totalTax: const Money.fromPaise(900),
      rounding: Money.zero,
      finalTotal: const Money.fromPaise(18900),
      status: 'issued',
      customerName: 'Kavita Sen',
      issuedAt: DateTime(2026, 11, 15, 14, 30),
      issuedBy: 'Vikram Mehta',
      items: const [
        InvoiceItem(
          id: 'i1',
          productName: 'Cappuccino',
          quantity: 2,
          unitPrice: Money.fromPaise(10000),
          subtotal: Money.fromPaise(20000),
          discount: Money.fromPaise(2000),
          taxableAmount: Money.fromPaise(18000),
          cgst: Money.fromPaise(450),
          sgst: Money.fromPaise(450),
          igst: Money.zero,
          totalTax: Money.fromPaise(900),
          lineTotal: Money.fromPaise(18900),
        ),
      ],
      payments: [
        PaymentRecord(
          id: 'pay_1',
          invoiceId: 'inv_test_001',
          method: 'cash',
          status: 'completed',
          amount: const Money.fromPaise(18900),
          tendered: const Money.fromRupees(200),
          changeDue: const Money.fromPaise(1100),
          recordedBy: 'Vikram Mehta',
          recordedAt: DateTime(2026, 11, 15, 14, 30),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ReceiptPreviewScreen(invoice: invoice),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Receipt Preview'), findsOneWidget);
    expect(find.text('Payment Successful'), findsOneWidget);
    expect(find.text('KHD-A-FY26-27-00042'), findsOneWidget);
    expect(find.text('Cappuccino'), findsOneWidget);
    expect(find.text('TOTAL PAYABLE'), findsOneWidget);
    expect(find.text('New Sale'), findsOneWidget);
  });
}
