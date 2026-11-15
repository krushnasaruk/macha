import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool showDot;

  const AppBadge({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primaryContainer,
    this.textColor = AppColors.onPrimaryContainer,
    this.icon,
    this.showDot = false,
  });

  factory AppBadge.status(String status) {
    final lower = status.toLowerCase();
    Color bg;
    Color fg;

    switch (lower) {
      case 'created':
        bg = const Color(0xFFF1F5F9);
        fg = AppColors.statusCreated;
        break;
      case 'confirmed':
        bg = AppColors.infoContainer;
        fg = AppColors.statusConfirmed;
        break;
      case 'preparing':
        bg = AppColors.warningContainer;
        fg = AppColors.statusPreparing;
        break;
      case 'ready':
        bg = AppColors.successContainer;
        fg = AppColors.statusReady;
        break;
      case 'served':
        bg = const Color(0xFFD1FAE5);
        fg = AppColors.statusServed;
        break;
      case 'cancelled':
        bg = AppColors.errorContainer;
        fg = AppColors.statusCancelled;
        break;
      default:
        bg = AppColors.primaryContainer;
        fg = AppColors.primary;
    }

    return AppBadge(
      label: status.toUpperCase(),
      backgroundColor: bg,
      textColor: fg,
      showDot: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppSpacing.roundedFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: textColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
