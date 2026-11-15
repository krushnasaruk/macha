import 'package:cafe_os/core/errors/app_failure.dart';

enum OrderStatus {
  created,
  confirmed,
  preparing,
  ready,
  served,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case OrderStatus.created:
        return 'Created';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.served:
        return 'Served';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (s) => s.name == value.toLowerCase(),
      orElse: () => OrderStatus.created,
    );
  }
}

typedef OrderLifecycleStatus = OrderStatus;

class OrderStatusHistoryEntry {
  final String? id;
  final String? orderId;
  final OrderStatus fromStatus;
  final OrderStatus toStatus;
  final String changedBy;
  final String? notes;
  final DateTime createdAt;

  const OrderStatusHistoryEntry({
    this.id,
    this.orderId,
    required this.fromStatus,
    required this.toStatus,
    required this.changedBy,
    this.notes,
    required this.createdAt,
  });
}

class OrderTransitionResult {
  final OrderStatus status;
  final OrderStatusHistoryEntry historyEntry;

  const OrderTransitionResult({
    required this.status,
    required this.historyEntry,
  });
}

abstract final class OrderLifecycle {
  static const Map<OrderStatus, Set<OrderStatus>> _allowedTransitions = {
    OrderStatus.created: {
      OrderStatus.confirmed,
      OrderStatus.cancelled,
    },
    OrderStatus.confirmed: {
      OrderStatus.preparing,
      OrderStatus.cancelled,
    },
    OrderStatus.preparing: {
      OrderStatus.confirmed,
      OrderStatus.ready,
      OrderStatus.cancelled,
    },
    OrderStatus.ready: {
      OrderStatus.preparing,
      OrderStatus.served,
      OrderStatus.cancelled,
    },
    OrderStatus.served: {
      OrderStatus.completed,
    },
    OrderStatus.completed: {},
    OrderStatus.cancelled: {},
  };

  static bool canTransition(OrderStatus from, OrderStatus to) {
    if (from == to) return true;
    final allowed = _allowedTransitions[from];
    return allowed?.contains(to) ?? false;
  }

  static OrderTransitionResult transition({
    required OrderStatus from,
    required OrderStatus to,
    String? actorId,
    String? changedBy,
    String? orderId,
    String? id,
    String? reason,
    String? notes,
  }) {
    if (!canTransition(from, to)) {
      throw ValidationFailure(
        'Cannot transition order status from "${from.label}" to "${to.label}".',
        fieldErrors: {'status': 'Invalid transition'},
      );
    }

    final effectiveActor = changedBy ?? actorId ?? 'system';
    final effectiveNotes = reason ?? notes;
    final history = OrderStatusHistoryEntry(
      id: id,
      orderId: orderId,
      fromStatus: from,
      toStatus: to,
      changedBy: effectiveActor,
      notes: effectiveNotes,
      createdAt: DateTime.now(),
    );

    return OrderTransitionResult(
      status: to,
      historyEntry: history,
    );
  }

  static bool canCancel(OrderStatus status) {
    return status != OrderStatus.completed && status != OrderStatus.cancelled;
  }
}

typedef OrderLifecycleStateMachine = OrderLifecycle;
