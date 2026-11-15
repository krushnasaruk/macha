import 'package:flutter/material.dart';
import '../ux/motion/motion_tokens.dart';
import 'mascot_asset_registry.dart';
import 'mascot_dialogue_bubble.dart';

/// Primary widget representing Chef Barnaby, the CaféOS official mascot.
/// Features gentle, restrained breathing animation and optional comic dialogue bubble.
class MascotWidget extends StatefulWidget {
  final String? assetPath;
  final MascotExpression? expression;
  final MascotAction? action;
  final MascotInteraction? interaction;
  final MascotStateIllustration? stateIllustration;
  final MascotPose? pose;
  final MascotPawStudy? pawStudy;
  final MascotObjectInteraction? objectInteraction;

  final double height;
  final double? width;
  final bool animate;
  final String? dialogue;
  final String? dialogueTitle;
  final BubbleStyle bubbleStyle;
  final BubbleTailPosition tailPosition;
  final VoidCallback? onTap;

  const MascotWidget({
    super.key,
    this.assetPath,
    this.expression,
    this.action,
    this.interaction,
    this.stateIllustration,
    this.pose,
    this.pawStudy,
    this.objectInteraction,
    this.height = 140.0,
    this.width,
    this.animate = true,
    this.dialogue,
    this.dialogueTitle,
    this.bubbleStyle = BubbleStyle.normal,
    this.tailPosition = BubbleTailPosition.left,
    this.onTap,
  });

  /// Factory for neutral standing mascot
  factory MascotWidget.neutral({double height = 140.0, String? dialogue}) =>
      MascotWidget(
        expression: MascotExpression.neutral,
        height: height,
        dialogue: dialogue,
      );

  /// Factory for celebration with confetti
  factory MascotWidget.celebrating({double height = 160.0, String? dialogue}) =>
      MascotWidget(
        interaction: MascotInteraction.celebratingTask,
        height: height,
        dialogue: dialogue,
        bubbleStyle: BubbleStyle.excited,
      );

  /// Factory for offline state
  factory MascotWidget.offline({double height = 150.0, String? dialogue}) =>
      MascotWidget(
        stateIllustration: MascotStateIllustration.offlineConcerned,
        height: height,
        dialogue: dialogue ?? 'Looks like the internet took a little coffee break.',
        bubbleStyle: BubbleStyle.warning,
      );

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _breatheController;
  late Animation<double> _breatheAnimation;

  bool get _isTestEnvironment =>
      WidgetsBinding.instance.runtimeType.toString().contains('Test');

  @override
  void initState() {
    super.initState();
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _breatheAnimation = Tween<double>(begin: 1.0, end: 1.018).animate(
      CurvedAnimation(
        parent: _breatheController,
        curve: Curves.easeInOutSine,
      ),
    );

    if (widget.animate && !_isTestEnvironment) {
      _breatheController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(MascotWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_isTestEnvironment && !_breatheController.isAnimating) {
      _breatheController.repeat(reverse: true);
    } else if (!widget.animate && _breatheController.isAnimating) {
      _breatheController.stop();
    }
  }

  @override
  void dispose() {
    _breatheController.dispose();
    super.dispose();
  }

  String _resolveAssetPath() {
    if (widget.assetPath != null) return widget.assetPath!;
    if (widget.expression != null) return widget.expression!.path;
    if (widget.action != null) return widget.action!.path;
    if (widget.interaction != null) return widget.interaction!.path;
    if (widget.stateIllustration != null) return widget.stateIllustration!.path;
    if (widget.pose != null) return widget.pose!.path;
    if (widget.objectInteraction != null) return widget.objectInteraction!.path;
    if (widget.pawStudy != null) return widget.pawStudy!.path;
    return MascotExpression.neutral.path;
  }

  @override
  Widget build(BuildContext context) {
    final path = _resolveAssetPath();
    final motion = Motion.of(context);

    Widget bearImage = Image.asset(
      path,
      height: widget.height,
      width: widget.width,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to master transparent if sub-variant is missing
        return Image.asset(
          MascotAssetRegistry.masterTransparent,
          height: widget.height,
          width: widget.width,
          fit: BoxFit.contain,
        );
      },
    );

    if (widget.animate && !motion.isReducedMotion) {
      bearImage = AnimatedBuilder(
        animation: _breatheAnimation,
        builder: (context, child) => Transform.scale(
          scaleY: _breatheAnimation.value,
          alignment: Alignment.bottomCenter,
          child: child,
        ),
        child: bearImage,
      );
    }

    if (widget.onTap != null) {
      bearImage = GestureDetector(
        onTap: widget.onTap,
        child: bearImage,
      );
    }

    if (widget.dialogue == null) {
      return bearImage;
    }

    // Combine bear with speech bubble in a pleasant layout
    final isHorizontal = widget.tailPosition == BubbleTailPosition.left ||
        widget.tailPosition == BubbleTailPosition.right;

    if (isHorizontal) {
      final isTailLeft = widget.tailPosition == BubbleTailPosition.left;
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isTailLeft) bearImage,
          if (isTailLeft) const SizedBox(width: 8),
          MascotDialogueBubble(
            text: widget.dialogue!,
            title: widget.dialogueTitle,
            style: widget.bubbleStyle,
            tailPosition: widget.tailPosition,
          ),
          if (!isTailLeft) const SizedBox(width: 8),
          if (!isTailLeft) bearImage,
        ],
      );
    } else {
      final isTailBottom = widget.tailPosition == BubbleTailPosition.bottom;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isTailBottom)
            MascotDialogueBubble(
              text: widget.dialogue!,
              title: widget.dialogueTitle,
              style: widget.bubbleStyle,
              tailPosition: widget.tailPosition,
            ),
          if (isTailBottom) const SizedBox(height: 8),
          bearImage,
          if (!isTailBottom) const SizedBox(height: 8),
          if (!isTailBottom)
            MascotDialogueBubble(
              text: widget.dialogue!,
              title: widget.dialogueTitle,
              style: widget.bubbleStyle,
              tailPosition: widget.tailPosition,
            ),
        ],
      );
    }
  }
}
