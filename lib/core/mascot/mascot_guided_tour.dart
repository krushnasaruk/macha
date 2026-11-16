import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final MascotPose? pose;
  final String featureHighlightLabel;
  final Rect Function(Size screenSize)? targetRectBuilder;

  const TourStep({
    required this.title,
    required this.dialogue,
    required this.description,
    required this.path,
    this.action,
    this.interaction,
    this.stateIllustration,
    this.expression,
    this.pose,
    this.featureHighlightLabel = 'Featured Spotlight',
    this.targetRectBuilder,
  });

  static List<TourStep> buildStepsForRole(UserRole role) {
    final allSteps = [
      TourStep(
        title: 'Welcome to MΛCHA!',
        dialogue: 'Hey there chef! Welcome to MΛCHA 🌿 I\'m Barnaby. Let\'s explore your café command center!',
        description: 'Track real-time sales, order volume, and daily rotating specials right from your home dashboard.',
        path: '/home',
        pose: MascotPose.waving,
        featureHighlightLabel: 'Live Sales & Daily Chef Special',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 75, size.width - 32, 210),
      ),
      TourStep(
        title: 'POS & Billing Counter',
        dialogue: 'Here is your POS counter ☕! Tap any item to ring up tickets instantly with 1-tap checkout.',
        description: 'One-tap item selection, category filtering, and 1-tap exact cash tender makes morning rushes effortless.',
        path: '/pos',
        pose: MascotPose.holding,
        featureHighlightLabel: 'One-Tap Catalog & Quick Order',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 110, size.width - 32, 260),
      ),
      TourStep(
        title: 'Live Orders Queue',
        dialogue: 'All tickets stream here live 📋! Track orders in real-time from New to Ready to Serve.',
        description: 'Monitor real-time stages: New ➔ Preparing ➔ Ready to Serve with table and customer tracking.',
        path: '/orders',
        pose: MascotPose.pointing,
        featureHighlightLabel: 'Real-Time Order Pipeline',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 75, size.width - 32, 250),
      ),
      TourStep(
        title: 'Kitchen Display System (KDS)',
        dialogue: 'Keep the kitchen moving 🍳! View station prep tickets and bump finished dishes with 5s undo.',
        description: 'Color-coded elapsed timers and instant bump actions ensure hot coffee and fresh food reach tables fast.',
        path: '/kitchen',
        pose: MascotPose.cooking,
        featureHighlightLabel: 'Station Prep Tickets & 5s Bump',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 75, size.width - 32, 260),
      ),
      TourStep(
        title: 'Inventory & Supplies',
        dialogue: 'Never run out of ingredients 📦! Real-time stock tracking and low-stock alerts give advance notice.',
        description: 'Automated recipe deduction, batch adjustments, and low-stock warnings keep your hoppers full.',
        path: '/inventory',
        pose: MascotPose.carrying,
        featureHighlightLabel: 'Real-Time Stock & Ingredient Alerts',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 75, size.width - 32, 250),
      ),
      TourStep(
        title: 'Reports & Performance',
        dialogue: 'Here is your café performance 📊! Instant revenue KPIs, bestselling items, and cashier drawer audits.',
        description: 'Real-time sales charts, hourly breakdowns, and drawer audits keep your business finances rock solid.',
        path: '/reports',
        pose: MascotPose.thinking,
        featureHighlightLabel: 'Instant Financial KPIs & Drawer Audit',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 75, size.width - 32, 240),
      ),
      TourStep(
        title: 'You\'re All Set!',
        dialogue: 'You are all set to run the café, chef! 🎉 I\'m always right here whenever you need me.',
        description: 'Have a phenomenal shift! Remember, Chef Barnaby is always by your side.',
        path: '/home',
        pose: MascotPose.celebrating,
        featureHighlightLabel: 'Chef Barnaby Companion Ready',
        targetRectBuilder: (size) => Rect.fromLTWH(16, 75, size.width - 32, 210),
      ),
    ];

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
}

final hasCompletedTourProvider = StateProvider<bool>((ref) => false);
final isTourActiveProvider = StateProvider<bool>((ref) => false);
final currentTourStepIndexProvider = StateProvider<int>((ref) => 0);

/// Primary controller to initiate and control the interactive multi-page tour.
abstract final class MascotGuidedTour {
  static void start(WidgetRef ref, BuildContext context) {
    ref.read(isTourActiveProvider.notifier).state = true;
    ref.read(currentTourStepIndexProvider.notifier).state = 0;
    try {
      context.go('/home');
    } catch (_) {}
  }

  static void stop(WidgetRef ref, [BuildContext? context]) {
    ref.read(isTourActiveProvider.notifier).state = false;
    ref.read(hasCompletedTourProvider.notifier).state = true;
    if (context != null) {
      try {
        context.go('/home');
      } catch (_) {}
    }
  }
}

/// Interactive Full-Screen Coachmark & Page-Switching Tour Overlay.
/// Mounted in AppShell: switches pages as steps advance, spotlights key features,
/// animates directional pointer beacons, and types dialogue with sound & haptics.
class GuidedTourOverlay extends ConsumerStatefulWidget {
  const GuidedTourOverlay({super.key});

  @override
  ConsumerState<GuidedTourOverlay> createState() => _GuidedTourOverlayState();
}

class _GuidedTourOverlayState extends ConsumerState<GuidedTourOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _finishTour() {
    ref.read(hasCompletedTourProvider.notifier).state = true;
    ref.read(isTourActiveProvider.notifier).state = false;
    try {
      HapticFeedback.mediumImpact();
      context.go('/home');
    } catch (_) {}
  }

  void _goToStep(int targetIndex, List<TourStep> steps) {
    if (targetIndex < 0 || targetIndex >= steps.length) return;
    ref.read(currentTourStepIndexProvider.notifier).state = targetIndex;
    final nextStep = steps[targetIndex];
    try {
      HapticFeedback.lightImpact();
      context.go(nextStep.path);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isTourActive = ref.watch(isTourActiveProvider);
    if (!isTourActive) return const SizedBox.shrink();

    final identity = ref.watch(currentIdentityNotifier);
    final steps = TourStep.buildStepsForRole(identity.role);
    final currentIndex = ref.watch(currentTourStepIndexProvider);
    final safeIndex = currentIndex.clamp(0, steps.length - 1);
    final step = steps[safeIndex];

    final isFirstStep = safeIndex == 0;
    final isLastStep = safeIndex == steps.length - 1;

    final screenSize = MediaQuery.of(context).size;
    final targetRect = step.targetRectBuilder?.call(screenSize) ??
        Rect.fromLTWH(16, 80, screenSize.width - 32, 220);

    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Semi-Transparent Backdrop with Spotlight Cut-Out
          CustomPaint(
            painter: _SpotlightOverlayPainter(
              targetRect: targetRect,
              glowProgress: _pulseController.value,
            ),
          ),

          // 2. Glowing Animated Beacon Pin on Target Feature
          Positioned(
            top: (targetRect.top - 44).clamp(16.0, screenSize.height - 140),
            left: 20,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, -4 * _pulseController.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.matchaGreen,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.matchaGreen.withOpacity(0.45 * _pulseController.value + 0.15),
                        blurRadius: 16,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.matchaGreen,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        step.featureHighlightLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Chef Barnaby Guided Tour Card (Docked neatly at bottom)
          Positioned(
            bottom: 12,
            left: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top progress bar & skip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Step ${safeIndex + 1} of ${steps.length} • ${step.path}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _finishTour,
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          foregroundColor: AppColors.textSecondaryLight,
                        ),
                        child: const Text(
                          'Skip Tour',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Character & Dialogue with Typewriter Sound & Haptic Vibration
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Mascot Image
                      MascotWidget(
                        pose: step.pose,
                        height: 90,
                        width: 78,
                        animate: true,
                      ),
                      const SizedBox(width: 10),
                      // Speech Bubble with Typewriter Animation
                      Expanded(
                        child: MascotDialogueBubble(
                          text: step.dialogue,
                          title: 'Chef Barnaby',
                          tailPosition: BubbleTailPosition.left,
                          style: isLastStep ? BubbleStyle.excited : BubbleStyle.tutorial,
                          animateTyping: true,
                          enableTypingFeedback: true,
                          maxWidth: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Bottom Controls (Dots & Navigation Buttons)
                  Row(
                    children: [
                      // Progress Dots
                      Row(
                        children: List.generate(steps.length, (i) {
                          final isActive = i == safeIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: isActive ? 18 : 6,
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primary : AppColors.borderLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),
                      const Spacer(),

                      // Previous Button
                      if (!isFirstStep) ...[
                        OutlinedButton(
                          onPressed: () => _goToStep(safeIndex - 1, steps),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.borderLight),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Back'),
                        ),
                        const SizedBox(width: 8),
                      ],

                      // Next / Finish Button
                      ElevatedButton(
                        onPressed: () {
                          if (isLastStep) {
                            _finishTour();
                          } else {
                            _goToStep(safeIndex + 1, steps);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 1,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isLastStep
                                  ? 'Get Started 🎉'
                                  : (isFirstStep ? 'Show Me Around →' : 'Next Step →'),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter for the semi-transparent backdrop and spotlight cut-out.
class _SpotlightOverlayPainter extends CustomPainter {
  final Rect targetRect;
  final double glowProgress;

  const _SpotlightOverlayPainter({
    required this.targetRect,
    required this.glowProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final targetRRect = RRect.fromRectAndRadius(targetRect, const Radius.circular(22));

    // Combined path with difference cutout
    final path = Path()
      ..addRect(fullRect)
      ..addRRect(targetRRect)
      ..fillType = PathFillType.evenOdd;

    final backdropPaint = Paint()
      ..color = const Color(0x99181412) // Dark warm espresso overlay
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, backdropPaint);

    // Outer soft pulsing halo
    final outerGlowPaint = Paint()
      ..color = AppColors.matchaGreen.withOpacity(0.3 * glowProgress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawRRect(targetRRect, outerGlowPaint);

    // Glowing highlight border around the target cut-out
    final glowPaint = Paint()
      ..color = AppColors.matchaGreen.withOpacity(0.6 + 0.4 * glowProgress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawRRect(targetRRect, glowPaint);
  }

  @override
  bool shouldRepaint(_SpotlightOverlayPainter oldDelegate) {
    return oldDelegate.targetRect != targetRect ||
        oldDelegate.glowProgress != glowProgress;
  }
}

/// Backwards-compatible modal component for standalone widget testing.
class MascotGuidedTourModal extends ConsumerStatefulWidget {
  final VoidCallback onDismiss;

  const MascotGuidedTourModal({super.key, required this.onDismiss});

  static void show(BuildContext context) {
    try {
      final container = ProviderScope.containerOf(context, listen: false);
      container.read(isTourActiveProvider.notifier).state = true;
      container.read(currentTourStepIndexProvider.notifier).state = 0;
      context.go('/home');
    } catch (_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MascotGuidedTourModal(
          onDismiss: () => Navigator.of(context).pop(),
        ),
      );
    }
  }

  @override
  ConsumerState<MascotGuidedTourModal> createState() =>
      _MascotGuidedTourModalState();
}

class _MascotGuidedTourModalState extends ConsumerState<MascotGuidedTourModal> {
  int _currentStepIndex = 0;

  void _finishTour() {
    ref.read(hasCompletedTourProvider.notifier).state = true;
    ref.read(isTourActiveProvider.notifier).state = false;
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final steps = TourStep.buildStepsForRole(identity.role);
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
              MascotWidget(
                pose: step.pose,
                action: step.action,
                interaction: step.interaction,
                stateIllustration: step.stateIllustration,
                expression: step.expression,
                height: 130,
                dialogue: step.dialogue,
                dialogueTitle: 'Chef Barnaby',
                tailPosition: BubbleTailPosition.bottom,
                bubbleStyle: isLastStep ? BubbleStyle.excited : BubbleStyle.tutorial,
                animateTyping: true,
                enableTypingFeedback: true,
              ),
              const SizedBox(height: 16),
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
