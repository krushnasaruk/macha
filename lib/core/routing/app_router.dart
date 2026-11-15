import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/billing/presentation/pos_screen.dart';
import '../../features/home/presentation/home_dashboard_screen.dart';
import '../../features/inventory/presentation/inventory_screen.dart';
import '../../features/kitchen/presentation/kitchen_screen.dart';
import '../../features/menu/presentation/menu_screen.dart';
import '../../features/orders/presentation/orders_screen.dart';
import '../../features/orders/presentation/tables_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/settings/presentation/component_gallery_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settings/presentation/tenant_settings_screen.dart';
import '../identity/identity_models.dart';
import '../identity/identity_provider.dart';
import '../permissions/permission_keys.dart';
import '../permissions/role_permissions.dart';
import 'app_shell.dart';

class NavDestination {
  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String? requiredPermission;

  const NavDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.requiredPermission,
  });
}

const List<NavDestination> allDestinations = [
  NavDestination(
    path: '/pos',
    label: 'POS',
    icon: Icons.point_of_sale_outlined,
    selectedIcon: Icons.point_of_sale_rounded,
    requiredPermission: AppPermissions.posAccess,
  ),
  NavDestination(
    path: '/orders',
    label: 'Orders',
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long_rounded,
    requiredPermission: AppPermissions.posAccess,
  ),
  NavDestination(
    path: '/tables',
    label: 'Tables',
    icon: Icons.table_restaurant_outlined,
    selectedIcon: Icons.table_restaurant_rounded,
    requiredPermission: AppPermissions.tablesAccess,
  ),
  NavDestination(
    path: '/kitchen',
    label: 'Kitchen',
    icon: Icons.soup_kitchen_outlined,
    selectedIcon: Icons.soup_kitchen_rounded,
    requiredPermission: AppPermissions.kdsAccess,
  ),
  NavDestination(
    path: '/menu',
    label: 'Menu',
    icon: Icons.restaurant_menu_outlined,
    selectedIcon: Icons.restaurant_menu_rounded,
    requiredPermission: AppPermissions.menuView,
  ),
  NavDestination(
    path: '/inventory',
    label: 'Inventory',
    icon: Icons.inventory_2_outlined,
    selectedIcon: Icons.inventory_2_rounded,
    requiredPermission: AppPermissions.inventoryView,
  ),
  NavDestination(
    path: '/reports',
    label: 'Reports',
    icon: Icons.bar_chart_outlined,
    selectedIcon: Icons.bar_chart_rounded,
    requiredPermission: AppPermissions.reportsView,
  ),
  NavDestination(
    path: '/settings',
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings_rounded,
  ),
];

final appRouterProvider = Provider<GoRouter>((ref) {
  final identity = ref.watch(currentIdentityNotifier);

  return GoRouter(
    initialLocation: _firstAllowedPath(identity.role),
    redirect: (context, state) {
      final currentPath = state.uri.path;
      if (currentPath == '/gallery') return null; // Dev gallery is open

      final match = allDestinations.firstWhere(
        (d) => d.path == currentPath,
        orElse: () => const NavDestination(
          path: '',
          label: '',
          icon: Icons.help,
          selectedIcon: Icons.help,
        ),
      );

      if (match.requiredPermission != null &&
          !RolePermissions.hasPermission(identity.role, match.requiredPermission!)) {
        return _firstAllowedPath(identity.role);
      }
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(child: HomeDashboardScreen()),
          ),
          GoRoute(
            path: '/pos',
            pageBuilder: (context, state) => const NoTransitionPage(child: PosScreen()),
          ),
          GoRoute(
            path: '/orders',
            pageBuilder: (context, state) => const NoTransitionPage(child: OrdersScreen()),
          ),
          GoRoute(
            path: '/tables',
            pageBuilder: (context, state) => const NoTransitionPage(child: TablesScreen()),
          ),
          GoRoute(
            path: '/kitchen',
            pageBuilder: (context, state) => const NoTransitionPage(child: KitchenScreen()),
          ),
          GoRoute(
            path: '/menu',
            pageBuilder: (context, state) => const NoTransitionPage(child: MenuScreen()),
          ),
          GoRoute(
            path: '/inventory',
            pageBuilder: (context, state) => const NoTransitionPage(child: InventoryScreen()),
          ),
          GoRoute(
            path: '/reports',
            pageBuilder: (context, state) => const NoTransitionPage(child: ReportsScreen()),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/gallery',
        builder: (context, state) => const ComponentGalleryScreen(),
      ),
      GoRoute(
        path: '/settings/tenant',
        builder: (context, state) => const TenantSettingsScreen(),
      ),
    ],
  );
});

String _firstAllowedPath(UserRole role) {
  for (final dest in allDestinations) {
    if (dest.requiredPermission == null ||
        RolePermissions.hasPermission(role, dest.requiredPermission!)) {
      return dest.path;
    }
  }
  return '/settings';
}
