import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/menu/data/datasources/menu_local_data_source.dart';
import 'package:cafe_os/features/menu/data/datasources/menu_remote_data_source.dart';
import 'package:cafe_os/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:cafe_os/features/menu/presentation/menu_screen.dart';

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
  testWidgets('MenuScreen renders catalog, search bar, and add dialog', (tester) async {
    final db = AppDatabase.memory(NativeDatabase.memory());
    addTearDown(db.close);

    final localDataSource = MenuLocalDataSourceImpl(db);
    final remoteDataSource = MockMenuRemoteDataSource();
    final repo = MenuRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      connectivityService: FakeConnectivityService(false),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          menuRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(
          home: MenuScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Menu Catalog'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Look for seeded items
    expect(find.text('Espresso Solo'), findsOneWidget);
    expect(find.text('Artisan Cappuccino'), findsOneWidget);
    expect(find.text('2 VARIANTS'), findsOneWidget);

    // Test search filter
    await tester.enterText(find.byType(TextField), 'Nitro');
    await tester.pumpAndSettle();

    expect(find.text('Nitro Cold Brew'), findsOneWidget);
    expect(find.text('Espresso Solo'), findsNothing);
  });
}
