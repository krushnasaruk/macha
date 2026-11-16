import 'package:flutter/material.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/values/money.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          // 4 Main KPI Cards
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Gross Sales', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13, fontWeight: FontWeight.w600)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('↑ 14%', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const CurrencyText(Money.fromRupees(42500), fontSize: 22),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Net Sales', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13, fontWeight: FontWeight.w600)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('↑ 12%', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const CurrencyText(Money.fromRupees(36017), fontSize: 22),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GST Collected', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13, fontWeight: FontWeight.w600)),
                      SizedBox(height: 8),
                      CurrencyText(Money.fromRupees(6483), fontSize: 22),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Orders', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13, fontWeight: FontWeight.w600)),
                      SizedBox(height: 8),
                      Text('148', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Payment Methods Breakdown
          const Text(
            'Payment Methods Split',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              children: [
                _buildPaymentRow('UPI / QR Code', '₹ 22,100', '52%', const Color(0xFF4A8060)),
                const Divider(height: 16),
                _buildPaymentRow('Cash Tender', '₹ 14,800', '35%', const Color(0xFFFFA767)),
                const Divider(height: 16),
                _buildPaymentRow('Credit / Debit Card', '₹ 5,600', '13%', AppColors.softLavender),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Top Bestsellers
          const Text(
            'Today’s Bestselling Items',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              children: [
                _buildBestsellerRow('Artisan Cappuccino', '46 cups', '₹ 8,280'),
                const Divider(height: 16),
                _buildBestsellerRow('Nitro Cold Brew', '32 glasses', '₹ 7,040'),
                const Divider(height: 16),
                _buildBestsellerRow('Almond Butter Croissant', '28 pastries', '₹ 5,460'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String method, String amount, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            method,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            percentage,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildBestsellerRow(String name, String volume, String revenue) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFFA767)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary),
          ),
        ),
        Text(
          volume,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
        ),
        const SizedBox(width: 12),
        Text(
          revenue,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.primary),
        ),
      ],
    );
  }
}
