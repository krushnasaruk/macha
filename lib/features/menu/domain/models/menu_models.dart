import '../../../../core/errors/app_failure.dart';
import '../../../../core/values/money.dart';

class Category {
  final String id;
  final String tenantId;
  final String name;
  final String slug;
  final int sortOrder;
  final bool isArchived;

  const Category({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.slug,
    this.sortOrder = 0,
    this.isArchived = false,
  });
}

class ProductVariant {
  final String id;
  final String productId;
  final String name;
  final Money priceDelta;
  final String? sku;
  final int sortOrder;
  final bool isActive;

  const ProductVariant({
    required this.id,
    required this.productId,
    required this.name,
    this.priceDelta = Money.zero,
    this.sku,
    this.sortOrder = 0,
    this.isActive = true,
  });
}

class Modifier {
  final String id;
  final String groupId;
  final String name;
  final Money priceDelta;
  final int sortOrder;
  final bool isActive;

  const Modifier({
    required this.id,
    required this.groupId,
    required this.name,
    this.priceDelta = Money.zero,
    this.sortOrder = 0,
    this.isActive = true,
  });
}

class ModifierGroup {
  final String id;
  final String tenantId;
  final String name;
  final int minSelection;
  final int maxSelection;
  final bool isMandatory;
  final List<Modifier> modifiers;

  const ModifierGroup({
    required this.id,
    required this.tenantId,
    required this.name,
    this.minSelection = 0,
    this.maxSelection = 1,
    this.isMandatory = false,
    this.modifiers = const [],
  });

  /// Validates user selection against group limits (ADR-D2 & Validation Rules).
  void validateSelection(List<Modifier> selected) {
    if (isMandatory && selected.isEmpty) {
      throw ValidationFailure(
        'Please select at least one item from $name.',
        fieldErrors: {id: 'Mandatory group'},
      );
    }
    if (selected.length < minSelection) {
      throw ValidationFailure(
        'Selection for $name must be at least $minSelection item(s).',
        fieldErrors: {id: 'Minimum $minSelection required'},
      );
    }
    if (selected.length > maxSelection) {
      throw ValidationFailure(
        'Selection for $name cannot exceed $maxSelection item(s).',
        fieldErrors: {id: 'Maximum $maxSelection allowed'},
      );
    }
  }
}

class Product {
  final String id;
  final String tenantId;
  final String categoryId;
  final String? taxCategoryId;
  final String name;
  final String? description;
  final Money basePrice;
  final String? imageUrl;
  final bool isArchived;
  final List<ProductVariant> variants;
  final List<ModifierGroup> modifierGroups;

  const Product({
    required this.id,
    required this.tenantId,
    required this.categoryId,
    this.taxCategoryId,
    required this.name,
    this.description,
    required this.basePrice,
    this.imageUrl,
    this.isArchived = false,
    this.variants = const [],
    this.modifierGroups = const [],
  });

  /// Computes the effective line item price snapshot including variant and modifier deltas.
  Money computeEffectivePrice({
    ProductVariant? variant,
    List<Modifier> selectedModifiers = const [],
    Money? branchOverridePrice,
  }) {
    Money total = branchOverridePrice ?? basePrice;
    if (variant != null) {
      total = total + variant.priceDelta;
    }
    for (final modifier in selectedModifiers) {
      total = total + modifier.priceDelta;
    }
    return total;
  }
}

class TaxCategory {
  final String id;
  final String tenantId;
  final String name;
  final String? hsnCode;
  final int cgstRateBps;
  final int sgstRateBps;
  final int igstRateBps;
  final bool isInclusive;

  const TaxCategory({
    required this.id,
    required this.tenantId,
    required this.name,
    this.hsnCode,
    this.cgstRateBps = 250,
    this.sgstRateBps = 250,
    this.igstRateBps = 500,
    this.isInclusive = true,
  });

  int get totalRateBps => cgstRateBps + sgstRateBps;
}
