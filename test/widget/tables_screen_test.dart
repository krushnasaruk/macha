import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/orders/presentation/tables_screen.dart';

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

    // Seed two tables
    await db.into(db.diningTablesTable).insert(
          DiningTablesTableCompanion.insert(
            id: 'tbl_101',
            tenantId: 'tenant_demo_001',
            branchId: 'branch_khd_01',
            name: 'Table 101',
            capacity: const Value(4),
            floorZone: const Value('indoor'),
            status: const Value('vacant'),
            qrToken: 'qr101',
          ),
        );
    await db.into(db.diningTablesTable).insert(
          DiningTablesTableCompanion.insert(
            id: 'tbl_102',
            tenantId: 'tenant_demo_001',
            branchId: 'branch_khd_01',
            name: 'Table 102',
            capacity: const Value(2),
            floorZone: const Value('outdoor'),
            status: const Value('occupied'),
            qrToken: 'qr102',
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
          DevIdentityProvider(initialRole: UserRole.owner),
        ),
      ],
      child: const MaterialApp(
        home: TablesScreen(),
      ),
    );
  }

  testWidgets('TablesScreen renders dining tables, status badges, and opens session dialog on tap',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(createTestWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify screen title
    expect(find.text('Dining Tables'), findsOneWidget);

    // Verify Zone Filters
    expect(find.text('All Zones'), findsOneWidget);
    expect(find.widgetWithText(FilterChip, 'INDOOR'), findsOneWidget);
    expect(find.widgetWithText(FilterChip, 'OUTDOOR'), findsOneWidget);

    // Verify Tables displayed
    expect(find.text('Table 101'), findsOneWidget);
    expect(find.text('Table 102'), findsOneWidget);
    expect(find.text('VACANT'), findsOneWidget);
    expect(find.text('OCCUPIED'), findsOneWidget);

    // Tap vacant table to open session dialog
    await tester.tap(find.text('Table 101'));
    await tester.pumpAndSettle();

    expect(find.text('Open Table 101'), findsOneWidget);
    expect(find.text('Seat Guests'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
