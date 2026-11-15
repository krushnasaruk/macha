import '../models/order_and_table_models.dart';

abstract class TableRepository {
  Stream<List<DiningTable>> watchTables(String branchId);
  Future<List<DiningTable>> getTables(String branchId);
  Future<DiningTable?> getTable(String tableId);
  Future<void> saveTable(DiningTable table);
  Future<TableSession> openSession({
    required String tableId,
    required int guestCount,
    required String openedBy,
    String? notes,
  });
  Future<void> transferTable({
    required String fromTableId,
    required String toTableId,
    required String performedBy,
  });
  Future<void> mergeTables({
    required String sourceTableId,
    required String targetTableId,
    required String performedBy,
  });
  Future<void> closeSession({
    required String tableId,
    required String sessionId,
    required String closedBy,
  });
}
