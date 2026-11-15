import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CircularIconContainer extends StatelessWidget {
  final Widget? child;
  final IconData? icon;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Border? border;

  const CircularIconContainer({
    super.key,
    this.child,
    this.icon,
    this.size = 46.0,
    this.iconSize = 22.0,
    this.backgroundColor,
    this.iconColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.creamContainer,
        shape: BoxShape.circle,
        border: border,
      ),
      alignment: Alignment.center,
      child: child ??
          (icon != null
              ? Icon(
                  icon,
                  size: iconSize,
                  color: iconColor ?? AppColors.primary,
                )
              : null),
    );
  }
}
