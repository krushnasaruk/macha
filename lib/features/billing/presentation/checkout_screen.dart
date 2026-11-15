import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cafe_os/core/components/app_button.dart';
import 'package:cafe_os/core/components/app_card.dart';
import 'package:cafe_os/core/components/currency_text.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/theme/app_colors.dart';
import 'package:cafe_os/core/theme/app_spacing.dart';
import 'package:cafe_os/core/theme/app_typography.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/presentation/cash_drawer_sheet.dart';
import 'package:cafe_os/features/billing/presentation/controllers/cart_controller.dart';
import 'package:cafe_os/features/billing/presentation/receipt_preview_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedMethod = 'cash'; // 'cash', 'upi', 'card'
  late Money _payable;
  String _tenderedInput = '';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final cart = ref.read(cartControllerProvider);
    _payable = cart.calculation.finalPayable;
    _tenderedInput = _payable.rupees.toString();
  }

  Money get _tenderedMoney {
    if (_tenderedInput.isEmpty) return _payable;
    final val = int.tryParse(_tenderedInput) ?? 0;
    return Money.fromRupees(val);
  }

  Money get _changeDue {
    final tendered = _tenderedMoney;
    if (tendered > _payable) {
      return tendered - _payable;
    }
    return Money.zero;
  }

  void _onKeypadTap(String val) {
    setState(() {
      if (val == 'C') {
        _tenderedInput = '';
      } else if (val == '⌫') {
        if (_tenderedInput.isNotEmpty) {
          _tenderedInput =
              _tenderedInput.substring(0, _tenderedInput.length - 1);
        }
      } else {
        _tenderedInput += val;
      }
    });
  }

  Future<void> _completeCashSale() async {
    final cart = ref.read(cartControllerProvider);
    if (cart.isEmpty) return;

    final tendered = _tenderedMoney;
    if (tendered < _payable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tendered amount cannot be less than total payable'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final repo = ref.read(billingRepositoryProvider);
      final activeSession = ref.read(activeCashSessionProvider).valueOrNull;

      final invoice = await repo.createAndSettleOrder(
        cart: cart,
        paymentMethod: 'cash',
        tendered: tendered,
        changeDue: _changeDue,
        cashSessionId: activeSession?.id,
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ReceiptPreviewScreen(invoice: invoice),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to complete sale: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final calc = cart.calculation;
    final isOnline = ref.watch(connectivityServiceProvider).isOnline;

    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart_outlined,
                  size: 64, color: AppColors.textSecondaryLight),
              const SizedBox(height: 12),
              const Text('Cart is empty'),
              const SizedBox(height: 16),
              AppButton(
                label: 'Return to POS',
                onPressed: () => context.go('/pos'),
              ),
            ],
          ),
        ),
      );
    }

    final quickDenominations = _generateQuickDenominations(calc.finalPayable.rupees);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Checkout & Payment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.point_of_sale_rounded),
            tooltip: 'Cash Drawer',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const CashDrawerSheet(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingMd,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Order Summary Card
                  AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${cart.orderType.label} · ${cart.totalItemCount} items',
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CurrencyText(
                              calc.finalPayable,
                              style: AppTypography.headlineSmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal: ${calc.grossSubtotal.format()}',
                                style: AppTypography.labelSmall),
                            if (calc.totalDiscounts.isPositive)
                              Text('Discount: -${calc.totalDiscounts.format()}',
                                  style: AppTypography.labelSmall
                                      .copyWith(color: AppColors.success)),
                            Text('Tax: ${calc.totalTax.format()}',
                                style: AppTypography.labelSmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Payment Method Segmented Selector
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'cash',
                        label: Text('Cash'),
                        icon: Icon(Icons.payments_rounded),
                      ),
                      ButtonSegment(
                        value: 'upi',
                        label: Text('UPI / QR'),
                        icon: Icon(Icons.qr_code_rounded),
                      ),
                      ButtonSegment(
                        value: 'card',
                        label: Text('Card / POS'),
                        icon: Icon(Icons.credit_card_rounded),
                      ),
                    ],
                    selected: {_selectedMethod},
                    onSelectionChanged: (val) {
                      setState(() {
                        _selectedMethod = val.first;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Method Details
                  if (_selectedMethod == 'cash') ...[
                    // Cash Path (ADR & Master Prompt 17.1)
                    AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        _tenderedMoney == _payable
                                            ? AppColors.primaryContainer
                                            : null,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _tenderedInput =
                                          _payable.rupees.toString();
                                    });
                                  },
                                  child: const Text('Exact Amount'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Quick Denominations
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: quickDenominations.map((denom) {
                              return ActionChip(
                                label: Text('₹$denom'),
                                onPressed: () {
                                  setState(() {
                                    _tenderedInput = denom.toString();
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          // Tendered Display & Change Due
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceLight,
                                    borderRadius: AppSpacing.roundedSm,
                                    border: Border.all(
                                        color: AppColors.borderLight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Tendered',
                                          style: AppTypography.labelSmall),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₹ ${_tenderedInput.isEmpty ? "0" : _tenderedInput}',
                                        style: AppTypography.titleLarge
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _changeDue.isPositive
                                        ? AppColors.success.withOpacity(0.12)
                                        : AppColors.surfaceLight,
                                    borderRadius: AppSpacing.roundedSm,
                                    border: Border.all(
                                      color: _changeDue.isPositive
                                          ? AppColors.success
                                          : AppColors.borderLight,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Change Due',
                                        style: AppTypography.labelSmall.copyWith(
                                          color: _changeDue.isPositive
                                              ? AppColors.success
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CurrencyText(
                                        _changeDue,
                                        style: AppTypography.titleLarge
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: _changeDue.isPositive
                                              ? AppColors.success
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Keypad
                          _buildNumericKeypad(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Complete Cash Sale',
                      icon: Icons.check_circle_rounded,
                      isLoading: _isProcessing,
                      onPressed: _completeCashSale,
                    ),
                  ] else ...[
                    // UPI / Card Path (Prohibition: never fake payment success offline)
                    if (!isOnline) ...[
                      AppCard(
                        backgroundColor: AppColors.errorContainer.withOpacity(0.4),
                        child: Row(
                          children: [
                            const Icon(Icons.cloud_off_rounded,
                                color: AppColors.error, size: 36),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cannot confirm payment without internet',
                                    style: AppTypography.titleSmall.copyWith(
                                      color: AppColors.error,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Take cash or try again when device is back online. Digital payments cannot be completed offline.',
                                    style: AppTypography.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Switch to Cash Payment',
                        onPressed: () {
                          setState(() {
                            _selectedMethod = 'cash';
                          });
                        },
                      ),
                    ] else ...[
                      AppCard(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const Icon(Icons.pending_actions_rounded,
                                size: 54, color: AppColors.primary),
                            const SizedBox(height: 16),
                            Text(
                              'Awaiting ${_selectedMethod.toUpperCase()} confirmation',
                              style: AppTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Customer can scan dynamic QR or tap card on terminal.',
                              textAlign: TextAlign.center,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton.icon(
                              icon: const Icon(Icons.check_rounded),
                              label: const Text('Simulate Webhook Success'),
                              onPressed: () async {
                                final nav = Navigator.of(context);
                                final repo =
                                    ref.read(billingRepositoryProvider);
                                final invoice =
                                    await repo.createAndSettleOrder(
                                  cart: cart,
                                  paymentMethod: _selectedMethod,
                                );
                                nav.pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => ReceiptPreviewScreen(
                                        invoice: invoice),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumericKeypad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['C', '0', '⌫'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppSpacing.roundedSm,
                      ),
                    ),
                    onPressed: () => _onKeypadTap(key),
                    child: Text(
                      key,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  List<int> _generateQuickDenominations(int totalRupees) {
    final candidates = <int>{};
    // Next nearest round amounts
    final round50 = ((totalRupees + 49) ~/ 50) * 50;
    final round100 = ((totalRupees + 99) ~/ 100) * 100;
    final round500 = ((totalRupees + 499) ~/ 500) * 500;

    candidates.add(round50);
    candidates.add(round100);
    candidates.add(round500);
    candidates.add(100);
    candidates.add(200);
    candidates.add(500);

    final sorted = candidates.where((d) => d >= totalRupees).toList()..sort();
    return sorted.take(4).toList();
  }
}
