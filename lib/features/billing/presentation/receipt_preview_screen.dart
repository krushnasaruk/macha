import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:cafe_os/core/components/app_button.dart';
import 'package:cafe_os/core/components/app_card.dart';
import 'package:cafe_os/core/components/currency_text.dart';
import 'package:cafe_os/core/identity/identity_provider.dart';
import 'package:cafe_os/core/mascot/mascot_asset_registry.dart';
import 'package:cafe_os/core/mascot/mascot_dialogue_bubble.dart';
import 'package:cafe_os/core/mascot/mascot_widget.dart';
import 'package:cafe_os/core/theme/app_colors.dart';
import 'package:cafe_os/core/theme/app_spacing.dart';
import 'package:cafe_os/core/theme/app_typography.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';
import 'package:cafe_os/features/billing/presentation/controllers/cart_controller.dart';

class ReceiptPreviewScreen extends ConsumerStatefulWidget {
  final Invoice invoice;

  const ReceiptPreviewScreen({
    super.key,
    required this.invoice,
  });

  @override
  ConsumerState<ReceiptPreviewScreen> createState() =>
      _ReceiptPreviewScreenState();
}

class _ReceiptPreviewScreenState extends ConsumerState<ReceiptPreviewScreen> {
  bool _isPrinting = false;
  bool _isPrinted = false;

  void _triggerPrint() async {
    setState(() {
      _isPrinting = true;
    });
    // Simulate non-blocking print operation (ESC/POS in Stage 8)
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() {
        _isPrinting = false;
        _isPrinted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt sent to thermal printer'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final invoice = widget.invoice;
    final dateStr =
        DateFormat('dd MMM yyyy, hh:mm a').format(invoice.issuedAt);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Receipt Preview'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            ref.read(cartControllerProvider.notifier).clearCart();
            context.go('/pos');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: 'Share Receipt',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Receipt copied to clipboard / shared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLg,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  // Success Mascot Header
                  const MascotWidget(
                    action: MascotAction.holdingReceipt,
                    height: 110,
                    dialogue: 'Payment settled! Order sent to kitchen.',
                    dialogueTitle: 'Chef Barnaby',
                    tailPosition: BubbleTailPosition.bottom,
                    bubbleStyle: BubbleStyle.excited,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Payment Successful',
                    style: AppTypography.headlineSmall.copyWith(
                      color: AppColors.textPrimaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CurrencyText(
                    invoice.finalTotal,
                    style: AppTypography.displayMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Receipt Paper Card
                  AppCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Café Branding Header
                        Center(
                          child: Column(
                            children: [
                              Text(
                                identity.tenant.name.toUpperCase(),
                                style: AppTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${identity.branch.name} Branch (${identity.branch.code})',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondaryLight,
                                ),
                              ),
                              Text(
                                'GSTIN: 27AABCT3518Q1ZV',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(thickness: 1, height: 1),
                        const SizedBox(height: 12),

                        // Metadata Rows
                        _metadataRow('Invoice No', invoice.invoiceNumber),
                        _metadataRow('Date & Time', dateStr),
                        _metadataRow('Billed By', invoice.issuedBy),
                        if (invoice.customerName != null)
                          _metadataRow('Customer', invoice.customerName!),
                        const SizedBox(height: 12),
                        const Divider(thickness: 1, height: 1),
                        const SizedBox(height: 12),

                        // Item Table Header
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Item',
                                style: AppTypography.labelMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Qty',
                                textAlign: TextAlign.center,
                                style: AppTypography.labelMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Total',
                                textAlign: TextAlign.right,
                                style: AppTypography.labelMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Item Rows
                        ...invoice.items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: AppTypography.bodySmall.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (item.variantName != null)
                                        Text(
                                          item.variantName!,
                                          style: AppTypography.labelSmall
                                              .copyWith(
                                            color:
                                                AppColors.textSecondaryLight,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${item.quantity}',
                                    textAlign: TextAlign.center,
                                    style: AppTypography.bodySmall,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CurrencyText(
                                    item.lineTotal,
                                    textAlign: TextAlign.right,
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        const Divider(thickness: 1, height: 1),
                        const SizedBox(height: 12),

                        // Financial Summary
                        _summaryRow('Subtotal', invoice.subtotal),
                        if (invoice.discount.isPositive)
                          _summaryRow(
                            'Discount',
                            -invoice.discount,
                            color: AppColors.success,
                          ),
                        _summaryRow('Taxable Value', invoice.taxableAmount),
                        if (invoice.cgst.isPositive)
                          _summaryRow('CGST (2.5%)', invoice.cgst),
                        if (invoice.sgst.isPositive)
                          _summaryRow('SGST (2.5%)', invoice.sgst),
                        if (invoice.igst.isPositive)
                          _summaryRow('IGST', invoice.igst),
                        if (invoice.rounding.paise != 0)
                          _summaryRow('Round-off', invoice.rounding),

                        const SizedBox(height: 8),
                        const Divider(thickness: 1.5, height: 1),
                        const SizedBox(height: 8),

                        // Grand Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TOTAL PAYABLE',
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CurrencyText(
                              invoice.finalTotal,
                              style: AppTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        const Divider(thickness: 1, height: 1),
                        const SizedBox(height: 12),

                        // Payment Tender Details
                        if (invoice.payments.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment Method',
                                style: AppTypography.bodySmall,
                              ),
                              Text(
                                invoice.payments.first.method.toUpperCase(),
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (invoice.payments.first.tendered != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tendered', style: AppTypography.bodySmall),
                                CurrencyText(
                                  invoice.payments.first.tendered!,
                                  style: AppTypography.bodySmall,
                                ),
                              ],
                            ),
                          if (invoice.payments.first.changeDue != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Change Given',
                                    style: AppTypography.bodySmall),
                                CurrencyText(
                                  invoice.payments.first.changeDue!,
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                        ],

                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            'Thank you for your visit!\nPlease come again.',
                            textAlign: TextAlign.center,
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.textSecondaryLight,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isPrinting ? null : _triggerPrint,
                          icon: _isPrinting
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : Icon(
                                  _isPrinted
                                      ? Icons.print_rounded
                                      : Icons.print_outlined,
                                ),
                          label: Text(_isPrinting
                              ? 'Printing…'
                              : (_isPrinted ? 'Printed' : 'Print Receipt')),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppSpacing.roundedSm,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          label: 'New Sale',
                          icon: Icons.add_shopping_cart_rounded,
                          onPressed: () {
                            ref
                                .read(cartControllerProvider.notifier)
                                .clearCart();
                            context.go('/pos');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _metadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, dynamic money, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: color ?? AppColors.textSecondaryLight,
            ),
          ),
          CurrencyText(
            money,
            style: AppTypography.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
