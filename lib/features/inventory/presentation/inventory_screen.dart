import 'package:flutter/material.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/theme/app_spacing.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stock = [
      ('Arabica Coffee Beans', '14.5 kg', '10 kg reorder', true),
      ('Full Cream Milk', '28 L', '15 L reorder', true),
      ('Oat Milk Barista', '3 L', '8 L reorder', false), // Low stock
      ('Paper Cups 250ml', '450 pcs', '200 pcs reorder', true),
      ('Brown Sugar Sachets', '800 pcs', '300 pcs reorder', true),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory & Stocks'),
      ),
      body: ListView.separated(
        padding: AppSpacing.paddingLg,
        itemCount: stock.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = stock[index];
          return ListTile(
            leading: Icon(
              item.$4 ? Icons.inventory_2_outlined : Icons.warning_amber_rounded,
              color: item.$4 ? Colors.brown : Colors.amber.shade800,
            ),
            title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Threshold: ${item.$3}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.$2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 12),
                AppBadge(
                  label: item.$4 ? 'IN STOCK' : 'LOW STOCK',
                  backgroundColor: item.$4 ? Colors.green.shade50 : Colors.amber.shade50,
                  textColor: item.$4 ? Colors.green.shade800 : Colors.amber.shade900,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
