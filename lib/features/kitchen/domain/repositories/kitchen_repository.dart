import 'package:cafe_os/features/orders/domain/models/order_and_table_models.dart';
import 'package:cafe_os/features/orders/domain/state_machine/order_lifecycle.dart';

abstract class KitchenRepository {
  Stream<List<KitchenStation>> watchStations(String branchId);
  Stream<List<KitchenTicket>> watchTickets({
    required String branchId,
    String? stationId,
  });
  Future<void> bumpTicket({
    required String orderId,
    required OrderLifecycleStatus targetStatus,
    required String changedBy,
  });
  Future<void> recallTicket({
    required String orderId,
    required OrderLifecycleStatus previousStatus,
    required String changedBy,
  });
  Future<void> toggleItemReady({
    required String orderItemId,
    required bool isReady,
  });
}
