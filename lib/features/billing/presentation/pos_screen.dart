import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cafe_os/core/components/app_button.dart';
import 'package:cafe_os/core/components/app_card.dart';
import 'package:cafe_os/core/components/currency_text.dart';
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
        title: const Text('CaféOS POS'),
        actions: [
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

        // Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Search menu by name…',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        setState(() {
                          _searchCtrl.clear();
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: const OutlineInputBorder(
                borderRadius: AppSpacing.roundedMd,
              ),
            ),
            onChanged: (val) => setState(() => _searchQuery = val.trim()),
          ),
        ),

        // Category Chips
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

                  return FilterChip(
                    label: Text(cat.name),
                    selected: isSelected,
                    onSelected: (_) {
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

              return GridView.builder(
                padding: AppSpacing.paddingMd,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  mainAxisExtent: 155,
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
    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: () {
        // Tap budget: 1 tap adds directly if no mandatory choices
        _handleProductTap(prod);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  prod.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (inCartCount > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: AppSpacing.roundedSm,
                  ),
                  child: Text(
                    '$inCartCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CurrencyText(
                prod.basePrice,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              if (inCartCount == 0)
                IconButton.filledTonal(
                  icon: const Icon(Icons.add_rounded, size: 20),
                  onPressed: () => _handleProductTap(prod),
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      icon: const Icon(Icons.remove_rounded, size: 16),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        final line = cartControllerRef(ref)
                            .items
                            .lastWhere((i) => i.productId == prod.id);
                        ref
                            .read(cartControllerProvider.notifier)
                            .decrementQuantity(line.id);
                      },
                    ),
                    const SizedBox(width: 4),
                    IconButton.filledTonal(
                      icon: const Icon(Icons.add_rounded, size: 16),
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _handleProductTap(prod),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
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
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, idx) {
                      final item = cart.items[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productName,
                                    style: AppTypography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (item.variantName != null)
                                    Text(item.variantName!,
                                        style: AppTypography.labelSmall),
                                  CurrencyText(item.unitPrice,
                                      style: AppTypography.labelSmall),
                                ],
                              ),
                            ),
                            // Stepper
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline,
                                      size: 20),
                                  onPressed: () => ref
                                      .read(cartControllerProvider.notifier)
                                      .decrementQuantity(item.id),
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: AppTypography.titleSmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline,
                                      size: 20),
                                  onPressed: () => ref
                                      .read(cartControllerProvider.notifier)
                                      .incrementQuantity(item.id),
                                ),
                              ],
                            ),
                            // Line Total
                            Expanded(
                              flex: 2,
                              child: CurrencyText(
                                item.unitPrice * item.quantity,
                                textAlign: TextAlign.right,
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${cart.totalItemCount} items',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              CurrencyText(
                calc.finalPayable,
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              label: 'View Cart & Charge',
              icon: Icons.shopping_bag_rounded,
              onPressed: () {
                _showPhoneCartSheet(cart);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPhoneCartSheet(CartState cart) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scrollController) {
          return Consumer(
            builder: (context, ref, _) {
              final liveCart = ref.watch(cartControllerProvider);
              return _buildCartPane(liveCart);
            },
          );
        },
      ),
    );
  }
}
