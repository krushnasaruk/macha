import 'package:flutter/material.dart';
import '../theme/app_typography.dart';
import '../values/money.dart';

/// Renders a [Money] value with tabular figures to prevent layout jitter during updates.
class CurrencyText extends StatelessWidget {
  final Money amount;
  final TextStyle? style;
  final bool includeSymbol;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CurrencyText(
    this.amount, {
    super.key,
    this.style,
    this.includeSymbol = true,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ??
        AppTypography.tabularMoney(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color,
        );

    return Text(
      amount.format(includeSymbol: includeSymbol),
      style: baseStyle.copyWith(
        fontFeatures: AppTypography.tabularFigures,
        color: color ?? baseStyle.color,
      ),
    );
  }
}
