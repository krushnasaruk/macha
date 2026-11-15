import 'package:flutter/material.dart';
import '../components/app_button.dart';
import '../components/currency_text.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../values/money.dart';
import 'mascot_asset_registry.dart';
import 'mascot_dialogue_bubble.dart';
import 'mascot_widget.dart';

/// Celebration modal displaying Chef Barnaby upon order settlement or operational victory.
class MascotCelebration extends StatelessWidget {
  final String title;
  final String message;
  final Money? amountSettled;
  final String? invoiceNumber;
  final VoidCallback onDismiss;

  const MascotCelebration({
    super.key,
    required this.title,
    required this.message,
    this.amountSettled,
    this.invoiceNumber,
    required this.onDismiss,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    Money? amountSettled,
    String? invoiceNumber,
    required VoidCallback onDismiss,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => MascotCelebration(
        title: title,
        message: message,
        amountSettled: amountSettled,
        invoiceNumber: invoiceNumber,
        onDismiss: () {
          Navigator.of(context).pop();
          onDismiss();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Celebrating Barnaby with confetti
              const MascotWidget(
                interaction: MascotInteraction.celebratingTask,
                height: 160,
                dialogue: 'Another order cooked & served to perfection!',
                dialogueTitle: 'Chef Barnaby',
                tailPosition: BubbleTailPosition.bottom,
                bubbleStyle: BubbleStyle.excited,
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              if (invoiceNumber != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Invoice #$invoiceNumber',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if (amountSettled != null) ...[
                const SizedBox(height: 8),
                CurrencyText(
                  amountSettled!,
                  style: AppTypography.headlineMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF27AE60),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                message,
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Ring Up Next Customer',
                isFullWidth: true,
                onPressed: onDismiss,
                variant: AppButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
