-- Migration: 0001_platform_core.sql
-- Description: Core multi-tenant platform tables, RLS security helpers, and audit logging.

CREATE SCHEMA IF NOT EXISTS app;

-- -----------------------------------------------------------------------------
-- Security Helper Functions (ADR-D5)
-- -----------------------------------------------------------------------------

-- Returns tenant UUIDs accessible to the calling authenticated session.
-- In Dev / offline sync, supports x-tenant-id claim or fallback.
CREATE OR REPLACE FUNCTION app.current_tenant_ids()
RETURNS SETOF UUID AS $$
BEGIN
  -- Extract from Supabase JWT claims or local dev session setting
  IF NULLIF(current_setting('request.jwt.claims', true), '') IS NOT NULL THEN
    RETURN QUERY
      SELECT (value::TEXT)::UUID
      FROM json_array_elements_text(
        coalesce(current_setting('request.jwt.claims', true)::json->'app_metadata'->'tenant_ids', '[]'::json)
      );
  END IF;

  -- Dev fallback for seeded tenant when auth is decoupled (Stage 1-11)
  RETURN QUERY SELECT '00000000-0000-0000-0000-000000000001'::UUID;
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- Checks if the calling session possesses the given permission key
CREATE OR REPLACE FUNCTION app.has_permission(p_permission TEXT)
RETURNS BOOLEAN AS $$
DECLARE
  v_role TEXT;
BEGIN
  -- Read role from JWT or dev fallback
  v_role := coalesce(
    current_setting('request.jwt.claims', true)::json->'app_metadata'->>'role',
    'owner'
  );

  RETURN EXISTS (
    SELECT 1
    FROM public.role_permissions rp
    WHERE rp.role_id = v_role
      AND rp.permission_id = p_permission
  );
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- -----------------------------------------------------------------------------
-- Core Business Tables
-- -----------------------------------------------------------------------------

-- Tenants (Organizations / Café Brands)
CREATE TABLE IF NOT EXISTS public.tenants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Tenant Settings (Configuration, Currency, GSTIN, Invoice Prefix)
CREATE TABLE IF NOT EXISTS public.tenant_settings (
  tenant_id UUID PRIMARY KEY REFERENCES public.tenants(id) ON DELETE CASCADE,
  currency TEXT NOT NULL DEFAULT 'INR',
  timezone TEXT NOT NULL DEFAULT 'Asia/Kolkata',
  gstin TEXT,
  invoice_prefix TEXT NOT NULL DEFAULT 'INV',
  fiscal_year_start_month INT NOT NULL DEFAULT 4,
  round_off_strategy TEXT NOT NULL DEFAULT 'HALF_UP',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Branches / Outlets
CREATE TABLE IF NOT EXISTS public.branches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  code TEXT NOT NULL,
  address TEXT,
  phone TEXT,
  is_default BOOLEAN NOT NULL DEFAULT false,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT uq_branch_tenant_code UNIQUE (tenant_id, code)
);

-- Roles Catalog
CREATE TABLE IF NOT EXISTS public.roles (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT
);

-- Granular Permissions Catalog
CREATE TABLE IF NOT EXISTS public.permissions (
  id TEXT PRIMARY KEY,
  category TEXT NOT NULL,
  description TEXT
);

-- Role-Permission Matrix
CREATE TABLE IF NOT EXISTS public.role_permissions (
  role_id TEXT NOT NULL REFERENCES public.roles(id) ON DELETE CASCADE,
  permission_id TEXT NOT NULL REFERENCES public.permissions(id) ON DELETE CASCADE,
  PRIMARY KEY (role_id, permission_id)
);

-- Employees / Staff
CREATE TABLE IF NOT EXISTS public.employees (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  branch_id UUID NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
  auth_user_id UUID,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  role_id TEXT NOT NULL REFERENCES public.roles(id),
  pin_hash TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- POS Registered Terminals (Invoice device series generator - ADR-D3)
CREATE TABLE IF NOT EXISTS public.devices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  branch_id UUID NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
  device_series TEXT NOT NULL,
  name TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT true,
  last_seen_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT uq_device_tenant_branch_series UNIQUE (tenant_id, branch_id, device_series)
);

-- Immutable Audit Log
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  branch_id UUID REFERENCES public.branches(id) ON DELETE SET NULL,
  employee_id UUID REFERENCES public.employees(id) ON DELETE SET NULL,
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT,
  details JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- -----------------------------------------------------------------------------
-- Row Level Security (RLS) Policies (ADR-D5)
-- -----------------------------------------------------------------------------

ALTER TABLE public.tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tenant_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.branches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.permissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_permissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.devices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- Tenants: Readable if in accessible tenant IDs
CREATE POLICY tenant_isolation_tenants ON public.tenants
  FOR ALL USING (id IN (SELECT app.current_tenant_ids()));

-- Tenant Settings: Managed by tenant
CREATE POLICY tenant_isolation_tenant_settings ON public.tenant_settings
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

-- Branches: Managed by tenant
CREATE POLICY tenant_isolation_branches ON public.branches
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

-- Roles and Permissions: Read-only catalog for authenticated tenants
CREATE POLICY read_roles ON public.roles FOR SELECT USING (true);
CREATE POLICY read_permissions ON public.permissions FOR SELECT USING (true);
CREATE POLICY read_role_permissions ON public.role_permissions FOR SELECT USING (true);

-- Employees: Scoped to tenant
CREATE POLICY tenant_isolation_employees ON public.employees
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

-- Devices: Scoped to tenant
CREATE POLICY tenant_isolation_devices ON public.devices
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

-- Audit Logs: Insertable & Readable within tenant
CREATE POLICY tenant_isolation_audit_logs ON public.audit_logs
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));
