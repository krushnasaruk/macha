import 'package:intl/intl.dart';

/// An immutable value object representing a monetary amount stored in minor units (paise).
///
/// Doubles are strictly prohibited for monetary calculations (ADR-D2).
class Money implements Comparable<Money> {
  final int paise;

  const Money._(this.paise);

  /// Creates a [Money] instance from the integer number of minor units (e.g. paise).
  const Money.fromPaise(this.paise);

  /// Creates a [Money] instance representing zero.
  static const Money zero = Money._(0);

  /// Creates a [Money] instance from major units (e.g. Rupees) and minor units.
  factory Money.fromRupees(int rupees, [int paise = 0]) {
    return Money._(rupees * 100 + paise);
  }

  /// Parses a string representation such as "120" or "120.50" into [Money].
  /// Does not use double parsing; parses string parts directly.
  factory Money.parse(String text) {
    final clean = text.trim().replaceAll(',', '').replaceAll('₹', '');
    if (clean.isEmpty) return Money.zero;

    final isNegative = clean.startsWith('-');
    final absText = isNegative ? clean.substring(1) : clean;

    final parts = absText.split('.');
    if (parts.length > 2) {
      throw FormatException('Invalid currency format: $text');
    }

    final rupees = int.parse(parts[0].isEmpty ? '0' : parts[0]);
    int minor = 0;
    if (parts.length == 2) {
      final decimalPart = parts[1];
      if (decimalPart.length == 1) {
        minor = int.parse(decimalPart) * 10;
      } else if (decimalPart.length >= 2) {
        minor = int.parse(decimalPart.substring(0, 2));
      }
    }

    final total = rupees * 100 + minor;
    return Money._(isNegative ? -total : total);
  }

  /// Safe parse that returns null on failure.
  static Money? tryParse(String? text) {
    if (text == null) return null;
    try {
      return Money.parse(text);
    } catch (_) {
      return null;
    }
  }

  /// Whole major units (e.g. Rupees).
  int get rupees => paise ~/ 100;

  /// Remainder minor units (0..99).
  int get minorUnits => (paise % 100).abs();

  bool get isNegative => paise < 0;
  bool get isZero => paise == 0;
  bool get isPositive => paise > 0;

  Money operator +(Money other) => Money._(paise + other.paise);
  Money operator -(Money other) => Money._(paise - other.paise);
  Money operator -() => Money._(-paise);

  /// Multiplies by an integer quantity.
  Money operator *(int quantity) => Money._(paise * quantity);

  /// Divides by an integer divisor, truncating remainder.
  Money operator ~/(int divisor) => Money._(paise ~/ divisor);

  /// Computes a percentage basis points (1% = 100 basis points).
  /// For instance, 18% GST = 1800 basis points.
  /// Uses round-half-up integer arithmetic.
  Money percent(int percentBasisPoints) {
    final result = (paise * percentBasisPoints + 5000) ~/ 10000;
    return Money._(result);
  }

  /// Formats the money value into standard display string (e.g. ₹1,250.00).
  String format({bool includeSymbol = true, String symbol = '₹'}) {
    final absPaise = paise.abs();
    final whole = absPaise ~/ 100;
    final frac = (absPaise % 100).toString().padLeft(2, '0');

    final numberFormat = NumberFormat('#,##,##0', 'en_IN');
    final formattedWhole = numberFormat.format(whole);
    final sign = isNegative ? '-' : '';
    final symbolPrefix = includeSymbol ? '$symbol ' : '';

    return '$sign$symbolPrefix$formattedWhole.$frac';
  }

  @override
  int compareTo(Money other) => paise.compareTo(other.paise);

  bool operator <(Money other) => paise < other.paise;
  bool operator <=(Money other) => paise <= other.paise;
  bool operator >(Money other) => paise > other.paise;
  bool operator >=(Money other) => paise >= other.paise;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Money && other.paise == paise);

  @override
  int get hashCode => paise.hashCode;

  @override
  String toString() => format();
}
