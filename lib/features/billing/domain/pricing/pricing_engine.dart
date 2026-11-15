import 'package:cafe_os/core/values/money.dart';

enum TaxType {
  /// Intra-state: CGST (50%) + SGST (50%)
  gstSplit,

  /// Inter-state: IGST (100%)
  igst,
}

enum DiscountType {
  none,
  percentage,
  fixed,
}

class LineDiscount {
  final DiscountType type;
  final int percentageBps; // Basis points, e.g., 1000 = 10.00%
  final Money fixedAmount;

  const LineDiscount.none()
      : type = DiscountType.none,
        percentageBps = 0,
        fixedAmount = Money.zero;

  const LineDiscount.percentage(this.percentageBps)
      : type = DiscountType.percentage,
        fixedAmount = Money.zero;

  const LineDiscount.fixed(this.fixedAmount)
      : type = DiscountType.fixed,
        percentageBps = 0;

  Money calculateDiscount(Money subtotal) {
    if (subtotal.isZero) return Money.zero;
    switch (type) {
      case DiscountType.none:
        return Money.zero;
      case DiscountType.percentage:
        final disc = subtotal.percent(percentageBps);
        return disc > subtotal ? subtotal : disc;
      case DiscountType.fixed:
        return fixedAmount > subtotal ? subtotal : fixedAmount;
    }
  }
}

class CartDiscount {
  final DiscountType type;
  final int percentageBps;
  final Money fixedAmount;

  const CartDiscount.none()
      : type = DiscountType.none,
        percentageBps = 0,
        fixedAmount = Money.zero;

  const CartDiscount.percentage(this.percentageBps)
      : type = DiscountType.percentage,
        fixedAmount = Money.zero;

  const CartDiscount.fixed(this.fixedAmount)
      : type = DiscountType.fixed,
        percentageBps = 0;

  Money calculateDiscount(Money netSubtotal) {
    if (netSubtotal.isZero) return Money.zero;
    switch (type) {
      case DiscountType.none:
        return Money.zero;
      case DiscountType.percentage:
        final disc = netSubtotal.percent(percentageBps);
        return disc > netSubtotal ? netSubtotal : disc;
      case DiscountType.fixed:
        return fixedAmount > netSubtotal ? netSubtotal : fixedAmount;
    }
  }
}

class PricingLineInput {
  final String id;
  final String title;
  final Money unitPrice;
  final int quantity;
  final int taxRateBps; // e.g. 500 = 5.00%, 1800 = 18.00%
  final bool isTaxInclusive;
  final TaxType taxType;
  final LineDiscount discount;

  const PricingLineInput({
    required this.id,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    this.taxRateBps = 0,
    this.isTaxInclusive = false,
    this.taxType = TaxType.gstSplit,
    this.discount = const LineDiscount.none(),
  });
}

class CalculatedLineItem {
  final String id;
  final String title;
  final Money unitPrice;
  final int quantity;
  final Money subtotal;
  final Money discountAmount;
  final Money taxableAmount;
  final Money cgst;
  final Money sgst;
  final Money igst;
  final Money totalTax;
  final Money lineTotal;
  final int taxRateBps;
  final bool isTaxInclusive;

  const CalculatedLineItem({
    required this.id,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    required this.subtotal,
    required this.discountAmount,
    required this.taxableAmount,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.totalTax,
    required this.lineTotal,
    required this.taxRateBps,
    required this.isTaxInclusive,
  });
}

class PricingCartInput {
  final List<PricingLineInput> lines;
  final CartDiscount cartDiscount;
  final bool roundOff;

  const PricingCartInput({
    required this.lines,
    this.cartDiscount = const CartDiscount.none(),
    this.roundOff = true,
  });
}

class CalculatedCart {
  final List<CalculatedLineItem> lines;
  final Money grossSubtotal;
  final Money totalItemDiscounts;
  final Money cartDiscountAmount;
  final Money totalDiscounts;
  final Money taxableAmount;
  final Money cgstTotal;
  final Money sgstTotal;
  final Money igstTotal;
  final Money totalTax;
  final Money payableBeforeRounding;
  final Money roundingDelta;
  final Money finalPayable;

  const CalculatedCart({
    required this.lines,
    required this.grossSubtotal,
    required this.totalItemDiscounts,
    required this.cartDiscountAmount,
    required this.totalDiscounts,
    required this.taxableAmount,
    required this.cgstTotal,
    required this.sgstTotal,
    required this.igstTotal,
    required this.totalTax,
    required this.payableBeforeRounding,
    required this.roundingDelta,
    required this.finalPayable,
  });
}

class PricingEngine {
  /// Pure integer division with half-up rounding: (num + den/2) / den
  static int _roundHalfUpDivision(int numerator, int denominator) {
    if (denominator == 0) return 0;
    if (numerator < 0) {
      return -_roundHalfUpDivision(-numerator, denominator);
    }
    return (numerator + (denominator ~/ 2)) ~/ denominator;
  }

  /// Calculates a single line item without cart-level discount.
  static CalculatedLineItem calculateLine(
    PricingLineInput item, {
    Money additionalDiscount = Money.zero,
  }) {
    final subtotalPaise = item.unitPrice.paise * item.quantity;
    final subtotal = Money.fromPaise(subtotalPaise);

    final itemDisc = item.discount.calculateDiscount(subtotal);
    final totalDiscPaise = (itemDisc.paise + additionalDiscount.paise)
        .clamp(0, subtotalPaise);
    final totalDisc = Money.fromPaise(totalDiscPaise);

    final discountedAmountPaise = subtotalPaise - totalDiscPaise;

    int taxablePaise;
    int totalTaxPaise;

    if (item.taxRateBps == 0 || discountedAmountPaise == 0) {
      taxablePaise = discountedAmountPaise;
      totalTaxPaise = 0;
    } else if (item.isTaxInclusive) {
      // Inclusive tax: Taxable = Gross * 10000 / (10000 + taxRateBps)
      taxablePaise = _roundHalfUpDivision(
        discountedAmountPaise * 10000,
        10000 + item.taxRateBps,
      );
      totalTaxPaise = discountedAmountPaise - taxablePaise;
    } else {
      // Exclusive tax: Tax = Taxable * taxRateBps / 10000
      taxablePaise = discountedAmountPaise;
      totalTaxPaise = _roundHalfUpDivision(
        taxablePaise * item.taxRateBps,
        10000,
      );
    }

    int cgstPaise = 0;
    int sgstPaise = 0;
    int igstPaise = 0;

    if (totalTaxPaise > 0) {
      if (item.taxType == TaxType.igst) {
        igstPaise = totalTaxPaise;
      } else {
        // GST split: half to CGST, remainder to SGST to ensure sum == totalTax
        final halfTaxRateBps = item.taxRateBps ~/ 2;
        if (item.isTaxInclusive) {
          // Half of total tax
          cgstPaise = totalTaxPaise ~/ 2;
          sgstPaise = totalTaxPaise - cgstPaise;
        } else {
          cgstPaise = _roundHalfUpDivision(taxablePaise * halfTaxRateBps, 10000);
          sgstPaise = totalTaxPaise - cgstPaise;
        }
      }
    }

    final lineTotalPaise = item.isTaxInclusive
        ? discountedAmountPaise
        : taxablePaise + totalTaxPaise;

    return CalculatedLineItem(
      id: item.id,
      title: item.title,
      unitPrice: item.unitPrice,
      quantity: item.quantity,
      subtotal: subtotal,
      discountAmount: totalDisc,
      taxableAmount: Money.fromPaise(taxablePaise),
      cgst: Money.fromPaise(cgstPaise),
      sgst: Money.fromPaise(sgstPaise),
      igst: Money.fromPaise(igstPaise),
      totalTax: Money.fromPaise(totalTaxPaise),
      lineTotal: Money.fromPaise(lineTotalPaise),
      taxRateBps: item.taxRateBps,
      isTaxInclusive: item.isTaxInclusive,
    );
  }

  /// Calculates a full cart including cart-level discount allocation and round-off.
  static CalculatedCart calculateCart(PricingCartInput cart) {
    if (cart.lines.isEmpty) {
      return const CalculatedCart(
        lines: [],
        grossSubtotal: Money.zero,
        totalItemDiscounts: Money.zero,
        cartDiscountAmount: Money.zero,
        totalDiscounts: Money.zero,
        taxableAmount: Money.zero,
        cgstTotal: Money.zero,
        sgstTotal: Money.zero,
        igstTotal: Money.zero,
        totalTax: Money.zero,
        payableBeforeRounding: Money.zero,
        roundingDelta: Money.zero,
        finalPayable: Money.zero,
      );
    }

    // 1. Calculate unallocated lines to find net line subtotals
    int grossSubtotalPaise = 0;
    int totalItemDiscountsPaise = 0;
    final lineNetPaiseList = <int>[];

    for (final line in cart.lines) {
      final lineSubtotal = line.unitPrice.paise * line.quantity;
      final lineDisc = line.discount.calculateDiscount(Money.fromPaise(lineSubtotal)).paise;
      grossSubtotalPaise += lineSubtotal;
      totalItemDiscountsPaise += lineDisc;
      lineNetPaiseList.add(lineSubtotal - lineDisc);
    }

    final netSubtotalPaise = grossSubtotalPaise - totalItemDiscountsPaise;
    final totalCartDisc = cart.cartDiscount.calculateDiscount(Money.fromPaise(netSubtotalPaise));
    final cartDiscPaise = totalCartDisc.paise;

    // 2. Allocate cart discount proportionally across lines without losing a single paise
    final additionalDiscounts = List<int>.filled(cart.lines.length, 0);
    if (cartDiscPaise > 0 && netSubtotalPaise > 0) {
      int allocatedSoFar = 0;
      int maxLineIdx = 0;
      int maxLineVal = -1;

      for (int i = 0; i < cart.lines.length; i++) {
        if (lineNetPaiseList[i] > maxLineVal) {
          maxLineVal = lineNetPaiseList[i];
          maxLineIdx = i;
        }
        final share = _roundHalfUpDivision(
          cartDiscPaise * lineNetPaiseList[i],
          netSubtotalPaise,
        );
        additionalDiscounts[i] = share;
        allocatedSoFar += share;
      }

      // Distribute any rounding remainder to the largest line
      final remainder = cartDiscPaise - allocatedSoFar;
      additionalDiscounts[maxLineIdx] += remainder;
    }

    // 3. Re-calculate lines with allocated cart discount
    final calculatedLines = <CalculatedLineItem>[];
    int taxablePaise = 0;
    int cgstPaise = 0;
    int sgstPaise = 0;
    int igstPaise = 0;
    int totalTaxPaise = 0;
    int totalPayableBeforeRoundPaise = 0;

    for (int i = 0; i < cart.lines.length; i++) {
      final line = cart.lines[i];
      final calc = calculateLine(
        line,
        additionalDiscount: Money.fromPaise(additionalDiscounts[i]),
      );
      calculatedLines.add(calc);

      taxablePaise += calc.taxableAmount.paise;
      cgstPaise += calc.cgst.paise;
      sgstPaise += calc.sgst.paise;
      igstPaise += calc.igst.paise;
      totalTaxPaise += calc.totalTax.paise;
      totalPayableBeforeRoundPaise += calc.lineTotal.paise;
    }

    // 4. Calculate round-off
    int roundingDeltaPaise = 0;
    int finalPayablePaise = totalPayableBeforeRoundPaise;

    if (cart.roundOff) {
      // Round to nearest whole rupee (100 paise)
      final remainder = totalPayableBeforeRoundPaise % 100;
      if (remainder != 0) {
        if (remainder >= 50) {
          roundingDeltaPaise = 100 - remainder;
        } else {
          roundingDeltaPaise = -remainder;
        }
      }
      finalPayablePaise = totalPayableBeforeRoundPaise + roundingDeltaPaise;
    }

    return CalculatedCart(
      lines: calculatedLines,
      grossSubtotal: Money.fromPaise(grossSubtotalPaise),
      totalItemDiscounts: Money.fromPaise(totalItemDiscountsPaise),
      cartDiscountAmount: totalCartDisc,
      totalDiscounts: Money.fromPaise(totalItemDiscountsPaise + cartDiscPaise),
      taxableAmount: Money.fromPaise(taxablePaise),
      cgstTotal: Money.fromPaise(cgstPaise),
      sgstTotal: Money.fromPaise(sgstPaise),
      igstTotal: Money.fromPaise(igstPaise),
      totalTax: Money.fromPaise(totalTaxPaise),
      payableBeforeRounding: Money.fromPaise(totalPayableBeforeRoundPaise),
      roundingDelta: Money.fromPaise(roundingDeltaPaise),
      finalPayable: Money.fromPaise(finalPayablePaise),
    );
  }
}
