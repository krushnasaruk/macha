# CaféOS Progress

## Current state
- Stage: 1 (Completed) → Stage 2 (Ready to start)
- Last completed task: Stage 1 Foundation (T1.1 through T1.9)
- Next task: T2.1 Migration 0001_platform_core (tenants, branches, roles, permissions, employees, devices, audit_logs)
- Build status: Clean compile (`flutter build bundle`), zero analyze issues, 25 tests passing

## Stage checklist
- [x] Stage 0 Inspection
- [x] Stage 1 Foundation
- [ ] Stage 2 Tenant and business foundation
- [ ] Stage 3 Menu management
- [ ] Stage 4 POS and billing (Milestone M1)
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
| 2026-11-15 | Stage 1 Gate | `dart run build_runner build` | Drift database code generated (`app_database.g.dart`) |
| 2026-11-15 | Stage 1 Gate | `flutter test` | All 25 unit and widget tests passed |
| 2026-11-15 | Stage 1 Gate | `flutter analyze` | Clean analysis (0 issues) |
| 2026-11-15 | Stage 1 Gate | `flutter build bundle` | Build successful (exit code 0) |

## Environment
- Flutter/Dart versions: Flutter 3.24.5 • Dart 3.5.4
- Supabase: CLI 3.1.0 (via `npx supabase`)
- Test devices: Windows desktop, Chrome, Edge; Android emulator `test_1` available
