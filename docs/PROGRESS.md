# CaféOS Progress

## Current state
- Stage: UX Phase Stage 1 (Completed) → Stage 2 (UX Foundation)
- Milestone: **M2 (Operating café) ACHIEVED & VERIFIED**
- Last completed task: UX Phase Stage 0 (Baseline) & Stage 1 (Audit)
- Next task: UX Phase Stage 2 (UX Foundation: `core/ux/` motion tokens, haptics, skeleton kit, `Pressable`, `SingleFlight`, Dev UX HUD)
- Build status: Clean compile, zero analyze issues, 77 tests passing

## Stage checklist
- [x] Stage 0 Inspection
- [x] Stage 1 Foundation
- [x] Stage 2 Tenant and business foundation
- [x] Stage 3 Menu management
- [x] Stage 4 POS and billing (Milestone M1 — Sellable cash POS)
- [x] Stage 5 Orders, tables, kitchen (Milestone M2)
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
| 2026-11-15 | T5.1 | Migration `0004_orders_and_tables` | Dining tables, table sessions, kitchen stations, product station routing, status history |
| 2026-11-15 | T5.2 | Order lifecycle state machine | Explicit transitions, kitchen recall allowed, audit trail record generation |
| 2026-11-15 | T5.3 | Drift table models & code gen | `DiningTablesTable`, `TableSessionsTable`, `KitchenStationsTable`, `OrderStatusHistoryTable` |
| 2026-11-15 | T5.4 | Table management & session lifecycle | Floor zone filtering, seat guests, table transfer, table merge, atomic outbox writes (ADR-D1) |
| 2026-11-15 | T5.5 | Kitchen Display System (KDS) | 3-column tablet / tabbed phone KDS, station chips, live timer badges (amber >=10m, red >=15m), bump & 5s undo |
| 2026-11-15 | T5.6 | Realtime & duplicate suppression | `KitchenRealtimeService` deduplication cache (1000 events), reconnection reconciliation |
| 2026-11-15 | M2 Milestone Gate | `flutter test` | All 77 unit and widget tests passed |
| 2026-11-15 | M2 Milestone Gate | `flutter analyze` | Clean analysis (0 issues) |
| 2026-11-15 | UX Stage 0 | Baseline report & benchmarks | `UX_BASELINE.md`, `UX_BENCHMARKS.md`, `UX_PROGRESS.md`, `UX_CHANGELOG.md` |
| 2026-11-15 | UX Stage 1 | Audit & principles | `UX_AUDIT.md` (15 reference apps, state matrix, single-flight audit, friction scorecard) & `UX_PRINCIPLES.md` |
| 2026-11-15 | Mobile UI Refinement | Screen Redesign & Visual Match | Redesigned Home Dashboard, POS, Inventory, Orders, and More to match approved warm reference design |
| 2026-11-16 | MΛCHA Brand Identity | Brand Generator Script | Generated custom architectural `Λ` wordmarks, standalone monogram, app icons, color palette, POS receipt, and cup mockups |
| 2026-11-16 | Quality Gate | `flutter test` | All 99 unit and widget tests passed |
| 2026-11-16 | Quality Gate | `flutter analyze` | Clean analysis (0 issues) |
| 2026-11-16 | Home UI & 7-Day Showcase | Weekly Food Image Rotation | Integrated 7 photorealistic transparent food assets into 'over the div' floating hero card with modal selector |
| 2026-11-16 | Quality Gate | `flutter test` | All 101 unit and widget tests passed |
| 2026-11-16 | Quality Gate | `flutter analyze` | Clean analysis (0 issues) |
| 2026-11-16 | MΛCHA Transformation | Deep Forest Matcha Palette | Enforced `#293D32` Deep Forest Matcha, `#A5B98A` Matcha Green, `#B9A7CE` Soft Lavender, `#FFF9F2` Vanilla Cream |
| 2026-11-16 | Fixed Bottom Navigation | Pinned Full-Width Bar | Replaced floating capsule with fixed 5-tab bar (Home, Orders, POS, Inventory, More) pinned to bottom edge |
| 2026-11-16 | Food Photography & Assets | Padding & Sunday Dessert | Eliminated edge cutting (`touch_edge=False`), replaced Sunday bread with French Glazed Strawberry Tart |
| 2026-11-16 | Mascot Identity Refinement | Strictly 2 Arms & Organic Paws | Resolved 4-arm bug in poses 4-12 (`get_base_body`), regenerated cuddly bear paw anatomy sheet |
| 2026-11-16 | User-Uploaded Food Images | ImageStorageService | Added `image_picker`, local persistent storage, Supabase storage remote sync, safe placeholder fallback |
| 2026-11-16 | Menu Management Feature | Add/Edit Product & Category Modals | Image picker with camera/gallery, category selector, price in Rupees, live food photography display |
| 2026-11-16 | Inventory Management Feature | Comprehensive Stock Control | KPI cards, stock adjustment modal (Restock/Waste/Audit), quick deltas, stock movement audit trail |
| 2026-11-16 | Screen Redesigns | MΛCHA Identity Refresh | Updated Home Dashboard, POS Screen, Settings/More, and Orders with MΛCHA branding and colors |
| 2026-11-16 | Final Quality Gate | `flutter analyze` & `flutter test` | Clean analysis (0 issues), 101/101 tests passed (100% pass rate) |

## Environment
- Flutter/Dart versions: Flutter 3.24.5 • Dart 3.5.4
- Supabase: CLI 3.1.0 (via `npx supabase`)
- Test devices: Windows desktop, Chrome, Edge; Android emulator `test_1` available
