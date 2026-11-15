import '../models/menu_models.dart';

abstract class MenuRepository {
  Future<List<Category>> getCategories(String tenantId);
  Stream<List<Category>> watchCategories(String tenantId);
  Future<void> saveCategory({
    required String id,
    required String tenantId,
    required String name,
    required String slug,
    int sortOrder = 0,
    bool isArchived = false,
  });

  Future<List<Product>> getProducts(String tenantId, {String? categoryId, String? searchQuery});
  Stream<List<Product>> watchProducts(String tenantId, {String? categoryId});
  Future<Product?> getProduct(String id);
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
  });

  Future<bool> isProductAvailableInBranch(String productId, String branchId);
  Future<void> setProductBranchAvailability({
    required String productId,
    required String branchId,
    required bool isAvailable,
    int? overridePricePaise,
  });

  Future<void> syncMenu(String tenantId);
}
