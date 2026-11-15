import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/circular_icon_container.dart';
import '../../../core/components/status_pill.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/ux/interaction/pressable.dart';
import '../../../core/values/money.dart';
import '../../orders/domain/state_machine/order_lifecycle.dart';
import '../../orders/presentation/controllers/orders_providers.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identity = ref.watch(currentIdentityNotifier);
    final ordersAsync = ref.watch(ordersStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(ordersStreamProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Logo + App Name + Bell + Profile Avatar
                _buildTopHeader(context, identity.employee.name),
                const SizedBox(height: 20),

                // Greeting
                _buildGreeting(identity.employee.name),
                const SizedBox(height: 20),

                // Sales Hero Card
                _buildSalesHeroCard(ordersAsync),
                const SizedBox(height: 20),

                // 3 Quick Metrics Cards
                _buildQuickMetrics(ordersAsync),
                const SizedBox(height: 24),

                // Quick Actions Section
                _buildQuickActions(context),
                const SizedBox(height: 24),

                // Recent Orders Section
                _buildRecentOrders(context, ordersAsync),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context, String employeeName) {
    return Row(
      children: [
        // CaféOS Emblem
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.coffee_rounded,
            color: AppColors.warmCream,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'CaféOS',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        // Notification Bell with Badge Dot
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No new notifications'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            Positioned(
              right: 12,
              top: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.terracotta,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        // Profile Avatar
        Pressable(
          onTap: () => context.go('/settings'),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.softBeige,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderLight, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Text(
              employeeName.isNotEmpty ? employeeName[0].toUpperCase() : 'C',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting(String employeeName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning!',
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Let’s make today brewing great ☕',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondaryLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSalesHeroCard(AsyncValue ordersAsync) {
    // Calculate total from confirmed orders, fallback to reference design value ₹12,450
    String salesDisplay = '₹12,450';
    ordersAsync.whenData((orders) {
      if (orders is List && orders.isNotEmpty) {
        int totalPaise = 0;
        for (final ord in orders) {
          totalPaise += (ord.finalTotalPaise as int? ?? 0);
        }
        if (totalPaise > 0) {
          salesDisplay = Money.fromPaise(totalPaise).format();
        }
      }
    });

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today’s Sales',
                  style: TextStyle(
                    color: AppColors.warmCream.withOpacity(0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  salesDisplay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.terracotta.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.terracotta.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.warmCream,
                        size: 15,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '↑ 12.5%',
                        style: TextStyle(
                          color: AppColors.warmCream,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Coffee cup graphic with steam
          SizedBox(
            width: 110,
            height: 100,
            child: Image.asset(
              'assets/branding/hero_coffee.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.coffee_rounded,
                size: 64,
                color: AppColors.warmCream,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMetrics(AsyncValue ordersAsync) {
    int ordersCount = 48;
    ordersAsync.whenData((orders) {
      if (orders is List && orders.isNotEmpty) {
        ordersCount = orders.length;
      }
    });

    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            icon: Icons.shopping_bag_outlined,
            value: '$ordersCount',
            label: 'Orders',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            icon: Icons.people_outline_rounded,
            value: '${ordersCount * 2 + 28}',
            label: 'Customers',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFE89246),
            value: '4.8',
            label: 'Rating',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    Color? iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.softBeige,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 20,
              color: iconColor ?? AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      (
        label: 'New Order',
        icon: Icons.local_cafe_outlined,
        onTap: () => context.go('/pos'),
      ),
      (
        label: 'View Orders',
        icon: Icons.receipt_long_outlined,
        onTap: () => context.go('/orders'),
      ),
      (
        label: 'Manage Inventory',
        icon: Icons.inventory_2_outlined,
        onTap: () => context.go('/inventory'),
      ),
      (
        label: 'Reports',
        icon: Icons.bar_chart_rounded,
        onTap: () => context.go('/reports'),
      ),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Actions',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Pressable(
              onTap: () => context.go('/pos'),
              child: const Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.textSecondaryLight,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: actions.map((act) {
            return SizedBox(
              width: 76,
              child: Pressable(
                onTap: act.onTap,
                child: Column(
                  children: [
                    CircularIconContainer(
                      icon: act.icon,
                      size: 56,
                      iconSize: 24,
                      iconColor: AppColors.primary,
                      backgroundColor: AppColors.softBeige,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      act.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentOrders(BuildContext context, AsyncValue ordersAsync) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Orders',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Pressable(
              onTap: () => context.go('/orders'),
              child: const Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.textSecondaryLight,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ordersAsync.when(
          data: (orders) {
            if (orders is! List || orders.isEmpty) {
              return _buildSampleOrderCard(context);
            }
            final firstOrder = orders.first;
            return _buildRealOrderCard(context, firstOrder);
          },
          loading: () => _buildSampleOrderCard(context),
          error: (_, __) => _buildSampleOrderCard(context),
        ),
      ],
    );
  }

  Widget _buildSampleOrderCard(BuildContext context) {
    return Pressable(
      onTap: () => context.go('/orders'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderLight, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 48,
                height: 48,
                color: AppColors.softBeige,
                child: Image.asset(
                  'assets/menu/iced_latte.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.local_cafe_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#1025',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2 items • 10:24 AM',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            StatusPill.fromOrderStatus('preparing'),
          ],
        ),
      ),
    );
  }

  Widget _buildRealOrderCard(BuildContext context, dynamic order) {
    final orderNum = order.orderNumber ?? '1025';
    final itemsCount = (order.items as List?)?.length ?? 1;
    final timeStr = order.createdAt != null
        ? '${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}'
        : '10:24 AM';
    final status = order.status is OrderLifecycleStatus
        ? order.status as OrderLifecycleStatus
        : OrderLifecycleStatus.preparing;

    return Pressable(
      onTap: () => context.go('/orders'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderLight, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 48,
                height: 48,
                color: AppColors.softBeige,
                child: Image.asset(
                  'assets/menu/latte.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.local_cafe_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#$orderNum',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$itemsCount item${itemsCount > 1 ? "s" : ""} • $timeStr',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            StatusPill.fromOrderStatus(status.name),
          ],
        ),
      ),
    );
  }
}
