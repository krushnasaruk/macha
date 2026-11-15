import 'package:flutter/material.dart';

/// Centralized motion durations and easing curves for CaféOS.
/// As defined in UX Master Prompt Section 7.2.
class MotionDurations {
  const MotionDurations._();

  /// Press feedback, micro toggles (80–120 ms). Default: 100 ms.
  static const Duration micro = Duration(milliseconds: 100);

  /// State changes, selection, fade (120–180 ms). Default: 150 ms.
  static const Duration shortDuration = Duration(milliseconds: 150);

  /// Page transitions, expand/collapse (180–260 ms). Default: 220 ms.
  static const Duration medium = Duration(milliseconds: 220);

  /// Bottom sheets, large container transforms (260–320 ms). Default: 280 ms.
  static const Duration longDuration = Duration(milliseconds: 280);
}

class MotionCurves {
  const MotionCurves._();

  /// Entering elements
  static const Curve enter = Curves.easeOutCubic;

  /// Exiting elements (~75% of enter duration)
  static const Curve exit = Curves.easeInCubic;

  /// Emphasized movements and container transforms
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;

  /// Standard natural curve
  static const Curve standard = Curves.easeInOutCubic;
}

/// Resolved motion configuration respecting OS and user reduced-motion preferences.
class MotionData {
  final bool isReducedMotion;

  const MotionData({required this.isReducedMotion});

  Duration get micro => isReducedMotion ? Duration.zero : MotionDurations.micro;
  Duration get shortDuration =>
      isReducedMotion ? Duration.zero : MotionDurations.shortDuration;
  Duration get medium =>
      isReducedMotion ? Duration.zero : MotionDurations.medium;
  Duration get longDuration =>
      isReducedMotion ? Duration.zero : MotionDurations.longDuration;

  Curve get enter => isReducedMotion ? Curves.linear : MotionCurves.enter;
  Curve get exit => isReducedMotion ? Curves.linear : MotionCurves.exit;
  Curve get emphasized =>
      isReducedMotion ? Curves.linear : MotionCurves.emphasized;
  Curve get standard => isReducedMotion ? Curves.linear : MotionCurves.standard;
}

/// Accessor for motion tokens in the current BuildContext.
class Motion {
  const Motion._();

  static MotionData of(BuildContext context) {
    final mediaReduced = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return MotionData(isReducedMotion: mediaReduced);
  }
}
