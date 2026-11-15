import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/presentation/pos_screen.dart';
import 'package:cafe_os/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:cafe_os/features/menu/domain/models/menu_models.dart';

class FakeConnectivity implements ConnectivityService {
  @override
  bool isOnline = true;
  @override
  Stream<bool> get onConnectivityChanged => Stream.value(true);
  @override
  void dispose() {}
}

void main() {
  testWidgets('POS Screen renders catalog, adds item to cart, and calculates total (M1 Milestone)',
      (tester) async {
    final db = AppDatabase.memory(NativeDatabase.memory());

    const testCategories = [
      Category(
        id: 'cat_coffee',
        tenantId: 'tenant_demo_001',
        name: 'Hot Brews',
        slug: 'hot-brews',
      ),
    ];

    const testProducts = [
      Product(
        id: 'prod_americano',
        tenantId: 'tenant_demo_001',
        categoryId: 'cat_coffee',
        name: 'Classic Americano',
        basePrice: Money.fromPaise(12000), // ₹120.00
      ),
      Product(
        id: 'prod_croissant',
        tenantId: 'tenant_demo_001',
        categoryId: 'cat_coffee',
        name: 'Almond Croissant',
        basePrice: Money.fromPaise(18000), // ₹180.00
      ),
    ];

    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          connectivityServiceProvider.overrideWithValue(FakeConnectivity()),
          menuCategoriesProvider.overrideWith((ref) async => testCategories),
          menuProductsProvider.overrideWith((ref) async => testProducts),
          posHeldCartsProvider.overrideWith((ref) async => []),
        ],
        child: const MaterialApp(
          home: PosScreen(),
        ),
      ),
    );

    // Initial pump and settle
    await tester.pumpAndSettle();

    // Verify UI elements
    expect(find.text('MΛCHA POS'), findsOneWidget);
    expect(find.text('Classic Americano'), findsOneWidget);
    expect(find.text('Almond Croissant'), findsOneWidget);
    expect(find.text('Current Sale (0)'), findsOneWidget);

    // Tap budget test: 1 tap on Classic Americano adds directly to cart
    await tester.tap(find.text('Classic Americano'));
    await tester.pumpAndSettle();

    // Cart total ticks, showing 1 item and ₹126.00 (with 5% GST = 120 + 6)
    expect(find.text('Current Sale (1)'), findsOneWidget);
    expect(find.text('Charge · ₹ 126.00'), findsOneWidget);

    // Tap second item: Almond Croissant
    await tester.tap(find.text('Almond Croissant'));
    await tester.pumpAndSettle();

    expect(find.text('Current Sale (2)'), findsOneWidget);

    // Clean up
    await db.close();
  });
}
