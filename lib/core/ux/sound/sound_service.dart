import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Operational audio feedback service.
/// Plays calm, restrained chimes for critical operational events.
class SoundService {
  final bool soundEnabled;

  const SoundService({this.soundEnabled = true});

  /// Pleasant, clear chime for new incoming kitchen tickets.
  Future<void> playNewOrder() async {
    if (!soundEnabled) return;
    try {
      debugPrint('[SoundService] 🔔 Playing new kitchen order chime');
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  /// Distinct, unmistakable confirmation chime for settled payment.
  Future<void> playPaymentSuccess() async {
    if (!soundEnabled) return;
    try {
      debugPrint('[SoundService] ✨ Playing payment success chime');
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  /// Attention chime for urgent printer, drawer, or hardware warnings.
  Future<void> playAlert() async {
    if (!soundEnabled) return;
    try {
      debugPrint('[SoundService] ⚠️ Playing alert chime');
      await SystemSound.play(SystemSoundType.alert);
    } catch (_) {}
  }
}

final soundEnabledProvider = StateProvider<bool>((ref) => true);

final soundServiceProvider = Provider<SoundService>((ref) {
  final enabled = ref.watch(soundEnabledProvider);
  return SoundService(soundEnabled: enabled);
});
