import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/offline_sync_indicator.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/mascot/mascot_asset_registry.dart';
import '../../../core/mascot/mascot_guided_tour.dart';
import '../../../core/mascot/mascot_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/ux/interaction/pressable.dart';
import 'dev_tools_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identity = ref.watch(currentIdentityNotifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        title: Text(
          'More',
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: OfflineSyncIndicator(),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.primary),
            tooltip: 'Settings',
            onPressed: () => DevToolsSheet.show(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // CaféOS Banner Card (matching reference design)
          _buildPremiumPlanCard(context, identity),
          const SizedBox(height: 24),

          // Tools & Features Section
          _buildSectionHeader('Tools & Features'),
          const SizedBox(height: 10),
          _buildGroupedCard([
            _SettingsTile(
              icon: Icons.restaurant_menu_rounded,
              title: 'Menu Catalog & Recipes',
              onTap: () => context.push('/menu'),
            ),
            _SettingsTile(
              icon: Icons.table_restaurant_rounded,
              title: 'Table Management',
              onTap: () => context.push('/tables'),
            ),
            _SettingsTile(
              icon: Icons.soup_kitchen_rounded,
              title: 'Kitchen Display (KDS)',
              onTap: () => context.push('/kitchen'),
            ),
            _SettingsTile(
              icon: Icons.bar_chart_rounded,
              title: 'Business Analytics',
              onTap: () => context.push('/reports'),
            ),
            _SettingsTile(
              icon: Icons.print_outlined,
              title: 'Print Settings',
              onTap: () => _showPrintSettingsDialog(context),
            ),
            _SettingsTile(
              icon: Icons.group_outlined,
              title: 'Staff Management',
              onTap: () => DevToolsSheet.show(context),
            ),
            _SettingsTile(
              icon: Icons.card_giftcard_rounded,
              title: 'Offers & Rewards',
              onTap: () => _showOffersDialog(context),
            ),
          ]),
          const SizedBox(height: 16),

          // Chef Barnaby Mascot Card (Guided Tour)
          _buildMascotTourCard(context),
          const SizedBox(height: 24),

          // Preferences Section
          _buildSectionHeader('Preferences'),
          const SizedBox(height: 10),
          _buildGroupedCard([
            _SettingsTile(
              icon: Icons.palette_outlined,
              title: 'Appearance & Design System',
              onTap: () => context.push('/gallery'),
            ),
            _SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              onTap: () => _showNotificationsDialog(context),
            ),
            _SettingsTile(
              icon: Icons.translate_rounded,
              title: 'Language',
              onTap: () => _showLanguageDialog(context),
            ),
            _SettingsTile(
              icon: Icons.developer_mode_rounded,
              title: 'Developer Tools & Role Switcher',
              onTap: () => DevToolsSheet.show(context),
            ),
            _SettingsTile(
              icon: Icons.storefront_rounded,
              title: 'Tenant & GST Settings',
              onTap: () => context.push('/settings/tenant'),
            ),
          ]),
          const SizedBox(height: 24),

          // Log Out Button (matching reference design)
          Pressable(
            onTap: () => _showLogoutConfirmDialog(context, ref),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.warmCream,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight, width: 1),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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

  Widget _buildPremiumPlanCard(BuildContext context, dynamic identity) {
    return Pressable(
      onTap: () => DevToolsSheet.show(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.warmCream,
          borderRadius: BorderRadius.circular(22),
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
          children: [
            // Left Circular dark emblem
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/branding/macha/macha_app_icon_forest.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Λ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MΛCHA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Enterprise Café-Tech • ${identity.employee.name}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascotTourCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const MascotWidget(
            pose: MascotPose.waving,
            height: 64,
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chef Barnaby Companion',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your friendly head chef & onboarding guide.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => MascotGuidedTourModal.show(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text('Tour', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildGroupedCard(List<_SettingsTile> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tiles.length,
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          thickness: 0.8,
          indent: 56,
          endIndent: 16,
          color: AppColors.borderLight,
        ),
        itemBuilder: (context, index) {
          final tile = tiles[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            leading: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.creamContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(tile.icon, size: 20, color: AppColors.primary),
            ),
            title: Text(
              tile.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondaryLight,
              size: 20,
            ),
            onTap: tile.onTap,
          );
        },
      ),
    );
  }

  void _showPrintSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Thermal Printer Settings'),
        content: const Text(
          'ESC/POS Bluetooth & LAN thermal receipt printer configuration is connected and ready.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }

  void _showOffersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Offers & Discounts'),
        content: const Text(
          'Active promotions:\n• Happy Hours (10% off on hot brews)\n• Loyalty member ₹50 off on ₹500+',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Notification Preferences'),
        content: const Text('All order alerts and inventory alerts are enabled for this terminal.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Language'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text('English (US/IN)'), trailing: Icon(Icons.check_rounded)),
            ListTile(title: Text('Hindi (हिंदी)')),
            ListTile(title: Text('Marathi (मराठी)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ],
      ),
    );
  }

  void _showLogoutConfirmDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Log Out'),
        content: const Text('Are you sure you want to log out of the current terminal session?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              DevToolsSheet.show(context);
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
