import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/theme/app_colors.dart';
import 'package:cafe_os/core/theme/app_theme.dart';
import 'package:cafe_os/core/theme/app_typography.dart';

void main() {
  group('Theme Smoke Tests', () {
    testWidgets('Light theme has correct primary brand color and surface brightness', (tester) async {
      final theme = AppTheme.light;
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppColors.primary);
      expect(theme.scaffoldBackgroundColor, AppColors.backgroundLight);
      expect(theme.useMaterial3, isTrue);
    });

    testWidgets('Dark theme has dark brightness and appropriate dark surface colors', (tester) async {
      final theme = AppTheme.dark;
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.primary, AppColors.primaryLight);
      expect(theme.scaffoldBackgroundColor, AppColors.backgroundDark);
      expect(theme.useMaterial3, isTrue);
    });

    testWidgets('Typography provides tabular figures for tabularMoney', (tester) async {
      final style = AppTypography.tabularMoney(fontSize: 18);
      expect(style.fontSize, 18);
      expect(style.fontFeatures, contains(const FontFeature.tabularFigures()));
    });
  });
}
