import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Standard rounded text input field for MΛCHA.
/// Enforces mandatory curved corners, comfortable padding, and high contrast.
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final int maxLines;
  final bool enabled;
  final FocusNode? focusNode;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.autofocus = false,
    this.maxLines = 1,
    this.enabled = true,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    const inputBorderRadius = BorderRadius.all(Radius.circular(20));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.labelLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryLight,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          autofocus: autofocus,
          maxLines: maxLines,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimaryLight,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? Colors.white : AppColors.warmNeutral.withOpacity(0.5),
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMutedLight,
              fontSize: 14,
            ),
            errorText: errorText,
            helperText: helperText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: const OutlineInputBorder(
              borderRadius: inputBorderRadius,
              borderSide: BorderSide(color: AppColors.borderLight, width: 1.2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: inputBorderRadius,
              borderSide: BorderSide(color: AppColors.borderLight, width: 1.2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: inputBorderRadius,
              borderSide: BorderSide(color: AppColors.primary, width: 2.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: inputBorderRadius,
              borderSide: BorderSide(color: AppColors.error, width: 1.2),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: inputBorderRadius,
              borderSide: BorderSide(color: AppColors.error, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
