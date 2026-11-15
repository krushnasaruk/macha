import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/components/pill_filter_chip.dart';
import '../../../core/components/state_indicators.dart';
import '../../../core/components/status_pill.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/mascot/mascot_empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/ux/interaction/pressable.dart';
import '../../../core/values/money.dart';
import '../domain/models/order_and_table_models.dart';
import '../domain/state_machine/order_lifecycle.dart';
import 'controllers/orders_providers.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  bool _showSearchBar = false;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(ordersStreamProvider);
    final filter = ref.watch(ordersFilterProvider);
    final filterNotifier = ref.watch(ordersFilterProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        title: Text(
          'Orders',
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showSearchBar ? Icons.close_rounded : Icons.search_rounded,
              color: AppColors.primary,
            ),
            tooltip: 'Search Orders',
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                if (!_showSearchBar) {
                  _searchCtrl.clear();
                  filterNotifier.setSearchQuery('');
                }
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Collapsible or explicit search bar
          if (_showSearchBar)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: AppTextField(
                controller: _searchCtrl,
                hint: 'Search by order #, customer, or phone...',
                prefixIcon: const Icon(Icons.search_rounded),
                onChanged: (val) => filterNotifier.setSearchQuery(val),
              ),
            ),

          // Status Filter Pills matching reference design
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                PillFilterChip(
                  label: 'All Statuses',
                  isSelected: filter.statusFilter == null,
                  onTap: () => filterNotifier.setStatusFilter(null),
                ),
                const SizedBox(width: 8),
                ...OrderLifecycleStatus.values.map((status) {
                  final isSelected = filter.statusFilter == status;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: PillFilterChip(
                      label: status.label,
                      isSelected: isSelected,
                      onTap: () => filterNotifier.setStatusFilter(
                        isSelected ? null : status,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),

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
                  return MascotEmptyState.orders(
                    onNewOrder: () => context.go('/pos'),
                  );
                }

                final queueCount = orders
                    .where((o) =>
                        o.status == OrderLifecycleStatus.created ||
                        o.status == OrderLifecycleStatus.confirmed ||
                        o.status == OrderLifecycleStatus.preparing)
                    .length;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: orders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return _OrderCard(
                            order: order,
                            onTap: () => _showOrderDetailDialog(context, ref, order),
                          );
                        },
                      ),
                    ),
                    // Bottom Queue Banner (matching reference design)
                    if (queueCount > 0)
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.warmCream,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight, width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: AppColors.softBeige,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.coffee_rounded,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '$queueCount orders in queue',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                  ],
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Order #${order.orderNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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

  String _thumbnailForOrder() {
    final name = order.items.isNotEmpty ? order.items.first.productName.toLowerCase() : '';
    if (name.contains('cold') || name.contains('nitro')) return 'assets/menu/cold_coffee.png';
    if (name.contains('mocha')) return 'assets/menu/mocha.png';
    if (name.contains('americano')) return 'assets/menu/americano.png';
    if (name.contains('latte')) return 'assets/menu/latte.png';
    return 'assets/menu/cappuccino.png';
  }

  @override
  Widget build(BuildContext context) {
    final timeStr =
        '${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}';
    final itemsText = '${order.items.length} item${order.items.length == 1 ? "" : "s"}';

    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderLight, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Drink thumbnail squircle
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 52,
                height: 52,
                color: AppColors.creamContainer,
                child: Image.asset(
                  _thumbnailForOrder(),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.local_cafe_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Middle Column: Order #, items & time, and Dine-in/Takeaway tag
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${order.orderNumber}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$itemsText • $timeStr',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.creamContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight, width: 0.8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          order.tableName != null
                              ? Icons.table_restaurant_rounded
                              : Icons.takeout_dining_rounded,
                          size: 13,
                          color: AppColors.textSecondaryLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order.tableName != null ? 'Table ${order.tableName}' : 'Takeaway',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right Column: Status pill badge & bold formatted price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusPill.fromOrderStatus(order.status.name),
                const SizedBox(height: 14),
                CurrencyText(
                  Money.fromPaise(order.finalTotalPaise),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
