import 'package:flutter/material.dart';

/// Semantic and brand color palette for CaféOS.
/// Aligned with the approved warm, modern café design language.
abstract final class AppColors {
  // Brand Warm Palette (from approved reference design)
  static const Color primary = Color(0xFF342B26); // Primary Dark Coffee
  static const Color primaryDark = Color(0xFF221C19);
  static const Color primaryLight = Color(0xFF4E4039);
  static const Color primaryContainer = Color(0xFFEEE6DC); // Soft Beige
  static const Color onPrimaryContainer = Color(0xFF342B26);

  // Accent & Action Colors
  static const Color terracotta = Color(0xFFD99469); // Muted Terracotta (FAB, active states)
  static const Color secondary = Color(0xFFD99469);
  static const Color secondaryContainer = Color(0xFFF9EFE7);
  static const Color onSecondaryContainer = Color(0xFF342B26);

  // Neutral Light Surfaces (Warm café tones)
  static const Color surfaceLight = Color(0xFFFFFFFF); // Card Surface
  static const Color backgroundLight = Color(0xFFFFFDF9); // Warm White Background
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE9E0D6); // Subtle Borders
  static const Color softBeige = Color(0xFFEEE6DC); // Soft Beige containers
  static const Color creamContainer = Color(0xFFF8F3EC); // Soft Cream for pills & icon circles
  static const Color warmCream = Color(0xFFFAF3EC); // Light Warm Cream accent

  // Typography Colors
  static const Color textPrimaryLight = Color(0xFF342B26); // Primary Coffee Text
  static const Color textSecondaryLight = Color(0xFF887B70); // Secondary Muted Text
  static const Color textMutedLight = Color(0xFFA89F95);

  // Neutral Dark (for dark theme & dark hero cards)
  static const Color surfaceDark = Color(0xFF221C19);
  static const Color backgroundDark = Color(0xFF181412);
  static const Color cardDark = Color(0xFF2C2420);
  static const Color borderDark = Color(0xFF453A34);
  static const Color textPrimaryDark = Color(0xFFFAF7F2);
  static const Color textSecondaryDark = Color(0xFFC4B8AD);
  static const Color textMutedDark = Color(0xFF8E8377);

  // Operational & Order Lifecycle Statuses (Soft, modern status tones)
  static const Color statusNew = Color(0xFFE89246); // Warm Amber ("New", "Pending")
  static const Color statusPreparing = Color(0xFFD99469); // Terracotta ("Preparing")
  static const Color statusReady = Color(0xFF5EAA81); // Soft Sage Green ("Ready", "In Stock")
  static const Color statusInStock = Color(0xFF5EAA81);
  static const Color statusLowStock = Color(0xFFE89246);
  static const Color statusOutOfStock = Color(0xFFDC2626);

  static const Color statusCreated = Color(0xFF887B70);
  static const Color statusConfirmed = Color(0xFF0284C7);
  static const Color statusServed = Color(0xFF5EAA81);
  static const Color statusCancelled = Color(0xFFDC2626);

  // Semantic Signals
  static const Color success = Color(0xFF5EAA81);
  static const Color successContainer = Color(0xFFEAF5EE);
  static const Color warning = Color(0xFFE89246);
  static const Color warningContainer = Color(0xFFFDF2E8);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF0284C7);
  static const Color infoContainer = Color(0xFFE0F2FE);

  // Offline / Sync Status
  static const Color syncPending = Color(0xFFE89246);
  static const Color syncActive = Color(0xFF3B82F6);
  static const Color syncSuccess = Color(0xFF5EAA81);
  static const Color syncFailed = Color(0xFFDC2626);
}
