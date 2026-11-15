import 'package:cafe_os/features/orders/domain/models/order_and_table_models.dart';
import 'package:cafe_os/features/orders/domain/state_machine/order_lifecycle.dart';

abstract class OrdersRepository {
  Stream<List<OrderSummary>> watchOrders({
    required String branchId,
    OrderLifecycleStatus? statusFilter,
    DateTime? fromDate,
    DateTime? toDate,
    String? searchQuery,
  });

  Future<OrderSummary?> getOrder(String orderId);

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderLifecycleStatus newStatus,
    required String changedBy,
    String? notes,
  });

  Future<void> cancelOrder({
    required String orderId,
    required String reason,
    required String cancelledBy,
  });

  Future<void> updateOrderItemStatus({
    required String orderItemId,
    required String newStatus,
  });
}
