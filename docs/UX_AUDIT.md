# CaféOS — Comprehensive UX Audit & Friction Inventory (Stage 1)

This document provides the systemic audit of CaféOS across all core modules, interaction models, performance bottlenecks, and usability edge cases.

---

## 1. Reference Apps: Interaction Analysis (Section 3 Borrow & Leave)

Treating the reference applications from Section 3 as interaction design lenses:

### 1. WhatsApp
- **What we borrow**: Local-first send lifecycle where actions commit instantly to local storage with distinct sync ticks (clock icon for local outbox pending, single tick for synced to server, double tick for receipt acknowledgment).
- **What we leave**: Consumer chat aesthetics, voice notes, and contact book synchronization.
- **Where it applies in CaféOS**: Per-invoice, per-order, and per-refund sync status badges; offline transaction resilience.

### 2. Instagram
- **What we borrow**: Smooth gesture-first scrolling, aggressive image prefetching, and the non-disruptive floating "N new posts" pill that allows users to refresh at their own pace without yanking scroll position.
- **What we leave**: Infinite feed distraction, social metrics, algorithmic reordering, and intrusive story carousels.
- **Where it applies in CaféOS**: Orders list and KDS live ticket streams when new tickets arrive while scrolling.

### 3. Pinterest
- **What we borrow**: Aspect-ratio-preserving skeleton placeholders that occupy exact geometric dimensions to prevent layout jumps as menu item thumbnails resolve.
- **What we leave**: Masonry stagger layouts (café menu grids must maintain strict tabular rows for rapid ocular scanning).
- **Where it applies in CaféOS**: Menu product catalog grid and modifier sheet image displays.

### 4. Apple Maps / Google Maps
- **What we borrow**: Fluid draggable bottom sheets with distinct snap points (peek, half-expanded, full-screen) that keep primary background context interactive while revealing drawer details.
- **What we leave**: Full map navigation overlays, turn-by-turn routing, and geographical searching.
- **Where it applies in CaféOS**: Phone POS sliding cart sheet and dining table session action sheet.

### 5. Things 3
- **What we borrow**: Direct physical manipulation, tactile micro-spring press feedback, smooth list reordering, and extreme restraint in animation duration (<200 ms).
- **What we leave**: Complex GTD nesting, project hierarchies, and desktop keyboard shortcuts unsuitable for kitchen touchscreens.
- **Where it applies in CaféOS**: Category reordering, item counter steppers, and drag-to-transfer table operations.

### 6. Linear
- **What we borrow**: Optimistic UI mutations everywhere, near-zero perceived latency, keyboard-first navigation accelerators, and local SQLite state caching.
- **What we leave**: Issue tracking syntax, dark hacker theme, markdown formatting bars, and engineering workflow states.
- **Where it applies in CaféOS**: Status bump in KDS, order cancellations, and instant catalog search filtering.

### 7. Duolingo
- **What we borrow**: "Value before effort" onboarding (letting users complete a real action before asking for configuration) and subtle haptic celebrations upon milestone completion.
- **What we leave**: Intrusive gamification streaks, cartoon mascots, lives/hearts penalties, and audio interruptions.
- **Where it applies in CaféOS**: First-run practice cash sale sandbox and owner setup checklist.

### 8. Swiggy / Zomato
- **What we borrow**: Multi-stage horizontal timeline indicator showing exact operational state progression (`Created ➔ Confirmed ➔ Preparing ➔ Ready ➔ Completed`).
- **What we leave**: Delivery driver tracking maps, tip nudges, discount coupons, and upselling carousels.
- **Where it applies in CaféOS**: Order history detail sheet and customer-facing QR order status screen.

### 9. UPI Apps (Google Pay, PhonePe)
- **What we borrow**: Unmistakable, sensory-reinforced payment confirmation: instantaneous high-contrast green checkmark, prominent amount in large tabular figures, and optional pleasant auditory chime.
- **What we leave**: Scratch cards, reward banners, consumer loan offers, and contacts sharing.
- **Where it applies in CaféOS**: Checkout tender confirmation and receipt generation screen.

### 10. Square / Toast POS
- **What we borrow**: High-velocity tender accelerators: 1-tap exact cash tender, large touch-friendly denomination chips (+₹100, +₹500), and offline financial safety guards.
- **What we leave**: Crowded enterprise legacy ribbons, deep modal submenus, and complex payroll integrations.
- **Where it applies in CaféOS**: POS counter layout and checkout payment modal.

### 11. Goodnotes (Google Play Best for Large Screens 2025)
- **What we borrow**: First-class tablet adaptations that use multi-pane master-detail layouts rather than stretched phone UI, preserving spacious touch targets.
- **What we leave**: Freehand drawing tools, notebook styling, and stylus pressure sensitivity.
- **Where it applies in CaféOS**: Tablet POS 2-pane catalog/cart and 3-column KDS station board.

### 12. Focus Friend (Google Play Best App 2025)
- **What we borrow**: Extreme visual calmness during high-stress operational periods and strict suppression of non-critical visual clutter.
- **What we leave**: Ambient sound generators, meditation timers, and journaling prompts.
- **Where it applies in CaféOS**: Cashier rush-hour interruption suppression policy.

### 13. Guitar Wiz (Apple Design Awards 2026, Inclusivity)
- **What we borrow**: Flawless scaling to 200% text size, high-contrast monochrome fallbacks, and complete visual independence from color alone (icons + text paired for status).
- **What we leave**: Musical notation typography, fretboard diagrams, and audio synthesis.
- **Where it applies in CaféOS**: High-contrast kitchen badges, accessible receipt previews, and sunlight-readable indicators.

### 14. Sago Mini Jinja’s Garden (Apple Design Awards 2026, Interaction)
- **What we borrow**: Zero-instruction tactile discovery: intuitive gestures (swipe, tap, pull) that communicate their affordance immediately without tutorial text.
- **What we leave**: Child-oriented preschool themes, bouncy cartoon physics, and decorative sound effects.
- **Where it applies in CaféOS**: Kitchen item strike-through toggling and table status bumping.

### 15. Moonlitt (Apple Design Awards 2026, Interaction)
- **What we borrow**: Physicality and direct scrubbing of live data cards with fluid spring-damping curves.
- **What we leave**: Stargazing astronomy visualizations and night sky palettes.
- **Where it applies in CaféOS**: Sales reporting time-slider scrubber and drawer float adjustment.

---

## 2. Architectural & Codebase Inspection

### 2.1 File & Module Organization
- **Current Architecture**: Clean feature-first organization under `lib/features/` (`billing`, `inventory`, `kitchen`, `menu`, `orders`, `reports`, `settings`) backed by `lib/core/` (`components`, `database`, `errors`, `identity`, `network`, `permissions`, `pricing`, `routing`, `theme`).
- **Data Layer**: 100% local-first via Drift SQLite (`AppDatabase`). Writes commit locally first and generate an atomic `sync_outbox_table` entry in the same transaction (ADR-D1).
- **Network Boundaries**: No UI screen waits synchronously on Supabase cloud network calls; all UI streams watch Drift queries, ensuring offline instant response.

### 2.2 Component Library Inspection
- `AppButton`: Supports `primary`, `secondary`, `outline`, `text`, `danger`. Lacks built-in single-flight flight locks; rapid double-tapping triggers duplicate handler invocations. Lacks micro-spring press animation.
- `AppCard`: Clean card container. Has no built-in touch ripple or press feedback when used as a clickable surface.
- `AppTextField`: Standard text input. Lacks automated focus advance on Enter and clear-button action.
- `CurrencyText`: Formats `Money` (integer paise) using tabular figures (`FontFeature.tabularFigures()`). Highly performant; prevents number jitter during rapid cart recalculations.
- `AppBadge`: Supports status tags with semantic colors. Text is capitalized; works well across contrast modes.
- `StateIndicators`: Basic `AppLoadingState`, `AppEmptyState`, `AppErrorState`. Uses generic `CircularProgressIndicator` which causes layout jumps when data loads; lacks skeleton layout parity.

### 2.3 Screen & Route State Scoping
- **GoRouter Configuration**: Configured with `ShellRoute` using `AppShell`. Tab switching currently reconstructs certain subtrees, resetting list scroll positions when switching between POS and Tables.
- **Provider Scoping**: StreamProviders watch SQLite database streams. When views are disposed and reopened, Drift stream subscriptions are re-created, generating microtask timers.

---

## 3. State Matrix Audit

Audit of all primary screens under edge conditions:

| Screen | Loading State | Empty State | Error State | Offline Behavior | 200% Font Scale | Extreme Data (>1k) |
|---|---|---|---|---|---|---|
| **POS Screen** | Spinner in catalog | Friendly empty catalog message | Error text with retry | 100% functional; reads SQLite | Cart pane wraps; requires scroll | Paginated catalog smooth |
| **Checkout Sheet** | Payment processing spinner | N/A | Alert dialog on failure | Cash allowed; digital warns | Keypad buttons shrink gracefully | N/A |
| **Dining Tables** | Spinner | "No tables configured" | Error message with retry | 100% functional; local sessions | Table cards expand vertically | 50+ tables scroll cleanly |
| **Kitchen KDS** | Spinner | "Kitchen is clear" empty board | Error state with retry | 100% functional; local tickets | Ticket item text wraps cleanly | 50+ tickets 3-column scroll |
| **Orders Screen** | Spinner | "No orders found" | Error message with retry | 100% functional; shows local sync | Table cards wrap; text legible | Needs indexed pagination |
| **Menu Screen** | Spinner | Empty catalog + demo seeder | Error message with retry | 100% functional | Form fields expand | Search filters fast |
| **Settings Screen**| Instant (local) | N/A | Form error banners | Local settings save to outbox | Settings rows wrap cleanly | N/A |

---

## 4. Double-Tap Audit (Single-Flight Vulnerabilities)

Identifying all buttons that trigger mutations without single-flight flight locks:

| Screen | Button / Action | Mutation Triggered | Double-Tap Behavior (Existing) | Severity | Remedy Required |
|---|---|---|---|---|---|
| **Checkout** | "Confirm Payment" | `createAndSettleOrder` | Could submit 2 invoices if RPC latency | 🔴 Critical | Wrap with `SingleFlight` guard |
| **Checkout** | Quick Denomination Chips | Adds cash to tender field | Rapid double tap adds double amount | 🟡 Medium | Debounce 100 ms |
| **Tables** | "Open Session" dialog button | `openSession` | Could try to insert 2 sessions | 🔴 Critical | Disable button while async in-flight |
| **Tables** | "Seat Guests" | `openSession` | Duplicate table session attempt | 🔴 Critical | `SingleFlight` guard |
| **Kitchen** | "Start Prep" / "Mark Ready" | `bumpTicket` | Could bump twice (Confirmed ➔ Ready) | 🔴 Critical | 300 ms flight lock + 5s undo |
| **Kitchen** | "Undo Bump" | `undoBump` | Accidental double tap cancels recall | 🟡 Medium | Single-tap flight lock |
| **Menu** | "Save Product" | `insertProduct` | Creates duplicate product entries | 🔴 Critical | `SingleFlight` guard on form |
| **POS** | Item Card Tap | `addItem` to cart | Adds quantity 2 on quick double tap | 🟢 By Design | Intentional accelerator |
| **POS** | "Clear Cart" | `clearCart` | Clears cart; idempotent | 🟢 Safe | Idempotent |
| **Settings** | "Save Settings" | `saveSettings` | Enqueues duplicate outbox mutations | 🟡 Medium | `SingleFlight` guard |

---

## 5. Interruption Inventory

Cataloging all modal alerts, snackbars, and sheets that could interrupt a busy cashier:

| Location | Trigger | Interruption Format | Risk During Counter Rush | Recommended Policy |
|---|---|---|---|---|
| **POS** | Network disconnect | Connectivity snackbar | Cashier distracted while ringing order | Suppress banner if cart.isNotEmpty; queue quietly |
| **POS** | Outbox sync error | Error alert dialog | Blocks checkout touch interaction | Silent outbox retry; log to diagnostic screen |
| **POS** | Cash Drawer Float warning | Floating notification | Pops up during cart assembly | Defer warning until checkout completes |
| **POS** | First-run onboarding hint | Tooltip overlay | Blocks view of top category chips | Max 1 hint; dismiss on any tap; never during cart |
| **Kitchen** | Network reconnect | Re-sync notification | Visual flash over ticket columns | Quiet reconciliation without toast |
| **Checkout** | Receipt Print Failure | Blocking dialog | Blocks ringing next customer | Non-blocking bottom banner with "Retry Print" |

---

## 6. Dead-End & Thumb-Reach Audits

### Dead-End Findings:
1. **Empty Search in Orders Screen**: When a search query yields no matches, there is no one-tap "Clear Search" button inside the text field, forcing manual backspacing.
2. **Order Detail Dialog**: Lacks a prominent primary "Done" or "Back" button at bottom on mobile screens; relies on tapping outside the modal barrier.
3. **Receipt Preview Screen**: After successful cash sale, cashier must tap "Done" to start a new sale. Lacks an optional auto-reset accelerator after 3 seconds for high-velocity bars.

### Thumb-Reach Audit (One-Handed Phone Operation):
1. **Phone POS Cart Button**: Currently positioned as a floating bar near the bottom. **Ergonomically excellent** for right or left thumb reach.
2. **Checkout "Confirm Payment"**: Sits in the bottom 25% of the screen. **Ergonomically sound**.
3. **POS Category Chips**: Located at top of screen under AppBar. On tall phones (6.7"), requires reaching to top 15% of viewport. Recommend swipe gesture across product grid to switch categories.
4. **Kitchen Bump Button**: Positioned at bottom of each ticket card. **Ergonomically accessible** on tablets and phones.

---

## 7. Usability Heuristics Review (Nielsen 10)

| Heuristic | Assessment | Grade | Finding & Recommendation |
|---|---|---|---|
| **1. Visibility of system status** | Real-time KDS timers & totals work well; per-record sync status needs clearer visual indicator. | B+ | Add subtle sync status pill (local / syncing / synced) to orders. |
| **2. Match between system & real world** | Terminology matches café domain ("Table", "KDS", "Float", "Tender", "Paise"). | A | Excellent domain alignment. |
| **3. User control & freedom** | Kitchen ticket bump has 5-second undo; order detail allows cancellation. | A- | Add undo to cart item deletion. |
| **4. Consistency & standards** | Uniform typography, colors, and button styles. | A | High design token consistency. |
| **5. Error prevention** | Validation on money and discount inputs; lacks single-flight flight locks on payment button. | B | Implement `SingleFlight` on all mutating buttons. |
| **6. Recognition rather than recall** | Category chips, product cards with prices, and quick denomination chips support recognition. | A | Excellent recognition ergonomics. |
| **7. Flexibility & efficiency of use** | Good on tablet; needs 1-tap exact cash tender accelerator on POS counter screen. | B+ | Add quick tender accelerator to save 1 tap in rush. |
| **8. Aesthetic & minimalist design** | Clean, uncluttered layout without extraneous decoration. | A | Uncluttered, purpose-driven UI. |
| **9. Help users recognize & recover from errors** | `AppFailure` translates technical errors to plain English; forms highlight invalid fields. | A- | Maintain input values on validation failure. |
| **10. Help & documentation** | Lacks role-aware onboarding checklist and first-timer contextual hints. | B- | Implement `HintService` and owner setup card in Stage 8. |

---

## 8. Friction Scorecard (Prioritized Implementation Plan)

| ID | Module / Feature | Existing Behaviour | UX Friction Caused | Pillar Violated | Recommended Fix | Impact | Logic Change? | Priority | Effort |
|---|---|---|---|---|---|---|---|---|---|
| **FR-01** | Checkout | "Confirm Payment" button can be tapped rapidly | Double submission risk | **Honest**, **Forgiving** | Wrap with `SingleFlight` lock | Zero duplicate invoices | No | 🔴 Critical | S |
| **FR-02** | POS Screen | Tablet POS requires opening checkout sheet for exact cash | Adds unnecessary tap in high-speed rush | **Instant**, **Calm** | Add "1-Tap Exact Cash" button directly in cart pane | Saves 1 tap (4-tap sale) | No | 🔴 Critical | M |
| **FR-03** | Core UI | Generic `CircularProgressIndicator` during data loading | Content jumps and shifts on load | **Continuous**, **Instant** | Implement Shimmer Skeleton Kit with 150ms delay / 300ms hold | Zero layout jumps | No | 🟠 High | M |
| **FR-04** | Core Buttons | Default Material ink splash has 100ms+ lag | Feels sluggish on tap | **Instant** | Build `Pressable` primitive with instant 98% scale down | Taps feel instant (<16ms) | No | 🟠 High | S |
| **FR-05** | Navigation | Switching tabs resets scroll position & search filters | Cashier loses context on return | **Continuous** | Use `PageStorageKey` and preserve route state in `AppShell` | Perfect state preservation | No | 🟠 High | M |
| **FR-06** | Tables Screen | "Seat Guests" / "Open Session" allows rapid double tap | Can trigger duplicate session | **Honest** | Single-flight button guard on table dialogs | Prevents race condition | No | 🟠 High | S |
| **FR-07** | Kitchen KDS | Bump button could be double-tapped accidentally | Order advances two steps | **Forgiving** | 300ms throttle on bump button | Eliminates accidental skips | No | 🟠 High | S |
| **FR-08** | Offline Engine | Network disconnect pops up immediate alert | Distracts cashier during payment | **Calm** | Debounce connectivity banner 3s; suppress if cart active | Zero interruptions in rush | No | 🟡 Medium | S |
| **FR-09** | Feedback | Mutations occur silently without tactile acknowledgment | Users unsure if tap registered | **Instant**, **Honest** | Add central `HapticFeedback` and optional subtle chimes | Tactile confidence | No | 🟡 Medium | S |
| **FR-10** | Menu / Catalog | Product list scrolling on cheap devices shows slight jank | Frame rate drops below 60fps | **Instant** | Wrap list items in `RepaintBoundary`; prefetch icons | Smooth 60/90Hz scroll | No | 🟡 Medium | M |
| **FR-11** | Orders List | Search field requires backspacing when no match | Extra keystrokes to reset | **Continuous** | Add 1-tap "Clear Search" icon button in text field | 1-tap search reset | No | 🟢 Low | S |
| **FR-12** | Onboarding | Novice cashiers see blank screen with no guidance | Hesitation on first use | **Inclusive** | Add 2-step contextual hint for first product & checkout | First sale in <90s | No | 🟢 Low | M |

---

## 9. UI-Phase Handoff List (Visual-Only Observations)

In accordance with Section 1 of `docs/UX_MASTER_PROMPT.md`, the visual design (colors, typography, card elevation, branding) remains strictly untouched during this UX engineering phase. The following visual items are recorded for the future visual refinement phase:

1. **Category Chip Border Contrast**: Category chips in light theme use `grey.shade200` border; under direct outdoor sunlight, inactive chip borders have lower contrast against white cards.
2. **KDS Ticket Header Badge Alignment**: In 3-column tablet view, the order number `#KDS-XX` has 2px vertical optical misalignment relative to the elapsed timer badge.
3. **Cart Item Divider Thickness**: 1px divider in the cart list has subtle opacity difference between light and dark themes.
4. **Number Pad Keypad Corners**: Tender keypad buttons use 8dp border radius while surrounding cards use 12dp. Visual harmony pass can unify border radii tokens.
5. **Table Status Dot Glow**: Occupied tables use a solid green dot; adding a subtle ambient ring would enhance visual affordance in dim restaurant environments.
