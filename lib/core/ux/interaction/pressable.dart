import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../motion/motion_tokens.dart';

/// Tactile interactive primitive providing immediate (≤16ms) visual press response.
/// As defined in UX Master Prompt Section 22.1 and Budget PERF-03.
/// Uses [Listener] to detect raw pointer-down instantly even over nested interactive widgets.
class Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final bool enableHaptics;
  final bool isInteractive;

  const Pressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.98,
    this.enableHaptics = true,
    this.isInteractive = true,
  });

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 70),
      reverseDuration: const Duration(milliseconds: 130),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressedScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: MotionCurves.enter,
      reverseCurve: MotionCurves.exit,
    ));
  }

  @override
  void didUpdateWidget(Pressable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pressedScale != widget.pressedScale) {
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: widget.pressedScale,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: MotionCurves.enter,
        reverseCurve: MotionCurves.exit,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    if (!widget.isInteractive) return;
    _isPressed = true;
    _controller.forward();
    if (widget.enableHaptics) {
      HapticFeedback.selectionClick();
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    if (!_isPressed) return;
    _isPressed = false;
    _controller.reverse();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (!_isPressed) return;
    _isPressed = false;
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final motion = Motion.of(context);

    if (motion.isReducedMotion || !widget.isInteractive) {
      if (widget.onTap != null || widget.onLongPress != null) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: widget.child,
        );
      }
      return widget.child;
    }

    Widget content = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: widget.child,
    );

    if (widget.onTap != null || widget.onLongPress != null) {
      content = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: content,
      );
    }

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: content,
    );
  }
}
