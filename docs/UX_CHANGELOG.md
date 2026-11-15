# CaféOS — UX Engineering Changelog

All UX, interaction, accessibility, and performance improvements across the CaféOS UX Phase are documented chronologically in this file.

---

## [Unreleased] - UX Phase Inception (2026-11-15)

### Stage 0: Baseline & Metrics Framework
- **Added**: `docs/UX_BASELINE.md` establishing hardware reference targets (4GB mid-range Android phone, 10-inch Android tablet) and initial baseline measurements.
- **Added**: `docs/UX_BENCHMARKS.md` defining 14 quantitative performance budgets (`PERF-01` to `PERF-14`) and 7 key workflow targets (`FLOW-01` to `FLOW-07`).
- **Added**: `docs/UX_PROGRESS.md` tracking the 13 UX execution stages (Stages 0–12).
- **Added**: `docs/UX_CHANGELOG.md` for historical change auditing.
- **Verified**: 77 unit & widget tests passing, zero issues in `flutter analyze`.

### Stage 1: Systemic Audit & Principles Definition
- **Added**: `docs/UX_AUDIT.md` containing borrow/leave analysis for all 15 reference apps (WhatsApp, Instagram, Pinterest, Apple Maps, Things 3, Linear, Duolingo, Swiggy, UPI, Square, Goodnotes, Focus Friend, Guitar Wiz, Sago Mini, Moonlitt), codebase review, complete State Matrix across 7 modules, Double-Tap vulnerability audit, Interruption inventory, Dead-end/Thumb-reach audits, and prioritized 12-item Friction Scorecard.
- **Added**: `docs/UX_PRINCIPLES.md` defining the Six Pillars (Instant, Continuous, Honest, Forgiving, Calm, Inclusive), Two-Speed Design (discoverable vs accelerator), Rush-Hour Interruption Purity Policy, and Honest State rules.
- **Added**: UI-Phase Handoff list capturing purely visual observations for future passes without altering current visual theme.

### Stage 2: UX Foundation Architecture
- **Added**: `lib/core/ux/motion/motion_tokens.dart` implementing `MotionDurations` (`micro: 100ms`, `short: 150ms`, `medium: 220ms`, `long: 280ms`), `MotionCurves`, and `Motion.of(context)` with OS/user reduced-motion auto-resolution.
- **Added**: `lib/core/ux/haptics/haptic_service.dart` providing semantic tactile patterns (`selection`, `lightTap`, `mediumTap`, `heavyTap`, `success`, `warning`, `error`) with enable/disable toggle.
- **Added**: `lib/core/ux/sound/sound_service.dart` providing non-intrusive operational chimes for new kitchen orders, payment confirmations, and alerts.
- **Added**: `lib/core/ux/feedback/feedback_service.dart` unifying motion, haptics, and sound into a single semantic API.
- **Added**: `lib/core/ux/interaction/single_flight.dart` and `singleFlightCallback` providing flight-lock protection against rapid double-taps on mutating buttons.
- **Added**: `lib/core/ux/interaction/pressable.dart` providing immediate (≤16ms) tactile press feedback scaling to 0.985x on pointer-down via `Listener`.
- **Added**: `lib/core/ux/interaction/hold_repeat.dart` providing accelerating hold-to-repeat gesture control for numeric steppers and quantity adjustments.
- **Added**: `lib/core/ux/loading/skeleton.dart` providing `Shimmer`, geometric placeholders (`SkeletonBox`, `SkeletonLine`, `SkeletonCircle`), and `DelayedLoading` (150ms delay to eliminate flash, 300ms minimum hold).
- **Added**: `lib/core/ux/metrics/ux_hud.dart` providing dev-mode FPS, jank percentage detection, and simulated network latency slider in `AppShell`.
- **Upgraded**: `AppButton` and `AppCard` in place to gain `Pressable` and single-flight flight locks without altering any visual styles, borders, or colors.
- **Upgraded**: `ComponentGalleryScreen` with Section 8: UX Primitives & Motion Lab.
- **Tests Added**: 11 new tests (`motion_test.dart`, `haptics_test.dart`, `ux_primitives_test.dart`), total 88 tests passing 100% green. Zero analyzer issues.
