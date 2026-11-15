/// Base hierarchy for domain and infrastructure failures in CaféOS.
sealed class AppFailure implements Exception {
  final String message;
  final String? code;
  final Object? cause;

  const AppFailure(this.message, {this.code, this.cause});

  @override
  String toString() => '$runtimeType: $message${code != null ? ' (code: $code)' : ''}';
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure([
    super.message = 'Network connection unavailable. Operating offline.',
    String? code,
    Object? cause,
  ]) : super(code: code, cause: cause);
}

final class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.message, {super.code, super.cause});
}

final class ValidationFailure extends AppFailure {
  final Map<String, String> fieldErrors;
  const ValidationFailure(super.message, {this.fieldErrors = const {}, super.code, super.cause});
}

final class PermissionDeniedFailure extends AppFailure {
  final String? requiredPermission;
  const PermissionDeniedFailure(
    super.message, {
    this.requiredPermission,
    super.code,
    super.cause,
  });
}

final class NotFoundFailure extends AppFailure {
  final String entityName;
  const NotFoundFailure(this.entityName, [String? id])
      : super('$entityName not found${id != null ? ' ($id)' : ''}.');
}

final class ConflictFailure extends AppFailure {
  const ConflictFailure(super.message, {super.code, super.cause});
}

final class SyncFailure extends AppFailure {
  final String operationUuid;
  const SyncFailure(super.message, {required this.operationUuid, super.code, super.cause});
}

final class HardwareFailure extends AppFailure {
  final String deviceType;
  const HardwareFailure(this.deviceType, super.message, {super.code, super.cause});
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure([
    super.message = 'An unexpected error occurred.',
    Object? cause,
  ]) : super(cause: cause);
}

/// Utility for transforming [AppFailure] instances into user-friendly localized messages.
abstract final class AppFailureMapper {
  static String toUserMessage(AppFailure failure) {
    return switch (failure) {
      NetworkFailure() =>
        'Unable to reach the server. CaféOS will continue offline and sync automatically.',
      DatabaseFailure(message: final msg) =>
        'Database error: $msg. Local data is safely preserved.',
      ValidationFailure(message: final msg, fieldErrors: final fields) =>
        fields.isEmpty ? msg : '$msg (${fields.entries.map((e) => '${e.key}: ${e.value}').join(', ')})',
      PermissionDeniedFailure(requiredPermission: final perm) =>
        perm != null
            ? 'Access denied. You do not have the required "$perm" permission.'
            : 'Access denied for your current role.',
      NotFoundFailure(entityName: final name) =>
        '$name was not found. It may have been archived or removed.',
      ConflictFailure(message: final msg) =>
        'Data conflict detected: $msg.',
      SyncFailure(message: final msg) =>
        'Synchronization issue: $msg. Pending changes remain in outbox.',
      HardwareFailure(deviceType: final dev, message: final msg) =>
        '$dev error: $msg. Please verify device connection and paper roll.',
      UnexpectedFailure(message: final msg) =>
        msg.isNotEmpty ? msg : 'An unexpected error occurred. Please try again.',
    };
  }
}
