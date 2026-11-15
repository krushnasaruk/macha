import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/identity/identity_models.dart';
import 'package:cafe_os/core/network/connectivity_service.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/data/datasources/billing_local_data_source.dart';
import 'package:cafe_os/features/billing/data/datasources/billing_remote_data_source.dart';
import 'package:cafe_os/features/billing/data/repositories/billing_repository_impl.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';
import 'package:cafe_os/features/billing/presentation/controllers/cart_controller.dart';

class MockConnectivity implements ConnectivityService {
  @override
  bool isOnline = false;
  @override
  Stream<bool> get onConnectivityChanged => Stream.value(false);
  @override
  void dispose() {}
}

class MockBillingRemote implements BillingRemoteDataSource {
  @override
  Future<Map<String, dynamic>?> placeOrderAndSettleRpc({
    required String operationId,
    required String tenantId,
    required String branchId,
    required String deviceSeries,
    required String fiscalYear,
    required String orderId,
    required String orderNumber,
    required String orderType,
    String? tableId,
    String? customerName,
    String? customerPhone,
    required int subtotalPaise,
    required int discountPaise,
    required int taxPaise,
    required int roundingPaise,
    required int finalTotalPaise,
    required String createdBy,
    required String paymentMethod,
    int? tenderedPaise,
    int? changeDuePaise,
    String? cashSessionId,
  }) async => null;
}

void main() {
  late AppDatabase db;
  late BillingRepositoryImpl repo;
  late CartController controller;

  const identity = SessionIdentity(
    tenant: Tenant(
      id: 't1',
      name: 'Café',
      currency: 'INR',
      timezone: 'Asia/Kolkata',
    ),
    branch: Branch(
      id: 'b1',
      tenantId: 't1',
      name: 'Kharadi',
      code: 'KHD',
    ),
    employee: Employee(
      id: 'e1',
      tenantId: 't1',
      branchId: 'b1',
      name: 'Cashier',
      email: 'cashier@cafe.com',
      role: UserRole.cashier,
    ),
    device: RegisteredDevice(
      id: 'd1',
      tenantId: 't1',
      branchId: 'b1',
      deviceSeries: 'A',
      name: 'POS 1',
    ),
  );

  setUp(() {
    db = AppDatabase.memory(NativeDatabase.memory());
    repo = BillingRepositoryImpl(
      localDataSource: BillingLocalDataSourceImpl(db),
      remoteDataSource: MockBillingRemote(),
      currentIdentity: identity,
      connectivity: MockConnectivity(),
    );
    controller = CartController(db, repo);
  });

  tearDown(() async {
    await db.close();
  });

  group('CartController & Drift Persistence (T4.2 & Master Prompt 17.1)', () {
    test('Starts with clean empty cart state', () {
      expect(controller.state.isEmpty, isTrue);
      expect(controller.state.totalItemCount, 0);
    });

    test('Adding product adds line item and computes totals', () {
      controller.addProduct(
        productId: 'prod_1',
        productName: 'Cold Coffee',
        unitPrice: const Money.fromPaise(12000), // ₹120.00
        taxRateBps: 500, // 5% GST
      );

      expect(controller.state.items.length, 1);
      expect(controller.state.totalItemCount, 1);

      // Adding identical product increments quantity instead of adding duplicate line
      controller.addProduct(
        productId: 'prod_1',
        productName: 'Cold Coffee',
        unitPrice: const Money.fromPaise(12000),
        taxRateBps: 500,
      );

      expect(controller.state.items.length, 1);
      expect(controller.state.totalItemCount, 2);
      expect(controller.state.items.first.quantity, 2);

      // Total: 2 * 120 = 240 + 5% GST (12) = 252.00 (25200 paise)
      final calc = controller.state.calculation;
      expect(calc.grossSubtotal, const Money.fromPaise(24000));
      expect(calc.totalTax, const Money.fromPaise(1200));
      expect(calc.finalPayable, const Money.fromPaise(25200));
    });

    test('Increment and decrement quantity steppers work as food delivery apps do', () {
      controller.addProduct(
        productId: 'prod_tea',
        productName: 'Masala Chai',
        unitPrice: const Money.fromPaise(4000),
      );

      final lineId = controller.state.items.first.id;

      // Increment
      controller.incrementQuantity(lineId);
      expect(controller.state.items.first.quantity, 2);

      // Decrement to 1
      controller.decrementQuantity(lineId);
      expect(controller.state.items.first.quantity, 1);

      // Decrementing at 1 removes item completely
      controller.decrementQuantity(lineId);
      expect(controller.state.isEmpty, isTrue);
    });

    test('Cart state survives controller recreation (Restored from SQLite AppConfig)', () async {
      // 1. Add item to cart
      controller.addProduct(
        productId: 'prod_bagel',
        productName: 'Cream Cheese Bagel',
        unitPrice: const Money.fromPaise(18000),
      );
      controller.setOrderType(OrderType.takeaway);
      controller.setCustomer(name: 'Aditi Rao', phone: '9876543210');

      // Wait a moment for async persistence
      await Future.delayed(const Duration(milliseconds: 50));

      // 2. Simulate restarting app / new controller instance
      final restoredController = CartController(db, repo);
      await Future.delayed(const Duration(milliseconds: 50));

      expect(restoredController.state.items.length, 1);
      expect(restoredController.state.items.first.productName, 'Cream Cheese Bagel');
      expect(restoredController.state.orderType, OrderType.takeaway);
      expect(restoredController.state.customerName, 'Aditi Rao');
      expect(restoredController.state.customerPhone, '9876543210');
    });

    test('Hold and resume cart moves cart to hold table and restores it on resume', () async {
      controller.addProduct(
        productId: 'p_latte',
        productName: 'Vanilla Latte',
        unitPrice: const Money.fromPaise(16000),
      );

      // Hold cart
      await controller.holdCart('Table 2');
      expect(controller.state.isEmpty, isTrue);

      final heldList = await repo.getHeldCarts();
      expect(heldList.length, 1);
      expect(heldList.first['label'], 'Table 2');

      // Resume cart
      await controller.resumeCart(
        heldList.first['id'] as String,
        heldList.first['cartJson'] as String,
      );

      expect(controller.state.items.length, 1);
      expect(controller.state.items.first.productName, 'Vanilla Latte');
    });
  });
}
