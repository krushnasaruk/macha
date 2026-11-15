import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_dialog.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/components/offline_sync_indicator.dart';
import '../../../core/components/state_indicators.dart';
import '../../../core/mascot/mascot_asset_registry.dart';
import '../../../core/mascot/mascot_celebration.dart';
import '../../../core/mascot/mascot_dialogue_bubble.dart';
import '../../../core/mascot/mascot_guided_tour.dart';
import '../../../core/mascot/mascot_widget.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/ux/interaction/hold_repeat.dart';
import '../../../core/ux/loading/skeleton.dart';
import '../../../core/values/money.dart';

class ComponentGalleryScreen extends StatefulWidget {
  const ComponentGalleryScreen({super.key});

  @override
  State<ComponentGalleryScreen> createState() => _ComponentGalleryScreenState();
}

class _ComponentGalleryScreenState extends State<ComponentGalleryScreen> {
  final _testController = TextEditingController(text: 'Espresso Blend');
  bool _selectedCard = false;
  bool _buttonLoading = false;
  int _stepperCount = 1;

  @override
  void dispose() {
    _testController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System & Component Gallery'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: OfflineSyncIndicator(pendingCount: 2),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          _sectionTitle('1. Typography & CurrencyText (ADR-D2)'),
          const Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CurrencyText(Money.fromRupees(150), fontSize: 24),
              CurrencyText(Money.fromRupees(1249, 50), fontSize: 20),
              CurrencyText(Money.fromPaise(500), fontSize: 16),
              CurrencyText(Money.fromRupees(-45), fontSize: 16, color: Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          _sectionTitle('2. Buttons (AppButton)'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: 'Primary Action',
                onPressed: () {},
                icon: Icons.add,
              ),
              AppButton(
                label: 'Secondary Action',
                onPressed: () {},
                variant: AppButtonVariant.secondary,
              ),
              AppButton(
                label: 'Outline Action',
                onPressed: () {},
                variant: AppButtonVariant.outline,
              ),
              AppButton(
                label: 'Danger Action',
                onPressed: () {},
                variant: AppButtonVariant.danger,
              ),
              AppButton(
                label: 'Loading State',
                isLoading: _buttonLoading,
                onPressed: () {
                  setState(() => _buttonLoading = !_buttonLoading);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          _sectionTitle('3. Badges & Order Statuses (AppBadge)'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppBadge.status('created'),
              AppBadge.status('confirmed'),
              AppBadge.status('preparing'),
              AppBadge.status('ready'),
              AppBadge.status('served'),
              AppBadge.status('cancelled'),
            ],
          ),
          const SizedBox(height: 24),

          _sectionTitle('4. Text Fields (AppTextField)'),
          AppTextField(
            label: 'Product Name',
            controller: _testController,
            hint: 'Enter item name',
            prefixIcon: const Icon(Icons.coffee_rounded),
          ),
          const SizedBox(height: 12),
          const AppTextField(
            label: 'Tax Slabs',
            hint: 'e.g. 5%, 18%',
            errorText: 'Sample validation error feedback',
          ),
          const SizedBox(height: 24),

          _sectionTitle('5. Interactive Cards (AppCard)'),
          AppCard(
            isSelected: _selectedCard,
            onTap: () {
              setState(() => _selectedCard = !_selectedCard);
            },
            child: Row(
              children: [
                const Icon(Icons.touch_app_rounded, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interactive Selection Card',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        _selectedCard ? 'Card is currently SELECTED' : 'Tap to select this card',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: _selectedCard,
                  onChanged: (v) => setState(() => _selectedCard = v ?? false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle('6. Dialogs (AppDialog)'),
          AppButton(
            label: 'Trigger Confirmation Dialog',
            variant: AppButtonVariant.outline,
            onPressed: () async {
              final result = await AppDialog.show(
                context,
                title: 'Confirm Void Order',
                message: 'Are you sure you want to void this bill? This action creates an audit trail.',
                isDestructive: true,
                confirmLabel: 'Void Order',
              );
              if (context.mounted && result == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Action confirmed!')),
                );
              }
            },
          ),
          const SizedBox(height: 24),

          _sectionTitle('7. Empty & Error States'),
          const AppCard(
            child: AppEmptyState(
              icon: Icons.receipt_long_rounded,
              title: 'No Pending Orders',
              description: 'Orders placed on the POS will appear here in real-time.',
              actionLabel: 'New Bill',
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: AppErrorState(
              message: 'Failed to connect to local printer series B-2.',
              onRetry: () {},
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle('8. UX Primitives & Motion Lab (Stage 2)'),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A. Pressable & Hold-to-Repeat Stepper',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    HoldRepeat(
                      onTrigger: () {
                        if (_stepperCount > 1) setState(() => _stepperCount--);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.remove, size: 20),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('Qty: $_stepperCount', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    HoldRepeat(
                      onTrigger: () {
                        setState(() => _stepperCount++);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, size: 20),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  'B. Shimmer Skeletons (150ms delay / 300ms min hold)',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Shimmer(
                  child: Row(
                    children: [
                      SkeletonCircle(size: 44),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(width: 140, height: 16),
                            SizedBox(height: 6),
                            SkeletonLine(width: 80, height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 24),
                Text(
                  'C. Haptic & Sensory Feedback',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    AppButton(
                      label: 'Selection Click',
                      variant: AppButtonVariant.outline,
                      height: 36,
                      onPressed: () => HapticFeedback.selectionClick(),
                    ),
                    AppButton(
                      label: 'Light Tap',
                      variant: AppButtonVariant.outline,
                      height: 36,
                      onPressed: () => HapticFeedback.lightImpact(),
                    ),
                    AppButton(
                      label: 'Heavy Confirm',
                      variant: AppButtonVariant.outline,
                      height: 36,
                      onPressed: () => HapticFeedback.heavyImpact(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle('9. Chef Barnaby & Comic Dialogue System'),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A. Mascot with Comic Speech Bubbles',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: MascotWidget(
                    expression: MascotExpression.happy,
                    height: 130,
                    dialogue: 'Hey chef! Welcome to CaféOS. Everything is local-first & ready for rush hour!',
                    dialogueTitle: 'Chef Barnaby',
                    tailPosition: BubbleTailPosition.bottom,
                    bubbleStyle: BubbleStyle.welcome,
                  ),
                ),
                const Divider(height: 24),
                Text(
                  'B. Speech Bubble Styles',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    MascotDialogueBubble(
                      title: 'Normal',
                      text: 'Order #ORD-101 has been sent to the espresso bar.',
                      style: BubbleStyle.normal,
                      tailPosition: BubbleTailPosition.none,
                      maxWidth: 240,
                    ),
                    MascotDialogueBubble(
                      title: 'Thought',
                      text: 'Hmm, looks like we might need to roast more dark blend soon...',
                      style: BubbleStyle.thought,
                      tailPosition: BubbleTailPosition.none,
                      maxWidth: 240,
                    ),
                    MascotDialogueBubble(
                      title: 'Excited!',
                      text: 'Record rush! 50 orders cleared without a hitch!',
                      style: BubbleStyle.excited,
                      tailPosition: BubbleTailPosition.none,
                      maxWidth: 240,
                    ),
                    MascotDialogueBubble(
                      title: 'Warning',
                      text: 'Internet took a coffee break. Working offline safely!',
                      style: BubbleStyle.warning,
                      tailPosition: BubbleTailPosition.none,
                      maxWidth: 240,
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  'C. Interactive Mascot Modals',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    AppButton(
                      label: 'Launch Guided Tour',
                      icon: Icons.explore_rounded,
                      variant: AppButtonVariant.primary,
                      onPressed: () => MascotGuidedTourModal.show(context),
                    ),
                    AppButton(
                      label: 'Trigger Celebration',
                      icon: Icons.celebration_rounded,
                      variant: AppButtonVariant.secondary,
                      onPressed: () => MascotCelebration.show(
                        context: context,
                        title: 'Payment Successful!',
                        message: 'Cash payment settled and recorded in drawer.',
                        amountSettled: const Money.fromRupees(420),
                        invoiceNumber: 'MAIN-01-26-00042',
                        onDismiss: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
