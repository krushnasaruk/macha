import 'dart:convert';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/domain/pricing/pricing_engine.dart';

enum OrderType {
  dineIn,
  takeaway,
  delivery;

  String get label {
    switch (this) {
      case OrderType.dineIn:
        return 'Dine-In';
      case OrderType.takeaway:
        return 'Takeaway';
      case OrderType.delivery:
        return 'Delivery';
    }
  }
}

class SelectedModifier {
  final String id;
  final String name;
  final Money priceDelta;

  const SelectedModifier({
    required this.id,
    required this.name,
    required this.priceDelta,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'priceDeltaPaise': priceDelta.paise,
      };

  factory SelectedModifier.fromJson(Map<String, dynamic> json) =>
      SelectedModifier(
        id: json['id'] as String,
        name: json['name'] as String,
        priceDelta: Money.fromPaise((json['priceDeltaPaise'] as num).toInt()),
      );
}

class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String? variantId;
  final String? variantName;
  final Money unitPrice;
  final int quantity;
  final int taxRateBps;
  final bool isTaxInclusive;
  final List<SelectedModifier> selectedModifiers;
  final String? notes;
  final LineDiscount discount;

  const CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.variantId,
    this.variantName,
    required this.unitPrice,
    required this.quantity,
    this.taxRateBps = 500, // Default 5.00% GST
    this.isTaxInclusive = false,
    this.selectedModifiers = const [],
    this.notes,
    this.discount = const LineDiscount.none(),
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? variantId,
    String? variantName,
    Money? unitPrice,
    int? quantity,
    int? taxRateBps,
    bool? isTaxInclusive,
    List<SelectedModifier>? selectedModifiers,
    String? notes,
    LineDiscount? discount,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      taxRateBps: taxRateBps ?? this.taxRateBps,
      isTaxInclusive: isTaxInclusive ?? this.isTaxInclusive,
      selectedModifiers: selectedModifiers ?? this.selectedModifiers,
      notes: notes ?? this.notes,
      discount: discount ?? this.discount,
    );
  }

  PricingLineInput toPricingLineInput() {
    return PricingLineInput(
      id: id,
      title: variantName != null ? '$productName ($variantName)' : productName,
      unitPrice: unitPrice,
      quantity: quantity,
      taxRateBps: taxRateBps,
      isTaxInclusive: isTaxInclusive,
      taxType: TaxType.gstSplit,
      discount: discount,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        'variantId': variantId,
        'variantName': variantName,
        'unitPricePaise': unitPrice.paise,
        'quantity': quantity,
        'taxRateBps': taxRateBps,
        'isTaxInclusive': isTaxInclusive,
        'selectedModifiers':
            selectedModifiers.map((m) => m.toJson()).toList(),
        'notes': notes,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'] as String,
        productId: json['productId'] as String,
        productName: json['productName'] as String,
        variantId: json['variantId'] as String?,
        variantName: json['variantName'] as String?,
        unitPrice: Money.fromPaise((json['unitPricePaise'] as num).toInt()),
        quantity: (json['quantity'] as num).toInt(),
        taxRateBps: (json['taxRateBps'] as num?)?.toInt() ?? 500,
        isTaxInclusive: (json['isTaxInclusive'] as bool?) ?? false,
        selectedModifiers: (json['selectedModifiers'] as List?)
                ?.map((e) =>
                    SelectedModifier.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        notes: json['notes'] as String?,
      );
}

class CartState {
  final List<CartItem> items;
  final CartDiscount cartDiscount;
  final OrderType orderType;
  final String? tableId;
  final String? customerName;
  final String? customerPhone;

  const CartState({
    this.items = const [],
    this.cartDiscount = const CartDiscount.none(),
    this.orderType = OrderType.dineIn,
    this.tableId,
    this.customerName,
    this.customerPhone,
  });

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CalculatedCart get calculation {
    final pricingLines = items.map((e) => e.toPricingLineInput()).toList();
    return PricingEngine.calculateCart(
      PricingCartInput(
        lines: pricingLines,
        cartDiscount: cartDiscount,
        roundOff: true,
      ),
    );
  }

  CartState copyWith({
    List<CartItem>? items,
    CartDiscount? cartDiscount,
    OrderType? orderType,
    String? tableId,
    String? customerName,
    String? customerPhone,
  }) {
    return CartState(
      items: items ?? this.items,
      cartDiscount: cartDiscount ?? this.cartDiscount,
      orderType: orderType ?? this.orderType,
      tableId: tableId ?? this.tableId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
    );
  }

  String toJsonString() {
    final map = {
      'items': items.map((i) => i.toJson()).toList(),
      'orderType': orderType.name,
      'tableId': tableId,
      'customerName': customerName,
      'customerPhone': customerPhone,
    };
    return jsonEncode(map);
  }

  factory CartState.fromJsonString(String jsonStr) {
    try {
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      final items = (map['items'] as List)
          .map((i) => CartItem.fromJson(i as Map<String, dynamic>))
          .toList();
      final orderType = OrderType.values.firstWhere(
        (e) => e.name == map['orderType'],
        orElse: () => OrderType.dineIn,
      );
      return CartState(
        items: items,
        orderType: orderType,
        tableId: map['tableId'] as String?,
        customerName: map['customerName'] as String?,
        customerPhone: map['customerPhone'] as String?,
      );
    } catch (_) {
      return const CartState();
    }
  }
}

class InvoiceItem {
  final String id;
  final String productName;
  final String? variantName;
  final int quantity;
  final Money unitPrice;
  final Money subtotal;
  final Money discount;
  final Money taxableAmount;
  final Money cgst;
  final Money sgst;
  final Money igst;
  final Money totalTax;
  final Money lineTotal;

  const InvoiceItem({
    required this.id,
    required this.productName,
    this.variantName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.discount,
    required this.taxableAmount,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.totalTax,
    required this.lineTotal,
  });
}

class PaymentRecord {
  final String id;
  final String invoiceId;
  final String? orderId;
  final String method; // cash, upi, card
  final String status; // completed, pending, failed
  final Money amount;
  final Money? tendered;
  final Money? changeDue;
  final String? referenceNumber;
  final String recordedBy;
  final DateTime recordedAt;

  const PaymentRecord({
    required this.id,
    required this.invoiceId,
    this.orderId,
    required this.method,
    required this.status,
    required this.amount,
    this.tendered,
    this.changeDue,
    this.referenceNumber,
    required this.recordedBy,
    required this.recordedAt,
  });
}

class Invoice {
  final String id;
  final String tenantId;
  final String branchId;
  final String invoiceNumber;
  final String? orderId;
  final String fiscalYear;
  final String deviceSeries;
  final int sequenceNumber;
  final Money subtotal;
  final Money discount;
  final Money taxableAmount;
  final Money cgst;
  final Money sgst;
  final Money igst;
  final Money totalTax;
  final Money rounding;
  final Money finalTotal;
  final String status;
  final String? customerName;
  final String? customerPhone;
  final String? customerGstin;
  final DateTime issuedAt;
  final String issuedBy;
  final List<InvoiceItem> items;
  final List<PaymentRecord> payments;

  const Invoice({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.invoiceNumber,
    this.orderId,
    required this.fiscalYear,
    required this.deviceSeries,
    required this.sequenceNumber,
    required this.subtotal,
    required this.discount,
    required this.taxableAmount,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.totalTax,
    required this.rounding,
    required this.finalTotal,
    required this.status,
    this.customerName,
    this.customerPhone,
    this.customerGstin,
    required this.issuedAt,
    required this.issuedBy,
    this.items = const [],
    this.payments = const [],
  });
}

class CashSessionRecord {
  final String id;
  final String tenantId;
  final String branchId;
  final String deviceId;
  final String openedBy;
  final String? closedBy;
  final Money openingFloat;
  final Money? closingCashActual;
  final Money expectedCash;
  final Money variance;
  final String status; // open, closed
  final DateTime openedAt;
  final DateTime? closedAt;
  final String? notes;

  const CashSessionRecord({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.deviceId,
    required this.openedBy,
    this.closedBy,
    required this.openingFloat,
    this.closingCashActual,
    required this.expectedCash,
    required this.variance,
    required this.status,
    required this.openedAt,
    this.closedAt,
    this.notes,
  });
}

class CashMovementRecord {
  final String id;
  final String sessionId;
  final String tenantId;
  final String branchId;
  final String type; // cash_in, cash_out, sale, refund
  final Money amount;
  final String? reason;
  final String performedBy;
  final DateTime createdAt;

  const CashMovementRecord({
    required this.id,
    required this.sessionId,
    required this.tenantId,
    required this.branchId,
    required this.type,
    required this.amount,
    this.reason,
    required this.performedBy,
    required this.createdAt,
  });
}

class RefundRecord {
  final String id;
  final String tenantId;
  final String branchId;
  final String invoiceId;
  final String? paymentId;
  final Money amount;
  final String reason;
  final String approvedBy;
  final String refundMethod;
  final String? refundReference;
  final DateTime createdAt;

  const RefundRecord({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.invoiceId,
    this.paymentId,
    required this.amount,
    required this.reason,
    required this.approvedBy,
    required this.refundMethod,
    this.refundReference,
    required this.createdAt,
  });
}
