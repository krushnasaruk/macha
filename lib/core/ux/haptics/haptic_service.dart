import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Centralized Haptic Feedback engine.
/// Honors user preference and avoids vibration on unsupported devices or tests.
class HapticService {
  final bool enabled;

  const HapticService({this.enabled = true});

  /// Subtle click for item selection, category switching, stepper adjustments.
  Future<void> selection() async {
    if (!enabled) return;
    try {
      await HapticFeedback.selectionClick();
    } catch (_) {}
  }

  /// Light touch for standard button presses and card taps.
  Future<void> lightTap() async {
    if (!enabled) return;
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {}
  }

  /// Medium impact for primary actions (e.g. Add to Cart, Open Table Session).
  Future<void> mediumTap() async {
    if (!enabled) return;
    try {
      await HapticFeedback.mediumImpact();
    } catch (_) {}
  }

  /// Heavy impact for destructive confirmations (e.g. Order Cancel, Drawer Close).
  Future<void> heavyTap() async {
    if (!enabled) return;
    try {
      await HapticFeedback.heavyImpact();
    } catch (_) {}
  }

  /// Double light pulse for successful transactions (e.g. Payment Confirmed, Ticket Bump).
  Future<void> success() async {
    if (!enabled) return;
    try {
      await HapticFeedback.mediumImpact();
      await Future<void>.delayed(const Duration(milliseconds: 80));
      await HapticFeedback.lightImpact();
    } catch (_) {}
  }

  /// Triple warning vibration for non-destructive alerts (e.g. Table occupied, offline fallback).
  Future<void> warning() async {
    if (!enabled) return;
    try {
      await HapticFeedback.heavyImpact();
    } catch (_) {}
  }

  /// Strong error pattern for failed validations or payment rejections.
  Future<void> error() async {
    if (!enabled) return;
    try {
      await HapticFeedback.vibrate();
    } catch (_) {}
  }
}

final hapticsEnabledProvider = StateProvider<bool>((ref) => true);

final hapticServiceProvider = Provider<HapticService>((ref) {
  final enabled = ref.watch(hapticsEnabledProvider);
  return HapticService(enabled: enabled);
});
