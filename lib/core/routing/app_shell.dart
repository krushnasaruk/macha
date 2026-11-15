import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/settings/presentation/dev_tools_sheet.dart';
import '../components/app_badge.dart';
import '../components/floating_bottom_nav.dart';
import '../identity/identity_provider.dart';
import '../permissions/role_permissions.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../ux/metrics/ux_hud.dart';
import 'app_router.dart';

class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identity = ref.watch(currentIdentityNotifier);
    final isTablet = AppSpacing.isTablet(context);

    // Filter destinations permitted for current role
    final allowedDestinations = allDestinations.where((dest) {
      if (dest.requiredPermission == null) return true;
      return RolePermissions.hasPermission(identity.role, dest.requiredPermission!);
    }).toList();

    final location = GoRouterState.of(context).uri.path;
    final currentIndex = allowedDestinations.indexWhere((d) => d.path == location);
    final safeIndex = currentIndex >= 0 ? currentIndex : 0;

    if (isTablet) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: safeIndex,
              onDestinationSelected: (index) {
                context.go(allowedDestinations[index].path);
              },
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/branding/logo/cafeos_app_icon.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CaféOS',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    AppBadge(
                      label: identity.role.title,
                      backgroundColor: AppColors.primaryContainer,
                      textColor: AppColors.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: IconButton(
                      icon: const Icon(Icons.developer_mode_rounded),
                      tooltip: 'Dev Role Switcher',
                      onPressed: () => DevToolsSheet.show(context),
                    ),
                  ),
                ),
              ),
              destinations: allowedDestinations.map((dest) {
                return NavigationRailDestination(
                  icon: Icon(dest.icon),
                  selectedIcon: Icon(dest.selectedIcon, color: AppColors.primary),
                  label: Text(dest.label),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: UxHudOverlay(child: child)),
          ],
        ),
      );
    }

    // Phone Floating Capsule Bottom Navigation (Reference Design)
    const mobileDestinations = [
      FloatingBottomNavItem(
        path: '/home',
        label: 'Home',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
      ),
      FloatingBottomNavItem(
        path: '/orders',
        label: 'Orders',
        icon: Icons.receipt_long_outlined,
        selectedIcon: Icons.receipt_long_rounded,
      ),
      FloatingBottomNavItem(
        path: '/pos',
        label: 'POS',
        icon: Icons.add_rounded,
        selectedIcon: Icons.add_rounded,
        isCenterFab: true,
      ),
      FloatingBottomNavItem(
        path: '/inventory',
        label: 'Stock',
        icon: Icons.inventory_2_outlined,
        selectedIcon: Icons.inventory_2_rounded,
      ),
      FloatingBottomNavItem(
        path: '/settings',
        label: 'More',
        icon: Icons.more_horiz_rounded,
        selectedIcon: Icons.more_horiz_rounded,
      ),
    ];

    int mobileIndex = mobileDestinations.indexWhere((d) => d.path == location);
    if (mobileIndex < 0) {
      if (location.startsWith('/orders')) {
        mobileIndex = 1;
      } else if (location.startsWith('/pos')) {
        mobileIndex = 2;
      } else if (location.startsWith('/inventory')) {
        mobileIndex = 3;
      } else if (location.startsWith('/settings')) {
        mobileIndex = 4;
      } else {
        mobileIndex = 0;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: UxHudOverlay(child: child),
      bottomNavigationBar: FloatingBottomNav(
        selectedIndex: mobileIndex,
        items: mobileDestinations,
        onItemSelected: (index) {
          context.go(mobileDestinations[index].path);
        },
      ),
    );
  }
}
