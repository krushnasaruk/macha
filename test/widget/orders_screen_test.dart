import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/orders/presentation/orders_screen.dart';

class FakeConnectivityService implements ConnectivityService {
  @override
  bool get isOnline => true;
  @override
  Stream<bool> get onConnectivityChanged => Stream.value(true);
  @override
  void dispose() {}
}

void main() {
  late AppDatabase db;
  late FakeConnectivityService connectivity;

  setUp(() async {
    db = AppDatabase.memory(NativeDatabase.memory());
    connectivity = FakeConnectivityService();

    await db.into(db.tenantsTable).insert(
          TenantsTableCompanion.insert(
            id: 'tenant_demo_001',
            name: 'Demo Café',
            slug: 'demo-cafe',
            updatedAt: DateTime.now(),
          ),
        );
    await db.into(db.branchesTable).insert(
          BranchesTableCompanion.insert(
            id: 'branch_khd_01',
            tenantId: 'tenant_demo_001',
            name: 'Main Branch',
            code: 'MAIN',
            updatedAt: DateTime.now(),
          ),
        );

    // Seed order with items and status history
    await db.into(db.ordersTable).insert(
          OrdersTableCompanion.insert(
            id: 'ord_history_test',
            tenantId: 'tenant_demo_001',
            branchId: 'branch_khd_01',
            orderNumber: 'ORD-501',
            status: const Value('confirmed'),
            subtotalPaise: const Value(25000),
            finalTotalPaise: const Value(26250),
            createdBy: 'Cashier',
          ),
        );
    await db.into(db.orderItemsTable).insert(
          OrderItemsTableCompanion.insert(
            id: 'item_cold_brew',
            orderId: 'ord_history_test',
            tenantId: 'tenant_demo_001',
            productId: 'prod_cb',
            productName: 'Nitro Cold Brew',
            unitPricePaise: 25000,
            subtotalPaise: 25000,
            taxablePaise: 25000,
            lineTotalPaise: 26250,
          ),
        );
    await db.into(db.orderStatusHistoryTable).insert(
          OrderStatusHistoryTableCompanion.insert(
            id: 'hist_1',
            orderId: 'ord_history_test',
            tenantId: 'tenant_demo_001',
            fromStatus: 'created',
            toStatus: 'confirmed',
            changedBy: 'Cashier Alice',
            notes: const Value('Customer paid at counter'),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        connectivityServiceProvider.overrideWithValue(connectivity),
        identityProviderInstance.overrideWithValue(
          DevIdentityProvider(initialRole: UserRole.cashier),
        ),
      ],
      child: const MaterialApp(
        home: OrdersScreen(),
      ),
    );
  }

  testWidgets('OrdersScreen renders orders list, filters, and detail dialog with timeline',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(createTestWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify Title
    expect(find.text('Orders'), findsOneWidget);

    // Verify Search and Filters
    expect(find.text('All Statuses'), findsOneWidget);
    expect(find.text('#ORD-501'), findsOneWidget);

    // Tap order card to open detail dialog
    await tester.tap(find.text('#ORD-501'));
    await tester.pumpAndSettle();

    // Verify Detail Dialog
    expect(find.text('Order #ORD-501'), findsOneWidget);
    expect(find.text('Nitro Cold Brew'), findsOneWidget);
    expect(find.text('Order Timeline'), findsOneWidget);
    expect(find.text('CREATED ➔ CONFIRMED'), findsOneWidget);
    expect(find.textContaining('Cashier Alice'), findsOneWidget);
    expect(find.textContaining('Customer paid at counter'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
