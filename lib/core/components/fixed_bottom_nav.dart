import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                // Primary Center POS Action Button (Elevated Circle with tactile depth)
                return Expanded(
                  child: Pressable(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      onItemSelected(index);
                    },
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryLight,
                              AppColors.primary,
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add_rounded,
                          color: AppColors.backgroundLight,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Standard Navigation Item (Sleek pill highlight + active indicator dot)
              return Expanded(
                child: Pressable(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onItemSelected(index);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            isSelected ? item.selectedIcon : item.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondaryLight,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 2),
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
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const SizedBox(height: 6),
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
