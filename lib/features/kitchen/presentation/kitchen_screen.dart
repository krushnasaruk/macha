import 'package:flutter/material.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_card.dart';
import '../../../core/theme/app_spacing.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Display System (KDS)'),
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          _ticketItem(
            orderNumber: '#1042',
            table: 'Table 3',
            timeAgo: '4m ago',
            status: 'preparing',
            items: ['1x Flat White (Oat Milk)', '2x Butter Croissant'],
          ),
          const SizedBox(height: 12),
          _ticketItem(
            orderNumber: '#1043',
            table: 'Takeaway',
            timeAgo: '1m ago',
            status: 'confirmed',
            items: ['2x Iced Americano', '1x Blueberry Muffin'],
          ),
        ],
      ),
    );
  }

  Widget _ticketItem({
    required String orderNumber,
    required String table,
    required String timeAgo,
    required String status,
    required List<String> items,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$orderNumber • $table',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  Text(timeAgo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(width: 8),
                  AppBadge.status(status),
                ],
              ),
            ],
          ),
          const Divider(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(item, style: const TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
