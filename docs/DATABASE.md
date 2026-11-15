# CaféOS — Database Architecture & Migration Workflow

This document details the PostgreSQL database design, Row Level Security (RLS) standards, RPCs, and local-first SQLite (Drift) synchronization.

---

## 1. Migration Workflow

All schema changes adhere strictly to the rule:
> **Rule:** DB changes are in a new migration file under `supabase/migrations/`, never edited into an old one.

### Local Development Flow
1. Ensure Docker Desktop is running.
2. Start local Supabase:
   ```bash
   npx supabase start
   ```
3. To create a new migration:
   ```bash
   npx supabase migration new <migration_name>
   ```
4. Apply migrations:
   ```bash
   npx supabase db reset
   ```
   *Note: `supabase db reset` tests that all migrations rebuild cleanly from zero.*
5. Dev-only mock policies or test fixtures live in `supabase/dev_only/` and are strictly excluded from `supabase/migrations/`.

---

## 2. Row Level Security (RLS) Philosophy (ADR-D5)
Every business table must have RLS enabled with tenant isolation:
```sql
ALTER TABLE my_table ENABLE ROW LEVEL SECURITY;
```
Access is governed by security helper functions:
- `app.current_tenant_ids()`: Returns the list of tenant UUIDs the authenticated user belongs to.
- `app.has_permission(permission_key)`: Checks whether the active user possesses the required permission.

---

## 3. Financial & Inventory RPCs (ADR-D6)
Critical multi-table financial writes are never performed via direct multi-table REST mutations from Flutter. Instead, PostgreSQL RPC functions handle:
- Order placement and settlement (`place_order_and_settle`)
- Stock deduction (`commit_order_stock`)
- Cash drawer movements (`record_cash_movement`)
- Refunds (`process_refund`)

All RPCs accept an `operation_uuid UUID` idempotency key.

---

## 4. Local Database (Drift) & Synchronization (ADR-D1)
- Local SQLite database managed via Drift in `lib/core/database/`.
- Every mutation performs a local write and inserts an outbox record into `sync_outbox_table` atomically.
- Sync worker processes the outbox and submits idempotent operations to Supabase RPCs.
