import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/mascot/mascot_asset_registry.dart';
import 'package:cafe_os/core/mascot/mascot_celebration.dart';
import 'package:cafe_os/core/mascot/mascot_dialogue_bubble.dart';
import 'package:cafe_os/core/mascot/mascot_empty_state.dart';
import 'package:cafe_os/core/mascot/mascot_guided_tour.dart';
import 'package:cafe_os/core/mascot/mascot_widget.dart';
import 'package:cafe_os/core/values/money.dart';

void main() {
  group('Mascot Asset Registry Tests', () {
    test('All expressions resolve to expected paths', () {
      expect(MascotExpression.neutral.path, contains('neutral.png'));
      expect(MascotExpression.happy.path, contains('happy.png'));
      expect(MascotExpression.thinking.path, contains('thinking.png'));
      expect(MascotExpression.sad.path, contains('sad.png'));
    });

    test('All paw studies resolve to expected paths', () {
      expect(MascotPawStudy.pointing.path, contains('paws/pointing.png'));
      expect(MascotPawStudy.thumbsUp.path, contains('paws/thumbs_up.png'));
      expect(MascotPawStudy.holdingCup.path, contains('paws/holding_cup.png'));
    });

    test('All object interactions resolve to expected paths', () {
      expect(MascotObjectInteraction.coffeeCup.path, contains('object_interactions/coffee_cup.png'));
      expect(MascotObjectInteraction.servingTray.path, contains('object_interactions/serving_tray.png'));
      expect(MascotObjectInteraction.trophy.path, contains('object_interactions/trophy.png'));
    });

    test('Model sheets are registered in MascotAssetRegistry', () {
      expect(MascotAssetRegistry.facialExpressionSheet, contains('facial_expression_sheet.png'));
      expect(MascotAssetRegistry.pawAnatomySheet, contains('paw_anatomy_sheet.png'));
      expect(MascotAssetRegistry.objectInteractionSheet, contains('object_interaction_sheet.png'));
      expect(MascotAssetRegistry.poseReferenceSheet, contains('pose_reference_sheet.png'));
    });

    test('All chef actions resolve to expected paths', () {
      expect(MascotAction.holdingCoffeeCup.path, contains('holding_coffee_cup.png'));
      expect(MascotAction.holdingTray.path, contains('holding_tray.png'));
      expect(MascotAction.cookingPan.path, contains('cooking_pan.png'));
    });

    test('All application state illustrations resolve to expected paths', () {
      expect(MascotStateIllustration.offlineConcerned.path, contains('offline_concerned.png'));
      expect(MascotStateIllustration.emptyPlate.path, contains('empty_plate.png'));
      expect(MascotStateIllustration.celebratingSuccess.path, contains('celebrating_success.png'));
    });
  });

  group('Mascot Widget & Dialogue Bubble Widget Tests', () {
    testWidgets('MascotWidget renders with dialogue bubble and title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MascotWidget(
              expression: MascotExpression.happy,
              height: 120,
              dialogue: 'Welcome to CaféOS!',
              dialogueTitle: 'Chef Barnaby',
              tailPosition: BubbleTailPosition.bottom,
            ),
          ),
        ),
      );

      expect(find.text('Chef Barnaby'), findsOneWidget);
      expect(find.text('Welcome to CaféOS!'), findsOneWidget);
    });

    testWidgets('MascotWidget renders with object interaction and paw study', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MascotWidget(
                  objectInteraction: MascotObjectInteraction.coffeeCup,
                  height: 120,
                ),
                MascotWidget(
                  pawStudy: MascotPawStudy.thumbsUp,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(MascotWidget), findsNWidgets(2));
    });

    testWidgets('MascotEmptyState renders with action button', (tester) async {
      bool actionTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MascotEmptyState.menu(
              onAddProduct: () => actionTriggered = true,
            ),
          ),
        ),
      );

      expect(find.text('Your Menu is Empty'), findsOneWidget);
      expect(find.text('Add First Product'), findsOneWidget);

      await tester.tap(find.text('Add First Product'));
      await tester.pumpAndSettle();

      expect(actionTriggered, isTrue);
    });

    testWidgets('MascotCelebration renders settled amount and invoice', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MascotCelebration(
              title: 'Order Completed!',
              message: 'Settled at counter.',
              amountSettled: const Money.fromRupees(350),
              invoiceNumber: 'INV-001',
              onDismiss: () {},
            ),
          ),
        ),
      );

      expect(find.text('Order Completed!'), findsOneWidget);
      expect(find.text('Invoice #INV-001'), findsOneWidget);
      expect(find.text('₹ 350.00'), findsOneWidget);
      expect(find.text('Ring Up Next Customer'), findsOneWidget);
    });

    testWidgets('MascotGuidedTourModal navigates steps and closes on finish', (tester) async {
      bool tourDismissed = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            identityProviderInstance.overrideWithValue(
              DevIdentityProvider(initialRole: UserRole.owner),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: MascotGuidedTourModal(
                onDismiss: () => tourDismissed = true,
              ),
            ),
          ),
        ),
      );

      // Verify Step 1
      expect(find.text('Step 1 of 7'), findsOneWidget);
      expect(find.text('Welcome to MΛCHA!'), findsOneWidget);

      // Tap Next
      await tester.tap(find.text('Show Me Around'));
      await tester.pumpAndSettle();

      // Verify Step 2
      expect(find.text('Step 2 of 7'), findsOneWidget);
      expect(find.text('POS & Billing Counter'), findsOneWidget);

      // Skip tour
      await tester.tap(find.text('Skip Tour'));
      await tester.pumpAndSettle();

      expect(tourDismissed, isTrue);
    });
  });
}
