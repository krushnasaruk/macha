import 'package:drift/drift.dart';

@DataClassName('OrdersTableData')
class OrdersTable extends Table {
  @override
  String get tableName => 'orders';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get orderNumber => text()();
  TextColumn get orderType => text().withDefault(const Constant('dine_in'))();
  TextColumn get status => text().withDefault(const Constant('created'))();
  TextColumn get source => text().withDefault(const Constant('pos'))();
  TextColumn get tableId => text().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get customerPhone => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get subtotalPaise => integer().withDefault(const Constant(0))();
  IntColumn get discountPaise => integer().withDefault(const Constant(0))();
  IntColumn get taxPaise => integer().withDefault(const Constant(0))();
  IntColumn get roundingPaise => integer().withDefault(const Constant(0))();
  IntColumn get finalTotalPaise => integer().withDefault(const Constant(0))();
  TextColumn get createdBy => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrderItemsTableData')
class OrderItemsTable extends Table {
  @override
  String get tableName => 'order_items';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get tenantId => text()();
  TextColumn get productId => text()();
  TextColumn get variantId => text().nullable()();
  TextColumn get productName => text()();
  TextColumn get variantName => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get unitPricePaise => integer()();
  IntColumn get subtotalPaise => integer()();
  IntColumn get discountPaise => integer().withDefault(const Constant(0))();
  IntColumn get taxablePaise => integer()();
  IntColumn get cgstPaise => integer().withDefault(const Constant(0))();
  IntColumn get sgstPaise => integer().withDefault(const Constant(0))();
  IntColumn get igstPaise => integer().withDefault(const Constant(0))();
  IntColumn get totalTaxPaise => integer().withDefault(const Constant(0))();
  IntColumn get lineTotalPaise => integer()();
  IntColumn get taxRateBps => integer().withDefault(const Constant(0))();
  BoolColumn get isTaxInclusive => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrderItemModifiersTableData')
class OrderItemModifiersTable extends Table {
  @override
  String get tableName => 'order_item_modifiers';

  TextColumn get id => text()();
  TextColumn get orderItemId => text()();
  TextColumn get modifierId => text()();
  TextColumn get modifierName => text()();
  IntColumn get priceDeltaPaise => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InvoicesTableData')
class InvoicesTable extends Table {
  @override
  String get tableName => 'invoices';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get invoiceNumber => text()();
  TextColumn get orderId => text().nullable()();
  IntColumn get subtotalPaise => integer()();
  IntColumn get discountPaise => integer().withDefault(const Constant(0))();
  IntColumn get taxablePaise => integer()();
  IntColumn get cgstPaise => integer().withDefault(const Constant(0))();
  IntColumn get sgstPaise => integer().withDefault(const Constant(0))();
  IntColumn get igstPaise => integer().withDefault(const Constant(0))();
  IntColumn get totalTaxPaise => integer().withDefault(const Constant(0))();
  IntColumn get roundingPaise => integer().withDefault(const Constant(0))();
  IntColumn get finalTotalPaise => integer()();
  TextColumn get status => text().withDefault(const Constant('issued'))();
  TextColumn get customerName => text().nullable()();
  TextColumn get customerPhone => text().nullable()();
  TextColumn get customerGstin => text().nullable()();
  TextColumn get fiscalYear => text()();
  TextColumn get deviceSeries => text()();
  IntColumn get sequenceNumber => integer()();
  DateTimeColumn get issuedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get issuedBy => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PaymentsTableData')
class PaymentsTable extends Table {
  @override
  String get tableName => 'payments';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get invoiceId => text().nullable()();
  TextColumn get orderId => text().nullable()();
  TextColumn get method => text()(); // cash, upi, card
  TextColumn get status => text().withDefault(const Constant('completed'))();
  IntColumn get amountPaise => integer()();
  IntColumn get tenderedPaise => integer().nullable()();
  IntColumn get changeDuePaise => integer().nullable()();
  TextColumn get referenceNumber => text().nullable()();
  TextColumn get recordedBy => text()();
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RefundsTableData')
class RefundsTable extends Table {
  @override
  String get tableName => 'refunds';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get invoiceId => text()();
  TextColumn get paymentId => text().nullable()();
  IntColumn get amountPaise => integer()();
  TextColumn get reason => text()();
  TextColumn get approvedBy => text()();
  TextColumn get refundMethod => text()();
  TextColumn get refundReference => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CashSessionsTableData')
class CashSessionsTable extends Table {
  @override
  String get tableName => 'cash_sessions';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get deviceId => text()();
  TextColumn get openedBy => text()();
  TextColumn get closedBy => text().nullable()();
  IntColumn get openingFloatPaise => integer().withDefault(const Constant(0))();
  IntColumn get closingCashActualPaise => integer().nullable()();
  IntColumn get expectedCashPaise => integer().withDefault(const Constant(0))();
  IntColumn get variancePaise => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('open'))();
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CashMovementsTableData')
class CashMovementsTable extends Table {
  @override
  String get tableName => 'cash_movements';

  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get type => text()(); // cash_in, cash_out, sale, refund
  IntColumn get amountPaise => integer()();
  TextColumn get reason => text().nullable()();
  TextColumn get performedBy => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CartHoldTableData')
class CartHoldTable extends Table {
  @override
  String get tableName => 'cart_holds';

  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get branchId => text()();
  TextColumn get label => text()(); // e.g. "Table 4" or "John - 3 items"
  TextColumn get cartJson => text()(); // Serialized CartState
  DateTimeColumn get heldAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get heldBy => text()();

  @override
  Set<Column> get primaryKey => {id};
}
