-- Seed: seed.sql
-- Idempotent seed for demo tenant, two branches, six employees, and catalog roles.

-- 1. Roles
INSERT INTO public.roles (id, title, description) VALUES
  ('owner', 'Owner', 'Full access to all café operations, settings, and finances.'),
  ('branch_manager', 'Branch Manager', 'Manages branch operations, staff, refunds, and inventory.'),
  ('cashier', 'Cashier', 'POS billing, cash drawer management, and order taking.'),
  ('waiter', 'Waiter / Server', 'Table management and dine-in order entry.'),
  ('kitchen_staff', 'Kitchen Staff', 'Kitchen Display System (KDS) order fulfillment.'),
  ('inventory_manager', 'Inventory Manager', 'Stock counts, purchasing, and recipe tracking.')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, description = EXCLUDED.description;

-- 2. Permissions
INSERT INTO public.permissions (id, category, description) VALUES
  ('pos.access', 'POS', 'Access point of sale screen'),
  ('pos.order.create', 'POS', 'Create new orders'),
  ('pos.order.cancel', 'POS', 'Cancel orders'),
  ('pos.discount.apply', 'POS', 'Apply standard discount'),
  ('pos.discount.override_max', 'POS', 'Apply discount exceeding threshold'),
  ('pos.cash_drawer.manage', 'POS', 'Open and close cash drawer'),
  ('pos.refund.issue', 'POS', 'Issue refunds and credit notes'),
  ('tables.access', 'Tables', 'View tables'),
  ('tables.manage', 'Tables', 'Assign, merge, and transfer tables'),
  ('kds.access', 'KDS', 'View kitchen display system'),
  ('kds.status.update', 'KDS', 'Update order item preparation status'),
  ('menu.view', 'Menu', 'View menu catalog'),
  ('menu.manage', 'Menu', 'Edit products, variants, and pricing'),
  ('inventory.view', 'Inventory', 'View stock levels'),
  ('inventory.manage', 'Inventory', 'Perform stock adjustments and purchases'),
  ('inventory.adjustment', 'Inventory', 'Perform wastage and variance write-offs'),
  ('staff.view', 'Staff', 'View employee roster'),
  ('staff.manage', 'Staff', 'Manage employees and shifts'),
  ('staff.attendance', 'Staff', 'Clock in/out attendance'),
  ('reports.view', 'Reports', 'View business and sales reports'),
  ('finances.view', 'Reports', 'View profit and loss and financial ledger'),
  ('settings.view', 'Settings', 'View branch settings'),
  ('settings.manage', 'Settings', 'Update tenant and branch configuration')
ON CONFLICT (id) DO NOTHING;

-- 3. Role Permissions Mapping
INSERT INTO public.role_permissions (role_id, permission_id)
SELECT 'owner', id FROM public.permissions
ON CONFLICT DO NOTHING;

INSERT INTO public.role_permissions (role_id, permission_id) VALUES
  ('branch_manager', 'pos.access'),
  ('branch_manager', 'pos.order.create'),
  ('branch_manager', 'pos.order.cancel'),
  ('branch_manager', 'pos.discount.apply'),
  ('branch_manager', 'pos.discount.override_max'),
  ('branch_manager', 'pos.cash_drawer.manage'),
  ('branch_manager', 'pos.refund.issue'),
  ('branch_manager', 'tables.access'),
  ('branch_manager', 'tables.manage'),
  ('branch_manager', 'kds.access'),
  ('branch_manager', 'kds.status.update'),
  ('branch_manager', 'menu.view'),
  ('branch_manager', 'menu.manage'),
  ('branch_manager', 'inventory.view'),
  ('branch_manager', 'inventory.manage'),
  ('branch_manager', 'inventory.adjustment'),
  ('branch_manager', 'staff.view'),
  ('branch_manager', 'staff.manage'),
  ('branch_manager', 'staff.attendance'),
  ('branch_manager', 'reports.view'),
  ('branch_manager', 'settings.view'),

  ('cashier', 'pos.access'),
  ('cashier', 'pos.order.create'),
  ('cashier', 'pos.order.cancel'),
  ('cashier', 'pos.discount.apply'),
  ('cashier', 'pos.cash_drawer.manage'),
  ('cashier', 'tables.access'),
  ('cashier', 'menu.view'),
  ('cashier', 'staff.attendance'),

  ('waiter', 'pos.access'),
  ('waiter', 'pos.order.create'),
  ('waiter', 'tables.access'),
  ('waiter', 'tables.manage'),
  ('waiter', 'menu.view'),
  ('waiter', 'staff.attendance'),

  ('kitchen_staff', 'kds.access'),
  ('kitchen_staff', 'kds.status.update'),
  ('kitchen_staff', 'menu.view'),
  ('kitchen_staff', 'staff.attendance'),

  ('inventory_manager', 'inventory.view'),
  ('inventory_manager', 'inventory.manage'),
  ('inventory_manager', 'inventory.adjustment'),
  ('inventory_manager', 'menu.view'),
  ('inventory_manager', 'staff.attendance')
ON CONFLICT DO NOTHING;

-- 4. Demo Tenant
INSERT INTO public.tenants (id, name, slug, is_active) VALUES
  ('00000000-0000-0000-0000-000000000001', 'Artisan Roast Café', 'artisan-roast', true)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, slug = EXCLUDED.slug;

-- 5. Tenant Settings
INSERT INTO public.tenant_settings (tenant_id, currency, timezone, gstin, invoice_prefix) VALUES
  ('00000000-0000-0000-0000-000000000001', 'INR', 'Asia/Kolkata', '27AABCA1234F1Z5', 'INV')
ON CONFLICT (tenant_id) DO UPDATE SET
  currency = EXCLUDED.currency,
  timezone = EXCLUDED.timezone,
  gstin = EXCLUDED.gstin,
  invoice_prefix = EXCLUDED.invoice_prefix;

-- 6. Demo Branches
INSERT INTO public.branches (id, tenant_id, name, code, address, is_default) VALUES
  ('00000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', 'Kharadi High Street', 'KHD', 'Shop 4, High Street, Kharadi, Pune', true),
  ('00000000-0000-0000-0000-000000000020', '00000000-0000-0000-0000-000000000001', 'Koregaon Park Lane 7', 'KP', 'Lane 7, Koregaon Park, Pune', false)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, code = EXCLUDED.code;

-- 7. Demo Employees (6 roles)
INSERT INTO public.employees (id, tenant_id, branch_id, name, email, role_id) VALUES
  ('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'Arjun Sharma', 'arjun@artisanroast.com', 'owner'),
  ('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'Priya Patel', 'priya@artisanroast.com', 'branch_manager'),
  ('00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'Rohan Verma', 'rohan@artisanroast.com', 'cashier'),
  ('00000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'Sneha Joshi', 'sneha@artisanroast.com', 'waiter'),
  ('00000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'Chef Vikram Rao', 'vikram@artisanroast.com', 'kitchen_staff'),
  ('00000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'Anil Kulkarni', 'anil@artisanroast.com', 'inventory_manager')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;

-- 8. Demo POS Terminal
INSERT INTO public.devices (id, tenant_id, branch_id, device_series, name, is_active) VALUES
  ('00000000-0000-0000-0000-000000000100', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000010', 'A1', 'Counter Terminal 1', true)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, is_active = EXCLUDED.is_active;
