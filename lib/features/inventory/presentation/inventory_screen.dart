import 'package:flutter/material.dart';
import '../../../core/components/pill_filter_chip.dart';
import '../../../core/components/quantity_stepper.dart';
import '../../../core/components/status_pill.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class InventoryItem {
  final String id;
  final String name;
  final String quantityStr;
  final String category;
  final String assetPath;
  final bool isLowStock;
  int count;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantityStr,
    required this.category,
    required this.assetPath,
    this.isLowStock = false,
    this.count = 1,
  });
}

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  late List<InventoryItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      InventoryItem(
        id: 'inv_1',
        name: 'Coffee Beans',
        quantityStr: '1 kg',
        category: 'Coffee',
        assetPath: 'assets/inventory/coffee_beans.png',
        isLowStock: false,
        count: 1,
      ),
      InventoryItem(
        id: 'inv_2',
        name: 'Milk',
        quantityStr: '1 Ltr',
        category: 'Milk',
        assetPath: 'assets/inventory/milk.png',
        isLowStock: false,
        count: 1,
      ),
      InventoryItem(
        id: 'inv_3',
        name: 'Sugar',
        quantityStr: '500 g',
        category: 'Others',
        assetPath: 'assets/inventory/sugar.png',
        isLowStock: true,
        count: 1,
      ),
      InventoryItem(
        id: 'inv_4',
        name: 'Tea Leaves',
        quantityStr: '250 g',
        category: 'Others',
        assetPath: 'assets/inventory/tea_leaves.png',
        isLowStock: false,
        count: 1,
      ),
      InventoryItem(
        id: 'inv_5',
        name: 'Chocolate Syrup',
        quantityStr: '750 ml',
        category: 'Others',
        assetPath: 'assets/inventory/chocolate_syrup.png',
        isLowStock: false,
        count: 1,
      ),
    ];
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _items.where((item) {
      if (_selectedCategory != 'All' && item.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty &&
          !item.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    const totalItems = 24; // Reference KPI
    const inStockCount = 18;
    const lowStockCount = 6;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        title: Text(
          'Inventory',
          style: AppTypography.headlineMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.primary),
            tooltip: 'Filter & Sort',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter & sorting applied'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top 3 KPI Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.inventory_2_outlined,
                      iconColor: const Color(0xFF8C6747),
                      circleBg: const Color(0xFFF1E6D8),
                      value: '$totalItems',
                      label: 'Items',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: const Color(0xFF3E8A5E),
                      circleBg: const Color(0xFFE5F4EB),
                      value: '$inStockCount',
                      label: 'In Stock',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.warning_amber_rounded,
                      iconColor: const Color(0xFFE89246),
                      circleBg: const Color(0xFFFDF2E4),
                      value: '$lowStockCount',
                      label: 'Low Stock',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderLight, width: 1),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search items...',
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondaryLight,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              setState(() {
                                _searchCtrl.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val.trim()),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Category Filter Pills (All, Coffee, Milk, Others)
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PillFilterChip(
                    label: 'All',
                    isSelected: _selectedCategory == 'All',
                    onTap: () => setState(() => _selectedCategory = 'All'),
                  ),
                  const SizedBox(width: 8),
                  PillFilterChip(
                    label: 'Coffee',
                    isSelected: _selectedCategory == 'Coffee',
                    onTap: () => setState(() => _selectedCategory = 'Coffee'),
                  ),
                  const SizedBox(width: 8),
                  PillFilterChip(
                    label: 'Milk',
                    isSelected: _selectedCategory == 'Milk',
                    onTap: () => setState(() => _selectedCategory = 'Milk'),
                  ),
                  const SizedBox(width: 8),
                  PillFilterChip(
                    label: 'Others',
                    isSelected: _selectedCategory == 'Others',
                    onTap: () => setState(() => _selectedCategory = 'Others'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Items List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return _buildInventoryRow(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required Color iconColor,
    required Color circleBg,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5EE),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDE3D7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: circleBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 19, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryRow(InventoryItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item.isLowStock ? const Color(0xFFF3DEC8) : const Color(0xFFEDE2D6),
          width: 1,
        ),
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
          // Circular leading illustration container
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFF6EFE6),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              item.assetPath,
              width: 36,
              height: 36,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.inventory_2_outlined,
                size: 24,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Name, Quantity and Status Pill
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.quantityStr,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                StatusPill(
                  label: item.isLowStock ? 'Low Stock' : 'In Stock',
                  type: item.isLowStock ? StatusPillType.lowStock : StatusPillType.inStock,
                  showDot: true,
                ),
              ],
            ),
          ),

          // Quantity Stepper
          QuantityStepper(
            value: item.count,
            min: 1,
            max: 99,
            onChanged: (newCount) {
              setState(() {
                item.count = newCount;
              });
            },
          ),
        ],
      ),
    );
  }
}
