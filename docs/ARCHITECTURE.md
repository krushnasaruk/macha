# CaféOS — Architecture Decision Records (ADRs)

This document formalizes critical architectural decisions locked in prior to and during feature development.

---

### ADR-D1: Local-First Architecture from Stage 2
- **Status:** Accepted
- **Context:** POS (Stage 4) and Orders (Stage 5) require seamless offline reliability. Retrofitting an outbox synchronization layer after building UI repositories against remote APIs leads to costly rewrites.
- **Decision:** From Stage 2 onwards, every repository writes directly to Drift (SQLite) first and enqueues an outbox row within the same local transaction. Remote synchronization reads from this outbox. Stage 7 focuses on synchronization hardening (conflicts, retries, recovery) rather than re-architecting data pipelines.
- **Consequences:** All features work offline by default; local database models must be maintained in sync with Supabase schemas.

---

### ADR-D2: Integer Minor Units for Monetary Values
- **Status:** Accepted
- **Context:** Floating point arithmetic (`double`) introduces rounding and precision errors in currency calculations, tax computations, and discounts.
- **Decision:** In Postgres, monetary columns use `NUMERIC(14,2)`. In Dart, all currency is encapsulated in an immutable `Money` value type backed strictly by integer minor units (e.g. paise for INR, cents for USD). Never use `double` for currency. All tax, discount, line totals, and round-offs reside in a pure-Dart pricing module backed by comprehensive unit tests.
- **Consequences:** Eliminates financial discrepancy bugs; displays require standard formatting via dedicated widgets (e.g. `CurrencyText`).

---

### ADR-D3: Offline-Safe Invoice Numbering
- **Status:** Accepted
- **Context:** Multiple POS terminals operating offline cannot synchronize a single database sequence counter. Collisions must be impossible.
- **Decision:** Invoice numbers follow the format: `{branch_code}-{device_series}-{fiscal_year}-{sequence}`, where `device_series` is unique per registered device allocated at onboarding. A composite unique constraint on `(tenant_id, branch_id, invoice_number)` guarantees global integrity.
- **Consequences:** Guarantees collision-free invoice numbering without requiring real-time network connectivity.

---

### ADR-D4: Unified Identity Seam (`IdentityProvider`)
- **Status:** Accepted
- **Context:** Decoupling authentication and role management from feature code allows testing all roles without needing live Supabase Auth in early stages.
- **Decision:** All tenant, branch, employee, role, and device information is accessed solely through an `IdentityProvider` interface. Stage 1 implements `DevIdentityProvider` (with seeded roles and a dev switcher). Stage 12 implements `SupabaseIdentityProvider`. Feature code is strictly prohibited from reading identity state from any other source.
- **Consequences:** Development and automated tests can run without live auth dependencies; switching to real Supabase Auth in Stage 12 will require zero changes to UI or domain logic.

---

### ADR-D5: Security by Design with RLS from Day One
- **Status:** Accepted
- **Context:** Deferring Row-Level Security (RLS) until the end leads to security leaks and major migration hurdles.
- **Decision:** Every Supabase table migration includes RLS policies using security helpers (`app.current_tenant_ids()`, `app.has_permission(...)`). Dev policies are isolated under `supabase/dev_only/` and never included in production migrations.
- **Consequences:** Zero regression risk for multi-tenant data leakage.

---

### ADR-D6: Server-Side RPCs for Critical Financial and Inventory Operations
- **Status:** Accepted
- **Context:** Operations such as order settlement, stock deductions, and refunds must remain transactional, atomic, and idempotent. Client devices must not compose multi-table transactional writes directly over REST.
- **Decision:** Operations including place order, record payment, issue invoice, deduct stock, receive goods, and refund are implemented as PostgreSQL functions idempotent by operation UUID. The client invokes these RPCs or pushes them via the sync outbox.
- **Consequences:** Prevents partial writes, duplicate billing, and stock corruption during network drops or client retries.

---

### ADR-D7: Anonymous QR Customer Ordering via Edge Functions
- **Status:** Accepted
- **Context:** Dine-in customers scanning table QR codes should not receive direct database access or credentials.
- **Decision:** Customer QR ordering is processed through Supabase Edge Functions that validate the QR session token, enforce rate limits, and calculate pricing server-side.
- **Consequences:** Prevents client price tampering and unauthorized access to internal staff tables or data.

---

### ADR-D8: Code Generation Policy
- **Status:** Accepted
- **Context:** Drift, Freezed, and JSON serialization require code generation via `build_runner`.
- **Decision:** Use Freezed and `json_serializable` for immutable models and Drift for database abstraction. Code generation files (`*.g.dart`, `*.freezed.dart`) are generated and maintained consistently, and gitignore policy will reflect project standards.
- **Consequences:** Consistent, type-safe models across database and domain layers.
