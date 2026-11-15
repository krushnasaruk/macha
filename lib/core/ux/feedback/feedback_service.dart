import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../haptics/haptic_service.dart';
import '../sound/sound_service.dart';

/// Unified sensory orchestrator for motion, haptics, and sound.
class FeedbackService {
  final HapticService _haptics;
  final SoundService _sound;

  FeedbackService({
    required HapticService haptics,
    required SoundService sound,
  })  : _haptics = haptics,
        _sound = sound;

  /// Subtle touch feedback for tab switching, category filter selection, stepper.
  void selection() {
    _haptics.selection();
  }

  /// Tactile feedback for standard button presses, product card additions.
  void tap() {
    _haptics.lightTap();
  }

  /// Primary button trigger (e.g. Open Table, Proceed to Checkout).
  void primaryAction() {
    _haptics.mediumTap();
  }

  /// Unmistakable celebration of financial settlement.
  void paymentSuccess() {
    _haptics.success();
    _sound.playPaymentSuccess();
  }

  /// KDS bump or recall action.
  void ticketBumped() {
    _haptics.mediumTap();
  }

  /// New incoming order alert on KDS or waiter tablet.
  void newOrderAlert() {
    _haptics.mediumTap();
    _sound.playNewOrder();
  }

  /// Destructive or high-caution action (e.g. Cancel Order, Close Session).
  void warning() {
    _haptics.warning();
  }

  /// Operation failed or hardware disconnected.
  void error() {
    _haptics.error();
    _sound.playAlert();
  }
}

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final haptics = ref.watch(hapticServiceProvider);
  final sound = ref.watch(soundServiceProvider);
  return FeedbackService(haptics: haptics, sound: sound);
});
