import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/ux/motion/motion_tokens.dart';

void main() {
  group('Motion Tokens & Reduced Motion Resolution (UX Section 7)', () {
    test('Standard motion tokens have expected durations and curves', () {
      expect(MotionDurations.micro.inMilliseconds, equals(100));
      expect(MotionDurations.shortDuration.inMilliseconds, equals(150));
      expect(MotionDurations.medium.inMilliseconds, equals(220));
      expect(MotionDurations.longDuration.inMilliseconds, equals(280));

      expect(MotionCurves.enter, equals(Curves.easeOutCubic));
      expect(MotionCurves.exit, equals(Curves.easeInCubic));
      expect(MotionCurves.emphasized, equals(Curves.easeInOutCubicEmphasized));
    });

    test('MotionData with reduced motion disabled returns standard durations', () {
      const data = MotionData(isReducedMotion: false);
      expect(data.micro, equals(MotionDurations.micro));
      expect(data.shortDuration, equals(MotionDurations.shortDuration));
      expect(data.medium, equals(MotionDurations.medium));
      expect(data.longDuration, equals(MotionDurations.longDuration));
      expect(data.enter, equals(MotionCurves.enter));
    });

    test('MotionData with reduced motion enabled returns zero durations', () {
      const data = MotionData(isReducedMotion: true);
      expect(data.micro, equals(Duration.zero));
      expect(data.shortDuration, equals(Duration.zero));
      expect(data.medium, equals(Duration.zero));
      expect(data.longDuration, equals(Duration.zero));
      expect(data.enter, equals(Curves.linear));
    });

    testWidgets('Motion.of(context) resolves reduced motion from MediaQuery',
        (tester) async {
      late MotionData resolvedMotion;

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Builder(
              builder: (context) {
                resolvedMotion = Motion.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(resolvedMotion.isReducedMotion, isTrue);
      expect(resolvedMotion.micro, equals(Duration.zero));
    });
  });
}
