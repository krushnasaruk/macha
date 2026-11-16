import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/components/app_badge.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/currency_text.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/permissions/permission_keys.dart';
import '../../../core/services/image_storage_service.dart';
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

      // Seed Demo Products with Real Food Photos
      await repo.saveProduct(
        id: 'prod_espresso_01',
        tenantId: identity.tenant.id,
        categoryId: 'cat_hot_01',
        name: 'Espresso Solo',
        description: 'Single origin bold extraction with golden crema',
        basePricePaise: 12000, // ₹ 120.00
        imageUrl: 'assets/food/food_day_1_monday.png',
      );

      await repo.saveProduct(
        id: 'prod_cappuccino_02',
        tenantId: identity.tenant.id,
        categoryId: 'cat_hot_01',
        name: 'Artisan Cappuccino',
        description: 'Velvety microfoam over double espresso and dusted cocoa',
        basePricePaise: 18000, // ₹ 180.00
        imageUrl: 'assets/food/food_day_1_monday.png',
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
        description: 'Steeped for 18 hours, cold-pressed and nitrogen infused',
        basePricePaise: 22000, // ₹ 220.00
        imageUrl: 'assets/food/food_day_4_thursday.png',
      );

      await repo.saveProduct(
        id: 'prod_croissant_04',
        tenantId: identity.tenant.id,
        categoryId: 'cat_bakery_03',
        name: 'Almond Butter Croissant',
        description: 'Flaky artisanal French pastry glazed fresh daily',
        basePricePaise: 19500, // ₹ 195.00
        imageUrl: 'assets/food/food_day_7_sunday.png',
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
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Menu Catalog'),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.create_new_folder_outlined),
            tooltip: 'Add Category',
            onPressed: () => _showAddCategoryDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Add Product',
            onPressed: () => _showAddProductDialog(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.add_rounded, size: 22),
        label: const Text(
          'Add Menu Item',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
        onPressed: () => _showAddProductDialog(context),
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
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
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
                          selectedColor: AppColors.primary,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isAll ? Colors.white : AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isAll ? AppColors.primary : AppColors.borderLight,
                            ),
                          ),
                          onSelected: (_) => setState(() => _selectedCategoryId = null),
                        );
                      }
                      final cat = categories[index - 1];
                      final isSelected = _selectedCategoryId == cat.id;
                      return ChoiceChip(
                        label: Text(cat.name),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? AppColors.primary : AppColors.borderLight,
                          ),
                        ),
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
                            const Icon(Icons.coffee_rounded, size: 56, color: AppColors.textMutedLight),
                            const SizedBox(height: 12),
                            Text(
                              'No products found',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 14),
                            AppButton(
                              label: 'Add First Product',
                              icon: Icons.add,
                              onPressed: () => _showAddProductDialog(context),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: AppSpacing.paddingLg,
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return AppCard(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: canManageMenu
                                ? () => _showEditProductDialog(context, product, categories)
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Product Image Thumbnail
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF6EADB),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.borderLight,
                                        width: 1,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: ImageStorageService.buildProductImage(
                                      product.imageUrl,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: AppColors.primary,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (product.variants.isNotEmpty) ...[
                                              const SizedBox(width: 6),
                                              AppBadge(
                                                label: '${product.variants.length} VARIANTS',
                                                backgroundColor: AppColors.softLavender.withOpacity(0.25),
                                                textColor: AppColors.primary,
                                              ),
                                            ],
                                          ],
                                        ),
                                        if (product.description != null && product.description!.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            product.description!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondaryLight,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                        const SizedBox(height: 6),
                                        CurrencyText(
                                          product.basePrice,
                                          fontSize: 15,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (canManageMenu) ...[
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () => _showEditProductDialog(
                                        context,
                                        product,
                                        categories,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
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

  void _showAddCategoryDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final identity = ref.read(currentIdentityNotifier);
    final repo = ref.read(menuRepositoryProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Category', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
        content: AppTextField(
          label: 'Category Name',
          controller: nameCtrl,
          hint: 'e.g. Signature Teas',
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
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isNotEmpty) {
                final slug = name.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
                await repo.saveCategory(
                  id: 'cat_${DateTime.now().millisecondsSinceEpoch}',
                  tenantId: identity.tenant.id,
                  name: name,
                  slug: slug,
                  sortOrder: 10,
                );
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) setState(() {});
              }
            },
            child: const Text('Save Category'),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    _showProductFormModal(context, product: null);
  }

  void _showEditProductDialog(BuildContext context, Product product, List<Category> categories) {
    _showProductFormModal(context, product: product);
  }

  void _showProductFormModal(BuildContext context, {Product? product}) {
    final isEditing = product != null;
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final priceCtrl = TextEditingController(
      text: product != null ? (product.basePrice.paise / 100).toStringAsFixed(0) : '',
    );
    final descCtrl = TextEditingController(text: product?.description ?? '');
    String? selectedCategoryId = product?.categoryId ?? _selectedCategoryId ?? 'cat_hot_01';
    String? currentImageUrl = product?.imageUrl;
    XFile? newPickedImage;

    final identity = ref.read(currentIdentityNotifier);
    final repo = ref.read(menuRepositoryProvider);
    final imageService = ref.read(imageStorageServiceProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => StatefulBuilder(
        builder: (ctx, setModalState) {
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
                  // Modal Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEditing ? 'Edit Menu Item' : 'Add New Product',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Image Picker Section
                  const Text(
                    'Item Photograph',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6EADB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: newPickedImage != null
                            ? Image.file(
                                File(newPickedImage!.path),
                                fit: BoxFit.cover,
                              )
                            : ImageStorageService.buildProductImage(
                                currentImageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: const BorderSide(color: AppColors.primary),
                                  ),
                                  icon: const Icon(Icons.photo_library_outlined, size: 16, color: AppColors.primary),
                                  label: const Text(
                                    'Gallery',
                                    style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () async {
                                    final picked = await imageService.pickImage(source: ImageSource.gallery);
                                    if (picked != null) {
                                      setModalState(() {
                                        newPickedImage = picked;
                                      });
                                    }
                                  },
                                ),
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: const BorderSide(color: AppColors.primary),
                                  ),
                                  icon: const Icon(Icons.camera_alt_outlined, size: 16, color: AppColors.primary),
                                  label: const Text(
                                    'Camera',
                                    style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () async {
                                    final picked = await imageService.pickImage(source: ImageSource.camera);
                                    if (picked != null) {
                                      setModalState(() {
                                        newPickedImage = picked;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            if (newPickedImage != null || (currentImageUrl != null && currentImageUrl!.isNotEmpty)) ...[
                              const SizedBox(height: 4),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    newPickedImage = null;
                                    currentImageUrl = null;
                                  });
                                },
                                child: const Text(
                                  'Remove photo',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Category Selector Dropdown
                  FutureBuilder<List<Category>>(
                    future: repo.getCategories(identity.tenant.id),
                    builder: (context, snap) {
                      final cats = snap.data ?? [];
                      if (cats.isEmpty) return const SizedBox.shrink();

                      if (!cats.any((c) => c.id == selectedCategoryId)) {
                        selectedCategoryId = cats.first.id;
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
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
                                value: selectedCategoryId,
                                icon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primary),
                                items: cats.map((c) {
                                  return DropdownMenuItem<String>(
                                    value: c.id,
                                    child: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  if (newVal != null) {
                                    setModalState(() {
                                      selectedCategoryId = newVal;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      );
                    },
                  ),

                  // Name & Price Inputs
                  AppTextField(
                    label: 'Item Name',
                    controller: nameCtrl,
                    hint: 'e.g. Vanilla Cold Foam Cold Brew',
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Base Price (Rupees)',
                    controller: priceCtrl,
                    hint: 'e.g. 150',
                    prefixIcon: const Icon(Icons.currency_rupee_rounded, size: 18),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Description',
                    controller: descCtrl,
                    hint: 'Ingredient notes, bean origin, allergen info...',
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final name = nameCtrl.text.trim();
                        final price = Money.tryParse(priceCtrl.text.trim()) ?? const Money.fromRupees(100);
                        if (name.isNotEmpty) {
                          String? finalImageUrl = currentImageUrl;
                          if (newPickedImage != null) {
                            finalImageUrl = await imageService.saveProductImage(newPickedImage!);
                          }

                          final prodId = product?.id ?? 'prod_${DateTime.now().millisecondsSinceEpoch}';
                          await repo.saveProduct(
                            id: prodId,
                            tenantId: identity.tenant.id,
                            categoryId: selectedCategoryId ?? 'cat_hot_01',
                            name: name,
                            description: descCtrl.text.trim(),
                            basePricePaise: price.paise,
                            imageUrl: finalImageUrl,
                            variants: product?.variants ?? const [],
                          );

                          if (ctx.mounted) Navigator.pop(ctx);
                          if (mounted) setState(() {});
                        }
                      },
                      child: Text(
                        isEditing ? 'Save Changes' : 'Add Product to Menu',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
