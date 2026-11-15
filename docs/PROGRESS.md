# CaféOS Progress

## Current state
- Stage: 0 (Completed) → Stage 1 (Ready to start)
- Last completed task: T0.3 Workspace inspection documentation and ADR setup
- Next task: T1.1 Initialise Flutter project with feature-first folder structure
- Build status: Environment inspected; clean starting state

## Stage checklist
- [x] Stage 0 Inspection
- [ ] Stage 1 Foundation
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
1. **Docker Desktop Daemon**: Docker CLI 29.9.2 is present, but Docker daemon is stopped. Starting Docker Desktop will be needed when running `npx supabase start` for local Supabase. Local tests and pure Dart/Flutter development are unblocked.
2. **Android SDK Command-line Tools / Licenses**: Missing `cmdline-tools` reported by `flutter doctor`. Can be installed in Android Studio SDK Manager or accepted via `sdkmanager`. Android emulator `test_1` is already created. Flutter Web and Windows desktop targets are operational for immediate UI verification.

## Known issues
- none

## Evidence log
| Date | Task | Command run | Result |
|---|---|---|---|
| 2026-11-15 | T0.1 | `flutter --version` | Flutter 3.24.5, Dart 3.5.4 |
| 2026-11-15 | T0.1 | `flutter doctor -v` | Android SDK 36.1.0 detected, Chrome/Edge/Windows targets detected |
| 2026-11-15 | T0.1 | `flutter emulators` | 1 emulator found: `test_1` (android) |
| 2026-11-15 | T0.2 | `docker --version`, `npx supabase --version` | Docker 29.9.2, Supabase CLI 3.1.0 available |
| 2026-11-15 | T0.3 | Git init & ADR setup | Initialized repository, created documentation structure |

## Environment
- Flutter/Dart versions: Flutter 3.24.5 • Dart 3.5.4
- Supabase: CLI 3.1.0 (via `npx supabase`)
- Test devices: Windows desktop, Chrome, Edge; Android emulator `test_1` available
