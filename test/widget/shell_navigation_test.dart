import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/app.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';

void main() {
  testWidgets('Owner role displays all navigation destinations on tablet', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final devId = DevIdentityProvider(initialRole: UserRole.owner);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityProviderInstance.overrideWithValue(devId),
        ],
        child: const CafeOsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('POS'), findsOneWidget);
    expect(find.text('Tables'), findsOneWidget);
    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Inventory'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Cashier role filters out Kitchen, Inventory, and Reports', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final devId = DevIdentityProvider(initialRole: UserRole.cashier);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityProviderInstance.overrideWithValue(devId),
        ],
        child: const CafeOsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('POS'), findsOneWidget);
    expect(find.text('Tables'), findsOneWidget);
    expect(find.text('Kitchen'), findsNothing);
    expect(find.text('Inventory'), findsNothing);
    expect(find.text('Reports'), findsNothing);
  });

  testWidgets('Kitchen staff role displays Kitchen and Menu, but no POS', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final devId = DevIdentityProvider(initialRole: UserRole.kitchenStaff);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityProviderInstance.overrideWithValue(devId),
        ],
        child: const CafeOsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('POS'), findsNothing);
    expect(find.text('Reports'), findsNothing);
  });
}
