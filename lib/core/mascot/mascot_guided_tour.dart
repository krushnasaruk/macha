import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/app_button.dart';
import '../identity/identity_models.dart';
import '../identity/identity_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'mascot_asset_registry.dart';
import 'mascot_dialogue_bubble.dart';
import 'mascot_widget.dart';

class TourStep {
  final String title;
  final String dialogue;
  final String description;
  final String path;
  final MascotAction? action;
  final MascotInteraction? interaction;
  final MascotStateIllustration? stateIllustration;
  final MascotExpression? expression;

  const TourStep({
    required this.title,
    required this.dialogue,
    required this.description,
    required this.path,
    this.action,
    this.interaction,
    this.stateIllustration,
    this.expression,
  });
}

final hasCompletedTourProvider = StateProvider<bool>((ref) => false);
final isTourActiveProvider = StateProvider<bool>((ref) => false);

/// Interactive comic-style guided onboarding tour guided by Chef Barnaby.
class MascotGuidedTourModal extends ConsumerStatefulWidget {
  final VoidCallback onDismiss;

  const MascotGuidedTourModal({super.key, required this.onDismiss});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MascotGuidedTourModal(
        onDismiss: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  ConsumerState<MascotGuidedTourModal> createState() =>
      _MascotGuidedTourModalState();
}

class _MascotGuidedTourModalState extends ConsumerState<MascotGuidedTourModal> {
  int _currentStepIndex = 0;

  List<TourStep> _buildStepsForRole(UserRole role) {
    final allSteps = [
      const TourStep(
        title: 'Welcome to CaféOS!',
        dialogue: 'Hey there, chef! Welcome to CaféOS.',
        description: 'I\'m Chef Barnaby, your kitchen & counter companion. Let me show you how we run things!',
        path: '/pos',
        interaction: MascotInteraction.welcoming,
      ),
      const TourStep(
        title: 'POS & Billing Counter',
        dialogue: 'Ready for your first order? This is where the magic happens!',
        description: 'Tap any product to add it to the cart. 1-tap exact cash tender makes rushes effortless.',
        path: '/pos',
        action: MascotAction.holdingCoffeeCup,
      ),
      const TourStep(
        title: 'Live Orders Queue',
        dialogue: 'All your orders live here. No more losing track of who is waiting!',
        description: 'Track real-time order stages: Created ➔ Confirmed ➔ Preparing ➔ Ready to Serve.',
        path: '/orders',
        action: MascotAction.holdingReceipt,
      ),
      const TourStep(
        title: 'Kitchen Display System (KDS)',
        dialogue: 'Let\'s keep the kitchen moving!',
        description: 'Filter by prep station, track elapsed minutes, and tap to bump tickets with 5s undo.',
        path: '/kitchen',
        action: MascotAction.holdingTray,
      ),
      const TourStep(
        title: 'Inventory & Supplies',
        dialogue: 'Let\'s make sure we never run out of the good stuff!',
        description: 'Automated recipe deduction and reorder warnings keep your bean hoppers full.',
        path: '/inventory',
        stateIllustration: MascotStateIllustration.lowInventoryWarning,
      ),
      const TourStep(
        title: 'Reports & Performance',
        dialogue: 'And here\'s how your café is doing. Looking good, chef!',
        description: 'View daily sales, category breakdowns, and cash drawer balance with zero math.',
        path: '/reports',
        interaction: MascotInteraction.lookingDashboard,
      ),
      const TourStep(
        title: 'You\'re All Set!',
        dialogue: 'That\'s the tour! You\'re officially ready, chef!',
        description: 'Have a great shift! Remember, I\'m always here if you need a hand.',
        path: '/pos',
        interaction: MascotInteraction.celebratingTask,
      ),
    ];

    // Role-filtered tour steps
    if (role == UserRole.kitchenStaff) {
      return [
        allSteps[0],
        allSteps[3], // KDS
        allSteps[6], // Celebration
      ];
    } else if (role == UserRole.cashier) {
      return [
        allSteps[0],
        allSteps[1], // POS
        allSteps[2], // Orders
        allSteps[6], // Celebration
      ];
    }

    return allSteps;
  }

  void _finishTour() {
    ref.read(hasCompletedTourProvider.notifier).state = true;
    ref.read(isTourActiveProvider.notifier).state = false;
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final steps = _buildStepsForRole(identity.role);
    final step = steps[_currentStepIndex];
    final isLastStep = _currentStepIndex == steps.length - 1;
    final isFirstStep = _currentStepIndex == 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Step ${_currentStepIndex + 1} of ${steps.length}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _finishTour,
                    child: const Text('Skip Tour'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Mascot with speech bubble
              MascotWidget(
                action: step.action,
                interaction: step.interaction,
                stateIllustration: step.stateIllustration,
                expression: step.expression,
                height: 130,
                dialogue: step.dialogue,
                dialogueTitle: 'Chef Barnaby',
                tailPosition: BubbleTailPosition.bottom,
                bubbleStyle: isLastStep ? BubbleStyle.excited : BubbleStyle.tutorial,
              ),
              const SizedBox(height: 16),

              // Title and Description
              Text(
                step.title,
                style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                step.description,
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Navigation controls
              Row(
                children: [
                  if (!isFirstStep)
                    Expanded(
                      child: AppButton(
                        label: 'Previous',
                        variant: AppButtonVariant.outline,
                        onPressed: () {
                          setState(() {
                            _currentStepIndex--;
                          });
                        },
                      ),
                    ),
                  if (!isFirstStep) const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: isLastStep
                          ? 'Get Started'
                          : (isFirstStep ? 'Show Me Around' : 'Next Step'),
                      variant: AppButtonVariant.primary,
                      onPressed: () {
                        if (isLastStep) {
                          _finishTour();
                        } else {
                          setState(() {
                            _currentStepIndex++;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
