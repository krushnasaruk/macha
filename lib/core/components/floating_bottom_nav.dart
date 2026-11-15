import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../ux/interaction/pressable.dart';

class FloatingBottomNavItem {
  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isCenterFab;

  const FloatingBottomNavItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.isCenterFab = false,
  });
}

class FloatingBottomNav extends StatelessWidget {
  final int selectedIndex;
  final List<FloatingBottomNavItem> items;
  final ValueChanged<int> onItemSelected;

  const FloatingBottomNav({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 68,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDF9),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: const Color(0xFFE8DFD5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF342B26).withOpacity(0.08),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == selectedIndex;

            if (item.isCenterFab) {
              // Prominent elevated circular POS button (Terracotta)
              return Pressable(
                onTap: () => onItemSelected(index),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.terracotta : AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isSelected ? AppColors.terracotta : AppColors.primary).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              );
            }

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
                        color: isSelected ? AppColors.primary : const Color(0xFF8E8278),
                        size: 22,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                          color: isSelected ? AppColors.primary : const Color(0xFF8E8278),
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
    );
  }
}
