import 'package:drift/drift.dart';

/// Local synchronization outbox table (ADR-D1).
/// All mutations are written locally and enqueued here in the same atomic transaction.
class SyncOutboxTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get operationUuid => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()(); // INSERT, UPDATE, DELETE, RPC
  TextColumn get payload => text()(); // JSON serialized payload
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, syncing, synced, failed
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Synchronization cursor state for pull syncing remote data.
class SyncStateTable extends Table {
  TextColumn get targetEntity => text()();
  DateTimeColumn get lastSyncedAt => dateTime()();
  TextColumn get lastCursor => text().nullable()();

  @override
  Set<Column> get primaryKey => {targetEntity};
}

/// Metadata table for local client configuration (device series, schema version).
class AppConfigTable extends Table {
  TextColumn get configKey => text()();
  TextColumn get configValue => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {configKey};
}
