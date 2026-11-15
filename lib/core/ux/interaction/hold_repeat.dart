import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hold-to-repeat gesture accelerator for numeric steppers and quantity buttons.
/// Begins repeating after [initialDelay] (400ms) and accelerates repetition rate.
class HoldRepeat extends StatefulWidget {
  final VoidCallback onTrigger;
  final Widget child;
  final Duration initialDelay;
  final Duration initialInterval;
  final Duration minInterval;

  const HoldRepeat({
    super.key,
    required this.onTrigger,
    required this.child,
    this.initialDelay = const Duration(milliseconds: 350),
    this.initialInterval = const Duration(milliseconds: 140),
    this.minInterval = const Duration(milliseconds: 50),
  });

  @override
  State<HoldRepeat> createState() => _HoldRepeatState();
}

class _HoldRepeatState extends State<HoldRepeat> {
  Timer? _initialTimer;
  Timer? _repeatTimer;
  Duration _currentInterval = Duration.zero;

  void _startHold() {
    widget.onTrigger();
    HapticFeedback.selectionClick();

    _currentInterval = widget.initialInterval;
    _initialTimer = Timer(widget.initialDelay, () {
      _startRepeating();
    });
  }

  void _startRepeating() {
    _repeatTimer?.cancel();
    _repeatTimer = Timer.periodic(_currentInterval, (timer) {
      widget.onTrigger();
      HapticFeedback.selectionClick();

      // Accelerate interval down to minInterval
      if (_currentInterval > widget.minInterval) {
        _currentInterval = Duration(
          milliseconds: (_currentInterval.inMilliseconds * 0.85).round(),
        );
        _startRepeating(); // re-arm with accelerated interval
      }
    });
  }

  void _stopHold() {
    _initialTimer?.cancel();
    _repeatTimer?.cancel();
  }

  @override
  void dispose() {
    _stopHold();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _startHold(),
      onTapUp: (_) => _stopHold(),
      onTapCancel: _stopHold,
      child: widget.child,
    );
  }
}
