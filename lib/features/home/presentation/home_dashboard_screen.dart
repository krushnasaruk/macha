import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/status_pill.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/ux/interaction/pressable.dart';
import '../../../core/values/money.dart';
import '../../orders/domain/state_machine/order_lifecycle.dart';
import '../../orders/presentation/controllers/orders_providers.dart';
import '../domain/daily_food_special.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeDashboardContent();
  }
}

class _HomeDashboardContent extends ConsumerStatefulWidget {
  const _HomeDashboardContent();

  @override
  ConsumerState<_HomeDashboardContent> createState() => _HomeDashboardContentState();
}

class _HomeDashboardContentState extends ConsumerState<_HomeDashboardContent> {
  int? _previewWeekday;

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final ordersAsync = ref.watch(ordersStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // Subtle warm ambient latte-art blobs at top (matching reference design background)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF6EADB).withOpacity(0.55),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: -80,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFAF1E8).withOpacity(0.65),
              ),
            ),
          ),

          SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(ordersStreamProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Header: Logo + App Name + Bell + Profile Avatar
                    _buildTopHeader(context, identity.employee.name),
                    const SizedBox(height: 18),

                    // Greeting
                    _buildGreeting(identity.employee.name),
                    const SizedBox(height: 18),

                    // Sales Hero Card
                    _buildSalesHeroCard(ordersAsync),
                    const SizedBox(height: 18),

                    // 3 Quick Metrics Cards
                    _buildQuickMetrics(ordersAsync),
                    const SizedBox(height: 22),

                    // Quick Actions Section
                    _buildQuickActions(context),
                    const SizedBox(height: 22),

                    // Recent Orders Section
                    _buildRecentOrders(context, ordersAsync),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context, String employeeName) {
    return Row(
      children: [
        // MΛCHA Emblem
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/branding/macha/macha_app_icon_forest.png',
            width: 38,
            height: 38,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Λ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'MΛCHA',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 1.2,
            color: AppColors.primary,
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
                    content: Text('All orders and hardware online'),
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
            fontSize: 26,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Let’s make today brewing great ☕',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondaryLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSalesHeroCard(AsyncValue ordersAsync) {
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

    final currentWeekday = DateTime.now().weekday;
    final activeWeekday = _previewWeekday ?? currentWeekday;
    final special = DailyFoodSpecial.forWeekday(activeWeekday);

    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Dark Espresso Base Card Container
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF382B24),
                  Color(0xFF251C17),
                ],
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF251C17).withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Warm Tabletop Curve on the right behind food
                Positioned(
                  right: -25,
                  bottom: -25,
                  child: Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4C3A30).withOpacity(0.65),
                    ),
                  ),
                ),

                // Metrics & Daily Special Label on the left
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 155),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header Row: Today's Sales + Interactive Weekday Tag
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Today’s Sales',
                            style: TextStyle(
                              color: const Color(0xFFD5C4B4).withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Weekday Tag Pill (tap to preview other days)
                          GestureDetector(
                            onTap: () => _showWeeklySpecialsSheet(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE89246).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFE89246).withOpacity(0.35),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    special.dayName,
                                    style: const TextStyle(
                                      color: Color(0xFFFFD199),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 12,
                                    color: Color(0xFFFFD199),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        salesDisplay,
                        style: const TextStyle(
                          color: Color(0xFFFFFDF9),
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Growth Chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE89246).withOpacity(0.22),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFE89246).withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up_rounded,
                              color: Color(0xFFFFD199),
                              size: 13,
                            ),
                            SizedBox(width: 3),
                            Text(
                              '↑ 12.5%',
                              style: TextStyle(
                                color: Color(0xFFFFD199),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Daily Dish Name
                      Text(
                        special.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFFD5C4B4).withOpacity(0.85),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Overlapping Food Image ("a little over the dive")
          Positioned(
            right: -2,
            top: -24, // Floats 24px ABOVE the card boundary!
            bottom: -8, // Anchors the dish drop-shadow to the tabletop
            width: 175,
            child: GestureDetector(
              onTap: () => _showWeeklySpecialsSheet(context),
              child: Image.asset(
                special.assetPath,
                fit: BoxFit.contain,
                alignment: Alignment.centerRight,
                filterQuality: FilterQuality.high,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.restaurant_rounded,
                  size: 64,
                  color: AppColors.warmCream,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeeklySpecialsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final currentWeekday = DateTime.now().weekday;
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFF9F2),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '7-Day Chef’s Showcase',
                          style: AppTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Hero dish rotates dynamically every day of the week',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.55,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: DailyFoodSpecial.allSpecials.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (ctx, i) {
                    final item = DailyFoodSpecial.allSpecials[i];
                    final isToday = item.weekday == currentWeekday;
                    final isSelected = (_previewWeekday ?? currentWeekday) == item.weekday;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _previewWeekday = item.weekday;
                        });
                        Navigator.pop(ctx);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.borderLight,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 50,
                                height: 50,
                                color: const Color(0xFF382B24),
                                child: Image.asset(
                                  item.assetPath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item.dayName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.textPrimaryLight,
                                        ),
                                      ),
                                      if (isToday) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE89246),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            'TODAY',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimaryLight.withOpacity(0.85),
                                    ),
                                  ),
                                  Text(
                                    item.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_previewWeekday != null) ...[
                const SizedBox(height: 12),
                Center(
                  child: TextButton.icon(
                    icon: const Icon(Icons.restore_rounded, size: 16),
                    label: const Text('Reset to Today’s Special'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _previewWeekday = null;
                      });
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
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
            iconColor: const Color(0xFF8C6747),
            value: '$ordersCount',
            label: 'Orders',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            icon: Icons.people_alt_outlined,
            iconColor: const Color(0xFF567482),
            value: '${ordersCount * 2 + 28}',
            label: 'Customers',
          ),
        ),
        const SizedBox(width: 10),
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
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5EE),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDE3D7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFF1E6D8),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 19,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      (
        label: 'New\nOrder',
        icon: Icons.local_cafe_outlined,
        onTap: () => context.go('/pos'),
      ),
      (
        label: 'View\nOrders',
        icon: Icons.receipt_long_outlined,
        onTap: () => context.go('/orders'),
      ),
      (
        label: 'Manage\nInventory',
        icon: Icons.inventory_2_outlined,
        onTap: () => context.go('/inventory'),
      ),
      (
        label: 'Reports\nAnalytics',
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
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontSize: 16,
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
        const SizedBox(height: 12),
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
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFE3D5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE2D4C4),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        act.icon,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      act.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
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
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontSize: 16,
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEDE2D6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 48,
                height: 48,
                color: const Color(0xFFF8F2EA),
                child: Image.asset(
                  'assets/menu/iced_latte.png',
                  fit: BoxFit.contain,
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
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2 items • 10:24 AM',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEDE2D6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 48,
                height: 48,
                color: const Color(0xFFF8F2EA),
                child: Image.asset(
                  'assets/menu/latte.png',
                  fit: BoxFit.contain,
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
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$itemsCount item${itemsCount > 1 ? "s" : ""} • $timeStr',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                      fontWeight: FontWeight.w500,
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
