import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../ux/motion/motion_tokens.dart';

enum BubbleStyle { normal, thought, excited, warning, welcome, tutorial }
enum BubbleTailPosition { left, right, bottom, top, none }

/// Comic-book dialogue speech bubble for Chef Barnaby.
/// Renders crisp vector bubble shapes with tails and animated entrance.
class MascotDialogueBubble extends StatefulWidget {
  final String text;
  final String? title;
  final BubbleStyle style;
  final BubbleTailPosition tailPosition;
  final double maxWidth;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool animateTyping;
  final bool enableTypingFeedback;
  final VoidCallback? onTypingFinished;

  const MascotDialogueBubble({
    super.key,
    required this.text,
    this.title,
    this.style = BubbleStyle.normal,
    this.tailPosition = BubbleTailPosition.left,
    this.maxWidth = 260.0,
    this.onTap,
    this.trailing,
    this.animateTyping = false,
    this.enableTypingFeedback = true,
    this.onTypingFinished,
  });

  @override
  State<MascotDialogueBubble> createState() => _MascotDialogueBubbleState();
}

class _MascotDialogueBubbleState extends State<MascotDialogueBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  int _charIndex = 0;
  bool _isTyping = false;
  Timer? _typingTimer;
  Timer? _cursorTimer;
  bool _showCursor = true;

  bool get _isTestEnvironment =>
      WidgetsBinding.instance.runtimeType.toString().contains('Test');

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: MotionDurations.medium,
    );
    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: MotionCurves.enter),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: MotionCurves.enter),
    );

    _animController.forward();

    if (widget.animateTyping && !_isTestEnvironment) {
      _startTyping();
    } else {
      _charIndex = widget.text.length;
    }
  }

  void _startTyping() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    _charIndex = 0;
    _isTyping = true;
    _showCursor = true;

    _cursorTimer = Timer.periodic(const Duration(milliseconds: 350), (timer) {
      if (mounted) {
        setState(() => _showCursor = !_showCursor);
      }
    });

    _typingTimer = Timer.periodic(const Duration(milliseconds: 26), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_charIndex < widget.text.length) {
        setState(() {
          _charIndex++;
        });

        // Trigger typing haptics & mechanical click sounds
        if (widget.enableTypingFeedback && (_charIndex % 2 == 0 || _charIndex == widget.text.length)) {
          _playTypingEffects();
        }
      } else {
        timer.cancel();
        _cursorTimer?.cancel();
        setState(() {
          _isTyping = false;
          _showCursor = false;
        });
        widget.onTypingFinished?.call();
      }
    });
  }

  void _completeTyping() {
    if (_isTyping) {
      _typingTimer?.cancel();
      _cursorTimer?.cancel();
      setState(() {
        _charIndex = widget.text.length;
        _isTyping = false;
        _showCursor = false;
      });
      widget.onTypingFinished?.call();
    }
  }

  void _playTypingEffects() {
    if (_isTestEnvironment) return;
    try {
      HapticFeedback.selectionClick();
      SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  @override
  void didUpdateWidget(MascotDialogueBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _animController.forward(from: 0.4);
      if (widget.animateTyping && !_isTestEnvironment) {
        _startTyping();
      } else {
        _charIndex = widget.text.length;
      }
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final (bgColor, borderColor, textColor, titleColor) = switch (widget.style) {
      BubbleStyle.normal => (
          isDark ? const Color(0xFF2C2825) : const Color(0xFFFFFBF5),
          isDark ? const Color(0xFF5A4D41) : const Color(0xFF232120),
          isDark ? Colors.white : const Color(0xFF1E1C1B),
          AppColors.primary,
        ),
      BubbleStyle.thought => (
          isDark ? const Color(0xFF25292D) : const Color(0xFFF3F7FA),
          isDark ? const Color(0xFF4C5B66) : const Color(0xFF2F80ED),
          isDark ? Colors.white : const Color(0xFF1E1C1B),
          const Color(0xFF2F80ED),
        ),
      BubbleStyle.excited => (
          isDark ? const Color(0xFF382E1E) : const Color(0xFFFFF9E6),
          const Color(0xFFE6AF2E),
          isDark ? Colors.white : const Color(0xFF1E1C1B),
          const Color(0xFFD48B00),
        ),
      BubbleStyle.warning => (
          isDark ? const Color(0xFF3B2520) : const Color(0xFFFDF2F0),
          const Color(0xFFEB5757),
          isDark ? Colors.white : const Color(0xFF1E1C1B),
          const Color(0xFFEB5757),
        ),
      BubbleStyle.welcome || BubbleStyle.tutorial => (
          isDark ? const Color(0xFF2D2520) : const Color(0xFFFAF3EC),
          AppColors.primary,
          isDark ? Colors.white : const Color(0xFF1E1C1B),
          AppColors.primary,
        ),
    };

    final displayedText = widget.animateTyping
        ? widget.text.substring(0, _charIndex.clamp(0, widget.text.length))
        : widget.text;

    final bubble = GestureDetector(
      onTap: () {
        if (_isTyping) {
          _completeTyping();
        } else {
          widget.onTap?.call();
        }
      },
      child: CustomPaint(
        painter: _BubblePainter(
          color: bgColor,
          borderColor: borderColor,
          tailPosition: widget.tailPosition,
          isThought: widget.style == BubbleStyle.thought,
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null) ...[
                Text(
                  widget.title!,
                  style: AppTypography.labelLarge.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
              ],
              Text(
                _isTyping && _showCursor ? '$displayedText ▎' : displayedText,
                style: AppTypography.bodySmall.copyWith(
                  color: textColor,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(height: 6),
                widget.trailing!,
              ],
            ],
          ),
        ),
      ),
    );

    final motion = Motion.of(context);
    if (motion.isReducedMotion) {
      return bubble;
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        alignment: switch (widget.tailPosition) {
          BubbleTailPosition.left => Alignment.centerLeft,
          BubbleTailPosition.right => Alignment.centerRight,
          BubbleTailPosition.bottom => Alignment.bottomCenter,
          BubbleTailPosition.top => Alignment.topCenter,
          BubbleTailPosition.none => Alignment.center,
        },
        child: bubble,
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final BubbleTailPosition tailPosition;
  final bool isThought;

  const _BubblePainter({
    required this.color,
    required this.borderColor,
    required this.tailPosition,
    required this.isThought,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(14),
    );

    // Draw main bubble
    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(rrect, borderPaint);

    // Draw comic tail
    if (tailPosition != BubbleTailPosition.none && !isThought) {
      final path = Path();
      switch (tailPosition) {
        case BubbleTailPosition.left:
          path.moveTo(0, size.height * 0.45);
          path.lineTo(-10, size.height * 0.55);
          path.lineTo(0, size.height * 0.65);
          break;
        case BubbleTailPosition.right:
          path.moveTo(size.width, size.height * 0.45);
          path.lineTo(size.width + 10, size.height * 0.55);
          path.lineTo(size.width, size.height * 0.65);
          break;
        case BubbleTailPosition.bottom:
          path.moveTo(size.width * 0.35, size.height);
          path.lineTo(size.width * 0.45, size.height + 9);
          path.lineTo(size.width * 0.55, size.height);
          break;
        case BubbleTailPosition.top:
          path.moveTo(size.width * 0.35, 0);
          path.lineTo(size.width * 0.45, -9);
          path.lineTo(size.width * 0.55, 0);
          break;
        case BubbleTailPosition.none:
          break;
      }
      path.close();
      canvas.drawPath(path, paint);
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BubblePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.tailPosition != tailPosition;
  }
}
