import 'package:drift/drift.dart';

/// Local Drift representation of the Tenant table.
class TenantsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of the TenantSettings table.
class TenantSettingsTable extends Table {
  TextColumn get tenantId => text()();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  TextColumn get timezone => text().withDefault(const Constant('Asia/Kolkata'))();
  TextColumn get gstin => text().nullable()();
  TextColumn get invoicePrefix => text().withDefault(const Constant('INV'))();
  IntColumn get fiscalYearStartMonth => integer().withDefault(const Constant(4))();
  TextColumn get roundOffStrategy => text().withDefault(const Constant('HALF_UP'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {tenantId};
}

/// Local Drift representation of the Branches table.
class BranchesTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get code => text()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of the Employees table.
class EmployeesTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get roleId => text()();
  TextColumn get pinHash => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of the Registered Devices table.
class DevicesTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get deviceSeries => text()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of the AuditLogs table.
class AuditLogsTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text().nullable()();
  TextColumn get employeeId => text().nullable()();
  TextColumn get action => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text().nullable()();
  TextColumn get detailsJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
