import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/ux/interaction/hold_repeat.dart';
import 'package:cafe_os/core/ux/interaction/pressable.dart';
import 'package:cafe_os/core/ux/interaction/single_flight.dart';
import 'package:cafe_os/core/ux/loading/skeleton.dart';

void main() {
  group('UX Interaction & Loading Primitives (Stage 2 Gate)', () {
    testWidgets('SingleFlight suppresses rapid duplicate taps on async operations',
        (tester) async {
      int triggerCount = 0;

      Future<void> simulateAsyncMutation() async {
        triggerCount++;
        await Future<void>.delayed(const Duration(milliseconds: 200));
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleFlight(
              onPressed: simulateAsyncMutation,
              child: const Text('Submit Payment'),
            ),
          ),
        ),
      );

      // Rapidly tap twice within 50ms
      await tester.tap(find.text('Submit Payment'));
      await tester.pump(const Duration(milliseconds: 30));
      await tester.tap(find.text('Submit Payment'));
      await tester.pump(const Duration(milliseconds: 30));

      // Advance time to allow in-flight task to finish
      await tester.pump(const Duration(milliseconds: 300));

      // In-flight guard should have allowed only 1 invocation
      expect(triggerCount, equals(1));
    });

    testWidgets('Pressable responds to tap and executes callback', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pressable(
              onTap: () => tapped = true,
              child: const Text('Pressable Card'),
            ),
          ),
        ),
      );

      expect(find.text('Pressable Card'), findsOneWidget);
      await tester.tap(find.text('Pressable Card'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('HoldRepeat triggers immediately and repeats on sustained hold',
        (tester) async {
      int count = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HoldRepeat(
              onTrigger: () => count++,
              initialDelay: const Duration(milliseconds: 100),
              initialInterval: const Duration(milliseconds: 50),
              child: const Text('Increment Stepper'),
            ),
          ),
        ),
      );

      // Initial tap down
      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Increment Stepper')),
      );
      await tester.pump();
      expect(count, equals(1)); // First immediate invocation

      // Hold past initialDelay (100ms) + 2 intervals (100ms)
      await tester.pump(const Duration(milliseconds: 220));
      expect(count, greaterThan(1));

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('DelayedLoading does not render skeleton if loaded within delay',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DelayedLoading(
              isLoading: true,
              skeleton: Text('Skeleton Placeholder'),
              child: Text('Loaded Data'),
            ),
          ),
        ),
      );

      // Within 150ms delay, skeleton is suppressed (PERF-08 flicker prevention)
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.text('Skeleton Placeholder'), findsNothing);

      // Past 150ms delay, skeleton becomes visible
      await tester.pump(const Duration(milliseconds: 120));
      expect(find.text('Skeleton Placeholder'), findsOneWidget);
    });
  });
}
