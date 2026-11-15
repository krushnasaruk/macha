-- Migration: 0002_menu_management.sql
-- Description: Categories, Products, Variants, Modifier Groups, Modifiers, Tax Categories, and Branch Availability.

-- 1. Tax Categories
CREATE TABLE IF NOT EXISTS public.tax_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  hsn_code TEXT,
  cgst_rate_bps INT NOT NULL DEFAULT 250, -- 2.5% = 250 bps
  sgst_rate_bps INT NOT NULL DEFAULT 250, -- 2.5% = 250 bps
  igst_rate_bps INT NOT NULL DEFAULT 500, -- 5.0% = 500 bps
  is_inclusive BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Categories
CREATE TABLE IF NOT EXISTS public.categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_archived BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT uq_category_tenant_slug UNIQUE (tenant_id, slug)
);

-- 3. Products
CREATE TABLE IF NOT EXISTS public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  category_id UUID NOT NULL REFERENCES public.categories(id) ON DELETE RESTRICT,
  tax_category_id UUID REFERENCES public.tax_categories(id) ON DELETE SET NULL,
  name TEXT NOT NULL,
  description TEXT,
  base_price_paise INT NOT NULL, -- Integer minor units (ADR-D2)
  image_url TEXT,
  is_archived BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 4. Product Variants
CREATE TABLE IF NOT EXISTS public.product_variants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  price_delta_paise INT NOT NULL DEFAULT 0,
  sku TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 5. Modifier Groups
CREATE TABLE IF NOT EXISTS public.modifier_groups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  min_selection INT NOT NULL DEFAULT 0,
  max_selection INT NOT NULL DEFAULT 1,
  is_mandatory BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 6. Modifiers
CREATE TABLE IF NOT EXISTS public.modifiers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id UUID NOT NULL REFERENCES public.modifier_groups(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  price_delta_paise INT NOT NULL DEFAULT 0,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 7. Product Modifier Groups Link
CREATE TABLE IF NOT EXISTS public.product_modifier_groups (
  product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  modifier_group_id UUID NOT NULL REFERENCES public.modifier_groups(id) ON DELETE CASCADE,
  sort_order INT NOT NULL DEFAULT 0,
  PRIMARY KEY (product_id, modifier_group_id)
);

-- 8. Branch Availability & Price Overrides
CREATE TABLE IF NOT EXISTS public.product_branch_availability (
  product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  branch_id UUID NOT NULL REFERENCES public.branches(id) ON DELETE CASCADE,
  is_available BOOLEAN NOT NULL DEFAULT true,
  override_price_paise INT,
  PRIMARY KEY (product_id, branch_id)
);

-- -----------------------------------------------------------------------------
-- Row Level Security
-- -----------------------------------------------------------------------------

ALTER TABLE public.tax_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_variants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.modifier_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.modifiers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_modifier_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_branch_availability ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation_tax_categories ON public.tax_categories
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

CREATE POLICY tenant_isolation_categories ON public.categories
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

CREATE POLICY tenant_isolation_products ON public.products
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

CREATE POLICY tenant_isolation_product_variants ON public.product_variants
  FOR ALL USING (product_id IN (SELECT id FROM public.products WHERE tenant_id IN (SELECT app.current_tenant_ids())));

CREATE POLICY tenant_isolation_modifier_groups ON public.modifier_groups
  FOR ALL USING (tenant_id IN (SELECT app.current_tenant_ids()));

CREATE POLICY tenant_isolation_modifiers ON public.modifiers
  FOR ALL USING (group_id IN (SELECT id FROM public.modifier_groups WHERE tenant_id IN (SELECT app.current_tenant_ids())));

CREATE POLICY tenant_isolation_product_modifier_groups ON public.product_modifier_groups
  FOR ALL USING (product_id IN (SELECT id FROM public.products WHERE tenant_id IN (SELECT app.current_tenant_ids())));

CREATE POLICY tenant_isolation_product_branch_availability ON public.product_branch_availability
  FOR ALL USING (product_id IN (SELECT id FROM public.products WHERE tenant_id IN (SELECT app.current_tenant_ids())));
