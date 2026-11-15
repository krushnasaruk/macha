import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/permissions/permission_keys.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/values/money.dart';
import '../../menu/domain/models/menu_models.dart';
import '../data/repositories/menu_repository_impl.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  String? _selectedCategoryId;
  final _searchController = TextEditingController();
  bool _hasSeededDemoMenu = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _seedDemoMenuIfEmpty() async {
    final identity = ref.read(currentIdentityNotifier);
    final repo = ref.read(menuRepositoryProvider);
    final existingCategories = await repo.getCategories(identity.tenant.id);

    if (existingCategories.isEmpty && !_hasSeededDemoMenu) {
      _hasSeededDemoMenu = true;

      // Seed 3 Demo Categories
      await repo.saveCategory(
        id: 'cat_hot_01',
        tenantId: identity.tenant.id,
        name: 'Hot Coffee',
        slug: 'hot-coffee',
        sortOrder: 1,
      );
      await repo.saveCategory(
        id: 'cat_cold_02',
        tenantId: identity.tenant.id,
        name: 'Cold Brews & Iced',
        slug: 'cold-brews',
        sortOrder: 2,
      );
      await repo.saveCategory(
        id: 'cat_bakery_03',
        tenantId: identity.tenant.id,
        name: 'Bakery & Pastries',
        slug: 'bakery',
        sortOrder: 3,
      );

      // Seed Demo Products with Variants
      await repo.saveProduct(
        id: 'prod_espresso_01',
        tenantId: identity.tenant.id,
        categoryId: 'cat_hot_01',
        name: 'Espresso Solo',
        description: 'Single origin bold extraction',
        basePricePaise: 12000, // ₹ 120.00
      );

      await repo.saveProduct(
        id: 'prod_cappuccino_02',
        tenantId: identity.tenant.id,
        categoryId: 'cat_hot_01',
        name: 'Artisan Cappuccino',
        description: 'Velvety microfoam over double espresso',
        basePricePaise: 18000, // ₹ 180.00
        variants: [
          const ProductVariant(
            id: 'var_cap_reg',
            productId: 'prod_cappuccino_02',
            name: 'Regular (250ml)',
            priceDelta: Money.zero,
            sortOrder: 1,
          ),
          const ProductVariant(
            id: 'var_cap_lrg',
            productId: 'prod_cappuccino_02',
            name: 'Grande (350ml)',
            priceDelta: Money.fromRupees(40), // +₹40
            sortOrder: 2,
          ),
        ],
      );

      await repo.saveProduct(
        id: 'prod_coldbrew_03',
        tenantId: identity.tenant.id,
        categoryId: 'cat_cold_02',
        name: 'Nitro Cold Brew',
        description: 'Steeped for 18 hours and nitrogen infused',
        basePricePaise: 22000, // ₹ 220.00
      );

      await repo.saveProduct(
        id: 'prod_croissant_04',
        tenantId: identity.tenant.id,
        categoryId: 'cat_bakery_03',
        name: 'Almond Butter Croissant',
        description: 'Flaky French pastry baked fresh daily',
        basePricePaise: 19500, // ₹ 195.00
      );

      if (mounted) setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _seedDemoMenuIfEmpty();
  }

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final repo = ref.watch(menuRepositoryProvider);
    final canManageMenu = ref.watch(canPermissionProvider(AppPermissions.menuManage));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Catalog'),
        actions: [
          if (canManageMenu)
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded),
              tooltip: 'Add Product',
              onPressed: () => _showAddProductDialog(context),
            ),
        ],
      ),
      body: FutureBuilder<List<Category>>(
        future: repo.getCategories(identity.tenant.id),
        builder: (context, catSnapshot) {
          final categories = catSnapshot.data ?? [];

          return Column(
            children: [
              // Search & Filter Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: AppTextField(
                  hint: 'Search products by name...',
                  controller: _searchController,
                  prefixIcon: const Icon(Icons.search_rounded),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              // Category Filter Chips
              if (categories.isNotEmpty)
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: AppSpacing.horizontalLg,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final isAll = _selectedCategoryId == null;
                        return ChoiceChip(
                          label: const Text('All Items'),
                          selected: isAll,
                          onSelected: (_) => setState(() => _selectedCategoryId = null),
                        );
                      }
                      final cat = categories[index - 1];
                      final isSelected = _selectedCategoryId == cat.id;
                      return ChoiceChip(
                        label: Text(cat.name),
                        selected: isSelected,
                        onSelected: (val) => setState(() => _selectedCategoryId = val ? cat.id : null),
                      );
                    },
                  ),
                ),
              const Divider(height: 16),

              // Products List
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: repo.getProducts(
                    identity.tenant.id,
                    categoryId: _selectedCategoryId,
                    searchQuery: _searchController.text.trim(),
                  ),
                  builder: (context, prodSnapshot) {
                    if (prodSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final products = prodSnapshot.data ?? [];
                    if (products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.coffee_rounded, size: 48, color: Colors.grey),
                            const SizedBox(height: 8),
                            Text(
                              'No products found',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (canManageMenu) ...[
                              const SizedBox(height: 12),
                              AppButton(
                                label: 'Add First Product',
                                icon: Icons.add,
                                onPressed: () => _showAddProductDialog(context),
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: AppSpacing.paddingLg,
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return AppCard(
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: AppSpacing.roundedSm,
                                ),
                                child: const Icon(
                                  Icons.local_cafe_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        if (product.variants.isNotEmpty) ...[
                                          const SizedBox(width: 8),
                                          AppBadge(
                                            label: '${product.variants.length} VARIANTS',
                                            backgroundColor: Colors.blue.shade50,
                                            textColor: Colors.blue.shade700,
                                          ),
                                        ],
                                      ],
                                    ),
                                    if (product.description != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        product.description!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? AppColors.textSecondaryDark
                                              : AppColors.textSecondaryLight,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 6),
                                    CurrencyText(product.basePrice, fontSize: 15),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final identity = ref.read(currentIdentityNotifier);
    final repo = ref.read(menuRepositoryProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(label: 'Item Name', controller: nameCtrl, hint: 'e.g. Vanilla Cold Foam'),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Base Price (Rupees)',
              controller: priceCtrl,
              hint: 'e.g. 150',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            AppTextField(label: 'Description', controller: descCtrl, hint: 'Optional description'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              final price = Money.tryParse(priceCtrl.text.trim()) ?? const Money.fromRupees(100);
              if (name.isNotEmpty) {
                await repo.saveProduct(
                  id: 'prod_${DateTime.now().millisecondsSinceEpoch}',
                  tenantId: identity.tenant.id,
                  categoryId: _selectedCategoryId ?? 'cat_hot_01',
                  name: name,
                  description: descCtrl.text.trim(),
                  basePricePaise: price.paise,
                );
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                }
                if (mounted) {
                  setState(() {});
                }
              }
            },
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }
}
