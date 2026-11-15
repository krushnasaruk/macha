import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/errors/app_failure.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/menu/domain/models/menu_models.dart';

void main() {
  group('Menu Validation Rules (T3.4)', () {
    const milkGroup = ModifierGroup(
      id: 'grp_milk',
      tenantId: 'tenant_demo_001',
      name: 'Milk Choice',
      minSelection: 1,
      maxSelection: 1,
      isMandatory: true,
      modifiers: [
        Modifier(
          id: 'mod_whole',
          groupId: 'grp_milk',
          name: 'Whole Milk',
          priceDelta: Money.zero,
        ),
        Modifier(
          id: 'mod_oat',
          groupId: 'grp_milk',
          name: 'Oat Milk Barista',
          priceDelta: Money.fromPaise(4000),
        ),
      ],
    );

    test('mandatory group throws ValidationFailure if no option is selected', () {
      expect(
        () => milkGroup.validateSelection([]),
        throwsA(isA<ValidationFailure>().having(
          (e) => e.message,
          'message',
          contains('Please select at least one item from Milk Choice'),
        )),
      );
    });

    test('group throws ValidationFailure if selection exceeds maxSelection', () {
      expect(
        () => milkGroup.validateSelection(milkGroup.modifiers),
        throwsA(isA<ValidationFailure>().having(
          (e) => e.message,
          'message',
          contains('cannot exceed 1 item(s)'),
        )),
      );
    });

    test('valid single selection succeeds without exception', () {
      expect(
        () => milkGroup.validateSelection([milkGroup.modifiers.first]),
        returnsNormally,
      );
    });
  });

  group('Price Snapshot Structures & Minor Unit Calculations (T3.4 & ADR-D2)', () {
    final cappuccino = Product(
      id: 'prod_cap_01',
      tenantId: 'tenant_demo_001',
      categoryId: 'cat_coffee',
      name: 'Artisan Cappuccino',
      basePrice: Money.fromRupees(180), // 18000 paise
    );

    final grandeVariant = ProductVariant(
      id: 'var_grande',
      productId: 'prod_cap_01',
      name: 'Grande',
      priceDelta: Money.fromRupees(40), // 4000 paise
    );

    final oatMilk = Modifier(
      id: 'mod_oat',
      groupId: 'grp_milk',
      name: 'Oat Milk',
      priceDelta: Money.fromRupees(40), // 4000 paise
    );

    final extraShot = Modifier(
      id: 'mod_shot',
      groupId: 'grp_shots',
      name: 'Extra Espresso Shot',
      priceDelta: Money.fromRupees(35), // 3500 paise
    );

    test('calculates base price when no variant or modifiers selected', () {
      final price = cappuccino.computeEffectivePrice();
      expect(price.paise, 18000);
      expect(price.format(), '₹ 180.00');
    });

    test('adds variant price delta to base price exactly in minor units', () {
      final price = cappuccino.computeEffectivePrice(variant: grandeVariant);
      expect(price.paise, 22000); // 180 + 40 = 220
      expect(price.format(), '₹ 220.00');
    });

    test('sums variant and multiple modifiers accurately without floating point drift', () {
      final price = cappuccino.computeEffectivePrice(
        variant: grandeVariant,
        selectedModifiers: [oatMilk, extraShot],
      );
      // 180 + 40 (grande) + 40 (oat) + 35 (extra shot) = 295.00 (29500 paise)
      expect(price.paise, 29500);
      expect(price.format(), '₹ 295.00');
    });

    test('branch override price takes precedence over base price', () {
      final airportOverride = Money.fromRupees(220); // Airport price 220
      final price = cappuccino.computeEffectivePrice(
        branchOverridePrice: airportOverride,
        variant: grandeVariant, // +40
        selectedModifiers: [oatMilk], // +40
      );
      // 220 + 40 + 40 = 300.00
      expect(price.paise, 30000);
      expect(price.format(), '₹ 300.00');
    });
  });
}
