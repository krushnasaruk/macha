import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum StatusPillType {
  newOrder,
  preparing,
  ready,
  pending,
  inStock,
  lowStock,
  outOfStock,
  custom,
}

class StatusPill extends StatelessWidget {
  final String label;
  final StatusPillType type;
  final Color? customBgColor;
  final Color? customTextColor;
  final bool showDot;

  const StatusPill({
    super.key,
    required this.label,
    this.type = StatusPillType.custom,
    this.customBgColor,
    this.customTextColor,
    this.showDot = false,
  });

  factory StatusPill.fromOrderStatus(String status) {
    final lower = status.toLowerCase();
    if (lower.contains('new') || lower.contains('create')) {
      return const StatusPill(label: 'New', type: StatusPillType.newOrder);
    } else if (lower.contains('prep')) {
      return const StatusPill(label: 'Preparing', type: StatusPillType.preparing);
    } else if (lower.contains('ready') || lower.contains('serve') || lower.contains('complete')) {
      return const StatusPill(label: 'Ready', type: StatusPillType.ready);
    } else if (lower.contains('pending')) {
      return const StatusPill(label: 'Pending', type: StatusPillType.pending);
    }
    return StatusPill(label: status, type: StatusPillType.custom);
  }

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;

    switch (type) {
      case StatusPillType.newOrder:
      case StatusPillType.pending:
      case StatusPillType.lowStock:
        bg = const Color(0xFFFDF0E6);
        text = const Color(0xFFE89246);
        break;
      case StatusPillType.preparing:
        bg = const Color(0xFFF9EFE7);
        text = const Color(0xFFD99469);
        break;
      case StatusPillType.ready:
      case StatusPillType.inStock:
        bg = const Color(0xFFEBF6F0);
        text = const Color(0xFF5EAA81);
        break;
      case StatusPillType.outOfStock:
        bg = const Color(0xFFFDE8E8);
        text = const Color(0xFFDC2626);
        break;
      case StatusPillType.custom:
        bg = customBgColor ?? AppColors.creamContainer;
        text = customTextColor ?? AppColors.textPrimaryLight;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: text,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
