import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cafe_os/core/components/app_button.dart';
import 'package:cafe_os/core/components/currency_text.dart';
import 'package:cafe_os/core/components/floating_cart_bar.dart';
import 'package:cafe_os/core/components/pill_filter_chip.dart';
import 'package:cafe_os/core/services/image_storage_service.dart';
import 'package:cafe_os/core/theme/app_colors.dart';
import 'package:cafe_os/core/theme/app_spacing.dart';
import 'package:cafe_os/core/theme/app_typography.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';
import 'package:cafe_os/features/billing/presentation/cash_drawer_sheet.dart';
import 'package:cafe_os/features/billing/presentation/checkout_screen.dart';
import 'package:cafe_os/features/billing/presentation/controllers/cart_controller.dart';
import 'package:cafe_os/features/billing/presentation/discount_dialog.dart';
import 'package:cafe_os/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:cafe_os/features/menu/domain/models/menu_models.dart';

final posHeldCartsProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.watch(billingRepositoryProvider);
  return repo.getHeldCarts();
});

class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});

  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen> {
  String? _selectedCategoryId;
  String _searchQuery = '';
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(menuCategoriesProvider);
    final productsAsync = ref.watch(menuProductsProvider);
    final cart = ref.watch(cartControllerProvider);
    final heldCartsAsync = ref.watch(posHeldCartsProvider);

    final isTabletLandscape =
        MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('MΛCHA POS'),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontSize: 20,
          letterSpacing: 0.5,
        ),
        actions: [
          // QR Scanner Icon (Reference Design)
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            tooltip: 'Scan QR Code',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('QR Scanner ready for item / customer scan'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          // Order Type Selector
          PopupMenuButton<OrderType>(
            initialValue: cart.orderType,
            tooltip: 'Order Type',
            onSelected: (type) {
              ref.read(cartControllerProvider.notifier).setOrderType(type);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: OrderType.dineIn,
                child: Row(
                  children: [
                    Icon(Icons.restaurant_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Dine-In'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: OrderType.takeaway,
                child: Row(
                  children: [
                    Icon(Icons.takeout_dining_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Takeaway'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: OrderType.delivery,
                child: Row(
                  children: [
                    Icon(Icons.delivery_dining_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Delivery'),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Chip(
                avatar: Icon(
                  cart.orderType == OrderType.dineIn
                      ? Icons.restaurant_rounded
                      : (cart.orderType == OrderType.takeaway
                          ? Icons.takeout_dining_rounded
                          : Icons.delivery_dining_rounded),
                  size: 16,
                ),
                label: Text(cart.orderType.label),
              ),
            ),
          ),
          // Cash Drawer Button
          IconButton(
            icon: const Icon(Icons.point_of_sale_rounded),
            tooltip: 'Cash Drawer',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const CashDrawerSheet(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: isTabletLandscape
            ? Row(
                children: [
                  // Left Pane: Catalog
                  Expanded(
                    flex: 6,
                    child: _buildCatalogSection(
                      categoriesAsync: categoriesAsync,
                      productsAsync: productsAsync,
                      cart: cart,
                      heldCartsAsync: heldCartsAsync,
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  // Right Pane: Persistent Cart
                  Expanded(
                    flex: 4,
                    child: _buildCartPane(cart),
                  ),
                ],
              )
            : Column(
                children: [
                  // Phone Catalog
                  Expanded(
                    child: _buildCatalogSection(
                      categoriesAsync: categoriesAsync,
                      productsAsync: productsAsync,
                      cart: cart,
                      heldCartsAsync: heldCartsAsync,
                    ),
                  ),
                  // Bottom Cart Bar (Phone)
                  if (cart.isNotEmpty) _buildPhoneBottomCartBar(cart),
                ],
              ),
      ),
    );
  }

  Widget _buildCatalogSection({
    required AsyncValue<List<Category>> categoriesAsync,
    required AsyncValue<List<Product>> productsAsync,
    required CartState cart,
    required AsyncValue<List<Map<String, dynamic>>> heldCartsAsync,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Held Carts Strip (if any)
        heldCartsAsync.when(
          data: (held) {
            if (held.isEmpty) return const SizedBox.shrink();
            return Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              color: AppColors.warning.withOpacity(0.12),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8, top: 6),
                    child: Icon(Icons.pause_circle_outline_rounded,
                        size: 20, color: AppColors.warning),
                  ),
                  ...held.map((h) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        label: Text('Resume: ${h['label']}'),
                        onPressed: () {
                          ref.read(cartControllerProvider.notifier).resumeCart(
                                h['id'] as String,
                                h['cartJson'] as String,
                              );
                          ref.invalidate(posHeldCartsProvider);
                        },
                      ),
                    );
                  }),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        // Search Bar (Pill shape)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.borderLight, width: 1),
            ),
            child: TextField(
              controller: _searchCtrl,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'Search menu...',
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

        // Category Chips (Using PillFilterChip)
        categoriesAsync.when(
          data: (cats) {
            if (cats.isEmpty) return const SizedBox.shrink();
            final allCats = [
              const Category(
                id: 'ALL',
                tenantId: '',
                name: 'All Items',
                slug: 'all',
              ),
              ...cats,
            ];
            return SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                scrollDirection: Axis.horizontal,
                itemCount: allCats.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, idx) {
                  final cat = allCats[idx];
                  final isSelected = (_selectedCategoryId == null &&
                          cat.id == 'ALL') ||
                      (_selectedCategoryId == cat.id);

                  return PillFilterChip(
                    label: cat.name,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedCategoryId =
                            cat.id == 'ALL' ? null : cat.id;
                      });
                    },
                  );
                },
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        // Product Grid
        Expanded(
          child: productsAsync.when(
            data: (products) {
              final filtered = products.where((p) {
                if (_selectedCategoryId != null &&
                    p.categoryId != _selectedCategoryId) {
                  return false;
                }
                if (_searchQuery.isNotEmpty &&
                    !p.name
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase())) {
                  return false;
                }
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return const Center(
                  child: Text(
                    'No products match search criteria',
                    style: TextStyle(color: AppColors.textSecondaryLight),
                  ),
                );
              }

              final isPhone = MediaQuery.of(context).size.width < 900;
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                gridDelegate: isPhone
                    ? const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.80,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      )
                    : const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 220,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final prod = filtered[index];
                  // Check quantity in cart
                  final inCartCount = cart.items
                      .where((item) => item.productId == prod.id)
                      .fold(0, (sum, i) => sum + i.quantity);

                  return _buildProductTile(prod, inCartCount);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }

  Widget _buildProductTile(Product prod, int inCartCount) {
    final asset = _productAsset(prod.name);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDE2D6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => _handleProductTap(prod),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Drink Illustration Container (prominent, filling top of card)
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Food/Drink Illustration or Real Photograph
                      Center(
                        child: prod.imageUrl != null && prod.imageUrl!.isNotEmpty
                            ? ImageStorageService.buildProductImage(
                                prod.imageUrl,
                                width: 105,
                                height: 105,
                                fit: BoxFit.contain,
                                borderRadius: BorderRadius.circular(16),
                              )
                            : Image.asset(
                                asset,
                                fit: BoxFit.contain,
                                width: 105,
                                height: 105,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.coffee_rounded,
                                  size: 48,
                                  color: AppColors.primary,
                                ),
                              ),
                      ),
                      if (inCartCount > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$inCartCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                // Product Name + Price on left, circular '+' button on right
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            prod.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: AppColors.primary,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          CurrencyText(
                            prod.basePrice,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (inCartCount > 0 && prod.variants.isEmpty && prod.modifierGroups.isEmpty)
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () => _decrementProduct(prod),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                child: Icon(Icons.remove_rounded, size: 16, color: AppColors.primary),
                              ),
                            ),
                            Text(
                              '$inCartCount',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppColors.primary,
                              ),
                            ),
                            InkWell(
                              onTap: () => _handleProductTap(prod),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                child: Icon(Icons.add_rounded, size: 16, color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      InkWell(
                        onTap: () => _handleProductTap(prod),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _decrementProduct(Product prod) {
    final cart = ref.read(cartControllerProvider);
    final match = cart.items.where((item) => item.productId == prod.id).toList();
    if (match.isNotEmpty) {
      ref.read(cartControllerProvider.notifier).decrementQuantity(match.first.id);
    }
  }

  String _productAsset(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('cappuccino')) return 'assets/menu/cappuccino.png';
    if (lower.contains('mocha')) return 'assets/menu/mocha.png';
    if (lower.contains('americano')) return 'assets/menu/americano.png';
    if (lower.contains('iced') || lower.contains('cold brew')) return 'assets/menu/iced_latte.png';
    if (lower.contains('cold')) return 'assets/menu/cold_coffee.png';
    return 'assets/menu/latte.png';
  }

  CartState cartControllerRef(WidgetRef r) => r.read(cartControllerProvider);

  void _handleProductTap(Product prod) {
    if (prod.variants.isNotEmpty || prod.modifierGroups.isNotEmpty) {
      _showCustomizationSheet(prod);
    } else {
      ref.read(cartControllerProvider.notifier).addProduct(
            productId: prod.id,
            productName: prod.name,
            unitPrice: prod.basePrice,
          );
    }
  }

  void _showCustomizationSheet(Product prod) {
    ProductVariant? selectedVariant =
        prod.variants.isNotEmpty ? prod.variants.first : null;
    final selectedModifiers = <Modifier>{};

    // Pre-select mandatory defaults
    for (final grp in prod.modifierGroups) {
      if (grp.isMandatory && grp.modifiers.isNotEmpty) {
        selectedModifiers.add(grp.modifiers.first);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
          final runningPrice = prod.computeEffectivePrice(
            variant: selectedVariant,
            selectedModifiers: selectedModifiers.toList(),
          );

          return SafeArea(
            child: Padding(
              padding: AppSpacing.paddingLg,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prod.name,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Variants
                  if (prod.variants.isNotEmpty) ...[
                    Text('Choose Size / Variant',
                        style: AppTypography.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: prod.variants.map((v) {
                        final isSel = selectedVariant?.id == v.id;
                        return ChoiceChip(
                          label: Text(
                              '${v.name} (+${v.priceDelta.format()})'),
                          selected: isSel,
                          onSelected: (val) {
                            if (val) setSheetState(() => selectedVariant = v);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Modifiers
                  ...prod.modifierGroups.map((grp) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${grp.name} ${grp.isMandatory ? "(Required)" : ""}',
                          style: AppTypography.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: grp.modifiers.map((m) {
                            final isSel =
                                selectedModifiers.any((sel) => sel.id == m.id);
                            return FilterChip(
                              label: Text(
                                  '${m.name} (+${m.priceDelta.format()})'),
                              selected: isSel,
                              onSelected: (val) {
                                setSheetState(() {
                                  if (val) {
                                    if (grp.maxSelection == 1) {
                                      selectedModifiers.removeWhere(
                                          (mod) => mod.groupId == grp.id);
                                    }
                                    selectedModifiers.add(m);
                                  } else {
                                    selectedModifiers.removeWhere(
                                        (mod) => mod.id == m.id);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }),

                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Add to Cart · ${runningPrice.format()}',
                    onPressed: () {
                      final mods = selectedModifiers
                          .map((m) => SelectedModifier(
                                id: m.id,
                                name: m.name,
                                priceDelta: m.priceDelta,
                              ))
                          .toList();

                      ref.read(cartControllerProvider.notifier).addProduct(
                            productId: prod.id,
                            productName: prod.name,
                            variantId: selectedVariant?.id,
                            variantName: selectedVariant?.name,
                            unitPrice: runningPrice,
                            selectedModifiers: mods,
                          );
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartPane(CartState cart) {
    final calc = cart.calculation;

    return Container(
      color: Colors.white,
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Sale (${cart.totalItemCount})',
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.pause_circle_outline_rounded),
                    tooltip: 'Hold Cart',
                    onPressed: cart.isEmpty
                        ? null
                        : () async {
                            await ref
                                .read(cartControllerProvider.notifier)
                                .holdCart(
                                  'Hold ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                                );
                            ref.invalidate(posHeldCartsProvider);
                          },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_sweep_rounded),
                    tooltip: 'Clear Cart',
                    onPressed: cart.isEmpty
                        ? null
                        : () => ref
                            .read(cartControllerProvider.notifier)
                            .clearCart(),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 12),

          // Line Items
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text(
                      'Cart is empty.\nTap items to start a sale.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondaryLight),
                    ),
                  )
                : ListView.separated(
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, idx) {
                      final item = cart.items[idx];
                      final asset = _productAsset(item.productName);
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.warmCream,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.borderLight, width: 0.8),
                        ),
                        child: Row(
                          children: [
                            // Thumbnail
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                asset,
                                width: 42,
                                height: 42,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.coffee_rounded,
                                  size: 26,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.primary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (item.variantName != null) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      item.variantName!,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondaryLight,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                  if (item.selectedModifiers.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      item.selectedModifiers.map((m) => m.name).join(', '),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.matchaGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 3),
                                  CurrencyText(
                                    item.unitPrice,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Stepper
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.borderLight),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      ref.read(cartControllerProvider.notifier).decrementQuantity(item.id);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      child: Icon(Icons.remove_rounded, size: 16, color: AppColors.primary),
                                    ),
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      ref.read(cartControllerProvider.notifier).incrementQuantity(item.id);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      child: Icon(Icons.add_rounded, size: 16, color: AppColors.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Line Total
                            SizedBox(
                              width: 58,
                              child: CurrencyText(
                                item.unitPrice * item.quantity,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          const Divider(height: 16),

          // Cart Totals & Discount Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: AppTypography.bodySmall),
              CurrencyText(calc.grossSubtotal, style: AppTypography.bodySmall),
            ],
          ),
          if (calc.totalDiscounts.isPositive) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.success)),
                CurrencyText(-calc.totalDiscounts,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.success)),
              ],
            ),
          ],
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax (GST)', style: AppTypography.bodySmall),
              CurrencyText(calc.totalTax, style: AppTypography.bodySmall),
            ],
          ),
          if (calc.roundingDelta.paise != 0) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Round-off', style: AppTypography.bodySmall),
                CurrencyText(calc.roundingDelta,
                    style: AppTypography.bodySmall),
              ],
            ),
          ],
          const SizedBox(height: 8),

          // Total & Charge Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.discount_outlined, size: 18),
                label: const Text('Discount'),
                onPressed: cart.isEmpty
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (_) => DiscountDialog(
                            currentSubtotal: calc.grossSubtotal,
                          ),
                        );
                      },
              ),
              CurrencyText(
                calc.finalPayable,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppButton(
            label: 'Charge · ${calc.finalPayable.format()}',
            icon: Icons.payment_rounded,
            onPressed: cart.isEmpty
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneBottomCartBar(CartState cart) {
    final calc = cart.calculation;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: FloatingCartBar(
        itemCount: cart.totalItemCount,
        totalAmount: calc.finalPayable,
        onViewCart: () {
          _showPhoneCartSheet(cart);
        },
      ),
    );
  }

  void _showPhoneCartSheet(CartState cart) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.80,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollController) {
          return Column(
            children: [
              // Grab handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 6),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    final liveCart = ref.watch(cartControllerProvider);
                    return _buildCartPane(liveCart);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
