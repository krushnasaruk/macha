import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/offline_sync_indicator.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/mascot/mascot_asset_registry.dart';
import '../../../core/mascot/mascot_guided_tour.dart';
import '../../../core/mascot/mascot_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import 'dev_tools_sheet.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identity = ref.watch(currentIdentityNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Administration'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: OfflineSyncIndicator(),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          // Active Identity Banner
          AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    identity.employee.name.substring(0, 1),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        identity.employee.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '${identity.tenant.name} • ${identity.branch.name}',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      AppBadge(
                        label: identity.role.title,
                        backgroundColor: AppColors.secondaryContainer,
                        textColor: AppColors.onSecondaryContainer,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz_rounded),
                  tooltip: 'Switch Role / Branch',
                  onPressed: () => DevToolsSheet.show(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Chef Barnaby Mascot Card
          AppCard(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF2C2825)
                : const Color(0xFFFAF3EC),
            child: Row(
              children: [
                const MascotWidget(
                  expression: MascotExpression.happy,
                  height: 64,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chef Barnaby Companion',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Your friendly head chef & guided onboarding tour.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.explore_rounded, size: 16),
                  label: const Text('Take Tour'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () => MascotGuidedTourModal.show(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tools & Modules
          Text(
            'Developer & System Controls',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.developer_mode_rounded, color: AppColors.secondary),
                  title: const Text('Dev Tools Sheet'),
                  subtitle: const Text('Switch active branch, employee role, or view seed state'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => DevToolsSheet.show(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.palette_rounded, color: AppColors.primary),
                  title: const Text('Design System Gallery'),
                  subtitle: const Text('Interactive testbed for buttons, fields, cards & Money (ADR-D2)'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push('/gallery'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.storefront_rounded, color: AppColors.primary),
                  title: const Text('Tenant & GST Settings'),
                  subtitle: const Text('Currency, timezone, GSTIN, and offline invoice series (ADR-D3)'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push('/settings/tenant'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'Hardware & Local Config',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.point_of_sale_rounded),
                  title: const Text('Terminal Registration'),
                  subtitle: Text('Device: ${identity.device.name} (Series: ${identity.device.deviceSeries})'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.print_rounded),
                  title: Text('Thermal Receipt Printer'),
                  subtitle: Text('ESC/POS Bluetooth & LAN driver abstraction (Stage 8)'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.sync_rounded),
                  title: Text('Outbox Synchronization'),
                  subtitle: Text('Local-first Drift database with automatic sync retry'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
