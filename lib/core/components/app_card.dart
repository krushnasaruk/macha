import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../ux/interaction/pressable.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? backgroundColor;
  final BorderSide? borderSide;

  const AppCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.paddingMd,
    this.onTap,
    this.isSelected = false,
    this.backgroundColor,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBorder = BorderSide(
      color: isSelected
          ? AppColors.primary
          : (isDark ? AppColors.borderDark : AppColors.borderLight),
      width: isSelected ? 2 : 1,
    );

    final bg = isSelected
        ? (isDark ? AppColors.primaryDark.withOpacity(0.3) : AppColors.primaryContainer.withOpacity(0.5))
        : (backgroundColor ?? (isDark ? AppColors.cardDark : AppColors.cardLight));

    final cardWidget = Material(
      color: bg,
      shape: RoundedRectangleBorder(
        side: borderSide ?? defaultBorder,
        borderRadius: AppSpacing.roundedMd,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );

    if (onTap == null) return cardWidget;

    return Pressable(
      isInteractive: true,
      pressedScale: 0.988,
      child: cardWidget,
    );
  }
}
