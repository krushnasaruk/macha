import 'package:flutter/material.dart';

/// Semantic and brand color palette for CaféOS.
abstract final class AppColors {
  // Brand Warm Espresso Palette
  static const Color primary = Color(0xFF6F4E37); // Warm Coffee/Espresso
  static const Color primaryDark = Color(0xFF4A3323);
  static const Color primaryLight = Color(0xFF9E7250);
  static const Color primaryContainer = Color(0xFFF3ECE7);
  static const Color onPrimaryContainer = Color(0xFF2C1B10);

  // Secondary Accents (Warm Amber / Caramel)
  static const Color secondary = Color(0xFFC67D38);
  static const Color secondaryContainer = Color(0xFFFBF1E6);
  static const Color onSecondaryContainer = Color(0xFF432305);

  // Neutral Light
  static const Color surfaceLight = Color(0xFFFAF8F5);
  static const Color backgroundLight = Color(0xFFF4F0E9);
  static const Color cardLight = Colors.white;
  static const Color borderLight = Color(0xFFE4DDD4);
  static const Color textPrimaryLight = Color(0xFF1E1915);
  static const Color textSecondaryLight = Color(0xFF6A625B);
  static const Color textMutedLight = Color(0xFF9A9188);

  // Neutral Dark
  static const Color surfaceDark = Color(0xFF1E1915);
  static const Color backgroundDark = Color(0xFF14110E);
  static const Color cardDark = Color(0xFF28231E);
  static const Color borderDark = Color(0xFF3F3730);
  static const Color textPrimaryDark = Color(0xFFF8F5F1);
  static const Color textSecondaryDark = Color(0xFFB5ADA4);
  static const Color textMutedDark = Color(0xFF7E756C);

  // Operational & Order Lifecycle Statuses
  static const Color statusCreated = Color(0xFF64748B); // Slate Gray
  static const Color statusConfirmed = Color(0xFF0284C7); // Sky Blue
  static const Color statusPreparing = Color(0xFFD97706); // Amber
  static const Color statusReady = Color(0xFF16A34A); // Emerald Green
  static const Color statusServed = Color(0xFF059669); // Forest Green
  static const Color statusCancelled = Color(0xFFDC2626); // Crimson Red

  // Semantic Signals
  static const Color success = Color(0xFF16A34A);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoContainer = Color(0xFFE0F2FE);

  // Offline / Sync Status
  static const Color syncPending = Color(0xFFEAB308);
  static const Color syncActive = Color(0xFF3B82F6);
  static const Color syncSuccess = Color(0xFF22C55E);
  static const Color syncFailed = Color(0xFFEF4444);
}
