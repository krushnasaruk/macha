import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/connectivity_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// App bar or header indicator displaying live online/offline and outbox sync status.
class OfflineSyncIndicator extends ConsumerWidget {
  final int pendingCount;
  final VoidCallback? onTap;

  const OfflineSyncIndicator({
    super.key,
    this.pendingCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(isOnlineProvider);
    final isOnline = connectivity.value ?? true;

    Color bg;
    Color fg;
    IconData icon;
    String text;

    if (!isOnline) {
      bg = const Color(0xFFFEF2F2);
      fg = AppColors.error;
      icon = Icons.cloud_off_rounded;
      text = 'Offline ($pendingCount queued)';
    } else if (pendingCount > 0) {
      bg = const Color(0xFFFEFCE8);
      fg = AppColors.syncPending;
      icon = Icons.sync_rounded;
      text = 'Syncing ($pendingCount)';
    } else {
      bg = const Color(0xFFF0FDF4);
      fg = AppColors.syncSuccess;
      icon = Icons.cloud_done_rounded;
      text = 'Online';
    }

    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.roundedFull,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: fg.withOpacity(0.3)),
          borderRadius: AppSpacing.roundedFull,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: fg,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
