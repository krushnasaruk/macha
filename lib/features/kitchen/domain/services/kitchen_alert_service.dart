import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KitchenAlertConfig {
  final bool soundEnabled;
  final bool visualBlinkEnabled;
  final int warningMinutes;
  final int delayedMinutes;

  const KitchenAlertConfig({
    this.soundEnabled = true,
    this.visualBlinkEnabled = true,
    this.warningMinutes = 10,
    this.delayedMinutes = 15,
  });

  KitchenAlertConfig copyWith({
    bool? soundEnabled,
    bool? visualBlinkEnabled,
    int? warningMinutes,
    int? delayedMinutes,
  }) {
    return KitchenAlertConfig(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      visualBlinkEnabled: visualBlinkEnabled ?? this.visualBlinkEnabled,
      warningMinutes: warningMinutes ?? this.warningMinutes,
      delayedMinutes: delayedMinutes ?? this.delayedMinutes,
    );
  }
}

class KitchenAlertNotifier extends StateNotifier<KitchenAlertConfig> {
  KitchenAlertNotifier() : super(const KitchenAlertConfig());

  void toggleSound() {
    state = state.copyWith(soundEnabled: !state.soundEnabled);
  }

  void toggleVisualBlink() {
    state = state.copyWith(visualBlinkEnabled: !state.visualBlinkEnabled);
  }

  void playNewOrderSound() {
    if (!state.soundEnabled) return;
    // In production or mobile this triggers platform sound or SystemSound.
    debugPrint('[KitchenAlert] 🔔 New order alert chime played');
  }

  void playDelayedOrderWarning() {
    if (!state.soundEnabled) return;
    debugPrint('[KitchenAlert] ⚠️ Ticket delayed warning chime played');
  }
}

final kitchenAlertProvider = StateNotifierProvider<KitchenAlertNotifier, KitchenAlertConfig>(
  (ref) => KitchenAlertNotifier(),
);
