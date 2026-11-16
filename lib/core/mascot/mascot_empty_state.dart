import 'package:flutter/material.dart';
import '../components/app_button.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'mascot_asset_registry.dart';
import 'mascot_dialogue_bubble.dart';
import 'mascot_widget.dart';

/// Friendly, character-driven empty state using Chef Barnaby.
/// Replaces cold empty screens with warm, guided culinary guidance.
class MascotEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final String? chefQuote;
  final String? actionLabel;
  final VoidCallback? onAction;
  final MascotStateIllustration? stateIllustration;
  final MascotAction? action;
  final MascotExpression? expression;
  final MascotPose? pose;
  final double mascotHeight;

  const MascotEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.chefQuote,
    this.actionLabel,
    this.onAction,
    this.stateIllustration,
    this.action,
    this.expression,
    this.pose,
    this.mascotHeight = 150.0,
  });

  /// Factory for empty orders screen
  factory MascotEmptyState.orders({VoidCallback? onNewOrder}) => MascotEmptyState(
        title: 'No Active Orders',
        description: 'Orders placed on the POS will appear here live.',
        chefQuote: 'The counter is quiet right now. Let\'s ring up a new customer!',
        actionLabel: onNewOrder != null ? 'New Order' : null,
        onAction: onNewOrder,
        pose: MascotPose.resting,
      );

  /// Factory for clear kitchen screen
  factory MascotEmptyState.kitchen() => const MascotEmptyState(
        title: 'Kitchen is Clear, Chef!',
        description: 'All pending tickets have been prepared and served.',
        chefQuote: 'Great work! Take a breath while we wait for the next rush.',
        pose: MascotPose.cooking,
      );

  /// Factory for empty menu screen
  factory MascotEmptyState.menu({VoidCallback? onAddProduct}) => MascotEmptyState(
        title: 'Your Menu is Empty',
        description: 'Add your coffee blends, pastries, and snacks to start selling.',
        chefQuote: 'Every great café starts with a killer signature brew!',
        actionLabel: onAddProduct != null ? 'Add First Product' : null,
        onAction: onAddProduct,
        pose: MascotPose.holding,
      );

  /// Factory for offline state
  factory MascotEmptyState.offline({VoidCallback? onRetry}) => MascotEmptyState(
        title: 'Offline Mode Active',
        description: 'All local billing and orders are completely safe and working.',
        chefQuote: 'Looks like the internet took a coffee break! Don\'t worry, I\'ve saved everything right here.',
        actionLabel: onRetry != null ? 'Check Connection' : null,
        onAction: onRetry,
        pose: MascotPose.thinking,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: AppSpacing.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MascotWidget(
              pose: pose,
              stateIllustration: stateIllustration,
              action: action,
              expression: expression,
              height: mascotHeight,
              dialogue: chefQuote,
              dialogueTitle: 'Chef Barnaby',
              tailPosition: BubbleTailPosition.bottom,
              bubbleStyle: BubbleStyle.normal,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Text(
                description,
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              AppButton(
                label: actionLabel!,
                onPressed: onAction!,
                variant: AppButtonVariant.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
