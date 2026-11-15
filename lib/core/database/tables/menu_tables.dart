import 'package:drift/drift.dart';

/// Local Drift representation of Categories table.
class CategoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of TaxCategories table.
class TaxCategoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  TextColumn get hsnCode => text().nullable()();
  IntColumn get cgstRateBps => integer().withDefault(const Constant(250))();
  IntColumn get sgstRateBps => integer().withDefault(const Constant(250))();
  IntColumn get igstRateBps => integer().withDefault(const Constant(500))();
  BoolColumn get isInclusive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of Products table.
class ProductsTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get categoryId => text()();
  TextColumn get taxCategoryId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get basePricePaise => integer()(); // Minor units (ADR-D2)
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of Product Variants table.
class ProductVariantsTable extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text()();
  TextColumn get name => text()();
  IntColumn get priceDeltaPaise => integer().withDefault(const Constant(0))();
  TextColumn get sku => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of Modifier Groups table.
class ModifierGroupsTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get name => text()();
  IntColumn get minSelection => integer().withDefault(const Constant(0))();
  IntColumn get maxSelection => integer().withDefault(const Constant(1))();
  BoolColumn get isMandatory => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of Modifiers table.
class ModifiersTable extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text()();
  TextColumn get name => text()();
  IntColumn get priceDeltaPaise => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local Drift representation of Product Modifier Groups relation table.
class ProductModifierGroupsTable extends Table {
  TextColumn get productId => text()();
  TextColumn get modifierGroupId => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {productId, modifierGroupId};
}

/// Local Drift representation of Product Branch Availability table.
class ProductBranchAvailabilityTable extends Table {
  TextColumn get productId => text()();
  TextColumn get branchId => text()();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  IntColumn get overridePricePaise => integer().nullable()();

  @override
  Set<Column> get primaryKey => {productId, branchId};
}
