import 'package:flutter/material.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/pill_filter_chip.dart';
import '../../../core/components/quantity_stepper.dart';
import '../../../core/components/status_pill.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class StockMovement {
  final DateTime timestamp;
  final int delta;
  final String reason;

  const StockMovement({
    required this.timestamp,
    required this.delta,
    required this.reason,
  });
}

class InventoryItem {
  final String id;
  final String name;
  final String unit;
  final String category;
  final String assetPath;
  final int threshold;
  int count;
  final List<StockMovement> history;

  InventoryItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.category,
    required this.assetPath,
    this.threshold = 3,
    this.count = 10,
    List<StockMovement>? history,
  }) : history = history ?? [];

  bool get isLowStock => count > 0 && count <= threshold;
  bool get isOutOfStock => count <= 0;
  String get quantityStr => '$count $unit';
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
        name: 'Single Origin Espresso Beans',
        unit: 'kg',
        category: 'Coffee',
        assetPath: 'assets/inventory/coffee_beans.png',
        threshold: 4,
        count: 14,
        history: [
          StockMovement(
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
            delta: -2,
            reason: 'Barista Morning Shift Dispense',
          ),
          StockMovement(
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            delta: 10,
            reason: 'Received Roast Supply PO #882',
          ),
        ],
      ),
      InventoryItem(
        id: 'inv_2',
        name: 'Whole Pasteurized Milk',
        unit: 'Ltr',
        category: 'Milk & Dairy',
        assetPath: 'assets/inventory/milk.png',
        threshold: 6,
        count: 18,
        history: [
          StockMovement(
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            delta: -4,
            reason: 'Breakfast Rush Service',
          ),
        ],
      ),
      InventoryItem(
        id: 'inv_3',
        name: 'Pure Cane Demerara Sugar',
        unit: 'kg',
        category: 'Others',
        assetPath: 'assets/inventory/sugar.png',
        threshold: 3,
        count: 2, // Low stock
        history: [
          StockMovement(
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
            delta: -3,
            reason: 'Syrup Batch Preparation',
          ),
        ],
      ),
      InventoryItem(
        id: 'inv_4',
        name: 'Organic Darjeeling Tea Leaves',
        unit: 'packs',
        category: 'Coffee',
        assetPath: 'assets/inventory/tea_leaves.png',
        threshold: 2,
        count: 8,
      ),
      InventoryItem(
        id: 'inv_5',
        name: 'Artisan Dark Chocolate Sauce',
        unit: 'bottles',
        category: 'Others',
        assetPath: 'assets/inventory/chocolate_syrup.png',
        threshold: 2,
        count: 5,
      ),
      InventoryItem(
        id: 'inv_6',
        name: 'Barista Oat Milk (Oatly)',
        unit: 'Ltr',
        category: 'Milk & Dairy',
        assetPath: 'assets/inventory/milk.png',
        threshold: 4,
        count: 12,
      ),
      InventoryItem(
        id: 'inv_7',
        name: 'Ceremonial Uji Matcha Powder',
        unit: 'tins',
        category: 'Coffee',
        assetPath: 'assets/inventory/tea_leaves.png',
        threshold: 3,
        count: 2, // Low stock
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

    final totalItems = _items.length;
    final inStockCount = _items.where((i) => !i.isLowStock && !i.isOutOfStock).length;
    final lowStockCount = _items.where((i) => i.isLowStock || i.isOutOfStock).length;

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
            icon: const Icon(Icons.add_box_outlined, color: AppColors.primary),
            tooltip: 'Add Inventory Item',
            onPressed: () => _showAddItemDialog(context),
          ),
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
                      iconColor: AppColors.primary,
                      circleBg: AppColors.primaryContainer,
                      value: '$totalItems',
                      label: 'Items',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.check_circle_outline_rounded,
                      iconColor: const Color(0xFF2E6B48),
                      circleBg: const Color(0xFFE2F0E7),
                      value: '$inStockCount',
                      label: 'In Stock',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildKpiCard(
                      icon: Icons.warning_amber_rounded,
                      iconColor: const Color(0xFFC06A23),
                      circleBg: const Color(0xFFFDECDA),
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
                  border: Border.all(color: AppColors.borderLight, width: 1.2),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search inventory items...',
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondaryLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18, color: AppColors.primary),
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

            // Category Filter Pills
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
                    label: 'Milk & Dairy',
                    isSelected: _selectedCategory == 'Milk & Dairy',
                    onTap: () => setState(() => _selectedCategory = 'Milk & Dairy'),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
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
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showStockAdjustmentSheet(context, item),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: item.isLowStock
                ? const Color(0xFFF3DEC8)
                : item.isOutOfStock
                    ? const Color(0xFFF7D5D5)
                    : AppColors.borderLight,
            width: item.isLowStock || item.isOutOfStock ? 1.5 : 1.0,
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
                color: Color(0xFFF6EADB),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    label: item.isOutOfStock
                        ? 'Out of Stock'
                        : item.isLowStock
                            ? 'Low Stock (Alert < ${item.threshold} ${item.unit})'
                            : 'In Stock',
                    type: item.isOutOfStock
                        ? StatusPillType.outOfStock
                        : item.isLowStock
                            ? StatusPillType.lowStock
                            : StatusPillType.inStock,
                    showDot: true,
                  ),
                ],
              ),
            ),

            // Quantity Stepper
            QuantityStepper(
              value: item.count,
              min: 0,
              max: 999,
              onChanged: (newCount) {
                final diff = newCount - item.count;
                setState(() {
                  item.count = newCount;
                  item.history.insert(
                    0,
                    StockMovement(
                      timestamp: DateTime.now(),
                      delta: diff,
                      reason: diff > 0 ? 'Quick Counter Add' : 'Quick Counter Deduction',
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final countCtrl = TextEditingController(text: '10');
    final unitCtrl = TextEditingController(text: 'kg');
    final thresholdCtrl = TextEditingController(text: '3');
    String selectedCategory = 'Coffee';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Add Inventory Item',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: 'Item Name',
                  controller: nameCtrl,
                  hint: 'e.g. Colombian Supremo Beans',
                ),
                const SizedBox(height: 12),
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderLight, width: 1.2),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedCategory,
                      items: const [
                        DropdownMenuItem(value: 'Coffee', child: Text('Coffee & Beans')),
                        DropdownMenuItem(value: 'Milk & Dairy', child: Text('Milk & Dairy')),
                        DropdownMenuItem(value: 'Others', child: Text('Others & Syrups')),
                      ],
                      onChanged: (val) {
                        if (val != null) setDialogState(() => selectedCategory = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Initial Count',
                        controller: countCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        label: 'Unit (kg, Ltr, pcs)',
                        controller: unitCtrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Low Stock Alert Threshold',
                  controller: thresholdCtrl,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondaryLight)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                final name = nameCtrl.text.trim();
                final count = int.tryParse(countCtrl.text.trim()) ?? 10;
                final threshold = int.tryParse(thresholdCtrl.text.trim()) ?? 3;
                final unit = unitCtrl.text.trim().isNotEmpty ? unitCtrl.text.trim() : 'pcs';

                if (name.isNotEmpty) {
                  setState(() {
                    _items.add(
                      InventoryItem(
                        id: 'inv_${DateTime.now().millisecondsSinceEpoch}',
                        name: name,
                        unit: unit,
                        category: selectedCategory,
                        assetPath: selectedCategory == 'Milk & Dairy'
                            ? 'assets/inventory/milk.png'
                            : selectedCategory == 'Coffee'
                                ? 'assets/inventory/coffee_beans.png'
                                : 'assets/inventory/sugar.png',
                        count: count,
                        threshold: threshold,
                      ),
                    );
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockAdjustmentSheet(BuildContext context, InventoryItem item) {
    int adjustmentDelta = 0;
    String adjustmentType = 'Restock'; // Restock, Spoilage, Manual Count
    final noteCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final newCalculatedCount = adjustmentType == 'Manual Count'
              ? adjustmentDelta
              : (item.count + adjustmentDelta).clamp(0, 9999);

          return Container(
            padding: EdgeInsets.fromLTRB(
              20,
              16,
              20,
              MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Stock Summary Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Current Stock', style: TextStyle(fontSize: 12, color: AppColors.textSecondaryLight)),
                            const SizedBox(height: 4),
                            Text(
                              '${item.count} ${item.unit}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary),
                            ),
                          ],
                        ),
                        Container(width: 1, height: 36, color: AppColors.borderLight),
                        Column(
                          children: [
                            const Text('After Adjustment', style: TextStyle(fontSize: 12, color: AppColors.textSecondaryLight)),
                            const SizedBox(height: 4),
                            Text(
                              '$newCalculatedCount ${item.unit}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: newCalculatedCount <= item.threshold ? Colors.orange.shade800 : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Adjustment Mode Selector
                  Row(
                    children: [
                      _buildModeChip('Restock', Icons.add_circle_outline, adjustmentType, (val) {
                        setSheetState(() {
                          adjustmentType = val;
                          adjustmentDelta = 5;
                        });
                      }),
                      const SizedBox(width: 8),
                      _buildModeChip('Waste / Loss', Icons.remove_circle_outline, adjustmentType, (val) {
                        setSheetState(() {
                          adjustmentType = val;
                          adjustmentDelta = -1;
                        });
                      }),
                      const SizedBox(width: 8),
                      _buildModeChip('Audit Fix', Icons.tune_rounded, adjustmentType, (val) {
                        setSheetState(() {
                          adjustmentType = val;
                          adjustmentDelta = item.count;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Quick Delta Buttons
                  if (adjustmentType != 'Audit Fix') ...[
                    const Text('Quick Adjustments', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [1, 5, 10, 20].map((step) {
                        final deltaValue = adjustmentType == 'Restock' ? step : -step;
                        final isSelected = adjustmentDelta == deltaValue;
                        return ChoiceChip(
                          label: Text('${deltaValue > 0 ? "+" : ""}$deltaValue ${item.unit}'),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          onSelected: (_) {
                            setSheetState(() {
                              adjustmentDelta = deltaValue;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                  ],

                  // Notes / Reason
                  AppTextField(
                    label: 'Reason / Supplier PO Reference',
                    controller: noteCtrl,
                    hint: adjustmentType == 'Restock'
                        ? 'e.g. Delivered by Roasters Ltd PO #9482'
                        : 'e.g. Spillage during espresso calibration',
                  ),
                  const SizedBox(height: 16),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        setState(() {
                          item.count = newCalculatedCount;
                          item.history.insert(
                            0,
                            StockMovement(
                              timestamp: DateTime.now(),
                              delta: newCalculatedCount - item.count,
                              reason: noteCtrl.text.trim().isNotEmpty
                                  ? noteCtrl.text.trim()
                                  : '$adjustmentType adjustment',
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                      },
                      child: const Text('Apply Stock Adjustment', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),

                  // Recent Movement History
                  if (item.history.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Audit & Movement History',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                    const SizedBox(height: 8),
                    ...item.history.take(3).map((hist) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hist.reason,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                            ),
                            Text(
                              '${hist.delta > 0 ? "+" : ""}${hist.delta} ${item.unit}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: hist.delta >= 0 ? const Color(0xFF2E6B48) : Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModeChip(
    String label,
    IconData icon,
    String currentMode,
    ValueChanged<String> onSelect,
  ) {
    final isSelected = currentMode == label;
    return Expanded(
      child: InkWell(
        onTap: () => onSelect(label),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : AppColors.primary),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
