import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../ux/interaction/pressable.dart';
import '../ux/interaction/single_flight.dart';

enum AppButtonVariant { primary, secondary, outline, text, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    final effectiveOnPressed = isLoading ? null : onPressed;
    final guardedOnPressed = effectiveOnPressed != null
        ? singleFlightCallback(context, effectiveOnPressed)
        : null;

    Widget button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: guardedOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: Size(isFullWidth ? double.infinity : 64, height ?? 48),
          ),
          child: child,
        ),
      AppButtonVariant.secondary => ElevatedButton(
          onPressed: guardedOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.white,
            minimumSize: Size(isFullWidth ? double.infinity : 64, height ?? 48),
          ),
          child: child,
        ),
      AppButtonVariant.outline => OutlinedButton(
          onPressed: guardedOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            minimumSize: Size(isFullWidth ? double.infinity : 64, height ?? 48),
          ),
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: guardedOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: Size(isFullWidth ? double.infinity : 64, height ?? 48),
          ),
          child: child,
        ),
      AppButtonVariant.danger => ElevatedButton(
          onPressed: guardedOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            minimumSize: Size(isFullWidth ? double.infinity : 64, height ?? 48),
          ),
          child: child,
        ),
    };

    final renderedButton = isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;

    return Pressable(
      isInteractive: guardedOnPressed != null,
      pressedScale: 0.985,
      child: renderedButton,
    );
  }
}
