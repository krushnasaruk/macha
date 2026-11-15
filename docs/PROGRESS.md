# CaféOS Progress

## Current state
- Stage: 4 (Completed) → Stage 5 (Ready to start)
- Milestone: **M1 (Sellable cash POS) ACHIEVED & VERIFIED**
- Last completed task: Stage 4 POS and billing (T4.1 through T4.10)
- Next task: T5.1 Orders, tables, and KDS migration (`0004_orders_and_tables.sql`)
- Build status: Clean compile, zero analyze issues, 61 tests passing

## Stage checklist
- [x] Stage 0 Inspection
- [x] Stage 1 Foundation
- [x] Stage 2 Tenant and business foundation
- [x] Stage 3 Menu management
- [x] Stage 4 POS and billing (Milestone M1 — Sellable cash POS)
- [ ] Stage 5 Orders, tables, kitchen (Milestone M2)
- [ ] Stage 5 Orders, tables, kitchen (Milestone M2)
- [ ] Stage 6 Inventory
- [ ] Stage 7 Offline engine hardening (Milestone M3)
- [ ] Stage 8 Printing and QR ordering
- [ ] Stage 9 Employees and operations (Milestone M4)
- [ ] Stage 10 Reports and finance
- [ ] Stage 11 Platform administration
- [ ] Stage 12 Authentication and production hardening (Milestone M5)

## Decisions (ADR index)
- [x] D1 Local-first writes from Stage 2 — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D2 Money type (integer minor units in paise) — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D3 Invoice numbering offline — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D4 Identity seam (`IdentityProvider` & `DevIdentityProvider`) — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D5 Security from day one (RLS helpers) — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D6 Critical operations are server-side RPCs — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D7 QR customers anonymous via Edge Functions — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))
- [x] D8 Code generation policy (Freezed, Drift, json_serializable) — Accepted ([docs/ARCHITECTURE.md](file:///c:/Users/Krushna/OneDrive/Documents/freelancing/kharadi/cafeOS/docs/ARCHITECTURE.md))

## Blockers (owner action needed)
1. **Docker Desktop Daemon**: Docker CLI 29.9.2 is installed, but Docker daemon needs to be running to execute `npx supabase start` for local Supabase database testing. Local tests and pure Dart/Flutter code generation are unblocked.
2. **Android SDK Command-line Tools / Licenses**: Missing `cmdline-tools` reported by `flutter doctor`. Can be installed in Android Studio SDK Manager or accepted via `sdkmanager`.

## Known issues
- none

## Evidence log
| Date | Task | Command run | Result |
|---|---|---|---|
| 2026-11-15 | T0.1 | `flutter --version` | Flutter 3.24.5, Dart 3.5.4 |
| 2026-11-15 | T0.1 | `flutter doctor -v` | Android SDK 36.1.0, Chrome, Edge, Windows targets |
| 2026-11-15 | T0.2 | `docker --version`, `npx supabase --version` | Docker 29.9.2, Supabase CLI 3.1.0 available |
| 2026-11-15 | T0.3 | Git init & ADR setup | Initialized repository, created documentation structure |
| 2026-11-15 | T1.1 | `flutter create` | Feature-first Flutter project initialized |
| 2026-11-15 | T1.2 | `flutter pub add` | Compatible dependencies resolved and pinned in `pubspec.yaml` |
| 2026-11-15 | T1.3 | Design system tokens | `AppColors`, `AppSpacing`, `AppTypography`, `AppTheme` implemented |
| 2026-11-15 | T1.4 | Core component library | `CurrencyText`, `AppButton`, `AppCard`, `AppTextField`, `AppBadge`, dialogs, states, ComponentGallery |
| 2026-11-15 | T1.5 | Navigation shell | Responsive phone bottom bar / tablet rail with `GoRouter` |
| 2026-11-15 | T1.6 | IdentityProvider | `DevIdentityProvider` with 6 seeded roles, 2 branches, 1 demo tenant |
| 2026-11-15 | T1.7 | Permission engine | Granular permission keys, `RolePermissions` matrix, `canPermissionProvider` |
| 2026-11-15 | T1.8 | Database & error model | Drift database bootstrap, outbox tables, `AppFailure` hierarchy & mapper |
| 2026-11-15 | T1.9 | Supabase configuration | `supabase init` completed, `DATABASE.md` documented, env config |
| 2026-11-15 | Stage 1 Gate | `flutter test` | All 25 unit and widget tests passed |
| 2026-11-15 | T2.1 | Migration `0001_platform_core` | Core platform tables, RLS helpers, audit log created |
| 2026-11-15 | T2.2 | RLS policies | Tenant isolation policies on public platform tables |
| 2026-11-15 | T2.3 | Seed script | `supabase/seed.sql` with idempotent ON CONFLICT clauses |
| 2026-11-15 | T2.4 | Drift platform tables | `TenantsTable`, `TenantSettingsTable`, `BranchesTable`, `EmployeesTable`, `DevicesTable`, `AuditLogsTable` |
| 2026-11-15 | T2.5 | Repository pattern template | `BranchRepository` single-write path (local transaction → outbox row) |
| 2026-11-15 | T2.6 | Tenant settings & branch selector | `TenantSettingsScreen` with live Drift persistence and outbox enqueue |
| 2026-11-15 | Stage 2 Gate | `dart run build_runner build` | Drift database code regenerated (1033 outputs) |
| 2026-11-15 | Stage 2 Gate | `flutter test` | All 29 unit and widget tests passed |
| 2026-11-15 | Stage 2 Gate | `flutter analyze` | Clean analysis (0 issues) |
| 2026-11-15 | T3.1 | Migration `0002_menu_management` | Categories, products, variants, modifier groups, modifiers, availability, tax categories |
| 2026-11-15 | T3.2 | Category CRUD | Drift `CategoriesTable`, data sources, and category selector |
| 2026-11-15 | T3.3 | Product CRUD | Drift `ProductsTable`, minor-unit price, image placeholder, and persistence |
| 2026-11-15 | T3.4 | Variants and modifiers | `ProductVariantsTable`, `ModifiersTable`, selection validation (min/max), minor-unit calculation |
| 2026-11-15 | T3.5 | Branch availability | `ProductBranchAvailabilityTable`, active toggle, price overrides per branch |
| 2026-11-15 | T3.6 | Menu offline cache & UI | `MenuScreen` with instant offline search, category chips, demo seeder, add product dialog |
| 2026-11-15 | Stage 3 Gate | `flutter test` | All 40 unit and widget tests passed |
| 2026-11-15 | Stage 3 Gate | `flutter analyze` | Clean analysis (0 issues) |
| 2026-11-15 | T4.1 | Pricing engine (pure Dart) | Minor units (paise), round-half-up, inclusive/exclusive GST, round-off, 9 unit tests |
| 2026-11-15 | T4.2 | Cart controller & persistence | Riverpod `CartController` with SQLite `AppConfigTable` persistence and hold/resume |
| 2026-11-15 | T4.3 | POS screen | Adaptive phone bottom cart / tablet 2-pane, 1-tap add, -/+ stepper, modifier sheet |
| 2026-11-15 | T4.4 | Discount flow | Preset chips, custom %, cash, permission checks (`posDiscountApply`, `overrideMax`) |
| 2026-11-15 | T4.5 | Migration `0003_orders_and_billing` | Orders, items, invoices, payments, refunds, cash sessions, movements + RLS |
| 2026-11-15 | T4.6 | Server RPC `place_order_and_settle` | Transactional, idempotent by operation UUID, D3 invoice numbering, ledger records |
| 2026-11-15 | T4.7 | Checkout screen | Exact amount, quick denominations, keypad, change due, offline digital guard |
| 2026-11-15 | T4.8 | Receipt preview & invoice | Immutable snapshot, GST split (CGST/SGST/IGST), non-blocking printer feedback |
| 2026-11-15 | T4.9 | Cash drawer management | Open float, cash in/out, shift end closing, expected vs actual variance calculation |
| 2026-11-15 | T4.10 | Refunds flow | Partial/full refund, reason, cashier drawer reversal, immutable invoice preserved |
| 2026-11-15 | M1 Milestone Gate | `flutter test` | All 61 unit and widget tests passed |
| 2026-11-15 | M1 Milestone Gate | `flutter analyze` | Clean analysis (0 issues) |

## Environment
- Flutter/Dart versions: Flutter 3.24.5 • Dart 3.5.4
- Supabase: CLI 3.1.0 (via `npx supabase`)
- Test devices: Windows desktop, Chrome, Edge; Android emulator `test_1` available
