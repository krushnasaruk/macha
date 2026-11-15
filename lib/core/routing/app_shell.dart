import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/settings/presentation/dev_tools_sheet.dart';
import '../components/app_badge.dart';
import '../identity/identity_provider.dart';
import '../permissions/role_permissions.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_cafe_rounded,
                        color: Colors.white,
                        size: 24,
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
            Expanded(child: child),
          ],
        ),
      );
    }

    // Phone Bottom Navigation
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: safeIndex,
        onDestinationSelected: (index) {
          context.go(allowedDestinations[index].path);
        },
        destinations: allowedDestinations.map((dest) {
          return NavigationDestination(
            icon: Icon(dest.icon),
            selectedIcon: Icon(dest.selectedIcon),
            label: dest.label,
          );
        }).toList(),
      ),
    );
  }
}
