import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/kitchen/presentation/kitchen_screen.dart';

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

    // Seed kitchen station
    await db.into(db.kitchenStationsTable).insert(
          KitchenStationsTableCompanion.insert(
            id: 'st_bar',
            tenantId: 'tenant_demo_001',
            branchId: 'branch_khd_01',
            name: 'Espresso Bar',
            code: 'BAR',
          ),
        );

    // Seed confirmed order with items
    await db.into(db.ordersTable).insert(
          OrdersTableCompanion.insert(
            id: 'ord_kds_test',
            tenantId: 'tenant_demo_001',
            branchId: 'branch_khd_01',
            orderNumber: 'KDS-99',
            status: const Value('confirmed'),
            createdBy: 'Cashier',
          ),
        );
    await db.into(db.orderItemsTable).insert(
          OrderItemsTableCompanion.insert(
            id: 'item_cappuccino',
            orderId: 'ord_kds_test',
            tenantId: 'tenant_demo_001',
            productId: 'prod_cap',
            productName: 'Cappuccino',
            unitPricePaise: 16000,
            subtotalPaise: 16000,
            taxablePaise: 16000,
            lineTotalPaise: 16000,
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
          DevIdentityProvider(initialRole: UserRole.kitchenStaff),
        ),
      ],
      child: const MaterialApp(
        home: KitchenScreen(),
      ),
    );
  }

  testWidgets('KitchenScreen renders 3-column tablet KDS layout, station filter, and bumps ticket',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(createTestWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify Title
    expect(find.text('Kitchen Display System (KDS)'), findsOneWidget);

    // Verify Stations Filter
    expect(find.text('All Stations'), findsOneWidget);
    expect(find.text('Espresso Bar'), findsOneWidget);

    // Verify 3 Column Headers
    expect(find.textContaining('NEW ORDERS'), findsOneWidget);
    expect(find.textContaining('PREPARING'), findsOneWidget);
    expect(find.textContaining('READY TO SERVE'), findsOneWidget);

    // Verify Ticket card displayed
    expect(find.text('#KDS-99'), findsOneWidget);
    expect(find.text('Cappuccino'), findsOneWidget);
    expect(find.text('Start Prep'), findsOneWidget);

    // Tap "Start Prep" to bump
    await tester.tap(find.text('Start Prep'));
    await tester.pumpAndSettle();

    // Verify order moved to PREPARING column
    expect(find.text('Mark Ready'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
