import 'package:flutter/material.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/values/money.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Gross Sales', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      CurrencyText(Money.fromRupees(42500), fontSize: 20),
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
                      const Text('Net Sales', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      CurrencyText(Money.fromRupees(36017), fontSize: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('GST Collected', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      CurrencyText(Money.fromRupees(6483), fontSize: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Orders', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 6),
                      Text('148', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
