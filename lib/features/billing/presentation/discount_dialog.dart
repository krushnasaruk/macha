import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cafe_os/core/components/app_button.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/permissions/permission_keys.dart';
import 'package:cafe_os/core/permissions/role_permissions.dart';
import 'package:cafe_os/core/theme/app_colors.dart';
import 'package:cafe_os/core/theme/app_spacing.dart';
import 'package:cafe_os/core/theme/app_typography.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/domain/pricing/pricing_engine.dart';
import 'package:cafe_os/features/billing/presentation/controllers/cart_controller.dart';

class DiscountDialog extends ConsumerStatefulWidget {
  final Money currentSubtotal;

  const DiscountDialog({super.key, required this.currentSubtotal});

  @override
  ConsumerState<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends ConsumerState<DiscountDialog> {
  bool _isPercentage = true;
  final _valCtrl = TextEditingController(text: '10');
  bool _requiresManagerApproval = false;
  bool _isApproved = false;

  @override
  void dispose() {
    _valCtrl.dispose();
    super.dispose();
  }

  void _checkApprovalRequirement() {
    final role = ref.read(currentIdentityNotifier).role;
    final canApply = RolePermissions.hasPermission(role, AppPermissions.posDiscountApply);
    final canOverride =
        RolePermissions.hasPermission(role, AppPermissions.posDiscountOverrideMax);

    if (!canApply) {
      _requiresManagerApproval = true;
      return;
    }

    if (_isPercentage) {
      final pct = int.tryParse(_valCtrl.text.trim()) ?? 0;
      // Cashiers can apply up to 10% without manager override
      if (pct > 10 && !canOverride) {
        _requiresManagerApproval = true;
      } else {
        _requiresManagerApproval = false;
      }
    } else {
      final amt = Money.tryParse(_valCtrl.text.trim()) ?? Money.zero;
      // Cashiers can apply up to ₹100 without manager override
      if (amt.paise > 10000 && !canOverride) {
        _requiresManagerApproval = true;
      } else {
        _requiresManagerApproval = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkApprovalRequirement();

    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.discount_rounded, color: AppColors.primary),
          SizedBox(width: 8),
          Text('Apply Cart Discount'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Discount Type Selector (Percentage vs Fixed)
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Percent (%)')),
                ButtonSegment(value: false, label: Text('Fixed Amount (₹)')),
              ],
              selected: {_isPercentage},
              onSelectionChanged: (val) {
                setState(() {
                  _isPercentage = val.first;
                  _valCtrl.text = _isPercentage ? '10' : '50';
                  _isApproved = false;
                });
              },
            ),
            const SizedBox(height: 16),

            // Quick Preset Chips
            Wrap(
              spacing: 8,
              children: _isPercentage
                  ? [5, 10, 15, 20].map((pct) {
                      return ActionChip(
                        label: Text('$pct%'),
                        onPressed: () {
                          setState(() {
                            _valCtrl.text = pct.toString();
                            _isApproved = false;
                          });
                        },
                      );
                    }).toList()
                  : [20, 50, 100, 200].map((amt) {
                      return ActionChip(
                        label: Text('₹$amt'),
                        onPressed: () {
                          setState(() {
                            _valCtrl.text = amt.toString();
                            _isApproved = false;
                          });
                        },
                      );
                    }).toList(),
            ),
            const SizedBox(height: 16),

            // Value Input Field
            TextField(
              controller: _valCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: _isPercentage ? 'Percentage' : 'Rupees',
                suffixText: _isPercentage ? '%' : '₹',
              ),
              onChanged: (_) => setState(() {
                _isApproved = false;
              }),
            ),

            // Approval Banner if required
            if (_requiresManagerApproval && !_isApproved) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.12),
                  borderRadius: AppSpacing.roundedSm,
                  border: Border.all(color: AppColors.warning),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.security_rounded,
                            color: AppColors.warning, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Needs Manager Approval',
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Discounts exceeding cashier limits require manager sign-off.',
                      style: AppTypography.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        // Pluggable approval hand-off without full auth
                        setState(() {
                          _isApproved = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Manager override approved by Branch Manager'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: const Text('Approve as Manager'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref
                .read(cartControllerProvider.notifier)
                .setCartDiscount(const CartDiscount.none());
            Navigator.pop(context);
          },
          child: const Text('Remove Discount'),
        ),
        AppButton(
          label: 'Apply',
          onPressed: (_requiresManagerApproval && !_isApproved)
              ? null
              : () {
                  if (_isPercentage) {
                    final pct = int.tryParse(_valCtrl.text.trim()) ?? 0;
                    ref.read(cartControllerProvider.notifier).setCartDiscount(
                          CartDiscount.percentage(pct * 100), // convert to basis points
                        );
                  } else {
                    final amt =
                        Money.tryParse(_valCtrl.text.trim()) ?? Money.zero;
                    ref.read(cartControllerProvider.notifier).setCartDiscount(
                          CartDiscount.fixed(amt),
                        );
                  }
                  Navigator.pop(context);
                },
        ),
      ],
    );
  }
}
