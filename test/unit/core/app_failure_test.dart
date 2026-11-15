import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/core/errors/app_failure.dart';

void main() {
  group('AppFailure & AppFailureMapper', () {
    test('NetworkFailure maps to friendly offline message', () {
      const failure = NetworkFailure();
      expect(
        AppFailureMapper.toUserMessage(failure),
        contains('Unable to reach the server'),
      );
    });

    test('ValidationFailure maps field errors properly', () {
      const failure = ValidationFailure(
        'Validation failed',
        fieldErrors: {'price': 'Must be greater than 0', 'name': 'Required'},
      );
      final msg = AppFailureMapper.toUserMessage(failure);
      expect(msg, contains('price: Must be greater than 0'));
      expect(msg, contains('name: Required'));
    });

    test('PermissionDeniedFailure surfaces permission key', () {
      const failure = PermissionDeniedFailure('No access', requiredPermission: 'pos.discount.apply');
      final msg = AppFailureMapper.toUserMessage(failure);
      expect(msg, contains('pos.discount.apply'));
    });

    test('HardwareFailure specifies device type and instruction', () {
      const failure = HardwareFailure('Thermal Printer', 'Out of paper');
      final msg = AppFailureMapper.toUserMessage(failure);
      expect(msg, contains('Thermal Printer error: Out of paper'));
      expect(msg, contains('paper roll'));
    });

    test('NotFoundFailure produces clear message', () {
      const failure = NotFoundFailure('Product', 'prod-123');
      final msg = AppFailureMapper.toUserMessage(failure);
      expect(msg, contains('Product was not found'));
    });
  });
}
