import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/features/kitchen/data/datasources/kitchen_local_data_source.dart';
import 'package:cafe_os/features/kitchen/data/repositories/kitchen_repository_impl.dart';
import 'package:cafe_os/features/kitchen/domain/services/kitchen_alert_service.dart';
import 'package:cafe_os/features/kitchen/domain/services/kitchen_realtime_service.dart';
import 'package:cafe_os/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:cafe_os/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:cafe_os/features/orders/domain/models/order_and_table_models.dart';
import 'package:cafe_os/features/orders/domain/state_machine/order_lifecycle.dart';

class FakeConnectivityService implements ConnectivityService {
  final bool _isOnline = true;
  @override
  bool get isOnline => _isOnline;
  @override
  Stream<bool> get onConnectivityChanged => Stream.value(_isOnline);
  @override
  void dispose() {}
}

void main() {
  late AppDatabase db;
  late KitchenLocalDataSource kitchenLocal;
  late OrdersLocalDataSource ordersLocal;
  late OrdersRepositoryImpl ordersRepo;
  late KitchenRepositoryImpl kitchenRepo;

  setUp(() async {
    db = AppDatabase.memory(NativeDatabase.memory());
    kitchenLocal = KitchenLocalDataSource(db);
    ordersLocal = OrdersLocalDataSource(db);
    ordersRepo = OrdersRepositoryImpl(db: db, localDataSource: ordersLocal);
    kitchenRepo = KitchenRepositoryImpl(localDataSource: kitchenLocal, ordersRepository: ordersRepo);

    // Seed tenant and branch
    await db.into(db.tenantsTable).insert(
          TenantsTableCompanion.insert(
            id: 't_demo',
            name: 'Demo Café',
            slug: 'demo-cafe',
            updatedAt: DateTime.now(),
          ),
        );
    await db.into(db.branchesTable).insert(
          BranchesTableCompanion.insert(
            id: 'b_main',
            tenantId: 't_demo',
            name: 'Main Branch',
            code: 'MAIN',
            updatedAt: DateTime.now(),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  group('Kitchen Ticket Model & Aging Logic (T5.5)', () {
    test('Ticket aging classifies normal, warning (>=10m) and delayed (>=15m)', () {
      final now = DateTime.now();

      final normalTicket = KitchenTicket(
        orderId: 'o1',
        orderNumber: '1001',
        orderType: 'dine_in',
        status: OrderLifecycleStatus.confirmed,
        createdAt: now.subtract(const Duration(minutes: 4)),
        items: const [],
      );
      expect(normalTicket.isWarning, isFalse);
      expect(normalTicket.isDelayed, isFalse);

      final warningTicket = KitchenTicket(
        orderId: 'o2',
        orderNumber: '1002',
        orderType: 'dine_in',
        status: OrderLifecycleStatus.confirmed,
        createdAt: now.subtract(const Duration(minutes: 11)),
        items: const [],
      );
      expect(warningTicket.isWarning, isTrue);
      expect(warningTicket.isDelayed, isFalse);

      final delayedTicket = KitchenTicket(
        orderId: 'o3',
        orderNumber: '1003',
        orderType: 'dine_in',
        status: OrderLifecycleStatus.confirmed,
        createdAt: now.subtract(const Duration(minutes: 17)),
        items: const [],
      );
      expect(delayedTicket.isWarning, isFalse);
      expect(delayedTicket.isDelayed, isTrue);
    });
  });

  group('Kitchen Ticket Bump & Status Transitions (T5.5 & Milestone M2)', () {
    test('bumpTicket advances confirmed order to preparing and ready', () async {
      // Insert order in 'confirmed' status
      await db.into(db.ordersTable).insert(
            OrdersTableCompanion.insert(
              id: 'ord_kds_1',
              tenantId: 't_demo',
              branchId: 'b_main',
              orderNumber: 'KDS-01',
              status: const Value('confirmed'),
              createdBy: 'Cashier',
            ),
          );

      // Bump to Preparing
      await kitchenRepo.bumpTicket(
        orderId: 'ord_kds_1',
        targetStatus: OrderLifecycleStatus.preparing,
        changedBy: 'Chef Marco',
      );

      var order = await ordersLocal.getOrderById('ord_kds_1');
      expect(order?.status, 'preparing');

      // Bump to Ready
      await kitchenRepo.bumpTicket(
        orderId: 'ord_kds_1',
        targetStatus: OrderLifecycleStatus.ready,
        changedBy: 'Chef Marco',
      );

      order = await ordersLocal.getOrderById('ord_kds_1');
      expect(order?.status, 'ready');

      // Recall back to Preparing
      await kitchenRepo.recallTicket(
        orderId: 'ord_kds_1',
        previousStatus: OrderLifecycleStatus.preparing,
        changedBy: 'Chef Marco',
      );

      order = await ordersLocal.getOrderById('ord_kds_1');
      expect(order?.status, 'preparing');
    });

    test('toggleItemReady updates individual item ready state', () async {
      await db.into(db.ordersTable).insert(
            OrdersTableCompanion.insert(
              id: 'ord_items_test',
              tenantId: 't_demo',
              branchId: 'b_main',
              orderNumber: 'KDS-02',
              createdBy: 'Cashier',
            ),
          );

      await db.into(db.orderItemsTable).insert(
            OrderItemsTableCompanion.insert(
              id: 'item_1',
              orderId: 'ord_items_test',
              tenantId: 't_demo',
              productId: 'prod_latte',
              productName: 'Caffè Latte',
              unitPricePaise: 18000,
              subtotalPaise: 18000,
              taxablePaise: 18000,
              lineTotalPaise: 18000,
              status: const Value('preparing'),
            ),
          );

      await kitchenRepo.toggleItemReady(orderItemId: 'item_1', isReady: true);

      final items = await kitchenLocal.getOrderItems('ord_items_test');
      expect(items.first.status, 'ready');

      await kitchenRepo.toggleItemReady(orderItemId: 'item_1', isReady: false);
      final itemsAfter = await kitchenLocal.getOrderItems('ord_items_test');
      expect(itemsAfter.first.status, 'preparing');
    });
  });

  group('Kitchen Realtime Service & Duplicate Suppression (T5.6)', () {
    test('Suppresses duplicate events with identical eventId', () {
      final connectivity = FakeConnectivityService();
      final alertNotifier = KitchenAlertNotifier();

      final service = KitchenRealtimeService(
        connectivity: connectivity,
        alertNotifier: alertNotifier,
      );

      final firstCall = service.handleRealtimeEvent(
        eventId: 'evt_1001',
        eventType: 'order_created',
        payload: {'order_id': 'ord_1'},
      );
      expect(firstCall, isTrue, reason: 'First event should be processed');

      final duplicateCall = service.handleRealtimeEvent(
        eventId: 'evt_1001',
        eventType: 'order_created',
        payload: {'order_id': 'ord_1'},
      );
      expect(duplicateCall, isFalse, reason: 'Duplicate event should be suppressed');

      final newCall = service.handleRealtimeEvent(
        eventId: 'evt_1002',
        eventType: 'order_status_updated',
        payload: {'order_id': 'ord_1', 'status': 'ready'},
      );
      expect(newCall, isTrue, reason: 'New unique event should be processed');

      service.dispose();
    });
  });
}
