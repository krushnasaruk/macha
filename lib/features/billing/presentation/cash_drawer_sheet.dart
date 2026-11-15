import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cafe_os/core/components/app_button.dart';
import 'package:cafe_os/core/components/app_card.dart';
import 'package:cafe_os/core/components/currency_text.dart';
import 'package:cafe_os/core/theme/app_colors.dart';
import 'package:cafe_os/core/theme/app_spacing.dart';
import 'package:cafe_os/core/theme/app_typography.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';

final activeCashSessionProvider =
    FutureProvider.autoDispose<CashSessionRecord?>((ref) async {
  final repo = ref.watch(billingRepositoryProvider);
  return repo.getActiveCashSession();
});

class CashDrawerSheet extends ConsumerStatefulWidget {
  const CashDrawerSheet({super.key});

  @override
  ConsumerState<CashDrawerSheet> createState() => _CashDrawerSheetState();
}

class _CashDrawerSheetState extends ConsumerState<CashDrawerSheet> {
  final _floatCtrl = TextEditingController(text: '2000');
  final _actualCashCtrl = TextEditingController();
  final _movementAmountCtrl = TextEditingController();
  final _movementReasonCtrl = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _floatCtrl.dispose();
    _actualCashCtrl.dispose();
    _movementAmountCtrl.dispose();
    _movementReasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(activeCashSessionProvider);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.point_of_sale_rounded,
                          color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Cash Drawer & Session',
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              sessionAsync.when(
                data: (session) {
                  if (session == null) {
                    return _buildOpenSessionView();
                  } else {
                    return _buildActiveSessionView(session);
                  }
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (err, _) => Center(
                  child: Text('Error loading session: $err'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpenSessionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          backgroundColor: AppColors.primaryContainer.withOpacity(0.5),
          child: Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'No cash drawer session is currently open on this device. Enter opening float to start sales.',
                  style: AppTypography.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Opening Cash Float',
          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _floatCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText: '₹ ',
            border: OutlineInputBorder(),
            labelText: 'Opening Float Amount',
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [1000, 2000, 3000, 5000].map((amt) {
            return ActionChip(
              label: Text('₹$amt'),
              onPressed: () {
                _floatCtrl.text = amt.toString();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Open Drawer & Start Session',
          isLoading: _isSubmitting,
          onPressed: () async {
            final amt =
                Money.tryParse(_floatCtrl.text.trim()) ?? const Money.fromRupees(2000);
            setState(() => _isSubmitting = true);
            final repo = ref.read(billingRepositoryProvider);
            await repo.openCashSession(amt);
            ref.invalidate(activeCashSessionProvider);
            setState(() => _isSubmitting = false);
          },
        ),
      ],
    );
  }

  Widget _buildActiveSessionView(CashSessionRecord session) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Session Status', style: AppTypography.bodySmall),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.15),
                      borderRadius: AppSpacing.roundedSm,
                    ),
                    child: Text(
                      'ACTIVE & RUNNING',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Opening Float', style: AppTypography.bodySmall),
                  CurrencyText(session.openingFloat,
                      style: AppTypography.bodySmall),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expected Cash in Drawer',
                      style: AppTypography.titleSmall
                          .copyWith(fontWeight: FontWeight.bold)),
                  CurrencyText(
                    session.expectedCash,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.arrow_downward_rounded,
                    color: AppColors.success),
                label: const Text('Cash In'),
                onPressed: () => _showMovementDialog(session.id, 'cash_in'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.arrow_upward_rounded,
                    color: AppColors.warning),
                label: const Text('Cash Out'),
                onPressed: () => _showMovementDialog(session.id, 'cash_out'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Close Drawer & End Session',
          variant: AppButtonVariant.secondary,
          icon: Icons.lock_clock_rounded,
          onPressed: () => _showCloseDrawerDialog(session),
        ),
      ],
    );
  }

  void _showMovementDialog(String sessionId, String type) {
    _movementAmountCtrl.clear();
    _movementReasonCtrl.clear();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(type == 'cash_in' ? 'Record Cash In' : 'Record Cash Out'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _movementAmountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '₹ ',
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _movementReasonCtrl,
              decoration: InputDecoration(
                labelText: 'Reason',
                hintText: type == 'cash_in'
                    ? 'e.g. Added change float'
                    : 'e.g. Petty cash milk purchase',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final amt = Money.tryParse(_movementAmountCtrl.text.trim());
              if (amt != null && amt.isPositive) {
                final repo = ref.read(billingRepositoryProvider);
                await repo.recordCashMovement(
                  sessionId: sessionId,
                  type: type,
                  amount: amt,
                  reason: _movementReasonCtrl.text.trim(),
                );
                ref.invalidate(activeCashSessionProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCloseDrawerDialog(CashSessionRecord session) {
    _actualCashCtrl.clear();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          final counted = Money.tryParse(_actualCashCtrl.text.trim());
          final variance =
              counted != null ? counted - session.expectedCash : null;

          return AlertDialog(
            title: const Text('Close Cash Drawer'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Expected Cash:'),
                      CurrencyText(session.expectedCash,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _actualCashCtrl,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixText: '₹ ',
                      labelText: 'Counted Actual Cash',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => setDialogState(() {}),
                  ),
                  if (variance != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: variance.isZero
                            ? AppColors.success.withOpacity(0.15)
                            : (variance.isPositive
                                ? AppColors.info.withOpacity(0.15)
                                : AppColors.error.withOpacity(0.15)),
                        borderRadius: AppSpacing.roundedSm,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            variance.isZero
                                ? 'Balanced (Zero variance)'
                                : (variance.isPositive ? 'Overage' : 'Shortage'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: variance.isZero
                                  ? AppColors.success
                                  : (variance.isPositive
                                      ? AppColors.info
                                      : AppColors.error),
                            ),
                          ),
                          CurrencyText(
                            variance.isNegative ? -variance : variance,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: variance.isZero
                                  ? AppColors.success
                                  : (variance.isPositive
                                      ? AppColors.info
                                      : AppColors.error),
                            ),
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
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final actual = Money.tryParse(_actualCashCtrl.text.trim());
                  if (actual != null) {
                    final rootNav = Navigator.of(context);
                    final repo = ref.read(billingRepositoryProvider);
                    await repo.closeCashSession(
                      sessionId: session.id,
                      actualCash: actual,
                    );
                    ref.invalidate(activeCashSessionProvider);
                    if (ctx.mounted) Navigator.pop(ctx);
                    if (mounted) rootNav.pop();
                  }
                },
                child: const Text('Submit & Close'),
              ),
            ],
          );
        },
      ),
    );
  }
}
