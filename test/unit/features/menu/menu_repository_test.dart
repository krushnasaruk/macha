import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/menu/data/datasources/menu_local_data_source.dart';
import 'package:cafe_os/features/menu/data/datasources/menu_remote_data_source.dart';
import 'package:cafe_os/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:cafe_os/features/menu/domain/models/menu_models.dart';

class MockMenuRemoteDataSource implements MenuRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchCategories(String tenantId) async => [];

  @override
  Future<Map<String, dynamic>> upsertCategory(Map<String, dynamic> data) async => data;

  @override
  Future<List<Map<String, dynamic>>> fetchProducts(String tenantId) async => [];

  @override
  Future<Map<String, dynamic>> upsertProduct(Map<String, dynamic> data) async => data;
}

void main() {
  late AppDatabase db;
  late MenuLocalDataSource localDataSource;
  late MockMenuRemoteDataSource remoteDataSource;
  late MenuRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.memory(NativeDatabase.memory());
    localDataSource = MenuLocalDataSourceImpl(db);
    remoteDataSource = MockMenuRemoteDataSource();
    repository = MenuRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      connectivityService: FakeConnectivityService(false),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Menu Repository & Offline Persistence (T3.2 - T3.6)', () {
    test('saveCategory writes to Drift and enqueues outbox record', () async {
      await repository.saveCategory(
        id: 'cat_beverages',
        tenantId: 'tenant_demo_001',
        name: 'Beverages',
        slug: 'beverages',
        sortOrder: 1,
      );

      final categories = await repository.getCategories('tenant_demo_001');
      expect(categories.length, 1);
      expect(categories.first.name, 'Beverages');

      // Verify outbox
      final outboxItems = await db.select(db.syncOutboxTable).get();
      expect(outboxItems.any((o) => o.entityId == 'cat_beverages'), isTrue);
    });

    test('saveProduct with variants persists and reloads offline without network', () async {
      await repository.saveCategory(
        id: 'cat_coffee',
        tenantId: 'tenant_demo_001',
        name: 'Coffee',
        slug: 'coffee',
      );

      await repository.saveProduct(
        id: 'prod_latte',
        tenantId: 'tenant_demo_001',
        categoryId: 'cat_coffee',
        name: 'Cafe Latte',
        description: 'Smooth espresso with steamed milk',
        basePricePaise: 16000,
        variants: [
          const ProductVariant(
            id: 'var_latte_regular',
            productId: 'prod_latte',
            name: 'Regular',
            priceDelta: Money.zero,
          ),
          const ProductVariant(
            id: 'var_latte_large',
            productId: 'prod_latte',
            name: 'Large',
            priceDelta: Money.fromRupees(30),
          ),
        ],
      );

      // Verify immediate local read
      final product = await repository.getProduct('prod_latte');
      expect(product, isNotNull);
      expect(product!.name, 'Cafe Latte');
      expect(product.basePrice.paise, 16000);
      expect(product.variants.length, 2);
      expect(product.variants.last.priceDelta.paise, 3000);

      // Verify outbox
      final outboxItems = await db.select(db.syncOutboxTable).get();
      expect(outboxItems.any((o) => o.entityId == 'prod_latte'), isTrue);
    });

    test('branch availability can be toggled and retrieved offline', () async {
      await repository.setProductBranchAvailability(
        productId: 'prod_latte',
        branchId: 'branch_khd_01',
        isAvailable: false,
      );

      final isAvailable = await repository.isProductAvailableInBranch('prod_latte', 'branch_khd_01');
      expect(isAvailable, isFalse);

      final isAvailableOtherBranch = await repository.isProductAvailableInBranch('prod_latte', 'branch_kp_02');
      expect(isAvailableOtherBranch, isTrue); // defaults to true
    });
  });
}
