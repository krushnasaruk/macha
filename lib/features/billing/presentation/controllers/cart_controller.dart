import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';
import 'package:cafe_os/features/billing/domain/pricing/pricing_engine.dart';
import 'package:cafe_os/features/billing/domain/repositories/billing_repository.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, CartState>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final repo = ref.watch(billingRepositoryProvider);
  return CartController(db, repo);
});

class CartController extends StateNotifier<CartState> {
  final AppDatabase _db;
  final BillingRepository _billingRepo;
  static const _activeCartKey = 'active_pos_cart';

  CartController(this._db, this._billingRepo) : super(const CartState()) {
    _restoreCart();
  }

  Future<void> _restoreCart() async {
    try {
      final config = await (_db.select(_db.appConfigTable)
            ..where((tbl) => tbl.configKey.equals(_activeCartKey)))
          .getSingleOrNull();

      if (config != null && config.configValue.isNotEmpty) {
        state = CartState.fromJsonString(config.configValue);
      }
    } catch (_) {
      // Ignore restore failure and keep blank cart
    }
  }

  Future<void> _persistCart(CartState newState) async {
    try {
      await _db.into(_db.appConfigTable).insertOnConflictUpdate(
            AppConfigTableCompanion.insert(
              configKey: _activeCartKey,
              configValue: newState.toJsonString(),
              updatedAt: DateTime.now(),
            ),
          );
    } catch (_) {
      // Ignore persistence failures
    }
  }

  void _updateState(CartState newState) {
    state = newState;
    _persistCart(newState);
  }

  /// Adds a product to cart. If already present with same variant/modifiers, increments quantity.
  void addProduct({
    required String productId,
    required String productName,
    String? variantId,
    String? variantName,
    required Money unitPrice,
    int taxRateBps = 500,
    bool isTaxInclusive = false,
    List<SelectedModifier> selectedModifiers = const [],
    String? notes,
  }) {
    // Check for existing matching item
    final existingIndex = state.items.indexWhere((item) =>
        item.productId == productId &&
        item.variantId == variantId &&
        _modifiersMatch(item.selectedModifiers, selectedModifiers));

    if (existingIndex >= 0) {
      final existing = state.items[existingIndex];
      final updated = existing.copyWith(quantity: existing.quantity + 1);
      final newItems = List<CartItem>.from(state.items);
      newItems[existingIndex] = updated;
      _updateState(state.copyWith(items: newItems));
    } else {
      final newItem = CartItem(
        id: 'line_${DateTime.now().microsecondsSinceEpoch}',
        productId: productId,
        productName: productName,
        variantId: variantId,
        variantName: variantName,
        unitPrice: unitPrice,
        quantity: 1,
        taxRateBps: taxRateBps,
        isTaxInclusive: isTaxInclusive,
        selectedModifiers: selectedModifiers,
        notes: notes,
      );
      _updateState(state.copyWith(items: [...state.items, newItem]));
    }
  }

  void incrementQuantity(String lineId) {
    final idx = state.items.indexWhere((i) => i.id == lineId);
    if (idx < 0) return;

    final existing = state.items[idx];
    final updated = existing.copyWith(quantity: existing.quantity + 1);
    final newItems = List<CartItem>.from(state.items);
    newItems[idx] = updated;
    _updateState(state.copyWith(items: newItems));
  }

  void decrementQuantity(String lineId) {
    final idx = state.items.indexWhere((i) => i.id == lineId);
    if (idx < 0) return;

    final existing = state.items[idx];
    final newItems = List<CartItem>.from(state.items);

    if (existing.quantity > 1) {
      newItems[idx] = existing.copyWith(quantity: existing.quantity - 1);
    } else {
      newItems.removeAt(idx);
    }
    _updateState(state.copyWith(items: newItems));
  }

  void removeItem(String lineId) {
    final newItems = state.items.where((i) => i.id != lineId).toList();
    _updateState(state.copyWith(items: newItems));
  }

  void setItemDiscount(String lineId, LineDiscount discount) {
    final idx = state.items.indexWhere((i) => i.id == lineId);
    if (idx < 0) return;

    final newItems = List<CartItem>.from(state.items);
    newItems[idx] = newItems[idx].copyWith(discount: discount);
    _updateState(state.copyWith(items: newItems));
  }

  void setCartDiscount(CartDiscount discount) {
    _updateState(state.copyWith(cartDiscount: discount));
  }

  void setOrderType(OrderType orderType) {
    _updateState(state.copyWith(orderType: orderType));
  }

  void setTable(String? tableId) {
    _updateState(state.copyWith(tableId: tableId));
  }

  void setCustomer({String? name, String? phone}) {
    _updateState(
      state.copyWith(
        customerName: name ?? state.customerName,
        customerPhone: phone ?? state.customerPhone,
      ),
    );
  }

  void clearCart() {
    _updateState(const CartState());
  }

  Future<void> holdCart(String label) async {
    if (state.isEmpty) return;
    await _billingRepo.holdCart(label: label, cart: state);
    clearCart();
  }

  Future<void> resumeCart(String holdId, String cartJson) async {
    final restored = CartState.fromJsonString(cartJson);
    await _billingRepo.removeHeldCart(holdId);
    _updateState(restored);
  }

  bool _modifiersMatch(
    List<SelectedModifier> a,
    List<SelectedModifier> b,
  ) {
    if (a.length != b.length) return false;
    final idsA = a.map((e) => e.id).toSet();
    final idsB = b.map((e) => e.id).toSet();
    return idsA.containsAll(idsB);
  }
}
