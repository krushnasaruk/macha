import 'package:flutter/material.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/values/money.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Espresso Solo', Money.fromRupees(120), 'Hot Beverages', true),
      ('Cappuccino', Money.fromRupees(180), 'Hot Beverages', true),
      ('Iced Latte', Money.fromRupees(220), 'Cold Beverages', true),
      ('Almond Croissant', Money.fromRupees(195), 'Bakery', true),
      ('Cold Brew Tonic', Money.fromRupees(240), 'Cold Beverages', false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Catalog'),
      ),
      body: ListView.separated(
        padding: AppSpacing.paddingLg,
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.coffee),
            ),
            title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(item.$3),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CurrencyText(item.$2, fontSize: 15),
                const SizedBox(width: 12),
                AppBadge(
                  label: item.$4 ? 'AVAILABLE' : 'SOLDOUT',
                  backgroundColor: item.$4 ? Colors.green.shade50 : Colors.red.shade50,
                  textColor: item.$4 ? Colors.green.shade800 : Colors.red.shade800,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
