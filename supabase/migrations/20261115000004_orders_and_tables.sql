-- 0004_orders_and_tables.sql
-- CaféOS Tables, Sessions, Kitchen Stations, and Station Routing

-- 1. Dining Tables
CREATE TABLE IF NOT EXISTS public.dining_tables (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    capacity INT NOT NULL DEFAULT 4,
    floor_zone TEXT NOT NULL DEFAULT 'indoor', -- indoor, outdoor, terrace, bar
    status TEXT NOT NULL DEFAULT 'vacant', -- vacant, occupied, billed, reserved
    current_session_id TEXT,
    qr_token TEXT NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_branch_table_name UNIQUE (tenant_id, branch_id, name)
);

CREATE INDEX IF NOT EXISTS idx_dining_tables_tenant_branch ON public.dining_tables(tenant_id, branch_id);
CREATE INDEX IF NOT EXISTS idx_dining_tables_status ON public.dining_tables(status);

-- 2. Table Sessions
CREATE TABLE IF NOT EXISTS public.table_sessions (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    table_id TEXT NOT NULL REFERENCES public.dining_tables(id) ON DELETE CASCADE,
    guest_count INT NOT NULL DEFAULT 2,
    status TEXT NOT NULL DEFAULT 'active', -- active, settled, closed
    opened_by TEXT NOT NULL,
    closed_by TEXT,
    opened_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    closed_at TIMESTAMPTZ,
    notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_table_sessions_table ON public.table_sessions(table_id);
CREATE INDEX IF NOT EXISTS idx_table_sessions_status ON public.table_sessions(status);

-- 3. Kitchen Stations (KDS)
CREATE TABLE IF NOT EXISTS public.kitchen_stations (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    branch_id TEXT NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
    name TEXT NOT NULL, -- e.g. Espresso Bar, Bakery, Hot Kitchen
    code TEXT NOT NULL, -- BAR, BAKE, HOT
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_kitchen_stations_branch ON public.kitchen_stations(tenant_id, branch_id);

-- 4. Product Station Routing
CREATE TABLE IF NOT EXISTS public.product_station_routing (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
    product_id TEXT NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
    station_id TEXT NOT NULL REFERENCES public.kitchen_stations(id) ON DELETE CASCADE,
    CONSTRAINT uq_product_station UNIQUE (product_id, station_id)
);

-- RLS Policies
ALTER TABLE public.dining_tables ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.table_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.kitchen_stations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_station_routing ENABLE ROW LEVEL SECURITY;

CREATE POLICY "dining_tables_tenant_isolation" ON public.dining_tables FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "table_sessions_tenant_isolation" ON public.table_sessions FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "kitchen_stations_tenant_isolation" ON public.kitchen_stations FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));

CREATE POLICY "product_station_routing_tenant_isolation" ON public.product_station_routing FOR ALL
    USING (tenant_id = ANY(app.current_tenant_ids()));
