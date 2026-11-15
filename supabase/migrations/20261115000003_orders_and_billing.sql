-- 0003_orders_and_billing.sql
-- CaféOS Orders, Billing, Payments, Invoices, Refunds, and Cash Drawer Sessions

-- 1. Orders Table
CREATE TABLE IF NOT EXISTS public.orders (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    order_number TEXT NOT NULL,
    order_type TEXT NOT NULL DEFAULT 'dine_in', -- dine_in, takeaway, delivery
    status TEXT NOT NULL DEFAULT 'created', -- created, confirmed, preparing, ready, served, completed, cancelled
    source TEXT NOT NULL DEFAULT 'pos', -- pos, qr, kds, admin
    table_id TEXT,
    customer_name TEXT,
    customer_phone TEXT,
    notes TEXT,
    subtotal_paise BIGINT NOT NULL DEFAULT 0,
    discount_paise BIGINT NOT NULL DEFAULT 0,
    tax_paise BIGINT NOT NULL DEFAULT 0,
    rounding_paise BIGINT NOT NULL DEFAULT 0,
    final_total_paise BIGINT NOT NULL DEFAULT 0,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    version INT NOT NULL DEFAULT 1
);

CREATE INDEX IF NOT EXISTS idx_orders_tenant_branch ON public.orders(tenant_id, branch_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON public.orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON public.orders(created_at DESC);

-- 2. Order Items Table
CREATE TABLE IF NOT EXISTS public.order_items (
    id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    product_id TEXT NOT NULL,
    variant_id TEXT,
    product_name TEXT NOT NULL,
    variant_name TEXT,
    quantity INT NOT NULL DEFAULT 1,
    unit_price_paise BIGINT NOT NULL,
    subtotal_paise BIGINT NOT NULL,
    discount_paise BIGINT NOT NULL DEFAULT 0,
    taxable_paise BIGINT NOT NULL,
    cgst_paise BIGINT NOT NULL DEFAULT 0,
    sgst_paise BIGINT NOT NULL DEFAULT 0,
    igst_paise BIGINT NOT NULL DEFAULT 0,
    total_tax_paise BIGINT NOT NULL DEFAULT 0,
    line_total_paise BIGINT NOT NULL,
    tax_rate_bps INT NOT NULL DEFAULT 0,
    is_tax_inclusive BOOLEAN NOT NULL DEFAULT FALSE,
    notes TEXT,
    status TEXT NOT NULL DEFAULT 'pending', -- pending, preparing, ready, served, cancelled
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON public.order_items(order_id);

-- 3. Order Item Modifiers
CREATE TABLE IF NOT EXISTS public.order_item_modifiers (
    id TEXT PRIMARY KEY,
    order_item_id TEXT NOT NULL REFERENCES public.order_items(id) ON DELETE CASCADE,
    modifier_id TEXT NOT NULL,
    modifier_name TEXT NOT NULL,
    price_delta_paise BIGINT NOT NULL DEFAULT 0
);

-- 4. Order Status History
CREATE TABLE IF NOT EXISTS public.order_status_history (
    id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    from_status TEXT NOT NULL,
    to_status TEXT NOT NULL,
    changed_by TEXT NOT NULL,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. Invoices Table (D3: unique invoice numbering per tenant + branch)
CREATE TABLE IF NOT EXISTS public.invoices (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    invoice_number TEXT NOT NULL,
    order_id TEXT REFERENCES public.orders(id),
    subtotal_paise BIGINT NOT NULL,
    discount_paise BIGINT NOT NULL DEFAULT 0,
    taxable_paise BIGINT NOT NULL,
    cgst_paise BIGINT NOT NULL DEFAULT 0,
    sgst_paise BIGINT NOT NULL DEFAULT 0,
    igst_paise BIGINT NOT NULL DEFAULT 0,
    total_tax_paise BIGINT NOT NULL DEFAULT 0,
    rounding_paise BIGINT NOT NULL DEFAULT 0,
    final_total_paise BIGINT NOT NULL,
    status TEXT NOT NULL DEFAULT 'issued', -- issued, cancelled, refunded
    customer_name TEXT,
    customer_phone TEXT,
    customer_gstin TEXT,
    fiscal_year TEXT NOT NULL,
    device_series TEXT NOT NULL,
    sequence_number INT NOT NULL,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    issued_by TEXT NOT NULL,
    CONSTRAINT uq_tenant_branch_invoice UNIQUE (tenant_id, branch_id, invoice_number)
);

CREATE INDEX IF NOT EXISTS idx_invoices_tenant_branch ON public.invoices(tenant_id, branch_id);
CREATE INDEX IF NOT EXISTS idx_invoices_order_id ON public.invoices(order_id);

-- 6. Invoice Items (Immutable Snapshot)
CREATE TABLE IF NOT EXISTS public.invoice_items (
    id TEXT PRIMARY KEY,
    invoice_id TEXT NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    product_name TEXT NOT NULL,
    variant_name TEXT,
    quantity INT NOT NULL,
    unit_price_paise BIGINT NOT NULL,
    subtotal_paise BIGINT NOT NULL,
    discount_paise BIGINT NOT NULL DEFAULT 0,
    taxable_paise BIGINT NOT NULL,
    cgst_paise BIGINT NOT NULL DEFAULT 0,
    sgst_paise BIGINT NOT NULL DEFAULT 0,
    igst_paise BIGINT NOT NULL DEFAULT 0,
    total_tax_paise BIGINT NOT NULL DEFAULT 0,
    line_total_paise BIGINT NOT NULL
);

-- 7. Payments Table
CREATE TABLE IF NOT EXISTS public.payments (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    invoice_id TEXT REFERENCES public.invoices(id),
    order_id TEXT REFERENCES public.orders(id),
    method TEXT NOT NULL, -- cash, upi, card, credit
    status TEXT NOT NULL DEFAULT 'completed', -- completed, pending, failed, refunded
    amount_paise BIGINT NOT NULL,
    tendered_paise BIGINT,
    change_due_paise BIGINT,
    reference_number TEXT,
    recorded_by TEXT NOT NULL,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 8. Payment Allocations
CREATE TABLE IF NOT EXISTS public.payment_allocations (
    id TEXT PRIMARY KEY,
    payment_id TEXT NOT NULL REFERENCES public.payments(id) ON DELETE CASCADE,
    invoice_id TEXT NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
    allocated_amount_paise BIGINT NOT NULL,
    allocated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 9. Refunds (Reversals never edit the original invoice)
CREATE TABLE IF NOT EXISTS public.refunds (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    invoice_id TEXT NOT NULL REFERENCES public.invoices(id),
    payment_id TEXT REFERENCES public.payments(id),
    amount_paise BIGINT NOT NULL,
    reason TEXT NOT NULL,
    approved_by TEXT NOT NULL,
    refund_method TEXT NOT NULL, -- cash, upi, card
    refund_reference TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 10. Cash Sessions (Cash Drawer)
CREATE TABLE IF NOT EXISTS public.cash_sessions (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    device_id TEXT NOT NULL,
    opened_by TEXT NOT NULL,
    closed_by TEXT,
    opening_float_paise BIGINT NOT NULL DEFAULT 0,
    closing_cash_actual_paise BIGINT,
    expected_cash_paise BIGINT NOT NULL DEFAULT 0,
    variance_paise BIGINT NOT NULL DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'open', -- open, closed
    opened_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    closed_at TIMESTAMPTZ,
    notes TEXT
);

-- 11. Cash Movements
CREATE TABLE IF NOT EXISTS public.cash_movements (
    id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES public.cash_sessions(id) ON DELETE CASCADE,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    type TEXT NOT NULL, -- cash_in, cash_out, sale, refund
    amount_paise BIGINT NOT NULL,
    reason TEXT,
    performed_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- RLS Policies
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_item_modifiers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_status_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.invoice_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payment_allocations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.refunds ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cash_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cash_movements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "orders_tenant_isolation" ON public.orders FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "order_items_tenant_isolation" ON public.order_items FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "invoices_tenant_isolation" ON public.invoices FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "invoice_items_tenant_isolation" ON public.invoice_items FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "payments_tenant_isolation" ON public.payments FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "refunds_tenant_isolation" ON public.refunds FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "cash_sessions_tenant_isolation" ON public.cash_sessions FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "cash_movements_tenant_isolation" ON public.cash_movements FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

-- RPC: place_order_and_settle (ADR-D6)
-- Server-side transactional and idempotent order settlement
CREATE OR REPLACE FUNCTION public.place_order_and_settle(
    p_operation_id TEXT,
    p_tenant_id TEXT,
    p_branch_id TEXT,
    p_device_series TEXT,
    p_fiscal_year TEXT,
    p_order_id TEXT,
    p_order_number TEXT,
    p_order_type TEXT,
    p_table_id TEXT,
    p_customer_name TEXT,
    p_customer_phone TEXT,
    p_subtotal_paise BIGINT,
    p_discount_paise BIGINT,
    p_tax_paise BIGINT,
    p_rounding_paise BIGINT,
    p_final_total_paise BIGINT,
    p_created_by TEXT,
    p_payment_method TEXT,
    p_tendered_paise BIGINT,
    p_change_due_paise BIGINT,
    p_cash_session_id TEXT
) RETURNS JSONB AS $$
DECLARE
    v_seq INT;
    v_branch_code TEXT;
    v_invoice_number TEXT;
    v_invoice_id TEXT;
    v_payment_id TEXT;
    v_existing_invoice TEXT;
BEGIN
    -- Idempotency check: see if invoice for this order already exists
    SELECT id, invoice_number INTO v_invoice_id, v_invoice_number
    FROM public.invoices
    WHERE order_id = p_order_id AND tenant_id = p_tenant_id;

    IF FOUND THEN
        RETURN jsonb_build_object(
            'success', true,
            'idempotent_replay', true,
            'invoice_id', v_invoice_id,
            'invoice_number', v_invoice_number
        );
    END IF;

    -- Lookup branch code
    SELECT code INTO v_branch_code FROM public.branches WHERE id = p_branch_id;
    IF v_branch_code IS NULL THEN
        v_branch_code := 'BR01';
    END IF;

    -- Next sequence for this branch and device series in this fiscal year
    SELECT COALESCE(MAX(sequence_number), 0) + 1 INTO v_seq
    FROM public.invoices
    WHERE tenant_id = p_tenant_id
      AND branch_id = p_branch_id
      AND device_series = p_device_series
      AND fiscal_year = p_fiscal_year;

    -- Format invoice number per ADR-D3: {branch_code}-{device_series}-{fiscal_year}-{sequence}
    v_invoice_number := v_branch_code || '-' || p_device_series || '-' || p_fiscal_year || '-' || LPAD(v_seq::TEXT, 5, '0');
    v_invoice_id := 'inv_' || p_operation_id;
    v_payment_id := 'pay_' || p_operation_id;

    -- 1. Insert or update Order
    INSERT INTO public.orders (
        id, tenant_id, branch_id, order_number, order_type, status, source,
        table_id, customer_name, customer_phone,
        subtotal_paise, discount_paise, tax_paise, rounding_paise, final_total_paise,
        created_by, created_at, updated_at
    ) VALUES (
        p_order_id, p_tenant_id, p_branch_id, p_order_number, p_order_type, 'completed', 'pos',
        p_table_id, p_customer_name, p_customer_phone,
        p_subtotal_paise, p_discount_paise, p_tax_paise, p_rounding_paise, p_final_total_paise,
        p_created_by, NOW(), NOW()
    ) ON CONFLICT (id) DO UPDATE SET
        status = 'completed',
        updated_at = NOW();

    -- 2. Insert Invoice
    INSERT INTO public.invoices (
        id, tenant_id, branch_id, invoice_number, order_id,
        subtotal_paise, discount_paise, taxable_paise,
        cgst_paise, sgst_paise, igst_paise, total_tax_paise,
        rounding_paise, final_total_paise, status,
        customer_name, customer_phone, fiscal_year, device_series, sequence_number,
        issued_at, issued_by
    ) VALUES (
        v_invoice_id, p_tenant_id, p_branch_id, v_invoice_number, p_order_id,
        p_subtotal_paise, p_discount_paise, (p_subtotal_paise - p_discount_paise),
        p_tax_paise / 2, p_tax_paise - (p_tax_paise / 2), 0, p_tax_paise,
        p_rounding_paise, p_final_total_paise, 'issued',
        p_customer_name, p_customer_phone, p_fiscal_year, p_device_series, v_seq,
        NOW(), p_created_by
    );

    -- 3. Insert Payment
    INSERT INTO public.payments (
        id, tenant_id, branch_id, invoice_id, order_id, method, status,
        amount_paise, tendered_paise, change_due_paise, recorded_by, recorded_at
    ) VALUES (
        v_payment_id, p_tenant_id, p_branch_id, v_invoice_id, p_order_id, p_payment_method, 'completed',
        p_final_total_paise, p_tendered_paise, p_change_due_paise, p_created_by, NOW()
    );

    -- 4. Record cash drawer movement if cash payment and session is provided
    IF p_payment_method = 'cash' AND p_cash_session_id IS NOT NULL THEN
        INSERT INTO public.cash_movements (
            id, session_id, tenant_id, branch_id, type, amount_paise, reason, performed_by, created_at
        ) VALUES (
            'mov_' || p_operation_id, p_cash_session_id, p_tenant_id, p_branch_id,
            'sale', p_final_total_paise, 'POS Sale: ' || v_invoice_number, p_created_by, NOW()
        );

        UPDATE public.cash_sessions
        SET expected_cash_paise = expected_cash_paise + p_final_total_paise
        WHERE id = p_cash_session_id;
    END IF;

    RETURN jsonb_build_object(
        'success', true,
        'idempotent_replay', false,
        'invoice_id', v_invoice_id,
        'invoice_number', v_invoice_number,
        'payment_id', v_payment_id
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
