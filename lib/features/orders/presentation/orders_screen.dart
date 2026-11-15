import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/components/state_indicators.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/values/money.dart';
import '../domain/models/order_and_table_models.dart';
import '../domain/state_machine/order_lifecycle.dart';
import 'controllers/orders_providers.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersStreamProvider);
    final filter = ref.watch(ordersFilterProvider);
    final filterNotifier = ref.watch(ordersFilterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                AppTextField(
                  hint: 'Search by order #, customer, or phone...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  onChanged: (val) => filterNotifier.setSearchQuery(val),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All Statuses'),
                        selected: filter.statusFilter == null,
                        onSelected: (_) => filterNotifier.setStatusFilter(null),
                      ),
                      const SizedBox(width: 8),
                      ...OrderLifecycleStatus.values.map((status) {
                        final isSelected = filter.statusFilter == status;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(status.name.toUpperCase()),
                            selected: isSelected,
                            onSelected: (_) => filterNotifier.setStatusFilter(isSelected ? null : status),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Orders List
          Expanded(
            child: ordersAsync.when(
              loading: () => const AppLoadingState(message: 'Loading orders...'),
              error: (err, stack) => AppErrorState(
                message: err.toString(),
                onRetry: () => ref.invalidate(ordersStreamProvider),
              ),
              data: (orders) {
                if (orders.isEmpty) {
                  return const AppEmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: 'No Orders Found',
                    description: 'No orders match the current filter or search criteria.',
                  );
                }

                return ListView.builder(
                  padding: AppSpacing.paddingLg,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _OrderCard(
                      order: order,
                      onTap: () => _showOrderDetailDialog(context, ref, order),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetailDialog(BuildContext context, WidgetRef ref, OrderSummary order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Order #${order.orderNumber}'),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Summary Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statusBadge(order.status),
                    Text(
                      '${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Type: ${order.orderType.toUpperCase()} • Table: ${order.tableName ?? "Takeaway"}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (order.customerName != null)
                  Text('Customer: ${order.customerName} (${order.customerPhone ?? ""})'),
                const Divider(height: 24),
                // Items
                Text('Order Items (${order.items.length})', style: AppTypography.titleSmall),
                const SizedBox(height: 8),
                ...order.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.quantity}x ', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w500)),
                              if (item.variantName != null)
                                Text('Variant: ${item.variantName}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              if (item.modifierNames.isNotEmpty)
                                Text(item.modifierNames.join(', '), style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                        CurrencyText(Money.fromPaise(item.lineTotalPaise)),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 24),
                // Pricing Breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount:'),
                    CurrencyText(
                      Money.fromPaise(order.finalTotalPaise),
                      style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(height: 24),
                // Order Timeline
                Text('Order Timeline', style: AppTypography.titleSmall),
                const SizedBox(height: 8),
                if (order.history.isEmpty)
                  const Text('No status transitions recorded yet.', style: TextStyle(fontSize: 12, color: Colors.grey))
                else
                  ...order.history.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.circle, size: 8, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${entry.fromStatus.name.toUpperCase()} ➔ ${entry.toStatus.name.toUpperCase()}',
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                                Text(
                                  'By ${entry.changedBy}${entry.notes != null ? " • ${entry.notes}" : ""}',
                                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${entry.createdAt.hour.toString().padLeft(2, '0')}:${entry.createdAt.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          if (OrderLifecycleStateMachine.canCancel(order.status))
            TextButton(
              child: const Text('Cancel Order', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(ctx);
                _showCancelOrderDialog(context, ref, order);
              },
            ),
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  void _showCancelOrderDialog(BuildContext context, WidgetRef ref, OrderSummary order) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Cancel Order #${order.orderNumber}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please provide a reason for cancelling this order:'),
            const SizedBox(height: 12),
            AppTextField(
              controller: reasonController,
              label: 'Cancellation Reason',
              hint: 'e.g. Customer changed mind, kitchen unavailable',
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Back')),
          AppButton(
            label: 'Confirm Cancellation',
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) return;

              final identity = ref.read(currentIdentityNotifier);
              final repo = ref.read(ordersRepositoryProvider);

              try {
                await repo.cancelOrder(
                  orderId: order.id,
                  reason: reason,
                  cancelledBy: identity.employee.name,
                );
                if (ctx.mounted) Navigator.pop(ctx);
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(OrderLifecycleStatus status) {
    return AppBadge.status(status.name);
  }
}

class _OrderCard extends StatelessWidget {
  final OrderSummary order;
  final VoidCallback onTap;

  const _OrderCard({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${order.orderNumber}',
                  style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                _badgeForStatus(order.status),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  order.tableName != null ? Icons.table_restaurant_rounded : Icons.takeout_dining_rounded,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  order.tableName ?? 'Takeaway',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  '${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.items.length} item${order.items.length == 1 ? "" : "s"}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                CurrencyText(
                  Money.fromPaise(order.finalTotalPaise),
                  style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badgeForStatus(OrderLifecycleStatus status) {
    return AppBadge.status(status.name);
  }
}
