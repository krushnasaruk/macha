import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/identity/identity_models.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class DevToolsSheet extends ConsumerWidget {
  const DevToolsSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DevToolsSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identity = ref.watch(currentIdentityNotifier);
    final identityNotifier = ref.read(currentIdentityNotifier.notifier);
    final identityProv = ref.watch(identityProviderInstance);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: AppSpacing.paddingLg,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  borderRadius: AppSpacing.roundedFull,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.developer_mode_rounded, color: AppColors.secondary),
                    const SizedBox(width: 8),
                    Text(
                      'Dev Tools & Role Switcher',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Switch between seeded roles to inspect adaptive navigation and permission enforcement (ADR-D4).',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
            const Divider(height: 24),

            // Branch Selector
            Text(
              'Active Branch',
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: identityProv.availableBranches.map((branch) {
                final isSelected = branch.id == identity.branch.id;
                return ChoiceChip(
                  label: Text('${branch.name} (${branch.code})'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      identityNotifier.switchBranch(branch.id);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Role Selector
            Text(
              'Active Employee Role',
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: UserRole.values.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final role = UserRole.values[index];
                final isSelected = role == identity.role;
                final employee = DevIdentityProvider.demoEmployees[role]!;

                return ListTile(
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppSpacing.roundedSm,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  tileColor: isSelected
                      ? (isDark ? AppColors.cardDark : AppColors.primaryContainer.withOpacity(0.4))
                      : null,
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: isSelected ? AppColors.primary : AppColors.secondaryContainer,
                    child: Text(
                      role.name.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(employee.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(width: 8),
                      AppBadge(
                        label: role.title,
                        backgroundColor: isSelected ? AppColors.primary : AppColors.borderLight,
                        textColor: isSelected ? Colors.white : AppColors.textPrimaryLight,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    role.description,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  ),
                  trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: AppColors.primary) : null,
                  onTap: () {
                    identityNotifier.switchRole(role);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
