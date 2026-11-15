import 'package:flutter/material.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_dialog.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/components/offline_sync_indicator.dart';
import '../../../core/components/state_indicators.dart';
import '../../../core/theme/app_spacing.dart';
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
          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CurrencyText(Money.fromRupees(150), fontSize: 24),
              CurrencyText(Money.fromRupees(1249, 50), fontSize: 20),
              const CurrencyText(Money.fromPaise(500), fontSize: 16),
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
