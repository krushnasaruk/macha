import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:cafe_os/core/database/app_database.dart';
import 'package:cafe_os/core/values/money.dart';
import 'package:cafe_os/features/billing/domain/models/billing_models.dart';

abstract class BillingLocalDataSource {
  Future<Invoice> createAndSettleOrderLocally({
    required String tenantId,
    required String branchId,
    required String branchCode,
    required String deviceSeries,
    required String employeeId,
    required CartState cart,
    required String paymentMethod,
    Money? tendered,
    Money? changeDue,
    String? cashSessionId,
  });

  Future<List<Invoice>> getInvoices({required String tenantId, required String branchId});
  Future<Invoice?> getInvoiceById(String id);
  Future<void> saveHeldCart({required String id, required String tenantId, required String branchId, required String label, required CartState cart, required String employeeId});
  Future<List<Map<String, dynamic>>> getHeldCarts({required String tenantId, required String branchId});
  Future<void> removeHeldCart(String id);

  Future<CashSessionRecord?> getActiveCashSession({required String tenantId, required String branchId, required String deviceId});
  Future<CashSessionRecord> openCashSession({
    required String id,
    required String tenantId,
    required String branchId,
    required String deviceId,
    required Money openingFloat,
    required String openedBy,
  });
  Future<void> recordCashMovement({
    required String id,
    required String sessionId,
    required String tenantId,
    required String branchId,
    required String type,
    required Money amount,
    String? reason,
    required String performedBy,
  });
  Future<CashSessionRecord> closeCashSession({
    required String sessionId,
    required Money actualCash,
    required String closedBy,
    String? notes,
  });

  Future<RefundRecord> createRefund({
    required String id,
    required String tenantId,
    required String branchId,
    required String invoiceId,
    String? paymentId,
    required Money amount,
    required String reason,
    required String approvedBy,
    required String refundMethod,
    String? cashSessionId,
  });
}

class BillingLocalDataSourceImpl implements BillingLocalDataSource {
  final AppDatabase _db;

  BillingLocalDataSourceImpl(this._db);

  String _getFiscalYear(DateTime date) {
    final year = date.year;
    // In India, FY runs from April 1 to March 31
    if (date.month >= 4) {
      final nextYear = (year + 1) % 100;
      return 'FY${year % 100}-${nextYear.toString().padLeft(2, '0')}';
    } else {
      final prevYear = (year - 1) % 100;
      return 'FY${prevYear.toString().padLeft(2, '0')}-${year % 100}';
    }
  }

  @override
  Future<Invoice> createAndSettleOrderLocally({
    required String tenantId,
    required String branchId,
    required String branchCode,
    required String deviceSeries,
    required String employeeId,
    required CartState cart,
    required String paymentMethod,
    Money? tendered,
    Money? changeDue,
    String? cashSessionId,
  }) async {
    final now = DateTime.now();
    final opId = 'op_${now.millisecondsSinceEpoch}';
    final orderId = 'ord_${now.millisecondsSinceEpoch}';
    final invoiceId = 'inv_${now.millisecondsSinceEpoch}';
    final paymentId = 'pay_${now.millisecondsSinceEpoch}';
    final fiscalYear = _getFiscalYear(now);

    final calc = cart.calculation;

    return await _db.transaction(() async {
      // 1. Calculate next sequence number for deviceSeries in this FY
      final existingInvoices = await (_db.select(_db.invoicesTable)
            ..where((tbl) =>
                tbl.tenantId.equals(tenantId) &
                tbl.branchId.equals(branchId) &
                tbl.deviceSeries.equals(deviceSeries) &
                tbl.fiscalYear.equals(fiscalYear)))
          .get();

      int nextSeq = 1;
      if (existingInvoices.isNotEmpty) {
        final maxSeq = existingInvoices
            .map((e) => e.sequenceNumber)
            .reduce((a, b) => a > b ? a : b);
        nextSeq = maxSeq + 1;
      }

      // ADR-D3: {branch_code}-{device_series}-{fiscal_year}-{sequence}
      final invoiceNumber =
          '$branchCode-$deviceSeries-$fiscalYear-${nextSeq.toString().padLeft(5, '0')}';
      final orderNumber = 'ORD-${nextSeq.toString().padLeft(5, '0')}';

      // 2. Insert Order
      await _db.into(_db.ordersTable).insert(
            OrdersTableCompanion.insert(
              id: orderId,
              tenantId: tenantId,
              branchId: branchId,
              orderNumber: orderNumber,
              orderType: Value(cart.orderType.name),
              status: const Value('completed'),
              source: const Value('pos'),
              tableId: Value(cart.tableId),
              customerName: Value(cart.customerName),
              customerPhone: Value(cart.customerPhone),
              subtotalPaise: Value(calc.grossSubtotal.paise),
              discountPaise: Value(calc.totalDiscounts.paise),
              taxPaise: Value(calc.totalTax.paise),
              roundingPaise: Value(calc.roundingDelta.paise),
              finalTotalPaise: Value(calc.finalPayable.paise),
              createdBy: employeeId,
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );

      // 3. Insert Order Items & Modifiers
      final invoiceItems = <InvoiceItem>[];
      for (final line in calc.lines) {
        final itemId = 'item_${now.millisecondsSinceEpoch}_${line.id}';
        await _db.into(_db.orderItemsTable).insert(
              OrderItemsTableCompanion.insert(
                id: itemId,
                orderId: orderId,
                tenantId: tenantId,
                productId: line.id,
                productName: line.title,
                quantity: Value(line.quantity),
                unitPricePaise: line.unitPrice.paise,
                subtotalPaise: line.subtotal.paise,
                discountPaise: Value(line.discountAmount.paise),
                taxablePaise: line.taxableAmount.paise,
                cgstPaise: Value(line.cgst.paise),
                sgstPaise: Value(line.sgst.paise),
                igstPaise: Value(line.igst.paise),
                totalTaxPaise: Value(line.totalTax.paise),
                lineTotalPaise: line.lineTotal.paise,
                taxRateBps: Value(line.taxRateBps),
                isTaxInclusive: Value(line.isTaxInclusive),
                createdAt: Value(now),
              ),
            );

        invoiceItems.add(
          InvoiceItem(
            id: itemId,
            productName: line.title,
            quantity: line.quantity,
            unitPrice: line.unitPrice,
            subtotal: line.subtotal,
            discount: line.discountAmount,
            taxableAmount: line.taxableAmount,
            cgst: line.cgst,
            sgst: line.sgst,
            igst: line.igst,
            totalTax: line.totalTax,
            lineTotal: line.lineTotal,
          ),
        );
      }

      // 4. Insert Invoice
      await _db.into(_db.invoicesTable).insert(
            InvoicesTableCompanion.insert(
              id: invoiceId,
              tenantId: tenantId,
              branchId: branchId,
              invoiceNumber: invoiceNumber,
              orderId: Value(orderId),
              subtotalPaise: calc.grossSubtotal.paise,
              discountPaise: Value(calc.totalDiscounts.paise),
              taxablePaise: calc.taxableAmount.paise,
              cgstPaise: Value(calc.cgstTotal.paise),
              sgstPaise: Value(calc.sgstTotal.paise),
              igstPaise: Value(calc.igstTotal.paise),
              totalTaxPaise: Value(calc.totalTax.paise),
              roundingPaise: Value(calc.roundingDelta.paise),
              finalTotalPaise: calc.finalPayable.paise,
              status: const Value('issued'),
              customerName: Value(cart.customerName),
              customerPhone: Value(cart.customerPhone),
              fiscalYear: fiscalYear,
              deviceSeries: deviceSeries,
              sequenceNumber: nextSeq,
              issuedAt: Value(now),
              issuedBy: employeeId,
            ),
          );

      // 5. Insert Payment
      await _db.into(_db.paymentsTable).insert(
            PaymentsTableCompanion.insert(
              id: paymentId,
              tenantId: tenantId,
              branchId: branchId,
              invoiceId: Value(invoiceId),
              orderId: Value(orderId),
              method: paymentMethod,
              status: const Value('completed'),
              amountPaise: calc.finalPayable.paise,
              tenderedPaise: Value(tendered?.paise),
              changeDuePaise: Value(changeDue?.paise),
              recordedBy: employeeId,
              recordedAt: Value(now),
            ),
          );

      // 6. Record Cash Drawer Movement if cash sale
      if (paymentMethod == 'cash' && cashSessionId != null) {
        final movId = 'mov_${now.millisecondsSinceEpoch}';
        await _db.into(_db.cashMovementsTable).insert(
              CashMovementsTableCompanion.insert(
                id: movId,
                sessionId: cashSessionId,
                tenantId: tenantId,
                branchId: branchId,
                type: 'sale',
                amountPaise: calc.finalPayable.paise,
                reason: Value('POS Sale $invoiceNumber'),
                performedBy: employeeId,
                createdAt: Value(now),
              ),
            );

        // Increment expected cash
        final session = await (_db.select(_db.cashSessionsTable)
              ..where((tbl) => tbl.id.equals(cashSessionId)))
            .getSingleOrNull();
        if (session != null) {
          await (_db.update(_db.cashSessionsTable)
                ..where((tbl) => tbl.id.equals(cashSessionId)))
              .write(
            CashSessionsTableCompanion(
              expectedCashPaise:
                  Value(session.expectedCashPaise + calc.finalPayable.paise),
            ),
          );
        }
      }

      // 7. Enqueue Outbox mutation for local-first sync (ADR-D1)
      final invoicePayload = {
        'id': invoiceId,
        'tenant_id': tenantId,
        'branch_id': branchId,
        'invoice_number': invoiceNumber,
        'order_id': orderId,
        'final_total_paise': calc.finalPayable.paise,
        'payment_method': paymentMethod,
        'issued_at': now.toIso8601String(),
      };

      await _db.into(_db.syncOutboxTable).insert(
            SyncOutboxTableCompanion.insert(
              id: 'outbox_${now.millisecondsSinceEpoch}',
              tenantId: tenantId,
              branchId: branchId,
              operationUuid: opId,
              entityType: 'invoices',
              entityId: invoiceId,
              operation: 'INSERT',
              payload: jsonEncode(invoicePayload),
              createdAt: now,
            ),
          );

      final payment = PaymentRecord(
        id: paymentId,
        invoiceId: invoiceId,
        orderId: orderId,
        method: paymentMethod,
        status: 'completed',
        amount: calc.finalPayable,
        tendered: tendered,
        changeDue: changeDue,
        recordedBy: employeeId,
        recordedAt: now,
      );

      return Invoice(
        id: invoiceId,
        tenantId: tenantId,
        branchId: branchId,
        invoiceNumber: invoiceNumber,
        orderId: orderId,
        fiscalYear: fiscalYear,
        deviceSeries: deviceSeries,
        sequenceNumber: nextSeq,
        subtotal: calc.grossSubtotal,
        discount: calc.totalDiscounts,
        taxableAmount: calc.taxableAmount,
        cgst: calc.cgstTotal,
        sgst: calc.sgstTotal,
        igst: calc.igstTotal,
        totalTax: calc.totalTax,
        rounding: calc.roundingDelta,
        finalTotal: calc.finalPayable,
        status: 'issued',
        customerName: cart.customerName,
        customerPhone: cart.customerPhone,
        issuedAt: now,
        issuedBy: employeeId,
        items: invoiceItems,
        payments: [payment],
      );
    });
  }

  @override
  Future<List<Invoice>> getInvoices({
    required String tenantId,
    required String branchId,
  }) async {
    final rows = await (_db.select(_db.invoicesTable)
          ..where((tbl) =>
              tbl.tenantId.equals(tenantId) & tbl.branchId.equals(branchId))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.issuedAt, mode: OrderingMode.desc)
          ]))
        .get();

    final result = <Invoice>[];
    for (final r in rows) {
      result.add(
        Invoice(
          id: r.id,
          tenantId: r.tenantId,
          branchId: r.branchId,
          invoiceNumber: r.invoiceNumber,
          orderId: r.orderId,
          fiscalYear: r.fiscalYear,
          deviceSeries: r.deviceSeries,
          sequenceNumber: r.sequenceNumber,
          subtotal: Money.fromPaise(r.subtotalPaise),
          discount: Money.fromPaise(r.discountPaise),
          taxableAmount: Money.fromPaise(r.taxablePaise),
          cgst: Money.fromPaise(r.cgstPaise),
          sgst: Money.fromPaise(r.sgstPaise),
          igst: Money.fromPaise(r.igstPaise),
          totalTax: Money.fromPaise(r.totalTaxPaise),
          rounding: Money.fromPaise(r.roundingPaise),
          finalTotal: Money.fromPaise(r.finalTotalPaise),
          status: r.status,
          customerName: r.customerName,
          customerPhone: r.customerPhone,
          customerGstin: r.customerGstin,
          issuedAt: r.issuedAt,
          issuedBy: r.issuedBy,
        ),
      );
    }
    return result;
  }

  @override
  Future<Invoice?> getInvoiceById(String id) async {
    final r = await (_db.select(_db.invoicesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (r == null) return null;

    final itemRows = await (_db.select(_db.orderItemsTable)
          ..where((tbl) => tbl.orderId.equals(r.orderId ?? '')))
        .get();

    final payRows = await (_db.select(_db.paymentsTable)
          ..where((tbl) => tbl.invoiceId.equals(id)))
        .get();

    final items = itemRows
        .map(
          (i) => InvoiceItem(
            id: i.id,
            productName: i.productName,
            variantName: i.variantName,
            quantity: i.quantity,
            unitPrice: Money.fromPaise(i.unitPricePaise),
            subtotal: Money.fromPaise(i.subtotalPaise),
            discount: Money.fromPaise(i.discountPaise),
            taxableAmount: Money.fromPaise(i.taxablePaise),
            cgst: Money.fromPaise(i.cgstPaise),
            sgst: Money.fromPaise(i.sgstPaise),
            igst: Money.fromPaise(i.igstPaise),
            totalTax: Money.fromPaise(i.totalTaxPaise),
            lineTotal: Money.fromPaise(i.lineTotalPaise),
          ),
        )
        .toList();

    final payments = payRows
        .map(
          (p) => PaymentRecord(
            id: p.id,
            invoiceId: id,
            orderId: p.orderId,
            method: p.method,
            status: p.status,
            amount: Money.fromPaise(p.amountPaise),
            tendered: p.tenderedPaise != null
                ? Money.fromPaise(p.tenderedPaise!)
                : null,
            changeDue: p.changeDuePaise != null
                ? Money.fromPaise(p.changeDuePaise!)
                : null,
            referenceNumber: p.referenceNumber,
            recordedBy: p.recordedBy,
            recordedAt: p.recordedAt,
          ),
        )
        .toList();

    return Invoice(
      id: r.id,
      tenantId: r.tenantId,
      branchId: r.branchId,
      invoiceNumber: r.invoiceNumber,
      orderId: r.orderId,
      fiscalYear: r.fiscalYear,
      deviceSeries: r.deviceSeries,
      sequenceNumber: r.sequenceNumber,
      subtotal: Money.fromPaise(r.subtotalPaise),
      discount: Money.fromPaise(r.discountPaise),
      taxableAmount: Money.fromPaise(r.taxablePaise),
      cgst: Money.fromPaise(r.cgstPaise),
      sgst: Money.fromPaise(r.sgstPaise),
      igst: Money.fromPaise(r.igstPaise),
      totalTax: Money.fromPaise(r.totalTaxPaise),
      rounding: Money.fromPaise(r.roundingPaise),
      finalTotal: Money.fromPaise(r.finalTotalPaise),
      status: r.status,
      customerName: r.customerName,
      customerPhone: r.customerPhone,
      customerGstin: r.customerGstin,
      issuedAt: r.issuedAt,
      issuedBy: r.issuedBy,
      items: items,
      payments: payments,
    );
  }

  @override
  Future<void> saveHeldCart({
    required String id,
    required String tenantId,
    required String branchId,
    required String label,
    required CartState cart,
    required String employeeId,
  }) async {
    await _db.into(_db.cartHoldTable).insertOnConflictUpdate(
          CartHoldTableCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            label: label,
            cartJson: cart.toJsonString(),
            heldAt: Value(DateTime.now()),
            heldBy: employeeId,
          ),
        );
  }

  @override
  Future<List<Map<String, dynamic>>> getHeldCarts({
    required String tenantId,
    required String branchId,
  }) async {
    final rows = await (_db.select(_db.cartHoldTable)
          ..where((tbl) =>
              tbl.tenantId.equals(tenantId) & tbl.branchId.equals(branchId))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.heldAt, mode: OrderingMode.desc)
          ]))
        .get();

    return rows
        .map((r) => {
              'id': r.id,
              'label': r.label,
              'cartJson': r.cartJson,
              'heldAt': r.heldAt,
              'heldBy': r.heldBy,
            })
        .toList();
  }

  @override
  Future<void> removeHeldCart(String id) async {
    await (_db.delete(_db.cartHoldTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<CashSessionRecord?> getActiveCashSession({
    required String tenantId,
    required String branchId,
    required String deviceId,
  }) async {
    final row = await (_db.select(_db.cashSessionsTable)
          ..where((tbl) =>
              tbl.tenantId.equals(tenantId) &
              tbl.branchId.equals(branchId) &
              tbl.deviceId.equals(deviceId) &
              tbl.status.equals('open')))
        .getSingleOrNull();

    if (row == null) return null;
    return CashSessionRecord(
      id: row.id,
      tenantId: row.tenantId,
      branchId: row.branchId,
      deviceId: row.deviceId,
      openedBy: row.openedBy,
      closedBy: row.closedBy,
      openingFloat: Money.fromPaise(row.openingFloatPaise),
      closingCashActual: row.closingCashActualPaise != null
          ? Money.fromPaise(row.closingCashActualPaise!)
          : null,
      expectedCash: Money.fromPaise(row.expectedCashPaise),
      variance: Money.fromPaise(row.variancePaise),
      status: row.status,
      openedAt: row.openedAt,
      closedAt: row.closedAt,
      notes: row.notes,
    );
  }

  @override
  Future<CashSessionRecord> openCashSession({
    required String id,
    required String tenantId,
    required String branchId,
    required String deviceId,
    required Money openingFloat,
    required String openedBy,
  }) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      await _db.into(_db.cashSessionsTable).insert(
            CashSessionsTableCompanion.insert(
              id: id,
              tenantId: tenantId,
              branchId: branchId,
              deviceId: deviceId,
              openedBy: openedBy,
              openingFloatPaise: Value(openingFloat.paise),
              expectedCashPaise: Value(openingFloat.paise),
              variancePaise: const Value(0),
              status: const Value('open'),
              openedAt: Value(now),
            ),
          );

      // Record opening movement
      await _db.into(_db.cashMovementsTable).insert(
            CashMovementsTableCompanion.insert(
              id: 'mov_${now.millisecondsSinceEpoch}',
              sessionId: id,
              tenantId: tenantId,
              branchId: branchId,
              type: 'cash_in',
              amountPaise: openingFloat.paise,
              reason: const Value('Opening Float'),
              performedBy: openedBy,
              createdAt: Value(now),
            ),
          );
    });

    return CashSessionRecord(
      id: id,
      tenantId: tenantId,
      branchId: branchId,
      deviceId: deviceId,
      openedBy: openedBy,
      openingFloat: openingFloat,
      expectedCash: openingFloat,
      variance: Money.zero,
      status: 'open',
      openedAt: now,
    );
  }

  @override
  Future<void> recordCashMovement({
    required String id,
    required String sessionId,
    required String tenantId,
    required String branchId,
    required String type,
    required Money amount,
    String? reason,
    required String performedBy,
  }) async {
    await _db.transaction(() async {
      await _db.into(_db.cashMovementsTable).insert(
            CashMovementsTableCompanion.insert(
              id: id,
              sessionId: sessionId,
              tenantId: tenantId,
              branchId: branchId,
              type: type,
              amountPaise: amount.paise,
              reason: Value(reason),
              performedBy: performedBy,
              createdAt: Value(DateTime.now()),
            ),
          );

      final session = await (_db.select(_db.cashSessionsTable)
            ..where((tbl) => tbl.id.equals(sessionId)))
          .getSingleOrNull();

      if (session != null) {
        final adjustment = type == 'cash_in' ? amount.paise : -amount.paise;
        await (_db.update(_db.cashSessionsTable)
              ..where((tbl) => tbl.id.equals(sessionId)))
            .write(
          CashSessionsTableCompanion(
            expectedCashPaise:
                Value(session.expectedCashPaise + adjustment),
          ),
        );
      }
    });
  }

  @override
  Future<CashSessionRecord> closeCashSession({
    required String sessionId,
    required Money actualCash,
    required String closedBy,
    String? notes,
  }) async {
    final now = DateTime.now();
    return await _db.transaction(() async {
      final session = await (_db.select(_db.cashSessionsTable)
            ..where((tbl) => tbl.id.equals(sessionId)))
          .getSingle();

      final expectedPaise = session.expectedCashPaise;
      final variancePaise = actualCash.paise - expectedPaise;

      await (_db.update(_db.cashSessionsTable)
            ..where((tbl) => tbl.id.equals(sessionId)))
          .write(
        CashSessionsTableCompanion(
          status: const Value('closed'),
          closingCashActualPaise: Value(actualCash.paise),
          variancePaise: Value(variancePaise),
          closedBy: Value(closedBy),
          closedAt: Value(now),
          notes: Value(notes),
        ),
      );

      return CashSessionRecord(
        id: session.id,
        tenantId: session.tenantId,
        branchId: session.branchId,
        deviceId: session.deviceId,
        openedBy: session.openedBy,
        closedBy: closedBy,
        openingFloat: Money.fromPaise(session.openingFloatPaise),
        closingCashActual: actualCash,
        expectedCash: Money.fromPaise(expectedPaise),
        variance: Money.fromPaise(variancePaise),
        status: 'closed',
        openedAt: session.openedAt,
        closedAt: now,
        notes: notes,
      );
    });
  }

  @override
  Future<RefundRecord> createRefund({
    required String id,
    required String tenantId,
    required String branchId,
    required String invoiceId,
    String? paymentId,
    required Money amount,
    required String reason,
    required String approvedBy,
    required String refundMethod,
    String? cashSessionId,
  }) async {
    final now = DateTime.now();
    return await _db.transaction(() async {
      // 1. Insert Refund record
      await _db.into(_db.refundsTable).insert(
            RefundsTableCompanion.insert(
              id: id,
              tenantId: tenantId,
              branchId: branchId,
              invoiceId: invoiceId,
              paymentId: Value(paymentId),
              amountPaise: amount.paise,
              reason: reason,
              approvedBy: approvedBy,
              refundMethod: refundMethod,
              createdAt: Value(now),
            ),
          );

      // 2. If cash refund and session provided, update drawer
      if (refundMethod == 'cash' && cashSessionId != null) {
        await _db.into(_db.cashMovementsTable).insert(
              CashMovementsTableCompanion.insert(
                id: 'mov_${now.millisecondsSinceEpoch}',
                sessionId: cashSessionId,
                tenantId: tenantId,
                branchId: branchId,
                type: 'refund',
                amountPaise: amount.paise,
                reason: Value('Refund for Invoice $invoiceId: $reason'),
                performedBy: approvedBy,
                createdAt: Value(now),
              ),
            );

        final session = await (_db.select(_db.cashSessionsTable)
              ..where((tbl) => tbl.id.equals(cashSessionId)))
            .getSingleOrNull();

        if (session != null) {
          await (_db.update(_db.cashSessionsTable)
                ..where((tbl) => tbl.id.equals(cashSessionId)))
              .write(
            CashSessionsTableCompanion(
              expectedCashPaise:
                  Value(session.expectedCashPaise - amount.paise),
            ),
          );
        }
      }

      // 3. Enqueue Outbox mutation for refund (ADR-D1)
      await _db.into(_db.syncOutboxTable).insert(
            SyncOutboxTableCompanion.insert(
              id: 'outbox_ref_${now.millisecondsSinceEpoch}',
              tenantId: tenantId,
              branchId: branchId,
              operationUuid: 'op_refund_${now.millisecondsSinceEpoch}',
              entityType: 'refunds',
              entityId: id,
              operation: 'INSERT',
              payload: jsonEncode({
                'id': id,
                'invoice_id': invoiceId,
                'amount_paise': amount.paise,
                'reason': reason,
                'approved_by': approvedBy,
                'refund_method': refundMethod,
              }),
              createdAt: now,
            ),
          );

      return RefundRecord(
        id: id,
        tenantId: tenantId,
        branchId: branchId,
        invoiceId: invoiceId,
        paymentId: paymentId,
        amount: amount,
        reason: reason,
        approvedBy: approvedBy,
        refundMethod: refundMethod,
        createdAt: now,
      );
    });
  }
}
