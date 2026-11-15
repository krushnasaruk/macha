# CaféOS — Coding Agent Execution Plan

Companion to the CaféOS Master Development Prompt. The master prompt says what to build; this plan says how the agent should work through it: in what order, in what size of steps, and what must be true before moving on.

---

## 1. How to use this plan

1. Put the Master Prompt in the repo at `docs/MASTER_PROMPT.md` and this plan at `docs/EXECUTION_PLAN.md`.
2. Create `docs/PROGRESS.md` (template in section 9). It is the agent's memory between sessions.
3. Start every session with the kickoff prompt in section 8. End every session by updating `PROGRESS.md`.
4. Work one task at a time (tasks are listed under each stage). Do not start a stage until the previous stage's exit gate passes.
5. Commit after every task that passes its checks. Never commit a broken build to the main branch.

---

## 2. Architecture decisions to lock in before writing features

The Master Prompt leaves a few things open that are expensive to change later. The agent should record these in `docs/ARCHITECTURE.md` as ADRs (architecture decision records) during Stage 1 and then follow them.

- **D1 — Local-first from the first billing screen.** The Master Prompt puts the offline engine at Stage 7, but POS (Stage 4) and orders (Stage 5) depend on it. Retrofitting an outbox under finished screens means rewriting every repository. Decision: from Stage 2 onward, every repository writes to Drift (SQLite) first and enqueues an outbox row in the same transaction. Stage 7 then becomes sync hardening (conflicts, retries, recovery tests), not a rewrite.
- **D2 — Money representation.** Postgres: `NUMERIC(14,2)`. Dart: a `Money` value type backed by integer minor units (paise), never `double`. All tax, discount and rounding logic lives in one pure-Dart pricing module with exhaustive unit tests.
- **D3 — Invoice numbering offline.** Two devices cannot share a counter while offline. Decision: invoice number = `{branch_code}-{device_series}-{fiscal_year}-{sequence}` with a per-device series allocated at device registration. Unique constraint on `(tenant_id, branch_id, invoice_number)`.
- **D4 — Identity seam.** One `IdentityProvider` interface (tenant, branch, employee, role, device). Stage 1 ships `DevIdentityProvider`; Stage 12 ships `SupabaseIdentityProvider`. No feature code may read tenant/branch/role from anywhere else.
- **D5 — Security from day one, auth last.** Write RLS policies in the very first migrations using a helper such as `app.current_tenant_ids()` and `app.has_permission(...)`. In development, run Supabase locally (`supabase start`, Docker) so no permissive policies ever touch a hosted project. Any dev-only policy lives in `supabase/dev_only/` and is never in `migrations/`.
- **D6 — Critical operations are server-side RPCs.** Place order, record payment, issue invoice, deduct stock, receive goods, refund: each is a Postgres function (transactional, idempotent by operation UUID). The Flutter app calls them (or syncs the outbox into them); it never composes multi-table financial writes itself.
- **D7 — QR customers are anonymous.** They never get direct table access. Customer ordering goes through Edge Functions that validate the QR token, re-price server-side, and rate-limit.
- **D8 — Code generation policy.** Freezed + json_serializable + Drift generate code. Generated files are committed only if the team prefers; decide once and document it.

---

## 3. Milestones (what "usable" means)

The 12 stages in the Master Prompt are kept, but grouped into milestones so there are earlier points where the product is genuinely usable.

| Milestone | Stages | What works at the end |
| :--- | :--- | :--- |
| **M1 — Sellable cash POS** | 1–4 | One café, one device: menu, cart, tax, discounts, cash payment, invoice, receipt preview, cash session. Data persists locally and survives restarts. |
| **M2 — Operating café** | 5–6 | Tables, orders, kitchen display with realtime, recipes and automatic stock deduction. |
| **M3 — Reliable and printable** | 7–8 | Offline sync proven, thermal printing, QR customer ordering. |
| **M4 — Whole business** | 9–11 | Staff, attendance, expenses, suppliers, purchases, reports, platform admin. |
| **M5 — Production** | 12 | Real authentication, production RLS, tenant-isolation tests, hardening. |

If time runs short, M1 is the product you can demo and pilot. Do not let later stages erode M1's quality.

---

## 4. Rules that apply to every task

### Definition of done for a task
- Compiles; `flutter analyze` has zero new issues.
- Business logic has unit tests; any new screen has at least one widget test for its main interaction.
- Every button and form field is wired to real behaviour. No dead controls, no TODOs on critical paths.
- Loading, empty and error states exist.
- DB changes are in a new migration file, never edited into an old one.
- `docs/PROGRESS.md` updated; relevant doc in `docs/` updated.

### Hard prohibitions (from the Master Prompt, restated for the agent)
- No auth implementation before Stage 12.
- No Firebase, no second frontend framework.
- No `double` for money.
- No service-role key in the app or in the repo.
- No fake payment success.
- No claim that something works without a test or a run that proves it.

### When blocked
- **Missing credential or external setting:** add a placeholder in `.env.example`, list exactly what the owner must provide in `PROGRESS.md` under Blockers, and continue with a local fixture.
- **Serious architectural fork:** write a short ADR, state the recommendation, then proceed with it unless the owner objects.

---

## 5. Stage-by-stage execution

### Stage 0 — Workspace inspection (first session, no feature code)
**Tasks:**
- **T0.1** Report project tree, Flutter/Dart versions (`flutter --version`, `flutter doctor -v`), connected Android devices/emulators, existing `supabase/` folder and migrations, existing `pubspec.yaml`.
- **T0.2** Check Docker and Supabase CLI availability for local Supabase.
- **T0.3** Produce `docs/PROGRESS.md` with the checklist, blockers, and the ADR list from section 2.

*Exit gate:* owner-readable inspection report committed; blockers listed.

---

### Stage 1 — Foundation
**Tasks:**
- **T1.1** Initialise or repair the Flutter project; feature-first folder structure from the Master Prompt.
- **T1.2** Dependencies: pick current compatible versions, record choices (and rejected alternatives) in `ARCHITECTURE.md`.
- **T1.3** Design system: colour tokens, typography (Outfit/Manrope + Inter, tabular figures), light and dark themes, spacing/radius tokens.
- **T1.4** Core component library (buttons, cards, fields, badges, empty/error/loading states, dialogs, `CurrencyText`, offline/sync indicators). Add a hidden component gallery screen to see all of them.
- **T1.5** Responsive shell: phone bottom navigation, tablet navigation rail, role-driven destinations. Use `go_router` with a permission-aware route table.
- **T1.6** `IdentityProvider` interface + `DevIdentityProvider` with six seeded roles and a role switcher in a dev-tools sheet.
- **T1.7** Permission engine: permission keys, role-to-permission map, `can(permission)` provider, route guard, and a unit-tested matrix.
- **T1.8** Drift database bootstrap with migrations support; connectivity service; app-wide error model (`AppFailure` hierarchy and user-message mapper).
- **T1.9** Supabase client config from `--dart-define` / `.env`; local Supabase project initialised (`supabase init`), migration workflow documented.

*Tests:* permission matrix, error mapper, theme smoke test, shell navigation per role.
*Exit gate:* app launches on an Android emulator; role switching changes navigation; `flutter analyze` clean; tests green.

---

### Stage 2 — Tenant and business foundation
**Tasks:**
- **T2.1** Migration `0001_platform_core`: tenants, tenant_settings, branches, roles, permissions, role_permissions, employees, devices, audit_logs, plus the RLS helper functions.
- **T2.2** RLS policies for these tables (written now, tested in Stage 12 with real users; unit-tested with SQL tests via pgTAP or Supabase test helpers using simulated JWT claims).
- **T2.3** Seed: one demo tenant, two branches, six demo employees.
- **T2.4** Local Drift tables mirroring the above, plus the outbox and `sync_state` tables (schema per Master Prompt section 17).
- **T2.5** Repository pattern: `LocalDataSource` + `RemoteDataSource` + repository with a single write path (local transaction → outbox row). Build it once on branches and reuse as the template for all later features.
- **T2.6** Branch selector, tenant settings screen (currency, timezone, GST profile, invoice prefix).

*Tests:* outbox written atomically with the business row; repository round-trip; seed idempotent.
*Exit gate:* switch branch and role in the app; settings persist locally and sync to local Supabase when online.

---

### Stage 3 — Menu management
**Tasks:**
- **T3.1** Migration: categories, products, product_variants, modifier_groups, modifiers, product_modifier_groups, product_branch_availability, tax categories.
- **T3.2** Category CRUD with reorder and archive.
- **T3.3** Product CRUD with image picker, Supabase Storage upload (local cache of images).
- **T3.4** Variants and modifier groups (min/max selection, mandatory flag, price delta).
- **T3.5** Availability: per-branch, temporary unavailable, scheduled.
- **T3.6** Menu cache for offline POS; search and filter queries.

*Tests:* validation rules (min/max modifiers), price snapshot structures, availability resolution.
*Exit gate:* a full menu can be created on one device and reloaded after an app restart without network.

---

### Stage 4 — POS and billing (milestone M1)
**Tasks:**
- **T4.1** Pure-Dart pricing module: line totals, discounts (fixed/percent, item/cart), CGST/SGST/IGST, inclusive vs exclusive tax, round-off. Write tests first, including edge cases (zero-rated items, discount larger than line, rounding on split tax).
- **T4.2** Cart controller (Riverpod) with persistence in Drift so a closed app restores the cart; hold and resume orders.
- **T4.3** POS screen: adaptive phone layout and tablet two-pane layout; category chips, search, product grid, variant/modifier sheet, item notes.
- **T4.4** Discount flow with permission-controlled approval and recording of who applied or approved it. Coupons.
- **T4.5** Migration: orders, order_items (price/tax snapshots), order_item_modifiers, order_status_history, payments, payment_allocations, invoices, invoice_items, refunds, cash_sessions, cash_movements.
- **T4.6** RPC `place_order_and_settle(...)`: transactional, idempotent by operation UUID, allocates invoice number (D3), writes ledger rows.
- **T4.7** Checkout screen: cash and split-payment recording with allocation validation; digital methods exist only behind a `PaymentProvider` interface and cannot be marked successful without provider confirmation.
- **T4.8** Invoice generation and `ReceiptPreview` widget from an immutable snapshot.
- **T4.9** Cash drawer open/close, cash in/out, expected vs actual, variance.
- **T4.10** Refunds: full and partial, reason, approval, refund receipt, reversal records (never edit the original invoice).

*Tests:* pricing (heavy), payment allocation, invoice numbering uniqueness, refund math, cart persistence, checkout widget test, integration test for "build cart → pay cash → invoice persisted → restart → invoice still there".
*Exit gate (M1):* the Master Prompt acceptance items 4–7 pass end-to-end on a device with airplane mode on.

---

### Stage 5 — Orders, tables, kitchen (M2 begins)
**Tasks:**
- **T5.1** Migration: dining_tables, table_sessions, kitchen stations, station routing on products.
- **T5.2** Order lifecycle state machine (Created → Confirmed → Preparing → Ready → Served → Completed, plus permitted cancellations) as a pure, tested class; history rows on every transition.
- **T5.3** Orders screens: filters, search, date range, detail with timeline.
- **T5.4** Table management: create/edit, sessions, assign, transfer, merge, status colours, QR token generation (UI only for now).
- **T5.5** Kitchen display: three-column tablet layout, per-station filter, timers, delayed indicators, item-level ready.
- **T5.6** Supabase Realtime subscription with reconnect, duplicate-event suppression, and a periodic reconciliation fetch (the database stays source of truth).
- **T5.7** Kitchen alerts: configurable sound and visual cues.

*Tests:* state-machine transitions (valid and invalid), duplicate realtime events, merge/transfer table logic.
*Exit gate:* cashier places an order on one device; it appears on a second device/emulator running kitchen mode; status changes flow back.

---

### Stage 6 — Inventory
**Tasks:**
- **T6.1** Migration: ingredients, ingredient_categories, recipes, recipe_versions, recipe_ingredients, inventory_stocks, stock_movements, stock_batches, stock_reservations, wastage_records, stock_counts, stock_transfers.
- **T6.2** Unit system and conversion library (pure Dart + mirrored SQL function); incompatible conversions throw. Tests first.
- **T6.3** Ingredient CRUD, reorder levels, expiry tracking.
- **T6.4** Recipe editor per product and variant, with versioning (orders reference the recipe version used).
- **T6.5** RPC `commit_order_stock(order_id)`: idempotent (unique `(order_id, recipe_version)` key on movements), handles cancellation, void, comp, refund-reversal policy.
- **T6.6** Stock operations: in, out, transfer, adjustment, physical count, wastage. All via ledger rows; direct overwrite is impossible.
- **T6.7** Weighted-average cost valuation.
- **T6.8** Inventory dashboard and low-stock notifications.

*Tests:* conversions, deduction idempotency (call twice, stock changes once), weighted average cost, negative-stock policy.
*Exit gate:* selling a cappuccino reduces beans, milk, sugar and cups by the recipe amounts exactly once; an adjustment appears in the ledger.

---

### Stage 7 — Offline engine hardening (M3 begins)
**Tasks:**
- **T7.1** Sync worker: batches outbox rows, uploads to the RPCs with operation UUID as idempotency key, exponential backoff, state machine (Pending → Uploading → Synced / Failed / Conflict / Requires review).
- **T7.2** Server-side `idempotency_keys` and `sync_operations` tables; replaying an operation returns the original result.
- **T7.3** Conflict detection and a Sync centre screen showing pending, failed, conflicts, and history.
- **T7.4** Pull sync for master data (menu, prices, tax config) with version/updated_at cursors.
- **T7.5** Negative-stock policy and reconciliation when offline sales exceed cached stock.
- **T7.6** Fault-injection tests: kill the app mid-upload, drop network mid-request, replay the same batch twice, clock skew.

*Tests:* duplicate-sync produces one invoice, one payment, one stock deduction; crash recovery.
*Exit gate:* acceptance items 17–19.

---

### Stage 8 — Printing and QR ordering
**Tasks:**
- **T8.1** `PrinterService` abstraction with Bluetooth and LAN ESC/POS drivers; 58 mm and 80 mm layouts.
- **T8.2** Local print queue with job status and retry; printing never affects payment state.
- **T8.3** Receipt and kitchen-ticket templates built from the stored snapshot (so reprints match the original).
- **T8.4** Printer settings: discovery, pairing, test print, station routing.
- **T8.5** Edge Functions: `qr_resolve_table`, `qr_submit_order` (server-side pricing, token validation, rate limit, revocation).
- **T8.6** Flutter web customer flow (menu → cart → submit → status → request bill) with no staff access paths.
- **T8.7** QR token management UI (generate, rotate, revoke, print table cards).

*Tests:* print failure leaves the invoice intact; tampered client price is overridden; revoked token rejected; rate limit.
*Exit gate:* acceptance items 14–16 (printing verified on real hardware; emulators cannot prove this).

---

### Stage 9 — Employees and operations (M4 begins)
**Tasks:**
- **T9.1** Employee management, shifts.
- **T9.2** Attendance: clock in/out, breaks, corrections with manager approval, offline timestamps stored separately from server timestamps; location capture opt-in only.
- **T9.3** Expenses with categories, attachments, approval.
- **T9.4** Suppliers.
- **T9.5** Purchase orders → goods receipt (partial, damaged, missing) → supplier invoice → payment; stock increases only on accepted goods; purchase returns.

*Exit gate:* acceptance items 12–13.

---

### Stage 10 — Reports and finance
**Tasks:**
- **T10.1** Postgres views/RPCs for sales, product, category, payment, GST, inventory valuation, consumption, wastage, expenses, supplier purchases.
- **T10.2** Profitability using the documented reporting rules (gross sales, net sales, tax, ingredient cost, gross profit, expenses, net estimate); document the definitions in `DATABASE.md`.
- **T10.3** Owner dashboard with filters and drill-downs; charts via `fl_chart`.
- **T10.4** CSV and PDF export, share sheet.

*Tests:* report totals reconcile with raw transactions on a seeded fixture dataset.
*Exit gate:* acceptance item 20.

---

### Stage 11 — Platform administration
**Tasks:**
- Tenant admin, subscription plans and entitlements (feature flags enforced both in UI and server), usage monitoring, platform logs.

*Exit gate:* a disabled entitlement blocks the feature server-side, not only in the UI.

---

### Stage 12 — Authentication and production hardening (M5)
**Tasks:**
- **T12.1** Implement `SupabaseIdentityProvider`; registration, login, password recovery, session handling.
- **T12.2** Membership resolution: user → tenants → branches → roles; tenant picker for multi-tenant users.
- **T12.3** Replace `DevIdentityProvider`; remove the dev role switcher from release builds.
- **T12.4** Apply and verify production RLS; delete everything in `supabase/dev_only/`.
- **T12.5** Security test suite: cross-tenant reads/writes, cross-branch access, unauthorized refunds and discounts, forged QR tokens, replayed operations.
- **T12.6** Release build, signing config, crash reporting, privacy notes, backup/restore procedure.

*Exit gate:* all 25 acceptance criteria in the Master Prompt pass, with evidence recorded in `PROGRESS.md`.

---

## 6. Testing pyramid and where it runs

| Layer | Tool | When |
| :--- | :--- | :--- |
| Pure logic (pricing, units, state machines) | `flutter test` | Every task, written before the code |
| Repositories against in-memory Drift | `flutter test` | Every data task |
| SQL functions and RLS | pgTAP / Supabase local test runner | Every migration |
| Widgets | `flutter test` | Every screen |
| Integration on emulator | `integration_test` | End of each stage |
| Hardware (printers, Bluetooth) | Manual checklist in `PRINTING.md` | Stage 8 and before release |

**Stage-end ritual:** `flutter analyze` → `flutter test` → `supabase db reset` (proves migrations rebuild from zero) → integration test → update docs.

---

## 7. Risk register

| Risk | Mitigation |
| :--- | :--- |
| Scope is very large for one agent | Milestones; M1 is independently shippable; strict task sizing |
| Offline retrofit pain | Decision D1: local-first writes from Stage 2 |
| Duplicate invoice or stock on retry | Operation-UUID idempotency in every RPC; replay tests |
| Auth-last leaves security untested | RLS written early and SQL-tested with simulated claims; real-user tests in Stage 12 |
| Printer variability | Abstraction layer; test on at least one 58 mm and one 80 mm device |
| Package or API drift (Supabase, Drift, Riverpod) | Agent reads current docs before using an API; pins versions |
| Agent claims success without proof | Every stage exit gate requires command output or a test result pasted into `PROGRESS.md` |
| Multi-device offline stock inconsistency | Single-device offline first; document the limitation; reconcile on sync |

---

## 8. Session kickoff prompt (paste at the start of every session)

> Read `docs/MASTER_PROMPT.md`, `docs/EXECUTION_PLAN.md` and `docs/PROGRESS.md`. Run `git status` and `flutter analyze` to confirm the starting state. Continue with the next unfinished task in the current stage. Before coding, state the task, the files you expect to touch, and the tests you will write first. Implement it following the Definition of Done in the plan. If you hit a decision with serious architectural consequences, write an ADR and explain it before implementing. When finished, run analyze and tests, update `PROGRESS.md`, commit, and report: what was implemented, files created and modified, DB changes, tests run and results, known limitations, and the next task.

---

## 9. PROGRESS.md template

```markdown
# CaféOS Progress

## Current state
- Stage: 1
- Last completed task: —
- Next task: T1.1
- Build status: not yet verified

## Stage checklist
- [ ] Stage 0 Inspection
- [ ] Stage 1 Foundation
- ... (through Stage 12)

## Decisions (ADR index)
- D1 Local-first writes — status
- D2 Money type — status

## Blockers (owner action needed)
- none

## Known issues
- none

## Evidence log
| Date | Task | Command run | Result |
|---|---|---|---|

## Environment
- Flutter/Dart versions:
- Supabase: local / hosted project ref:
- Test devices:
```

---

## 10. What the owner must provide, and when

| Needed | By stage | Notes |
| :--- | :--- | :--- |
| Android device or emulator, Docker, Supabase CLI | 0 | Local Supabase avoids hosted dev policies |
| Hosted Supabase development project URL and anon key | 2 (optional) | Only if remote testing is wanted; never the service-role key in the app |
| Branding: logo, café name, brand colours override | 1 | Defaults come from the design tokens |
| GST details for a pilot café (GSTIN, tax slabs, state) | 4 | Needed to validate tax output |
| Thermal printers (one 58 mm, one 80 mm, Bluetooth and LAN if possible) | 8 | Required for real verification |
| Payment provider choice (Razorpay, PhonePe, etc.) | after 4 | Interface exists from Stage 4; implementation is a later, separate task |
| Production Supabase project, domain for QR web app | 12 | Plus app signing keys |

---

## 11. Adopted adjustments to the Master Prompt

1. **Adopt decision D1 (local-first from Stage 2).** This is the most important change; without it Stage 7 becomes a rewrite.
2. **Use integer minor units for money in Dart.** The prompt forbids doubles but does not name the replacement.
3. **Decision threshold:** the agent proceeds alone on anything reversible within a day's work, and writes an ADR for anything else.
4. **Defer platform admin (Stage 11) and multi-branch stock transfers if a pilot café is waiting.**
5. **Plan the first real pilot at the end of M1 or M2, not after Stage 12.**
