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
