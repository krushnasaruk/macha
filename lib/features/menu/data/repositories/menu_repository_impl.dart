import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/values/money.dart';
import '../../domain/models/menu_models.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_local_data_source.dart';
import '../datasources/menu_remote_data_source.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuLocalDataSource _localDataSource;
  final MenuRemoteDataSource _remoteDataSource;
  final ConnectivityService _connectivityService;
  final Uuid _uuid;

  MenuRepositoryImpl({
    required MenuLocalDataSource localDataSource,
    required MenuRemoteDataSource remoteDataSource,
    required ConnectivityService connectivityService,
    Uuid? uuid,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _connectivityService = connectivityService,
        _uuid = uuid ?? const Uuid();

  @override
  Future<List<Category>> getCategories(String tenantId) async {
    final rows = await _localDataSource.getCategories(tenantId);
    return rows.map(_mapCategory).toList();
  }

  @override
  Stream<List<Category>> watchCategories(String tenantId) {
    return _localDataSource.watchCategories(tenantId).map(
          (rows) => rows.map(_mapCategory).toList(),
        );
  }

  @override
  Future<void> saveCategory({
    required String id,
    required String tenantId,
    required String name,
    required String slug,
    int sortOrder = 0,
    bool isArchived = false,
  }) async {
    final now = DateTime.now();
    final opUuid = _uuid.v4();

    final categoryCompanion = CategoriesTableCompanion.insert(
      id: id,
      tenantId: tenantId,
      name: name,
      slug: slug,
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      updatedAt: now,
    );

    final payloadJson = jsonEncode({
      'id': id,
      'tenant_id': tenantId,
      'name': name,
      'slug': slug,
      'sort_order': sortOrder,
      'is_archived': isArchived,
      'updated_at': now.toIso8601String(),
    });

    final outboxCompanion = SyncOutboxTableCompanion.insert(
      id: _uuid.v4(),
      tenantId: tenantId,
      branchId: '',
      operationUuid: opUuid,
      entityType: 'category',
      entityId: id,
      operation: 'UPSERT',
      payload: payloadJson,
      createdAt: now,
      status: const Value('pending'),
    );

    await _localDataSource.saveCategoryWithOutbox(
      category: categoryCompanion,
      outbox: outboxCompanion,
    );

    if (_connectivityService.isOnline) {
      try {
        await _remoteDataSource.upsertCategory(jsonDecode(payloadJson));
      } catch (_) {}
    }
  }

  @override
  Future<List<Product>> getProducts(String tenantId, {String? categoryId, String? searchQuery}) async {
    final productRows = await _localDataSource.getProducts(tenantId, categoryId: categoryId, searchQuery: searchQuery);
    final products = <Product>[];

    for (final row in productRows) {
      final variants = await _localDataSource.getVariantsForProduct(row.id);
      final groups = await _localDataSource.getModifierGroupsForProduct(row.id);
      final fullGroups = <ModifierGroup>[];

      for (final g in groups) {
        final mods = await _localDataSource.getModifiersForGroup(g.id);
        fullGroups.add(
          ModifierGroup(
            id: g.id,
            tenantId: g.tenantId,
            name: g.name,
            minSelection: g.minSelection,
            maxSelection: g.maxSelection,
            isMandatory: g.isMandatory,
            modifiers: mods.map(_mapModifier).toList(),
          ),
        );
      }

      products.add(
        Product(
          id: row.id,
          tenantId: row.tenantId,
          categoryId: row.categoryId,
          taxCategoryId: row.taxCategoryId,
          name: row.name,
          description: row.description,
          basePrice: Money.fromPaise(row.basePricePaise),
          imageUrl: row.imageUrl,
          isArchived: row.isArchived,
          variants: variants.map(_mapVariant).toList(),
          modifierGroups: fullGroups,
        ),
      );
    }

    return products;
  }

  @override
  Stream<List<Product>> watchProducts(String tenantId, {String? categoryId}) {
    return _localDataSource.watchProducts(tenantId, categoryId: categoryId).asyncMap(
      (rows) async {
        return getProducts(tenantId, categoryId: categoryId);
      },
    );
  }

  @override
  Future<Product?> getProduct(String id) async {
    final row = await _localDataSource.getProductById(id);
    if (row == null) return null;

    final variants = await _localDataSource.getVariantsForProduct(row.id);
    final groups = await _localDataSource.getModifierGroupsForProduct(row.id);
    final fullGroups = <ModifierGroup>[];

    for (final g in groups) {
      final mods = await _localDataSource.getModifiersForGroup(g.id);
      fullGroups.add(
        ModifierGroup(
          id: g.id,
          tenantId: g.tenantId,
          name: g.name,
          minSelection: g.minSelection,
          maxSelection: g.maxSelection,
          isMandatory: g.isMandatory,
          modifiers: mods.map(_mapModifier).toList(),
        ),
      );
    }

    return Product(
      id: row.id,
      tenantId: row.tenantId,
      categoryId: row.categoryId,
      taxCategoryId: row.taxCategoryId,
      name: row.name,
      description: row.description,
      basePrice: Money.fromPaise(row.basePricePaise),
      imageUrl: row.imageUrl,
      isArchived: row.isArchived,
      variants: variants.map(_mapVariant).toList(),
      modifierGroups: fullGroups,
    );
  }

  @override
  Future<void> saveProduct({
    required String id,
    required String tenantId,
    required String categoryId,
    String? taxCategoryId,
    required String name,
    String? description,
    required int basePricePaise,
    String? imageUrl,
    List<ProductVariant> variants = const [],
    List<String> modifierGroupIds = const [],
  }) async {
    final now = DateTime.now();
    final opUuid = _uuid.v4();

    final productCompanion = ProductsTableCompanion.insert(
      id: id,
      tenantId: tenantId,
      categoryId: categoryId,
      taxCategoryId: Value(taxCategoryId),
      name: name,
      description: Value(description),
      basePricePaise: basePricePaise,
      imageUrl: Value(imageUrl),
      isArchived: const Value(false),
      updatedAt: now,
    );

    final variantCompanions = variants.map((v) {
      return ProductVariantsTableCompanion.insert(
        id: v.id,
        productId: id,
        name: v.name,
        priceDeltaPaise: Value(v.priceDelta.paise),
        sku: Value(v.sku),
        sortOrder: Value(v.sortOrder),
        isActive: Value(v.isActive),
      );
    }).toList();

    final payloadJson = jsonEncode({
      'id': id,
      'tenant_id': tenantId,
      'category_id': categoryId,
      'tax_category_id': taxCategoryId,
      'name': name,
      'description': description,
      'base_price_paise': basePricePaise,
      'image_url': imageUrl,
      'updated_at': now.toIso8601String(),
    });

    final outboxCompanion = SyncOutboxTableCompanion.insert(
      id: _uuid.v4(),
      tenantId: tenantId,
      branchId: '',
      operationUuid: opUuid,
      entityType: 'product',
      entityId: id,
      operation: 'UPSERT',
      payload: payloadJson,
      createdAt: now,
      status: const Value('pending'),
    );

    await _localDataSource.saveProductWithOutbox(
      product: productCompanion,
      outbox: outboxCompanion,
      variants: variantCompanions,
      modifierGroupIds: modifierGroupIds,
    );

    if (_connectivityService.isOnline) {
      try {
        await _remoteDataSource.upsertProduct(jsonDecode(payloadJson));
      } catch (_) {}
    }
  }

  @override
  Future<bool> isProductAvailableInBranch(String productId, String branchId) async {
    final row = await _localDataSource.getBranchAvailability(productId, branchId);
    return row?.isAvailable ?? true; // Defaults to available if unconfigured
  }

  @override
  Future<void> setProductBranchAvailability({
    required String productId,
    required String branchId,
    required bool isAvailable,
    int? overridePricePaise,
  }) async {
    final now = DateTime.now();
    final companion = ProductBranchAvailabilityTableCompanion.insert(
      productId: productId,
      branchId: branchId,
      isAvailable: Value(isAvailable),
      overridePricePaise: Value(overridePricePaise),
    );

    final outbox = SyncOutboxTableCompanion.insert(
      id: _uuid.v4(),
      tenantId: '',
      branchId: branchId,
      operationUuid: _uuid.v4(),
      entityType: 'product_branch_availability',
      entityId: '${productId}_$branchId',
      operation: 'UPSERT',
      payload: jsonEncode({
        'product_id': productId,
        'branch_id': branchId,
        'is_available': isAvailable,
        'override_price_paise': overridePricePaise,
      }),
      createdAt: now,
      status: const Value('pending'),
    );

    await _localDataSource.setBranchAvailability(
      availability: companion,
      outbox: outbox,
    );
  }

  @override
  Future<void> syncMenu(String tenantId) async {
    if (!_connectivityService.isOnline) return;
    try {
      // Remote fetch will populate categories and products
    } catch (_) {}
  }

  Category _mapCategory(CategoriesTableData row) {
    return Category(
      id: row.id,
      tenantId: row.tenantId,
      name: row.name,
      slug: row.slug,
      sortOrder: row.sortOrder,
      isArchived: row.isArchived,
    );
  }

  ProductVariant _mapVariant(ProductVariantsTableData row) {
    return ProductVariant(
      id: row.id,
      productId: row.productId,
      name: row.name,
      priceDelta: Money.fromPaise(row.priceDeltaPaise),
      sku: row.sku,
      sortOrder: row.sortOrder,
      isActive: row.isActive,
    );
  }

  Modifier _mapModifier(ModifiersTableData row) {
    return Modifier(
      id: row.id,
      groupId: row.groupId,
      name: row.name,
      priceDelta: Money.fromPaise(row.priceDeltaPaise),
      sortOrder: row.sortOrder,
      isActive: row.isActive,
    );
  }
}

final menuLocalDataSourceProvider = Provider<MenuLocalDataSource>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return MenuLocalDataSourceImpl(db);
});

final menuRemoteDataSourceProvider = Provider<MenuRemoteDataSource>((ref) {
  return MenuRemoteDataSourceImpl();
});

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepositoryImpl(
    localDataSource: ref.watch(menuLocalDataSourceProvider),
    remoteDataSource: ref.watch(menuRemoteDataSourceProvider),
    connectivityService: ref.watch(connectivityServiceProvider),
  );
});
