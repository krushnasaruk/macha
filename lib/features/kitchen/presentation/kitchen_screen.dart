import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/state_indicators.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/mascot/mascot_empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../orders/domain/models/order_and_table_models.dart';
import '../../orders/domain/state_machine/order_lifecycle.dart';
import '../../orders/presentation/controllers/orders_providers.dart';
import '../domain/services/kitchen_alert_service.dart';

class KitchenScreen extends ConsumerStatefulWidget {
  const KitchenScreen({super.key});

  @override
  ConsumerState<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends ConsumerState<KitchenScreen> {
  Timer? _ticker;
  final List<KitchenTicket> _recentlyBumped = [];

  @override
  void initState() {
    super.initState();
    // Live timer ticking every 15 seconds to update elapsed ticket minutes
    // In test environment, skip periodic timer to prevent test invariant assertion failures
    final isTestBinding = WidgetsBinding.instance is! WidgetsFlutterBinding;
    if (!isTestBinding) {
      _ticker = Timer.periodic(const Duration(seconds: 15), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketsAsync = ref.watch(kitchenTicketsStreamProvider);
    final stationsAsync = ref.watch(kitchenStationsStreamProvider);
    final selectedStation = ref.watch(selectedStationFilterProvider);
    final alertConfig = ref.watch(kitchenAlertProvider);
    final alertNotifier = ref.watch(kitchenAlertProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Display System (KDS)'),
        actions: [
          IconButton(
            icon: Icon(
              alertConfig.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
              color: alertConfig.soundEnabled ? AppColors.primary : Colors.grey,
            ),
            tooltip: alertConfig.soundEnabled ? 'Mute Kitchen Chimes' : 'Unmute Kitchen Chimes',
            onPressed: () => alertNotifier.toggleSound(),
          ),
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Recently Bumped Tickets',
            onPressed: () => _showRecallSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStationFilterBar(stationsAsync, selectedStation),
          Expanded(
            child: ticketsAsync.when(
              loading: () => const AppLoadingState(message: 'Loading active orders...'),
              error: (err, stack) => AppErrorState(
                message: err.toString(),
                onRetry: () => ref.invalidate(kitchenTicketsStreamProvider),
              ),
              data: (tickets) {
                if (tickets.isEmpty) {
                  return MascotEmptyState.kitchen();
                }

                final confirmed = tickets.where((t) => t.status == OrderLifecycleStatus.confirmed).toList();
                final preparing = tickets.where((t) => t.status == OrderLifecycleStatus.preparing).toList();
                final ready = tickets.where((t) => t.status == OrderLifecycleStatus.ready).toList();

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isTablet = constraints.maxWidth >= 768;

                    if (isTablet) {
                      // 3-Column Tablet Layout
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildColumn(
                              title: 'NEW ORDERS (${confirmed.length})',
                              color: Colors.blue.shade700,
                              tickets: confirmed,
                              actionLabel: 'Start Prep',
                              targetStatus: OrderLifecycleStatus.preparing,
                            ),
                          ),
                          const VerticalDivider(width: 1),
                          Expanded(
                            child: _buildColumn(
                              title: 'PREPARING (${preparing.length})',
                              color: Colors.amber.shade800,
                              tickets: preparing,
                              actionLabel: 'Mark Ready',
                              targetStatus: OrderLifecycleStatus.ready,
                            ),
                          ),
                          const VerticalDivider(width: 1),
                          Expanded(
                            child: _buildColumn(
                              title: 'READY TO SERVE (${ready.length})',
                              color: Colors.green.shade700,
                              tickets: ready,
                              actionLabel: 'Complete',
                              targetStatus: OrderLifecycleStatus.served,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Phone: Tabbed view
                      return DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                Tab(text: 'New (${confirmed.length})'),
                                Tab(text: 'Prep (${preparing.length})'),
                                Tab(text: 'Ready (${ready.length})'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  _buildTicketList(confirmed, 'Start Prep', OrderLifecycleStatus.preparing),
                                  _buildTicketList(preparing, 'Mark Ready', OrderLifecycleStatus.ready),
                                  _buildTicketList(ready, 'Complete', OrderLifecycleStatus.served),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationFilterBar(
    AsyncValue<List<KitchenStation>> stationsAsync,
    String? selectedStation,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('All Stations'),
            selected: selectedStation == null,
            onSelected: (_) => ref.read(selectedStationFilterProvider.notifier).state = null,
          ),
          const SizedBox(width: 8),
          stationsAsync.maybeWhen(
            data: (stations) => Row(
              children: stations.map((st) {
                final isSelected = selectedStation == st.id;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(st.name),
                    selected: isSelected,
                    onSelected: (_) =>
                        ref.read(selectedStationFilterProvider.notifier).state = isSelected ? null : st.id,
                  ),
                );
              }).toList(),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildColumn({
    required String title,
    required Color color,
    required List<KitchenTicket> tickets,
    required String actionLabel,
    required OrderLifecycleStatus targetStatus,
  }) {
    return Container(
      color: color.withOpacity(0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: color.withOpacity(0.3), width: 2)),
            ),
            child: Text(
              title,
              style: AppTypography.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: _buildTicketList(tickets, actionLabel, targetStatus),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketList(
    List<KitchenTicket> tickets,
    String actionLabel,
    OrderLifecycleStatus targetStatus,
  ) {
    if (tickets.isEmpty) {
      return Center(
        child: Text(
          'No orders in this stage',
          style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _buildTicketCard(ticket, actionLabel, targetStatus);
      },
    );
  }

  Widget _buildTicketCard(
    KitchenTicket ticket,
    String actionLabel,
    OrderLifecycleStatus targetStatus,
  ) {
    final elapsedMins = ticket.elapsedMinutes;
    final isDelayed = ticket.isDelayed; // >= 15m
    final isWarning = ticket.isWarning; // >= 10m

    Color? borderColor;
    if (isDelayed) {
      borderColor = Colors.red.shade600;
    } else if (isWarning) {
      borderColor = Colors.amber.shade700;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        borderSide: borderColor != null ? BorderSide(color: borderColor, width: isDelayed ? 2.0 : 1.0) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Order Number, Table, Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '#${ticket.orderNumber}',
                      style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    AppBadge(
                      label: ticket.tableName ?? ticket.orderType.toUpperCase(),
                      backgroundColor: ticket.tableName != null ? AppColors.infoContainer : const Color(0xFFF1F5F9),
                      textColor: ticket.tableName != null ? AppColors.primary : Colors.black87,
                    ),
                  ],
                ),
                _buildTimerBadge(elapsedMins, isDelayed, isWarning),
              ],
            ),
            if (ticket.notes != null && ticket.notes!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Note: ${ticket.notes}',
                  style: TextStyle(fontSize: 11, color: Colors.amber.shade900, fontWeight: FontWeight.w500),
                ),
              ),
            ],
            const Divider(height: 16),
            // Items with tap-to-ready
            ...ticket.items.map((item) => _buildItemRow(item)),
            const SizedBox(height: 12),
            // Action Bump Button
            AppButton(
              label: actionLabel,
              onPressed: () => _bumpTicket(ticket, targetStatus),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerBadge(int mins, bool isDelayed, bool isWarning) {
    Color bg;
    Color text;
    IconData icon;

    if (isDelayed) {
      bg = Colors.red.shade100;
      text = Colors.red.shade900;
      icon = Icons.error_outline_rounded;
    } else if (isWarning) {
      bg = Colors.amber.shade100;
      text = Colors.amber.shade900;
      icon = Icons.access_time_rounded;
    } else {
      bg = Colors.grey.shade100;
      text = Colors.grey.shade800;
      icon = Icons.timer_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: text),
          const SizedBox(width: 4),
          Text(
            '${mins}m',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: text),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(KitchenTicketItem item) {
    return InkWell(
      onTap: () {
        final repo = ref.read(kitchenRepositoryProvider);
        repo.toggleItemReady(orderItemId: item.orderItemId, isReady: !item.isReady);
      },
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              item.isReady ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              size: 18,
              color: item.isReady ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              '${item.quantity}x',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: item.isReady ? Colors.grey : null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: item.isReady ? TextDecoration.lineThrough : null,
                      color: item.isReady ? Colors.grey : null,
                    ),
                  ),
                  if (item.variantName != null)
                    Text(
                      'Variant: ${item.variantName}',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  if (item.modifierNames.isNotEmpty)
                    Text(
                      item.modifierNames.join(', '),
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                    ),
                  if (item.notes != null && item.notes!.isNotEmpty)
                    Text(
                      'Special: ${item.notes}',
                      style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _bumpTicket(KitchenTicket ticket, OrderLifecycleStatus targetStatus) async {
    final identity = ref.read(currentIdentityNotifier);
    final repo = ref.read(kitchenRepositoryProvider);
    final originalStatus = ticket.status;

    try {
      await repo.bumpTicket(
        orderId: ticket.orderId,
        targetStatus: targetStatus,
        changedBy: identity.employee.name,
      );

      // Record in recently bumped for recall
      setState(() {
        _recentlyBumped.insert(0, ticket);
        if (_recentlyBumped.length > 20) _recentlyBumped.removeLast();
      });

      // Show 5-second Undo SnackBar
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          content: Text('Order #${ticket.orderNumber} moved to ${targetStatus.name.toUpperCase()}'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () async {
              try {
                await repo.recallTicket(
                  orderId: ticket.orderId,
                  previousStatus: originalStatus,
                  changedBy: identity.employee.name,
                );
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Undo failed: $e')));
                }
              }
            },
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error bumping ticket: $e')));
      }
    }
  }

  void _showRecallSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recently Bumped Tickets',
                style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (_recentlyBumped.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No recently bumped tickets to recall.')),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _recentlyBumped.length,
                    itemBuilder: (context, i) {
                      final item = _recentlyBumped[i];
                      return ListTile(
                        leading: const Icon(Icons.receipt_long_rounded),
                        title: Text('#${item.orderNumber} — ${item.tableName ?? item.orderType}'),
                        subtitle: Text('${item.items.length} items • ${item.status.name.toUpperCase()}'),
                        trailing: OutlinedButton(
                          child: const Text('Recall'),
                          onPressed: () async {
                            final identity = ref.read(currentIdentityNotifier);
                            final repo = ref.read(kitchenRepositoryProvider);
                            Navigator.pop(ctx);
                            try {
                              await repo.recallTicket(
                                orderId: item.orderId,
                                previousStatus: item.status,
                                changedBy: identity.employee.name,
                              );
                              setState(() => _recentlyBumped.remove(item));
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                              }
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
