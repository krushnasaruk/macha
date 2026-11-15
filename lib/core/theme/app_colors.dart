import 'package:flutter/material.dart';

/// Semantic and brand color palette for MΛCHA ("Geometry meets café culture").
/// Aligned strictly with the Matcha × Lavender brand identity standard.
abstract final class AppColors {
  // Primary Signature Brand Color
  /// Deep Forest Matcha — The defining dark colour of MΛCHA (#293D32)
  static const Color primary = Color(0xFF293D32);
  static const Color primaryDark = Color(0xFF1B2922);
  static const Color primaryLight = Color(0xFF3B5647);
  static const Color primaryContainer = Color(0xFFDCE6DF);
  static const Color onPrimaryContainer = Color(0xFF293D32);

  // Matcha Accent & Secondary Colors
  /// Matcha Green (#A5B98A) — Highlights and positive/active states
  static const Color matchaGreen = Color(0xFFA5B98A);
  static const Color secondary = Color(0xFFA5B98A);
  static const Color secondaryContainer = Color(0xFFEDF3E8);
  static const Color onSecondaryContainer = Color(0xFF293D32);

  // Lavender Accents
  /// Soft Lavender (#B9A7CE) — Secondary accents, selected chips, tags
  static const Color softLavender = Color(0xFFB9A7CE);
  /// Lilac Mist (#D8CBE5) — Soft decorative surfaces and subtle borders
  static const Color lilacMist = Color(0xFFD8CBE5);
  static const Color lavenderContainer = Color(0xFFF3EEF9);
  static const Color onLavenderContainer = Color(0xFF293D32);

  // Legacy compatibility alias
  static const Color terracotta = Color(0xFFA5B98A);

  // Neutral Light Surfaces (MΛCHA Warm Canvas)
  /// Vanilla Cream (#FFF9F2) — Main application background
  static const Color backgroundLight = Color(0xFFFFF9F2);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  /// Warm Neutral (#E9E5DE) — Borders, card dividers, neutral surfaces
  static const Color borderLight = Color(0xFFE9E5DE);
  static const Color warmNeutral = Color(0xFFE9E5DE);
  static const Color softBeige = Color(0xFFF5EFE6);
  static const Color creamContainer = Color(0xFFFAF4EC);
  static const Color warmCream = Color(0xFFFFF9F2);

  // Typography Colors
  /// Deep Forest Matcha (#293D32) — Primary text on light surfaces
  static const Color textPrimaryLight = Color(0xFF293D32);
  /// Muted Text (#827B82) — Secondary text and descriptions
  static const Color textSecondaryLight = Color(0xFF827B82);
  static const Color textMutedLight = Color(0xFFA099A0);

  // Neutral Dark (for dark theme & dark hero cards)
  static const Color surfaceDark = Color(0xFF293D32);
  static const Color backgroundDark = Color(0xFF1B2922);
  static const Color cardDark = Color(0xFF24362C);
  static const Color borderDark = Color(0xFF384F42);
  static const Color textPrimaryDark = Color(0xFFFFF9F2);
  static const Color textSecondaryDark = Color(0xFFD8CBE5);
  static const Color textMutedDark = Color(0xFF9EABA2);

  // Operational & Order Lifecycle Statuses
  static const Color statusNew = Color(0xFFB9A7CE); // Lavender ("New", "Pending")
  static const Color statusPreparing = Color(0xFFA5B98A); // Matcha Green ("Preparing")
  static const Color statusReady = Color(0xFF4A8060); // Forest Sage ("Ready")
  static const Color statusInStock = Color(0xFF4A8060);
  static const Color statusLowStock = Color(0xFFD97706); // Warm Amber Alert
  static const Color statusOutOfStock = Color(0xFFDC2626); // Red

  static const Color statusCreated = Color(0xFF827B82);
  static const Color statusConfirmed = Color(0xFF293D32);
  static const Color statusServed = Color(0xFF4A8060);
  static const Color statusCancelled = Color(0xFFDC2626);

  // Semantic Signals
  static const Color success = Color(0xFF4A8060);
  static const Color successContainer = Color(0xFFEAF5EE);
  static const Color warning = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF293D32);
  static const Color infoContainer = Color(0xFFD8CBE5);

  // Offline / Sync Status
  static const Color syncPending = Color(0xFFB9A7CE);
  static const Color syncActive = Color(0xFFA5B98A);
  static const Color syncSuccess = Color(0xFF4A8060);
  static const Color syncFailed = Color(0xFFDC2626);
}
