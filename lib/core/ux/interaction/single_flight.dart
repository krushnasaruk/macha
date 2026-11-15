import 'dart:async';
import 'package:flutter/material.dart';

/// Prevents double-taps and concurrent execution of asynchronous operations.
/// As mandated by UX Master Prompt Section 22.1 & Double-Tap Audit.
class SingleFlight extends StatefulWidget {
  final FutureOr<void> Function()? onPressed;
  final Widget child;
  final Widget? inFlightWidget;
  final Duration throttleDuration;

  const SingleFlight({
    super.key,
    required this.onPressed,
    required this.child,
    this.inFlightWidget,
    this.throttleDuration = const Duration(milliseconds: 300),
  });

  @override
  State<SingleFlight> createState() => _SingleFlightState();
}

class _SingleFlightState extends State<SingleFlight> {
  bool _isInFlight = false;
  DateTime? _lastExecutionTime;

  Future<void> _handleTap() async {
    if (widget.onPressed == null || _isInFlight) return;

    final now = DateTime.now();
    if (_lastExecutionTime != null &&
        now.difference(_lastExecutionTime!) < widget.throttleDuration) {
      return;
    }

    setState(() {
      _isInFlight = true;
      _lastExecutionTime = now;
    });

    try {
      final result = widget.onPressed!();
      if (result is Future) {
        await result;
      }
    } finally {
      if (mounted) {
        setState(() {
          _isInFlight = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed == null ? null : _handleTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: _isInFlight ? 0.65 : 1.0,
        child: _isInFlight && widget.inFlightWidget != null
            ? widget.inFlightWidget!
            : widget.child,
      ),
    );
  }
}

/// Helper function to wrap any async callback with single-flight idempotency.
VoidCallback? singleFlightCallback(
  BuildContext context,
  FutureOr<void> Function()? callback, {
  Duration throttleDuration = const Duration(milliseconds: 300),
}) {
  if (callback == null) return null;

  bool inFlight = false;
  DateTime? lastTrigger;

  return () async {
    if (inFlight) return;
    final now = DateTime.now();
    if (lastTrigger != null && now.difference(lastTrigger!) < throttleDuration) {
      return;
    }

    inFlight = true;
    lastTrigger = now;

    try {
      final res = callback();
      if (res is Future) {
        await res;
      }
    } finally {
      inFlight = false;
    }
  };
}
