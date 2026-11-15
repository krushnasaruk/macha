import 'dart:async';
import 'package:flutter/material.dart';
import '../motion/motion_tokens.dart';

/// Shimmer effect provider using an animated gradient.
/// Respects reduced motion settings by showing a static subtle grey fill.
class Shimmer extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration period;

  const Shimmer({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.period = const Duration(milliseconds: 1400),
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = Motion.of(context);
    if (motion.isReducedMotion) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(slidePercent: _controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;
  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (slidePercent * 2 - 1), 0.0, 0.0);
  }
}

/// Primitive rectangular skeleton placeholder.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white10 : Colors.black.withOpacity(0.06);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

/// Circular skeleton placeholder for avatar or icon dots.
class SkeletonCircle extends StatelessWidget {
  final double size;

  const SkeletonCircle({super.key, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}

/// Text line skeleton placeholder.
class SkeletonLine extends StatelessWidget {
  final double? width;
  final double height;

  const SkeletonLine({
    super.key,
    this.width,
    this.height = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(4),
    );
  }
}

/// Delayed loading container (UX Master Prompt Budget PERF-08).
/// - Delays rendering [skeleton] for [delay] (default 150ms).
/// - Once displayed, guarantees [skeleton] is held for at least [minHold] (default 300ms)
///   to prevent micro-flash jitter before rendering [child].
class DelayedLoading extends StatefulWidget {
  final bool isLoading;
  final Widget skeleton;
  final Widget child;
  final Duration delay;
  final Duration minHold;

  const DelayedLoading({
    super.key,
    required this.isLoading,
    required this.skeleton,
    required this.child,
    this.delay = const Duration(milliseconds: 150),
    this.minHold = const Duration(milliseconds: 300),
  });

  @override
  State<DelayedLoading> createState() => _DelayedLoadingState();
}

class _DelayedLoadingState extends State<DelayedLoading> {
  bool _showSkeleton = false;
  Timer? _delayTimer;
  DateTime? _shownAt;

  @override
  void initState() {
    super.initState();
    _handleLoadingChange();
  }

  @override
  void didUpdateWidget(DelayedLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading != widget.isLoading) {
      _handleLoadingChange();
    }
  }

  void _handleLoadingChange() {
    if (widget.isLoading) {
      if (_shownAt == null) {
        _delayTimer?.cancel();
        _delayTimer = Timer(widget.delay, () {
          if (mounted && widget.isLoading) {
            setState(() {
              _showSkeleton = true;
              _shownAt = DateTime.now();
            });
          }
        });
      }
    } else {
      _delayTimer?.cancel();
      if (_shownAt != null) {
        final elapsed = DateTime.now().difference(_shownAt!);
        if (elapsed < widget.minHold) {
          final remaining = widget.minHold - elapsed;
          Timer(remaining, () {
            if (mounted) {
              setState(() {
                _showSkeleton = false;
                _shownAt = null;
              });
            }
          });
          return;
        }
      }
      _showSkeleton = false;
      _shownAt = null;
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _showSkeleton ? Shimmer(child: widget.skeleton) : const SizedBox.shrink();
    }
    return widget.child;
  }
}
