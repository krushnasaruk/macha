import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/errors/app_failure.dart';
import 'package:cafe_os/features/orders/domain/state_machine/order_lifecycle.dart';

void main() {
  group('Order Lifecycle State Machine (T5.2 & Milestone M2)', () {
    test('Allows valid sequential happy path transitions', () {
      OrderStatus state = OrderStatus.created;

      // Created -> Confirmed
      expect(OrderLifecycle.canTransition(state, OrderStatus.confirmed), isTrue);
      state = OrderLifecycle.transition(
        from: state,
        to: OrderStatus.confirmed,
        actorId: 'emp_cashier_01',
      ).status;
      expect(state, OrderStatus.confirmed);

      // Confirmed -> Preparing
      expect(OrderLifecycle.canTransition(state, OrderStatus.preparing), isTrue);
      state = OrderLifecycle.transition(
        from: state,
        to: OrderStatus.preparing,
        actorId: 'emp_chef_01',
      ).status;
      expect(state, OrderStatus.preparing);

      // Preparing -> Ready
      expect(OrderLifecycle.canTransition(state, OrderStatus.ready), isTrue);
      state = OrderLifecycle.transition(
        from: state,
        to: OrderStatus.ready,
        actorId: 'emp_chef_01',
      ).status;
      expect(state, OrderStatus.ready);

      // Ready -> Served
      expect(OrderLifecycle.canTransition(state, OrderStatus.served), isTrue);
      state = OrderLifecycle.transition(
        from: state,
        to: OrderStatus.served,
        actorId: 'emp_waiter_01',
      ).status;
      expect(state, OrderStatus.served);

      // Served -> Completed
      expect(OrderLifecycle.canTransition(state, OrderStatus.completed), isTrue);
      state = OrderLifecycle.transition(
        from: state,
        to: OrderStatus.completed,
        actorId: 'emp_cashier_01',
      ).status;
      expect(state, OrderStatus.completed);
    });

    test('Allows permitted cancellation with reason before completed', () {
      // Cancellation from created
      expect(
        OrderLifecycle.canTransition(OrderStatus.created, OrderStatus.cancelled),
        isTrue,
      );

      // Cancellation from preparing
      expect(
        OrderLifecycle.canTransition(OrderStatus.preparing, OrderStatus.cancelled),
        isTrue,
      );

      final result = OrderLifecycle.transition(
        from: OrderStatus.preparing,
        to: OrderStatus.cancelled,
        actorId: 'emp_mgr_01',
        reason: 'Customer emergency departure',
      );
      expect(result.status, OrderStatus.cancelled);
      expect(result.historyEntry.notes, 'Customer emergency departure');
    });

    test('Throws ValidationFailure on illegal transitions', () {
      // Cannot jump from created to served directly
      expect(
        () => OrderLifecycle.transition(
          from: OrderStatus.created,
          to: OrderStatus.served,
          actorId: 'emp_01',
        ),
        throwsA(isA<ValidationFailure>()),
      );

      // Cannot reopen completed order
      expect(
        () => OrderLifecycle.transition(
          from: OrderStatus.completed,
          to: OrderStatus.preparing,
          actorId: 'emp_01',
        ),
        throwsA(isA<ValidationFailure>()),
      );

      // Cannot cancel an already completed order
      expect(
        () => OrderLifecycle.transition(
          from: OrderStatus.completed,
          to: OrderStatus.cancelled,
          actorId: 'emp_01',
        ),
        throwsA(isA<ValidationFailure>()),
      );
    });

    test('Generates complete audit history entry for transition', () {
      final transition = OrderLifecycle.transition(
        from: OrderStatus.created,
        to: OrderStatus.confirmed,
        actorId: 'emp_123',
        notes: 'Kitchen ticket printed',
      );

      final history = transition.historyEntry;
      expect(history.fromStatus, OrderStatus.created);
      expect(history.toStatus, OrderStatus.confirmed);
      expect(history.changedBy, 'emp_123');
      expect(history.notes, 'Kitchen ticket printed');
      expect(history.createdAt, isNotNull);
    });
  });
}
