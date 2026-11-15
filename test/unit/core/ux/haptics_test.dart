import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/ux/feedback/feedback_service.dart';
import 'package:cafe_os/core/ux/haptics/haptic_service.dart';
import 'package:cafe_os/core/ux/sound/sound_service.dart';

void main() {
  group('Haptic & Feedback Services (UX Section 22.1)', () {
    test('HapticService respects enabled toggle', () async {
      const disabledService = HapticService(enabled: false);
      expect(disabledService.enabled, isFalse);

      // Should complete cleanly without exception even when disabled
      await disabledService.lightTap();
      await disabledService.selection();
      await disabledService.success();
      await disabledService.warning();
      await disabledService.error();

      const enabledService = HapticService(enabled: true);
      expect(enabledService.enabled, isTrue);
    });

    test('SoundService respects soundEnabled toggle', () async {
      const mutedService = SoundService(soundEnabled: false);
      expect(mutedService.soundEnabled, isFalse);

      await mutedService.playNewOrder();
      await mutedService.playPaymentSuccess();
      await mutedService.playAlert();
    });

    test('FeedbackService orchestrates haptics and sound without crashing', () {
      final feedback = FeedbackService(
        haptics: const HapticService(enabled: false),
        sound: const SoundService(soundEnabled: false),
      );

      feedback.selection();
      feedback.tap();
      feedback.primaryAction();
      feedback.paymentSuccess();
      feedback.ticketBumped();
      feedback.newOrderAlert();
      feedback.warning();
      feedback.error();
    });
  });
}
