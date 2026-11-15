import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

abstract class MenuLocalDataSource {
  Future<List<CategoriesTableData>> getCategories(String tenantId);
  Stream<List<CategoriesTableData>> watchCategories(String tenantId);
  Future<void> saveCategoryWithOutbox({
    required CategoriesTableCompanion category,
    required SyncOutboxTableCompanion outbox,
  });

  Future<List<ProductsTableData>> getProducts(String tenantId, {String? categoryId, String? searchQuery});
  Stream<List<ProductsTableData>> watchProducts(String tenantId, {String? categoryId});
  Future<ProductsTableData?> getProductById(String id);
  Future<List<ProductVariantsTableData>> getVariantsForProduct(String productId);
  Future<List<ModifierGroupsTableData>> getModifierGroupsForProduct(String productId);
  Future<List<ModifiersTableData>> getModifiersForGroup(String groupId);

  Future<void> saveProductWithOutbox({
    required ProductsTableCompanion product,
    required SyncOutboxTableCompanion outbox,
    List<ProductVariantsTableCompanion> variants = const [],
    List<String> modifierGroupIds = const [],
  });

  Future<ProductBranchAvailabilityTableData?> getBranchAvailability(String productId, String branchId);
  Future<void> setBranchAvailability({
    required ProductBranchAvailabilityTableCompanion availability,
    required SyncOutboxTableCompanion outbox,
  });
}

class MenuLocalDataSourceImpl implements MenuLocalDataSource {
  final AppDatabase _db;

  MenuLocalDataSourceImpl(this._db);

  @override
  Future<List<CategoriesTableData>> getCategories(String tenantId) {
    return (_db.select(_db.categoriesTable)
          ..where((t) => t.tenantId.equals(tenantId) & t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  @override
  Stream<List<CategoriesTableData>> watchCategories(String tenantId) {
    return (_db.select(_db.categoriesTable)
          ..where((t) => t.tenantId.equals(tenantId) & t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  @override
  Future<void> saveCategoryWithOutbox({
    required CategoriesTableCompanion category,
    required SyncOutboxTableCompanion outbox,
  }) {
    return _db.transaction(() async {
      await _db.into(_db.categoriesTable).insertOnConflictUpdate(category);
      await _db.into(_db.syncOutboxTable).insert(outbox);
    });
  }

  @override
  Future<List<ProductsTableData>> getProducts(String tenantId, {String? categoryId, String? searchQuery}) {
    final query = _db.select(_db.productsTable)
      ..where((t) => t.tenantId.equals(tenantId) & t.isArchived.equals(false));

    if (categoryId != null) {
      query.where((t) => t.categoryId.equals(categoryId));
    }
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      query.where((t) => t.name.like('%${searchQuery.trim()}%'));
    }

    return query.get();
  }

  @override
  Stream<List<ProductsTableData>> watchProducts(String tenantId, {String? categoryId}) {
    final query = _db.select(_db.productsTable)
      ..where((t) => t.tenantId.equals(tenantId) & t.isArchived.equals(false));

    if (categoryId != null) {
      query.where((t) => t.categoryId.equals(categoryId));
    }
    return query.watch();
  }

  @override
  Future<ProductsTableData?> getProductById(String id) {
    return (_db.select(_db.productsTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<List<ProductVariantsTableData>> getVariantsForProduct(String productId) {
    return (_db.select(_db.productVariantsTable)
          ..where((t) => t.productId.equals(productId) & t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  @override
  Future<List<ModifierGroupsTableData>> getModifierGroupsForProduct(String productId) async {
    final links = await (_db.select(_db.productModifierGroupsTable)
          ..where((t) => t.productId.equals(productId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();

    final groupIds = links.map((l) => l.modifierGroupId).toList();
    if (groupIds.isEmpty) return [];

    return (_db.select(_db.modifierGroupsTable)..where((t) => t.id.isIn(groupIds))).get();
  }

  @override
  Future<List<ModifiersTableData>> getModifiersForGroup(String groupId) {
    return (_db.select(_db.modifiersTable)
          ..where((t) => t.groupId.equals(groupId) & t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  @override
  Future<void> saveProductWithOutbox({
    required ProductsTableCompanion product,
    required SyncOutboxTableCompanion outbox,
    List<ProductVariantsTableCompanion> variants = const [],
    List<String> modifierGroupIds = const [],
  }) {
    return _db.transaction(() async {
      await _db.into(_db.productsTable).insertOnConflictUpdate(product);

      if (variants.isNotEmpty) {
        for (final variant in variants) {
          await _db.into(_db.productVariantsTable).insertOnConflictUpdate(variant);
        }
      }

      if (modifierGroupIds.isNotEmpty) {
        for (int i = 0; i < modifierGroupIds.length; i++) {
          await _db.into(_db.productModifierGroupsTable).insertOnConflictUpdate(
                ProductModifierGroupsTableCompanion.insert(
                  productId: product.id.value,
                  modifierGroupId: modifierGroupIds[i],
                  sortOrder: Value(i),
                ),
              );
        }
      }

      await _db.into(_db.syncOutboxTable).insert(outbox);
    });
  }

  @override
  Future<ProductBranchAvailabilityTableData?> getBranchAvailability(String productId, String branchId) {
    return (_db.select(_db.productBranchAvailabilityTable)
          ..where((t) => t.productId.equals(productId) & t.branchId.equals(branchId)))
        .getSingleOrNull();
  }

  @override
  Future<void> setBranchAvailability({
    required ProductBranchAvailabilityTableCompanion availability,
    required SyncOutboxTableCompanion outbox,
  }) {
    return _db.transaction(() async {
      await _db.into(_db.productBranchAvailabilityTable).insertOnConflictUpdate(availability);
      await _db.into(_db.syncOutboxTable).insert(outbox);
    });
  }
}
