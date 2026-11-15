import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/domain/pricing/pricing_engine.dart';

void main() {
  group('Pricing Engine - Line Item Pricing (T4.1 & ADR-D2)', () {
    test('Standard item with exclusive tax calculates tax and total correctly', () {
      // Cappuccino: ₹100.00 (10000 paise), quantity 2, exclusive GST 5% (500 bps)
      const item = PricingLineInput(
        id: 'item_1',
        title: 'Cappuccino',
        unitPrice: Money.fromPaise(10000),
        quantity: 2,
        taxRateBps: 500, // 5.00%
        isTaxInclusive: false,
        taxType: TaxType.gstSplit,
      );

      final result = PricingEngine.calculateLine(item);

      expect(result.subtotal, const Money.fromPaise(20000)); // ₹200.00
      expect(result.discountAmount, Money.zero);
      expect(result.taxableAmount, const Money.fromPaise(20000));
      expect(result.cgst, const Money.fromPaise(500)); // 2.5% of 20000 = 500 paise (₹5.00)
      expect(result.sgst, const Money.fromPaise(500)); // 2.5% of 20000 = 500 paise (₹5.00)
      expect(result.igst, Money.zero);
      expect(result.totalTax, const Money.fromPaise(1000)); // ₹10.00
      expect(result.lineTotal, const Money.fromPaise(21000)); // ₹210.00
    });

    test('Standard item with inclusive tax extracts tax correctly', () {
      // Croissant: ₹105.00 (10500 paise) gross, quantity 1, inclusive GST 5% (500 bps)
      // Taxable = 10500 * 10000 / (10000 + 500) = 105000000 / 10500 = 10000 paise (₹100.00)
      // Total tax = 10500 - 10000 = 500 paise (₹5.00) -> CGST 250, SGST 250
      const item = PricingLineInput(
        id: 'item_2',
        title: 'Butter Croissant',
        unitPrice: Money.fromPaise(10500),
        quantity: 1,
        taxRateBps: 500,
        isTaxInclusive: true,
        taxType: TaxType.gstSplit,
      );

      final result = PricingEngine.calculateLine(item);

      expect(result.subtotal, const Money.fromPaise(10500));
      expect(result.taxableAmount, const Money.fromPaise(10000));
      expect(result.cgst, const Money.fromPaise(250));
      expect(result.sgst, const Money.fromPaise(250));
      expect(result.totalTax, const Money.fromPaise(500));
      expect(result.lineTotal, const Money.fromPaise(10500));
    });

    test('Zero-rated item calculates zero tax', () {
      // Fresh drinking water: ₹50.00, 0% tax
      const item = PricingLineInput(
        id: 'item_water',
        title: 'Mineral Water',
        unitPrice: Money.fromPaise(5000),
        quantity: 3,
        taxRateBps: 0,
        isTaxInclusive: false,
        taxType: TaxType.gstSplit,
      );

      final result = PricingEngine.calculateLine(item);

      expect(result.subtotal, const Money.fromPaise(15000));
      expect(result.taxableAmount, const Money.fromPaise(15000));
      expect(result.totalTax, Money.zero);
      expect(result.lineTotal, const Money.fromPaise(15000));
    });

    test('Fixed item discount reduces taxable amount and tax proportionally', () {
      // ₹200 item with ₹50 discount -> ₹150 taxable with 5% exclusive tax
      // 5% of 15000 = 750 paise -> CGST 375, SGST 375
      const item = PricingLineInput(
        id: 'item_discounted',
        title: 'Special Sandwich',
        unitPrice: Money.fromPaise(20000),
        quantity: 1,
        taxRateBps: 500,
        isTaxInclusive: false,
        taxType: TaxType.gstSplit,
        discount: LineDiscount.fixed(Money.fromPaise(5000)),
      );

      final result = PricingEngine.calculateLine(item);

      expect(result.subtotal, const Money.fromPaise(20000));
      expect(result.discountAmount, const Money.fromPaise(5000));
      expect(result.taxableAmount, const Money.fromPaise(15000));
      expect(result.totalTax, const Money.fromPaise(750));
      expect(result.lineTotal, const Money.fromPaise(15750));
    });

    test('Discount larger than line subtotal is capped at subtotal (never negative)', () {
      const item = PricingLineInput(
        id: 'item_overdiscount',
        title: 'Espresso',
        unitPrice: Money.fromPaise(8000),
        quantity: 1,
        taxRateBps: 500,
        isTaxInclusive: false,
        taxType: TaxType.gstSplit,
        discount: LineDiscount.fixed(Money.fromPaise(15000)), // ₹150 discount on ₹80 item
      );

      final result = PricingEngine.calculateLine(item);

      expect(result.discountAmount, const Money.fromPaise(8000));
      expect(result.taxableAmount, Money.zero);
      expect(result.totalTax, Money.zero);
      expect(result.lineTotal, Money.zero);
    });

    test('Rounding on odd-paise split tax distributes without losing 1 paise', () {
      // 1 item of ₹33.33 (3333 paise) with 5% exclusive tax
      // 5% of 3333 = 166.65 -> half-up total tax = 167 paise
      // CGST = round(3333 * 2.5%) = 83.325 -> 83 paise.
      // SGST = totalTax (167) - CGST (83) = 84 paise.
      // Sum CGST + SGST MUST equal totalTax (167 paise).
      const item = PricingLineInput(
        id: 'item_odd',
        title: 'Cookie',
        unitPrice: Money.fromPaise(3333),
        quantity: 1,
        taxRateBps: 500,
        isTaxInclusive: false,
        taxType: TaxType.gstSplit,
      );

      final result = PricingEngine.calculateLine(item);

      expect(result.totalTax.paise, 167);
      expect(result.cgst.paise + result.sgst.paise, result.totalTax.paise);
      expect(result.lineTotal.paise, 3333 + 167);
    });
  });

  group('Pricing Engine - Cart Level Calculation & Allocation', () {
    test('Calculates full cart with mixed tax rates and round-off to nearest rupee', () {
      // Item 1: ₹100 + 5% exclusive GST -> ₹105 (tax ₹5)
      // Item 2: ₹210 inclusive 5% GST -> ₹210 (taxable ₹200, tax ₹10)
      // Item 3: ₹50 0% GST -> ₹50
      const cart = PricingCartInput(
        lines: [
          PricingLineInput(
            id: 'l1',
            title: 'Coffee',
            unitPrice: Money.fromPaise(10000),
            quantity: 1,
            taxRateBps: 500,
            isTaxInclusive: false,
          ),
          PricingLineInput(
            id: 'l2',
            title: 'Pastry',
            unitPrice: Money.fromPaise(21000),
            quantity: 1,
            taxRateBps: 500,
            isTaxInclusive: true,
          ),
          PricingLineInput(
            id: 'l3',
            title: 'Water',
            unitPrice: Money.fromPaise(5000),
            quantity: 1,
            taxRateBps: 0,
            isTaxInclusive: false,
          ),
        ],
        cartDiscount: CartDiscount.none(),
        roundOff: true,
      );

      final result = PricingEngine.calculateCart(cart);

      // Subtotals: 10000 + 21000 + 5000 = 36000
      expect(result.grossSubtotal, const Money.fromPaise(36000));
      // Taxable: 10000 + 20000 + 5000 = 35000
      expect(result.taxableAmount, const Money.fromPaise(35000));
      // Total tax: 500 (from l1) + 1000 (from l2) + 0 = 1500
      expect(result.totalTax, const Money.fromPaise(1500));
      // Total payable before round-off: 10500 + 21000 + 5000 = 36500 paise (₹365.00)
      expect(result.finalPayable, const Money.fromPaise(36500));
      expect(result.roundingDelta, Money.zero);
    });

    test('Round-off rounds to nearest rupee (half-up at 50 paise)', () {
      // Line total ₹100.40 (10040 paise) -> rounds down to ₹100.00 (-40 delta)
      const cart1 = PricingCartInput(
        lines: [
          PricingLineInput(
            id: 'l1',
            title: 'Snack',
            unitPrice: Money.fromPaise(10040),
            quantity: 1,
            taxRateBps: 0,
            isTaxInclusive: false,
          ),
        ],
        roundOff: true,
      );
      final res1 = PricingEngine.calculateCart(cart1);
      expect(res1.roundingDelta.paise, -40);
      expect(res1.finalPayable, const Money.fromPaise(10000));

      // Line total ₹100.60 (10060 paise) -> rounds up to ₹101.00 (+40 delta)
      const cart2 = PricingCartInput(
        lines: [
          PricingLineInput(
            id: 'l2',
            title: 'Snack',
            unitPrice: Money.fromPaise(10060),
            quantity: 1,
            taxRateBps: 0,
            isTaxInclusive: false,
          ),
        ],
        roundOff: true,
      );
      final res2 = PricingEngine.calculateCart(cart2);
      expect(res2.roundingDelta.paise, 40);
      expect(res2.finalPayable, const Money.fromPaise(10100));
    });

    test('Cart percentage discount is applied accurately and proportionally', () {
      // 2 items each ₹100, cart discount 10% (1000 bps)
      // Total before discount ₹200
      // 10% discount = ₹20 (2000 paise)
      // Net ₹180 + 5% tax (₹9) = ₹189
      const cart = PricingCartInput(
        lines: [
          PricingLineInput(
            id: 'l1',
            title: 'Coffee 1',
            unitPrice: Money.fromPaise(10000),
            quantity: 1,
            taxRateBps: 500,
            isTaxInclusive: false,
          ),
          PricingLineInput(
            id: 'l2',
            title: 'Coffee 2',
            unitPrice: Money.fromPaise(10000),
            quantity: 1,
            taxRateBps: 500,
            isTaxInclusive: false,
          ),
        ],
        cartDiscount: CartDiscount.percentage(1000), // 10%
        roundOff: true,
      );

      final result = PricingEngine.calculateCart(cart);

      expect(result.grossSubtotal, const Money.fromPaise(20000));
      expect(result.cartDiscountAmount, const Money.fromPaise(2000));
      expect(result.taxableAmount, const Money.fromPaise(18000));
      expect(result.totalTax, const Money.fromPaise(900));
      expect(result.finalPayable, const Money.fromPaise(18900));
    });
  });
}
