import 'package:cafe_os/features/orders/domain/state_machine/order_lifecycle.dart';

enum TableStatus {
  vacant,
  occupied,
  billed,
  reserved;

  String get value => name;

  static TableStatus fromString(String value) {
    return TableStatus.values.firstWhere(
      (s) => s.name == value.toLowerCase(),
      orElse: () => TableStatus.vacant,
    );
  }
}

enum TableFloorZone {
  indoor,
  outdoor,
  terrace,
  bar;

  String get value => name;

  static TableFloorZone fromString(String value) {
    return TableFloorZone.values.firstWhere(
      (z) => z.name == value.toLowerCase(),
      orElse: () => TableFloorZone.indoor,
    );
  }
}

class DiningTable {
  final String id;
  final String tenantId;
  final String branchId;
  final String name;
  final int capacity;
  final TableFloorZone floorZone;
  final TableStatus status;
  final String? currentSessionId;
  final String qrToken;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DiningTable({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.name,
    this.capacity = 4,
    this.floorZone = TableFloorZone.indoor,
    this.status = TableStatus.vacant,
    this.currentSessionId,
    required this.qrToken,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  DiningTable copyWith({
    String? name,
    int? capacity,
    TableFloorZone? floorZone,
    TableStatus? status,
    String? currentSessionId,
    String? qrToken,
    int? sortOrder,
    DateTime? updatedAt,
  }) {
    return DiningTable(
      id: id,
      tenantId: tenantId,
      branchId: branchId,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      floorZone: floorZone ?? this.floorZone,
      status: status ?? this.status,
      currentSessionId: currentSessionId ?? this.currentSessionId,
      qrToken: qrToken ?? this.qrToken,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TableSession {
  final String id;
  final String tenantId;
  final String branchId;
  final String tableId;
  final int guestCount;
  final String status; // active, settled, closed
  final String openedBy;
  final String? closedBy;
  final DateTime openedAt;
  final DateTime? closedAt;
  final String? notes;

  const TableSession({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.tableId,
    this.guestCount = 2,
    this.status = 'active',
    required this.openedBy,
    this.closedBy,
    required this.openedAt,
    this.closedAt,
    this.notes,
  });

  bool get isActive => status == 'active';
}

class KitchenStation {
  final String id;
  final String tenantId;
  final String branchId;
  final String name;
  final String code;
  final bool isActive;
  final int sortOrder;

  const KitchenStation({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.name,
    required this.code,
    this.isActive = true,
    this.sortOrder = 0,
  });
}

class ProductStationRouting {
  final String id;
  final String tenantId;
  final String productId;
  final String stationId;

  const ProductStationRouting({
    required this.id,
    required this.tenantId,
    required this.productId,
    required this.stationId,
  });
}

class KitchenTicketItem {
  final String orderItemId;
  final String productId;
  final String productName;
  final int quantity;
  final String? variantName;
  final List<String> modifierNames;
  final String? notes;
  final bool isReady;

  const KitchenTicketItem({
    required this.orderItemId,
    required this.productId,
    required this.productName,
    required this.quantity,
    this.variantName,
    this.modifierNames = const [],
    this.notes,
    this.isReady = false,
  });

  KitchenTicketItem copyWith({bool? isReady}) {
    return KitchenTicketItem(
      orderItemId: orderItemId,
      productId: productId,
      productName: productName,
      quantity: quantity,
      variantName: variantName,
      modifierNames: modifierNames,
      notes: notes,
      isReady: isReady ?? this.isReady,
    );
  }
}

class KitchenTicket {
  final String orderId;
  final String orderNumber;
  final String? tableId;
  final String? tableName;
  final String orderType; // dine_in, takeaway, delivery
  final OrderLifecycleStatus status;
  final DateTime createdAt;
  final List<KitchenTicketItem> items;
  final String? notes;
  final String? stationId;

  const KitchenTicket({
    required this.orderId,
    required this.orderNumber,
    this.tableId,
    this.tableName,
    required this.orderType,
    required this.status,
    required this.createdAt,
    required this.items,
    this.notes,
    this.stationId,
  });

  int get elapsedMinutes => DateTime.now().difference(createdAt).inMinutes;
  bool get isWarning => elapsedMinutes >= 10 && elapsedMinutes < 15;
  bool get isDelayed => elapsedMinutes >= 15;

  KitchenTicket copyWith({
    OrderLifecycleStatus? status,
    List<KitchenTicketItem>? items,
  }) {
    return KitchenTicket(
      orderId: orderId,
      orderNumber: orderNumber,
      tableId: tableId,
      tableName: tableName,
      orderType: orderType,
      status: status ?? this.status,
      createdAt: createdAt,
      items: items ?? this.items,
      notes: notes,
      stationId: stationId,
    );
  }
}

class OrderItemSummary {
  final String id;
  final String productId;
  final String productName;
  final String? variantName;
  final int quantity;
  final int unitPricePaise;
  final int lineTotalPaise;
  final String? notes;
  final String status;
  final List<String> modifierNames;

  const OrderItemSummary({
    required this.id,
    required this.productId,
    required this.productName,
    this.variantName,
    required this.quantity,
    required this.unitPricePaise,
    required this.lineTotalPaise,
    this.notes,
    required this.status,
    this.modifierNames = const [],
  });
}

class OrderSummary {
  final String id;
  final String tenantId;
  final String branchId;
  final String orderNumber;
  final String orderType;
  final OrderLifecycleStatus status;
  final String source;
  final String? tableId;
  final String? tableName;
  final String? customerName;
  final String? customerPhone;
  final String? notes;
  final int subtotalPaise;
  final int discountPaise;
  final int taxPaise;
  final int roundingPaise;
  final int finalTotalPaise;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemSummary> items;
  final List<OrderStatusHistoryEntry> history;

  const OrderSummary({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.orderNumber,
    required this.orderType,
    required this.status,
    required this.source,
    this.tableId,
    this.tableName,
    this.customerName,
    this.customerPhone,
    this.notes,
    required this.subtotalPaise,
    required this.discountPaise,
    required this.taxPaise,
    required this.roundingPaise,
    required this.finalTotalPaise,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
    this.history = const [],
  });
}
