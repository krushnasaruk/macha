import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/values/money.dart';

class PosScreen extends ConsumerWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identity = ref.watch(currentIdentityNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Point of Sale (POS)'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AppBadge(
              label: '${identity.branch.code} • ${identity.device.deviceSeries}',
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: AppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.point_of_sale_rounded, size: 56, color: Colors.brown),
                  const SizedBox(height: 16),
                  Text(
                    'Café POS Ready',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Active Terminal: ${identity.device.name} (${identity.device.deviceSeries})',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Cashier: ${identity.employee.name} (${identity.role.title})',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statItem('Current Drawer', Money.fromRupees(5000)),
                      _statItem('Today Sales', Money.fromRupees(18450)),
                      _statItem('Active Orders', null, count: '3'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statItem(String label, Money? amount, {String? count}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        if (amount != null)
          CurrencyText(amount, fontSize: 18)
        else
          Text(count ?? '0', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
