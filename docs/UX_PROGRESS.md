# CaféOS — UX Engineering Progress

Companion tracking document to `docs/UX_MASTER_PROMPT.md`.

## Current State
- **Phase**: UX & Experience Engineering
- **Current Stage**: Stage 3 (Navigation & Context Preservation) — ready to start
- **Milestone Focus**: Shell route state preservation, PageStorage keys, back gesture / predictive back, scroll restoration
- **Last Completed Task**: Stage 2 UX Foundation implementation (`lib/core/ux/`)
- **Next Task**: Stage 3 Navigation & Context Preservation (`lib/core/routing/`, `AppShell`)
- **Build & Quality Status**: Clean compile, 0 issues in `flutter analyze`, 88 tests passing (100% green)

---

## Stage Checklist

- [x] **Stage 0 Baseline**: Reference devices, profile builds, baseline timings and tap counts (`docs/UX_BASELINE.md`, `docs/UX_BENCHMARKS.md`)
- [x] **Stage 1 Audit**: Full UX audit, state matrix, double-tap audit, interruption inventory, friction scorecard, UI-phase handoff (`docs/UX_AUDIT.md`, `docs/UX_PRINCIPLES.md`)
- [x] **Stage 2 UX Foundation**: `lib/core/ux/` motion tokens, haptics, skeleton kit, interaction primitives (`Pressable`, `SingleFlight`, `HoldRepeat`), Dev UX HUD
- [ ] **Stage 3 Navigation & Context**: Shell route state preservation, PageStorage keys, back gesture / predictive back, scroll restoration
- [ ] **Stage 4 Loading & Perceived Performance**: Shimmer skeletons, delay/hold logic, optimistic UI mutations, startup acceleration
- [ ] **Stage 5 Micro-interactions & Accelerators**: Spring press states, numeric steppers, haptic taps, auditory chimes, microcopy review
- [ ] **Stage 6 Scrolling & Runtime Performance**: List rebuild profiling, `RepaintBoundary` wrappers, Drift stream memory leak elimination
- [ ] **Stage 7 Core Café Flows Optimization**: 4-tap cash sale on POS, rapid checkout denominations, rush-hour interruption guards
- [ ] **Stage 8 First-Run & Onboarding**: Role-aware checklist for owner, 2-hint cashier intro, sample menu seeder, isolated Practice Sale mode
- [ ] **Stage 9 Remaining Modules Refinement**: Orders, Tables, KDS, Menu, Tenant Settings state-matrix alignment
- [ ] **Stage 10 Offline Experience**: Per-record sync indicators, sync centre, graceful offline banners with flapping suppression
- [ ] **Stage 11 Accessibility & Platform Craft**: Semantics pass, 200% text scale verification, high-contrast labels, edge-to-edge Android
- [ ] **Stage 12 Verification & Usability Testing**: 5-person unaided usability test, regression test suite, final benchmark sign-off

---

## Blockers & Dependencies
- None currently. All required Flutter capabilities, Drift local persistence, and test harnesses are operational.

---

## Evidence Log

| Date | Stage / Task | Action / Command | Result |
|---|---|---|---|
| 2026-11-15 | Setup | Save UX Master Prompt | `docs/UX_MASTER_PROMPT.md` written to repository |
| 2026-11-15 | Stage 0 | Reference device & baseline profiling | Created `docs/UX_BASELINE.md` with cold/warm start, tap counts, and frame budgets |
| 2026-11-15 | Stage 0 | Benchmark metrics setup | Created `docs/UX_BENCHMARKS.md` tracing PERF-01 through PERF-14 and FLOW-01 through FLOW-07 |
| 2026-11-15 | Stage 0 | Quality check | `flutter analyze` clean (0 issues), 77 tests green |
| 2026-11-15 | Stage 1 | Systemic UX audit | Created `docs/UX_AUDIT.md` (15 reference apps analysis, state matrix, double-tap audit, interruption inventory, friction scorecard) |
| 2026-11-15 | Stage 1 | Core UX principles | Created `docs/UX_PRINCIPLES.md` (the six pillars, two-speed architecture, rush-hour interruption policy, honest state) |
| 2026-11-15 | Stage 2 | UX Foundation Modules | Implemented `lib/core/ux/` (`motion_tokens.dart`, `haptic_service.dart`, `sound_service.dart`, `feedback_service.dart`, `single_flight.dart`, `pressable.dart`, `hold_repeat.dart`, `skeleton.dart`, `ux_hud.dart`) |
| 2026-11-15 | Stage 2 | Component Upgrades | Upgraded `AppButton` with `Pressable` and `singleFlightCallback`; upgraded `AppCard` with `Pressable` scale response |
| 2026-11-15 | Stage 2 | Component Gallery Lab | Added UX Primitives & Motion Lab section in `ComponentGalleryScreen` |
| 2026-11-15 | Stage 2 | Quality & Gate Checks | 88 tests green (11 new unit and widget tests), 0 analyzer issues |
