import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/status_pill.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/mascot/mascot_asset_registry.dart';
import '../../../core/mascot/mascot_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/ux/interaction/pressable.dart';
import '../../../core/values/money.dart';
import '../../billing/presentation/cash_drawer_sheet.dart';
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
    final tablesAsync = ref.watch(tablesStreamProvider);
    final kitchenTicketsAsync = ref.watch(kitchenTicketsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // 1. Organic Ambient Background Droplet Blobs (Matching Behance organic liquid language)
          Positioned(
            top: -70,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lilacMist.withOpacity(0.28),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -90,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.matchaGreen.withOpacity(0.18),
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF3E7D7).withOpacity(0.4),
              ),
            ),
          ),

          SafeArea(
            child: RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: Colors.white,
              onRefresh: () async {
                ref.invalidate(ordersStreamProvider);
                ref.invalidate(tablesStreamProvider);
                ref.invalidate(kitchenTicketsStreamProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Fluid Header: Logo + MΛCHA Wordmark + Live Status + Profile
                    _buildTopHeader(context, identity.employee.name),
                    const SizedBox(height: 14),

                    // Greeting + Mascot Waving
                    _buildGreeting(identity.employee.name),
                    const SizedBox(height: 14),

                    // Crew Presence / Shift Selector (Behance circular avatar strip)
                    _buildShiftPresenceRow(context),
                    const SizedBox(height: 16),

                    // Upgraded MΛCHA Sales Hero Card (Deep Forest Matcha with daily food float)
                    _buildSalesHeroCard(ordersAsync),
                    const SizedBox(height: 16),

                    // 3 Live Performance KPI Micro-Widgets
                    _buildQuickMetrics(ordersAsync),
                    const SizedBox(height: 20),

                    // 6 High-Utility Feature Shortcuts Grid (Award-Winning Micro-Widgets)
                    _buildFeatureShortcutsSection(
                      context,
                      tablesAsync: tablesAsync,
                      kitchenTicketsAsync: kitchenTicketsAsync,
                    ),
                    const SizedBox(height: 20),

                    // Hourly Rush-Hour Velocity Chart ("Динамика" from Behance Reference)
                    _buildRushHourVelocityCard(),
                    const SizedBox(height: 20),

                    // Operational Alert Chevrons (Inspired by Behance "Не забудь о встречах! <")
                    _buildOperationalAlerts(context),
                    const SizedBox(height: 20),

                    // Live Recent Orders Pipeline
                    _buildRecentOrders(context, ordersAsync),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Header: Custom Stylized Wordmark + Capsule + Actions
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader(BuildContext context, String employeeName) {
    return Row(
      children: [
        // MΛCHA Emblem with squircle border
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/branding/macha/macha_app_icon_forest.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Text(
                'Λ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MΛCHA',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 1.4,
                color: AppColors.primary,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A8060),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Roastery Active • Morning Shift',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        // Notification Bell with Orange Dot
        Pressable(
          onTap: () {
            HapticFeedback.selectionClick();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('All systems online: POS, Kitchen KDS, Cash Drawer'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderLight, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.primary,
                  size: 21,
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFA767),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Profile Avatar Button
        Pressable(
          onTap: () {
            HapticFeedback.selectionClick();
            context.go('/settings');
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.softLavender,
                  AppColors.lilacMist,
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softLavender.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              employeeName.isNotEmpty ? employeeName[0].toUpperCase() : 'C',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Greeting + Mascot Animation
  // ---------------------------------------------------------------------------
  Widget _buildGreeting(String employeeName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning!',
                style: AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  fontSize: 25,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Let’s make today brewing great ☕',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const MascotWidget(
          pose: MascotPose.waving,
          height: 56,
          animate: true,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Crew Presence & Shift Bar (Behance Circular Avatar Row)
  // ---------------------------------------------------------------------------
  Widget _buildShiftPresenceRow(BuildContext context) {
    final crew = [
      (name: 'Barnaby', role: 'Head Chef', pose: MascotPose.standing, isMascot: true),
      (name: 'Maya', role: 'Cashier', pose: null, isMascot: false),
      (name: 'Ken', role: 'Barista', pose: null, isMascot: false),
      (name: 'Leo', role: 'Floor', pose: null, isMascot: false),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.8), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Crew',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '4 Online',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: crew.map((member) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Tooltip(
                      message: '${member.name} • ${member.role}',
                      child: Pressable(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${member.name} (${member.role}) active on shift'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: member.isMascot
                                        ? AppColors.primaryContainer
                                        : AppColors.lavenderContainer,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: member.isMascot
                                          ? AppColors.primary
                                          : AppColors.softLavender,
                                      width: 1.2,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  alignment: Alignment.center,
                                  child: member.isMascot
                                      ? Image.asset(
                                          'assets/mascot/poses/standing.png',
                                          fit: BoxFit.contain,
                                          width: 28,
                                          height: 28,
                                          errorBuilder: (_, __, ___) => const Icon(
                                            Icons.pets_rounded,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : Text(
                                          member.name[0],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4A8060),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 1.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              member.name,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Pressable(
            onTap: () {
              HapticFeedback.selectionClick();
              context.go('/settings/staff');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5EE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderLight, width: 0.8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tune_rounded, size: 12, color: AppColors.primary),
                  SizedBox(width: 2),
                  Text(
                    'Shift',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sales Hero Card: Deep Forest Matcha × Cream (Overlapping Dish)
  // ---------------------------------------------------------------------------
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
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Deep Forest Matcha Gradient Container
          Container(
            width: double.infinity,
            height: 165,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E2D25),
                  Color(0xFF293D32),
                ],
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E2D25).withOpacity(0.35),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Organic ambient matcha radial highlight
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.matchaGreen.withOpacity(0.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Metrics & Daily Special Label on the left
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 18, bottom: 18, right: 155),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header Row: Today's Sales + Interactive Weekday Tag
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Today’s Gross Sales',
                            style: TextStyle(
                              color: Color(0xFFD8E5DC),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Weekday Tag Pill (tap to preview other days)
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              _showWeeklySpecialsSheet(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.matchaGreen.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.matchaGreen.withOpacity(0.5),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    special.dayName,
                                    style: const TextStyle(
                                      color: Color(0xFFE8F5E9),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 12,
                                    color: Color(0xFFE8F5E9),
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
                      // Growth Chip + Avg Ticket
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFA767).withOpacity(0.22),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFFFA767).withOpacity(0.45),
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up_rounded,
                                  color: Color(0xFFFFCC99),
                                  size: 13,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '↑ 12.5%',
                                  style: TextStyle(
                                    color: Color(0xFFFFCC99),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '• ₹340 avg',
                            style: TextStyle(
                              color: Color(0xFFD8E5DC),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Daily Dish Name
                      Text(
                        'Special: ${special.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFFB5C9BE),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
            bottom: -8, // Anchors the dish drop-shadow cleanly
            width: 175,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                _showWeeklySpecialsSheet(context);
              },
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

  // ---------------------------------------------------------------------------
  // 3 Quick Performance Metric Micro-Widgets
  // ---------------------------------------------------------------------------
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
            icon: Icons.local_cafe_rounded,
            iconColor: const Color(0xFFFFA767),
            bgColor: const Color(0xFFFFF4EB),
            value: '$ordersCount',
            label: 'Orders',
            subLabel: '+6 vs target',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            icon: Icons.groups_rounded,
            iconColor: AppColors.primary,
            bgColor: AppColors.primaryContainer.withOpacity(0.5),
            value: '${ordersCount * 2 + 28}',
            label: 'Guests',
            subLabel: '4.8 ★ CSAT',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            icon: Icons.timer_outlined,
            iconColor: const Color(0xFF4A8060),
            bgColor: const Color(0xFFE8F5E9),
            value: '6.2m',
            label: 'Avg Speed',
            subLabel: '1.4m faster',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String value,
    required String label,
    required String subLabel,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.9), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 18,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textPrimaryLight,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subLabel,
            style: const TextStyle(
              fontSize: 9,
              color: AppColors.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6 High-Utility Feature Shortcuts Grid (Micro-Widgets)
  // ---------------------------------------------------------------------------
  Widget _buildFeatureShortcutsSection(
    BuildContext context, {
    required AsyncValue tablesAsync,
    required AsyncValue kitchenTicketsAsync,
  }) {
    // Dynamic badges from stream providers
    String tableOccupancy = '8/12 Seated';
    tablesAsync.whenData((tables) {
      if (tables is List && tables.isNotEmpty) {
        final occupied = tables.where((t) => t.isOccupied == true || (t.status as String?) == 'occupied').length;
        tableOccupancy = '$occupied/${tables.length} Seated';
      }
    });

    String kitchenBadge = '3 In Prep';
    kitchenTicketsAsync.whenData((tickets) {
      if (tickets is List && tickets.isNotEmpty) {
        final inPrep = tickets.where((t) => (t.status as String?) != 'served' && (t.status as String?) != 'completed').length;
        kitchenBadge = '$inPrep In Prep';
      }
    });

    final shortcuts = [
      (
        title: 'New Order',
        subtitle: 'Dine-in, To-Go, Bar',
        badge: 'POS ⚡',
        badgeColor: const Color(0xFFFFA767),
        icon: Icons.local_cafe_rounded,
        iconColor: const Color(0xFFFFA767),
        bgColor: const Color(0xFFFFF6ED),
        onTap: () {
          HapticFeedback.selectionClick();
          context.go('/pos');
        },
      ),
      (
        title: 'Kitchen KDS',
        subtitle: 'Live ticket queue',
        badge: kitchenBadge,
        badgeColor: AppColors.matchaGreen,
        icon: Icons.soup_kitchen_rounded,
        iconColor: const Color(0xFF4A8060),
        bgColor: const Color(0xFFEDF7EE),
        onTap: () {
          HapticFeedback.selectionClick();
          context.go('/kitchen');
        },
      ),
      (
        title: 'Table Sessions',
        subtitle: 'Floor turnaround',
        badge: tableOccupancy,
        badgeColor: AppColors.softLavender,
        icon: Icons.table_restaurant_rounded,
        iconColor: const Color(0xFF7B5EA7),
        bgColor: const Color(0xFFF4EEFB),
        onTap: () {
          HapticFeedback.selectionClick();
          context.go('/tables');
        },
      ),
      (
        title: 'Inventory',
        subtitle: 'Stock & par levels',
        badge: '2 Restock ⚠️',
        badgeColor: const Color(0xFFEAB308),
        icon: Icons.inventory_2_rounded,
        iconColor: const Color(0xFFD97706),
        bgColor: const Color(0xFFFEF9C3),
        onTap: () {
          HapticFeedback.selectionClick();
          context.go('/inventory');
        },
      ),
      (
        title: 'Cash Drawer',
        subtitle: 'Shift float audit',
        badge: '₹4,500 Float',
        badgeColor: const Color(0xFF4A8060),
        icon: Icons.point_of_sale_rounded,
        iconColor: AppColors.primary,
        bgColor: AppColors.primaryContainer.withOpacity(0.4),
        onTap: () {
          HapticFeedback.selectionClick();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const CashDrawerSheet(),
          );
        },
      ),
      (
        title: 'Analytics',
        subtitle: 'Peak hours & margin',
        badge: '+18% Rush 📈',
        badgeColor: const Color(0xFF9C84B8),
        icon: Icons.insights_rounded,
        iconColor: const Color(0xFF6E568F),
        bgColor: const Color(0xFFF3EDFA),
        onTap: () {
          HapticFeedback.selectionClick();
          context.go('/reports');
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Operations & Shortcuts',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: AppColors.primary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '6 Tools',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            Pressable(
              onTap: () => context.go('/pos'),
              child: const Row(
                children: [
                  Text(
                    'All',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.55,
          ),
          itemCount: shortcuts.length,
          itemBuilder: (ctx, index) {
            final s = shortcuts[index];
            return Pressable(
              onTap: s.onTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.borderLight.withOpacity(0.8),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.025),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: s.bgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            s.icon,
                            color: s.iconColor,
                            size: 20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: s.badgeColor.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            s.badge,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.title,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          s.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Rush Hour Velocity Card ("Динамика" Activity Chart from Behance)
  // ---------------------------------------------------------------------------
  Widget _buildRushHourVelocityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2922),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2922).withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title + Peak Indicator Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.auto_graph_rounded,
                    color: AppColors.matchaGreen,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Rush Hour Velocity',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFFDF9),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA767).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFFA767).withOpacity(0.4),
                    width: 0.8,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: Color(0xFFFFCC99),
                      size: 12,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Peak 1:30 PM (38/hr)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFCC99),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Custom Painted Bezier Sparkline Chart
          SizedBox(
            height: 80,
            width: double.infinity,
            child: CustomPaint(
              painter: _RushHourSparklinePainter(
                lineColor: AppColors.matchaGreen,
                peakColor: const Color(0xFFFFA767),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Time Axis Labels
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('8 AM', style: TextStyle(color: Color(0xFF8FA196), fontSize: 9.5, fontWeight: FontWeight.w600)),
              Text('11 AM (Rush)', style: TextStyle(color: Color(0xFF8FA196), fontSize: 9.5, fontWeight: FontWeight.w600)),
              Text('1:30 PM (Peak)', style: TextStyle(color: Color(0xFFFFCC99), fontSize: 9.5, fontWeight: FontWeight.w700)),
              Text('5 PM', style: TextStyle(color: Color(0xFF8FA196), fontSize: 9.5, fontWeight: FontWeight.w600)),
              Text('8 PM', style: TextStyle(color: Color(0xFF8FA196), fontSize: 9.5, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0xFF2C3E33), height: 1),
          const SizedBox(height: 12),

          // 3 Bottom Stats: Morning, Lunch, Evening
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Morning Rush', style: TextStyle(color: Color(0xFF8FA196), fontSize: 10)),
                    SizedBox(height: 2),
                    Text('42 Orders', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lunch Peak', style: TextStyle(color: Color(0xFF8FA196), fontSize: 10)),
                    SizedBox(height: 2),
                    Text('78 Orders', style: TextStyle(color: Color(0xFFFFCC99), fontSize: 13, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Prep Pace', style: TextStyle(color: Color(0xFF8FA196), fontSize: 10)),
                    SizedBox(height: 2),
                    Text('⚡ 6.2m avg', style: TextStyle(color: AppColors.matchaGreen, fontSize: 13, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Operational Alert Chevron Strips (Behance "Не забудь о встречах! <")
  // ---------------------------------------------------------------------------
  Widget _buildOperationalAlerts(BuildContext context) {
    return Column(
      children: [
        // Alert 1: Kitchen Queue
        Pressable(
          onTap: () {
            HapticFeedback.selectionClick();
            context.go('/kitchen');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF7EE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.soup_kitchen_rounded,
                    color: Color(0xFF4A8060),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kitchen Queue: 2 orders ready for expedite',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'Table 4 & Takeaway #1026 ready for pickup',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Alert 2: Par Level Alert
        Pressable(
          onTap: () {
            HapticFeedback.selectionClick();
            context.go('/inventory');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF9C3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFD97706),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stock Warning: Whole Milk below 5L threshold',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '2 items near par • Tap to open inventory',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Recent Orders Live Stream
  // ---------------------------------------------------------------------------
  Widget _buildRecentOrders(BuildContext context, AsyncValue ordersAsync) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: AppColors.primary,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(width: 6),
                StatusPill(label: 'Live', type: StatusPillType.ready, showDot: true),
              ],
            ),
            Pressable(
              onTap: () {
                HapticFeedback.selectionClick();
                context.go('/orders');
              },
              child: const Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.primary,
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
      onTap: () {
        HapticFeedback.selectionClick();
        context.go('/orders');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.02),
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
                    '#1025 • Table 4',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2 items • 10:24 AM • ₹480',
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

    final totalPaise = (order.finalTotalPaise as int?) ?? 48000;
    final moneyDisplay = Money.fromPaise(totalPaise).format();

    return Pressable(
      onTap: () {
        HapticFeedback.selectionClick();
        context.go('/orders');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.02),
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
                    '$itemsCount item${itemsCount > 1 ? "s" : ""} • $timeStr • $moneyDisplay',
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

  // ---------------------------------------------------------------------------
  // 7-Day Chef's Showcase Bottom Sheet
  // ---------------------------------------------------------------------------
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
                                color: const Color(0xFF1E2D25),
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
                                            color: const Color(0xFFFFA767),
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
}

// -----------------------------------------------------------------------------
// Custom Bezier Sparkline Painter for Rush Hour Velocity
// -----------------------------------------------------------------------------
class _RushHourSparklinePainter extends CustomPainter {
  final Color lineColor;
  final Color peakColor;

  _RushHourSparklinePainter({
    required this.lineColor,
    required this.peakColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Normalised points: 8am (0.8h), 10am (0.42h), 11:30am (0.55h), 1:30pm (0.12h peak!), 3:30pm (0.65h), 5:30pm (0.35h), 8pm (0.8h)
    final points = [
      Offset(0, h * 0.82),
      Offset(w * 0.18, h * 0.42),
      Offset(w * 0.35, h * 0.50),
      Offset(w * 0.52, h * 0.15), // Peak at 1:30 PM!
      Offset(w * 0.68, h * 0.62),
      Offset(w * 0.84, h * 0.38),
      Offset(w, h * 0.78),
    ];

    // Build smooth Bezier path
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final midX = (p0.dx + p1.dx) / 2;
      path.cubicTo(midX, p0.dy, midX, p1.dy, p1.dx, p1.dy);
    }

    // Gradient Area Fill under Curve
    final fillPath = Path.from(path)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withOpacity(0.35),
          lineColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Stroke line
    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, linePaint);

    // Draw Subtle Dotted Grid Guide at peak
    final peakPoint = points[3];
    final guidePaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(peakPoint.dx, peakPoint.dy), Offset(peakPoint.dx, h), guidePaint);

    // Draw Glowing Peak Node
    final glowPaint = Paint()
      ..color = peakColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(peakPoint, 9, glowPaint);

    final nodePaint = Paint()
      ..color = peakColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(peakPoint, 4.5, nodePaint);

    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(peakPoint, 2, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
