import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../ux/interaction/pressable.dart';

class BottomNavItem {
  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isCenterAction;

  const BottomNavItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.isCenterAction = false,
  });
}

/// Official MΛCHA Fixed Full-Width Bottom Navigation Bar.
/// Pinned cleanly to the bottom screen edge, respecting safe area insets.
class FixedBottomNav extends StatelessWidget {
  final int selectedIndex;
  final List<BottomNavItem> items;
  final ValueChanged<int> onItemSelected;

  const FixedBottomNav({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == selectedIndex;

              if (item.isCenterAction) {
                // Primary Center POS Action Button
                return Expanded(
                  child: Pressable(
                    onTap: () => onItemSelected(index),
                    child: Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.92),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add_rounded,
                          color: AppColors.backgroundLight,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Standard Navigation Item
              return Expanded(
                child: Pressable(
                  onTap: () => onItemSelected(index),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected ? item.selectedIcon : item.icon,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondaryLight,
                          size: 23,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.label,
                          style: AppTypography.bodySmall.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondaryLight,
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w500,
                            fontSize: 11,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
