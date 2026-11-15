import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/values/money.dart';

void main() {
  group('Money value object', () {
    test('creates from paise correctly', () {
      const m = Money.fromPaise(15050);
      expect(m.paise, 15050);
      expect(m.rupees, 150);
      expect(m.minorUnits, 50);
      expect(m.format(), '₹ 150.50');
    });

    test('creates from rupees and paise', () {
      const m = Money.fromRupees(250, 75);
      expect(m.paise, 25075);
      expect(m.format(), '₹ 250.75');
    });

    test('handles zero', () {
      expect(Money.zero.paise, 0);
      expect(Money.zero.isZero, isTrue);
      expect(Money.zero.format(), '₹ 0.00');
    });

    test('parses plain integers and decimal strings without double float conversion', () {
      expect(Money.parse('100').paise, 10000);
      expect(Money.parse('100.5').paise, 10050);
      expect(Money.parse('100.50').paise, 10050);
      expect(Money.parse('100.05').paise, 10005);
      expect(Money.parse('₹ 1,234.50').paise, 123450);
      expect(Money.parse('-50.25').paise, -5025);
    });

    test('arithmetic operations preserve exact paise precision', () {
      const a = Money.fromRupees(100, 50); // 10050
      const b = Money.fromRupees(49, 75);  // 4975

      expect((a + b).paise, 15025);
      expect((a - b).paise, 5075);
      expect((b * 3).paise, 14925);
      expect((a ~/ 2).paise, 5025);
      expect((-a).paise, -10050);
    });

    test('percent calculates basis points with half-up rounding', () {
      // 18% of 100.00 = 18.00
      const m = Money.fromRupees(100);
      expect(m.percent(1800).paise, 1800);

      // 5% of 99.50 = 4.975 -> rounded to 4.98 (498 paise)
      const m2 = Money.fromPaise(9950);
      expect(m2.percent(500).paise, 498);
    });

    test('comparison operators work correctly', () {
      const smaller = Money.fromRupees(50);
      const larger = Money.fromRupees(100);

      expect(smaller < larger, isTrue);
      expect(smaller <= larger, isTrue);
      expect(larger > smaller, isTrue);
      expect(larger >= smaller, isTrue);
      expect(smaller == const Money.fromPaise(5000), isTrue);
    });
  });
}
