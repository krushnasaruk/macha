# CaféOS — Experience Engineering Master Prompt

*UX phase · Flutter · Supabase · Drift · Riverpod · GoRouter. Save as `docs/UX_MASTER_PROMPT.md` and give it to the coding agent as the single source of truth for this phase.*

**How this prompt is organised:** sections 0–3 set the intent and the reference standard; section 4 is the measurable bar; sections 5–23 are the work; sections 24–27 are the execution protocol, acceptance criteria and final instruction.

---

## 0. Role and mission

Act as a senior UX engineer, interaction designer, Flutter performance engineer and mobile application architect.

You are working on **CaféOS**, a café management and billing application built with Flutter and Dart, Supabase (backend and database), SQLite via Drift (local, offline-first persistence), Riverpod (state) and GoRouter (navigation).

**Mission.** Make CaféOS feel like software people have used for years on the first day they open it, and keep it feeling effortless on the 500th sale of a Saturday rush.

Two people must be served at the same time:

- **The first-timer** — a new cashier or café owner who has never seen the app. They need clarity, safety and a quick first win.
- **The expert in a rush** — a cashier with one hand free and a queue in front of them. They need speed, muscle memory and zero interruptions.

Great apps serve both through progressive disclosure: the obvious path is always visible, accelerators sit underneath it, and nothing ever gets in the way.

---

## 1. Scope guardrails

**In scope:** interaction design, motion, haptics, sound, loading and perceived performance, navigation, state and context preservation, gestures, microcopy, first-run behaviour, accessibility behaviour, offline feedback, runtime performance and instrumentation.

**Out of scope: visual redesign.** Do not change the theme, brand, colours, typography, card styling, icon set or overall layout direction. Motion, haptics, sound and wording are not a visual redesign and are in scope. If a visual property causes a real usability defect (a touch target that is too small, text that fails contrast, an ambiguous status colour), record it in the audit under **UI-phase handoff** and make only the minimum fix needed to remove the defect.

**Hard rules carried over from the main project:**

1. Authentication is postponed to the final development stage. Do not add login, registration, session handling or auth-dependent UX. Do not change the development identity system.
2. Do not weaken database security, RLS or tenant isolation to make a UX feature work.
3. Preserve all existing business logic: tax, discount, invoice numbering, payments, refunds, inventory deduction, sync and idempotency.
4. Never show an unconfirmed financial transaction as complete. Never fake payment success.
5. Never silently discard user input or pending transactions.
6. Do not add a dependency for something Flutter already does. Any new package needs a compatibility review and a written justification.
7. Work incrementally. No big-bang rewrite.

**Precedence rule:** UX never overrides correctness. When speed and integrity conflict, integrity wins and the interface communicates a safe, honest pending state.

---

## 2. The experience we are building

### 2.1 What “feels great on first use” means

Apps that win design recognition, and apps people instantly like, share a small set of traits. Build all ten into CaféOS:

1. **Value before effort.** Let people do something real or realistic before asking them to configure anything.
2. **Zero-instruction controls.** Affordances teach the interface. Apple’s Interaction criteria reward intuitive interfaces and effortless controls tailored to the platform.
3. **Instant response.** Local-first data, one-frame acknowledgement of every tap.
4. **Continuity.** Motion explains where things came from and where they went. The user never loses their place.
5. **Honest state.** Always visible: saved on this device, syncing, confirmed, or needs attention.
6. **Forgiveness.** Undo beats confirmation dialogs. Every error has a way out.
7. **Calm.** One thing at a time, restrained attention, no noise competing with the task.
8. **Inclusive by default.** Large text, contrast, and meaning that never depends on colour alone.
9. **Native feel.** Respect Android: edge-to-edge, predictive back, haptics, real tablet layouts.
10. **Earned delight.** Rare, brief, skippable moments that appear only when something meaningful happened.

### 2.2 The six pillars (the acceptance lens for every change)

| Pillar | The test |
| --- | --- |
| **Instant** | Does the interface react within one frame and never wait for the network to show something it already knows? |
| **Continuous** | After any navigation, is the user exactly where they expect to be, with their search, filters, scroll and drafts intact? |
| **Honest** | Can the user always tell what is saved, pending, confirmed or failed, without checking? |
| **Forgiving** | Can a mistake be undone or recovered in one step, without losing work? |
| **Calm** | Would a stressed cashier be interrupted, distracted or slowed by this? |
| **Inclusive** | Does it work with big text, a screen reader, one hand, bright sunlight and a cheap phone? |

Every proposed change in the audit must name the pillar it serves. If it serves none, do not do it.

### 2.3 Designing for two speeds

- **Discoverable path:** labelled, visible, safe, guided on first use.
- **Accelerators:** favourites, recents, smart defaults, swipe actions, long-press menus, hold-to-repeat, barcode input, remembered choices. They never replace the discoverable path; they sit on top of it.
- **Interruption policy:** while a cashier has an active cart or an open payment, nothing non-critical may take focus (no tips, no promotions, no sync dialogs, no non-critical sheets). Queue it and show it later in a quiet, non-blocking way.

---

## 3. Reference apps and what to borrow

Study **interaction principles, not visuals.** Do not copy layouts, assets, branding or illustrations. For each reference below, write a three-line “what we borrow, what we leave” note in `docs/UX_AUDIT.md` (use the real app where possible). The award references come from public announcements (Apple Design Awards 2026, judged across Delight and Fun, Inclusivity, Innovation, Interaction, Social Impact and Visuals and Graphics; Google Play Best of 2025). Treat them as lenses, not specifications.

| Reference | Principle to borrow | Where it applies in CaféOS |
| --- | --- | --- |
| **WhatsApp** | Local-first send; delivery ticks that show clock → saved → delivered; works on poor networks | Per-record sync state; offline bills and orders |
| **Instagram** | Prefetch what is next; gesture-first; smooth media-heavy scrolling; “new posts” pill that never yanks the list | Orders list, menu grid, “N new orders” pill |
| **Pinterest** | Image placeholders that hold their space; infinite scroll with prefetch; no layout jumps | Product grid, image loading, pagination |
| **Apple Maps / Google Maps** | Draggable bottom sheet with snap points over persistent content | Phone POS cart, table session sheet |
| **Things 3** | Direct manipulation, quick entry, drag that feels physical, restrained motion | Reordering categories, quick add, table drag |
| **Linear** | Optimistic everything, speed as a feature, local-first sync that feels instant | Status changes, search, sync UX |
| **Duolingo** | Do before you configure; instant feedback; tiny celebrations with haptics and sound | First-run practice sale |
| **Swiggy / Zomato** | Live order tracking with a clear stage timeline | Order timeline, QR customer status screen |
| **UPI apps (Google Pay, PhonePe)** | An unmistakable payment-success moment: tick, amount, optional sound | Payment confirmation |
| **Square / Toast-class POS** | Fast tender: exact cash, quick denominations, offline tolerance | Checkout |
| **Goodnotes** (Play Best for Large Screens, 2025) | Real tablet adaptation rather than stretched phones | Tablet POS and kitchen layouts |
| **Focus Friend** (Play Best App, 2025) | Calm, single-purpose focus | Rush-hour interruption policy |
| **Guitar Wiz** (ADA 2026, Inclusivity) | Honouring text size, contrast and differentiate-without-colour settings | Accessibility pass |
| **Sago Mini Jinja’s Garden** (ADA 2026, Interaction) | Learn by doing; swipe controls that need no reading | Zero-instruction gestures |
| **Moonlitt** (ADA 2026, Interaction) | Direct, physical interaction with live data | Dashboard scrubbing, charts |

---

## 4. Experience budgets (the measurable bar)

Define a **reference device**: a mid-range Android phone (about 4 GB RAM, 60/90 Hz) and one 8–10 inch tablet. Measure in **profile mode** on real hardware, never in debug mode and never only on an emulator. The numbers below are starting targets; tune them against measured baselines and record the final values in `docs/UX_BENCHMARKS.md`.

| Area | Target |
| --- | --- |
| Cold start to interactive (cashier landing, cached menu) | ≤ 2.0 s; warm start ≤ 700 ms |
| Tap to visible feedback | ≤ 100 ms; aim for the next frame |
| Add item to cart → totals updated | Same or next frame |
| Frame budget while scrolling or animating | Build ≤ 8 ms, raster ≤ 8 ms; under 1 % janky frames over a 1,000-item list |
| Skeleton behaviour | Appears only if data takes longer than 150 ms; once shown, stays at least 300 ms (no flicker) |
| Local search over 5,000 records | ≤ 100 ms to first results |
| Remote search debounce | 200–300 ms |
| New order appearing on the kitchen board | ≤ 2 s after commit on a normal connection |
| Perceived local commit of a cash payment | ≤ 300 ms to the success state |
| Connectivity banner changes | Within 1 s of the change, debounced about 3 s to prevent flapping |
| Memory after 50 navigation round trips | No sustained growth |
| **Cash sale of two simple items, from the cashier landing screen** | **≤ 5 taps** |
| **First sale by a first-time user, no help** | **≤ 90 seconds** |
| Adding a first product by a first-time owner | ≤ 2 minutes |

---

## 5. First: audit the existing application

Before changing any code, inspect everything and produce `docs/UX_BASELINE.md` and `docs/UX_AUDIT.md`. Do not blindly rewrite anything; preserve all working functionality.

### 5.1 Inspect

1. The complete project structure and architecture.
2. Every screen, route, dialog, bottom sheet and navigation flow.
3. Riverpod providers and how state is scoped and watched.
4. Supabase repositories and Drift implementation; which screens read local data and which wait on the network.
5. Existing loading, empty, error and offline states.
6. Unnecessary rebuilds, expensive widget trees, main-isolate work, repeated queries, excess subscriptions, leaked controllers.
7. Navigation bugs, context loss, duplicate pushes, inconsistent transitions.
8. Interactions that take too many taps; operations that block the interface while waiting for the backend.

### 5.2 Measure the baseline (before touching anything)

Record, on the reference devices: cold and warm start; frame statistics while scrolling the longest list; time and tap count for these five flows: **first sale**, **add a product**, **advance an order status**, **receive stock**, **close the day**; memory after repeated navigation.

### 5.3 Additional audits

- **State matrix.** For every screen verify: loading, empty, error, offline, partial data, stale data, permission denied, very long text, 200 % text scale, many items.
- **Double-tap audit.** For every button that mutates data, what happens on a rapid double tap? List every one that is not single-flight and idempotent.
- **Interruption inventory.** Every dialog, snackbar, sheet or banner that could interrupt an active cashier.
- **Dead-end audit.** Screens where the user cannot tell what to do next or how to go back.
- **Thumb-reach audit.** Where the primary action of each screen sits relative to one-handed reach on a large phone.
- **Heuristic review** against the ten classic usability heuristics (visibility of status, match with real world, user control, consistency, error prevention, recognition over recall, flexibility, minimalism, error recovery, help).

### 5.4 `UX_AUDIT.md` format

For every issue: screen or feature; existing behaviour; UX problem; why it creates friction; pillar violated; recommended improvement; flow and tap count if relevant; baseline metric; whether it touches business logic; priority (Critical, High, Medium, Low); effort (S, M, L). Keep a separate **UI-phase handoff** list for purely visual findings.

---

## 6. First-run and onboarding experience

The first minute decides whether someone trusts the product. Build it without authentication; use the existing development identity and role selection.

### 6.1 Principles

- No tutorial carousels. No walls of text. No permission requests before the moment they are needed.
- The first real action is possible within seconds.
- Everything is skippable and resumable. Setup progress persists.

### 6.2 Role-aware first run

- **Owner:** a compact “Set up your café” checklist card on Home (café details, add the menu, add the first employee, connect a printer — optional). Each step completes inline and ticks itself off. The card disappears when finished and can be reopened from Settings.
- **Cashier:** lands directly on POS. A single hint on the first product tap, a second on the cart bar, then nothing more.
- **Kitchen:** lands on the board with a one-line explanation of the columns and a “Test the alert sound” action.
- **Inventory manager:** lands on overview with a prompt to start a first stock count or add a first ingredient.

### 6.3 Sample menu

Offer a one-tap “Load a sample menu” in the empty menu state. Sample records are flagged as demo data, shown with a subtle marker, and removable in one action. Never mix them silently with real data and never let them distort real reports.

### 6.4 Practice mode (“Try a practice sale”)

A safe sandbox that lets a first-timer ring up a full sale end to end. Strict isolation rules:

- It writes to a separate local namespace or flagged tables, never into real orders, invoices, payments or stock.
- It consumes no invoice numbers, creates no outbox rows, triggers no sync and no inventory deduction.
- A persistent, unmistakable “Practice mode” indicator is visible on every screen in it, with one-tap exit.
- It can never be entered accidentally while a real cart exists.

### 6.5 Contextual hints

Build a small `HintService`: each hint appears once, at the moment it is relevant, is dismissible with one tap, is stored as seen, and is replayable from Settings. Maximum one hint per screen visit. Never during an active payment, never while a modal is open.

### 6.6 Empty states are onboarding

Every empty list gets one plain sentence and one primary action (“No products yet. Add your first product.”). No illustrations are required; do not alter the existing visual language.

### 6.7 Just-in-time permissions

Ask for Bluetooth, camera, notifications or location only when the user triggers the feature that needs it, after a one-line explanation of why. If denied, explain how to continue without it and how to enable it later. Location is requested only if attendance geolocation is turned on.

### 6.8 Progressive disclosure

Keep the main path light. Split payments, batch operations, advanced discounts and rarely used fields live behind “More options”, never removed, never in the way.

---

## 7. Motion system

### 7.1 Principles

1. **Purpose:** animation explains what changed, where something came from or what was selected. If it explains nothing, remove it.
2. **Speed:** short, and never in the way of work.
3. **Physicality:** natural curves, interruptible, drag follows the finger.
4. **Consistency:** everything draws from shared tokens.
5. **Restraint:** at most one primary and two secondary animated elements per interaction.
6. **Respect:** honour reduced-motion settings completely.

### 7.2 Tokens (`core/ux/motion/`)

| Token | Duration | Use |
| --- | --- | --- |
| `micro` | 80–120 ms | Press feedback, small toggles |
| `short` | 120–180 ms | State change, selection, fade |
| `medium` | 180–260 ms | Page transitions, expand and collapse |
| `long` | 260–320 ms | Bottom sheets, large container changes |

Curves: enter `easeOutCubic`; exit `easeInCubic` at about 75 % of the enter duration; large or emphasised movement `easeInOutCubicEmphasized`; drag release uses a spring with centrally defined stiffness and damping. Expose them through one `Motion.of(context)` accessor that already resolves reduced-motion, so screens never read raw durations.

### 7.3 Patterns

- **Container transform:** order card → order detail; product tile → customisation sheet when it helps spatial understanding.
- **Shared axis:** checkout steps, settings hierarchy, wizard flows.
- **Fade through:** switching between bottom-navigation destinations.
- **Dialogs:** short fade with a very slight scale. **Bottom sheets:** slide up and follow the finger.
- **List changes:** size-and-fade for single user-initiated insertions and removals only. Bulk refreshes update in place without per-item animation.
- **Numbers:** totals tween briefly using tabular figures so width does not jitter. The accessible value is always the final value, and amounts on payment confirmation appear instantly.
- **Success mark:** a single drawn checkmark on payment success, once, not looping.

Evaluate Flutter’s official `animations` package against custom implementations for container transform, shared axis and fade through; adopt it only if it is maintained, compatible and measurably simpler.

### 7.4 Interruptibility and predictive back

Animations must be reversible mid-flight. Enable Android predictive back and verify, against current Flutter documentation, that route transitions support the back-swipe preview on the main flows. Sheets and dialogs must dismiss with the same gesture.

### 7.5 Motion performance

Dispose every controller. Prefer implicit animations and `*Transition` widgets. Avoid `Opacity` over large subtrees. Wrap frequently animating regions in `RepaintBoundary`. Never animate offscreen list items. Verify on a 90 or 120 Hz device.

### 7.6 Reduced motion

Respect the OS setting (`MediaQuery.disableAnimationsOf`) and add an in-app “Reduce motion” override. Replace movement with a fade or an instant change but **keep the state feedback**: colour, icon and text still communicate what happened.

### 7.7 Deliverables

`docs/MOTION_SYSTEM.md` and a development-only “Motion lab” screen that previews every token, pattern and reduced-motion variant.

---

## 8. Haptics and sound

### 8.1 Haptic vocabulary

Create one `HapticService` and never call platform haptics directly from screens. Prefer Flutter’s built-in `HapticFeedback`; evaluate a vibration package only if a required pattern cannot be achieved and the gain is measurable on target devices. Motors vary widely on Android, so test on at least three devices.

| Event | Feedback |
| --- | --- |
| Quantity step, tab change, picker tick, chart scrub point | Selection tick |
| Item added to cart, toggle flipped | Light impact |
| Status bump committed, drag snapped to a target | Medium impact |
| Payment recorded | Success pattern (medium, then light about 80 ms later) |
| Payment failed, hard validation block, stock limit reached | Two short pulses |
| Swipe action passes its commit threshold | Light impact, once |

**Rules:** never on scroll; never on every list tap; rate-limit to one pulse per 60 ms; respect the system haptics setting; provide an in-app On/Off; haptics always accompany, never replace, a visual state change.

### 8.2 Sound

- **Kitchen new-order chime:** on by default, configurable sound and volume, optional “repeat until seen” capped at three repeats.
- **Payment success sound:** optional, off by default (many cafes play music and share a counter).
- **Error sounds:** none.
- Keep sounds under one second. Use transient audio focus so background music **ducks** instead of stopping. Every sound has a visual and haptic equivalent. Evaluate a low-latency audio option before adding a package.

---

## 9. Gestures and direct manipulation

Gestures are accelerators. Each one must have a visible alternative (button or menu) and a screen-reader equivalent (custom semantics actions).

| Gesture | Where | Behaviour |
| --- | --- | --- |
| Swipe a row | Orders list; cart lines | Reveal the primary action (advance status, remove). Haptic at the commit threshold. Always followed by an Undo toast, except cancel, which confirms. |
| Long-press | Products, orders, tables | Quick-actions menu: mark unavailable, print or reprint, copy order number, transfer, merge. |
| Drag handle | Categories, modifiers, favourites | Reorder with a lifted, physical-feeling drag and a spring settle. |
| Drag onto a target | Order → table, table → table | Transfer or merge, with a confirmation naming the consequence. |
| Hold a stepper button | Quantity and stock steppers | Repeat; accelerate after about 400 ms; clamp at limits with a subtle reject haptic. |
| Pull down | Lists | Refresh; content stays in place. |
| Drag or swipe down | Sheets | Dismiss, unless a critical operation is running. |
| Edge swipe | System | Predictive back. Keep swipe-to-act zones clear of the screen edges. |

**Discoverability:** show each swipe or long-press hint once, through the `HintService`, with a brief “peek” of the action. **Reachability:** on phones keep primary and frequent actions in the lower third; on tablets use side panes and persistent panels rather than top-corner buttons.

---

## 10. Navigation, state restoration and context

### 10.1 Rules

- Predictable transitions per navigation type; clear parent-child relationships.
- Back always behaves the same way.
- No duplicate screens on the stack; rapid double taps never navigate twice.
- Returning to a screen restores search, filters, sort, tab, scroll position and drafts.

### 10.2 Implementation guidance

- Use `StatefulShellRoute.indexedStack` (or the current equivalent) so each top-level destination keeps its own stack, scroll position and filters.
- Add a `NavigationGuard` that ignores a second navigation to the same location within about 400 ms.
- Define, per flow, whether to `push`, `go` or `replace`; document it in `docs/NAVIGATION.md`.
- Keep search, filters and sort in feature-scoped Riverpod providers keyed by branch, **not** in widget state. Keep drafts and carts in Drift. Keep scroll offsets in a restoration-aware store.

### 10.3 What persists, and when it expires

| State | Lifetime |
| --- | --- |
| Search query, filters, sort, selected tab | Session; reset on branch or role switch |
| Scroll position | Session; reset when the list is refreshed from empty |
| Report date range | Session; reverts to “Today” on a new day |
| Form drafts | Until saved or discarded; expire after a configured number of days |
| POS cart and held orders | Persisted in Drift until completed or discarded |
| Anything role-sensitive | Cleared on role or branch switch |

### 10.4 Restoration after process death, rotation and window resize

Use Flutter’s restoration APIs for navigation and key UI state. If Android kills the app while the cashier is on checkout, the restored screen must be derived from the **database** (payment recorded or not), never from stale UI memory. Rotation and window resizing must never lose a cart, a form or a scroll position.

### 10.5 Where the user lands after an action

| After | Land on |
| --- | --- |
| Bill completed | Success screen → “New sale” returns to POS with the last-used category |
| Product saved | The list, scrolled to the item, highlighted briefly |
| Refund recorded | Order detail, updated |
| Form cancelled | The previous screen, untouched |
| Goods received | The purchase order detail |
| Notification tapped | The relevant order, with back leading to the list |

### 10.6 Back behaviour

Back closes the top overlay first; then, if the screen is dirty, offers **Keep editing / Save draft / Discard**; then pops. At a tab root it returns to the primary tab, and exits only from there; with an active cart it asks once before exiting. Back is blocked only while a critical operation has not yet become durable.

---

## 11. Perceived performance: loading and progressive content

### 11.1 Stale-while-revalidate

Read local data first, show it immediately, revalidate in the background, then update in place without flashing. Where stale money figures could mislead (dashboard, reports), show a quiet freshness label (“Updated 2 min ago”).

### 11.2 Loading types

| Situation | Treatment |
| --- | --- |
| First load, no cache | Skeleton matching the content |
| Cached data available | Show it; revalidate silently |
| Refresh | Pull indicator; content stays |
| Next page | Small footer indicator |
| Submitting | Loading state on the button itself |
| Background sync | Quiet status chip, never a blocker |
| One component slow | Local placeholder for that component only |

### 11.3 Skeleton kit

Build skeletons for dashboard cards, sales summaries, product grids and lists, order lists and details, inventory, employees, customers, reports and charts, profile and settings. Rules:

- **Geometry parity:** a skeleton occupies the same space as the real content; verify with widget tests that compare layout size so nothing jumps on reveal.
- One shared animation controller drives all shimmer on a screen.
- Appears only after 150 ms, stays at least 300 ms once shown; crossfade out in about 150 ms.
- Static placeholder under reduced motion.
- Never shown when cached data exists.

### 11.4 Images

Placeholders hold the final aspect ratio; decode at display size; use the disk cache; prefetch the next category’s images; fade in over about 120 ms; fall back to a neutral initial-letter tile on error. Images never block layout or interaction. Evaluate a tiny blur-style placeholder only if it is measurably worth the complexity for the menu size.

### 11.5 Prefetching and warm-up

On POS open, prefetch the first category’s images. On the orders list, prefetch details for the first visible rows. Warm the Drift connection and key providers behind the native splash, in parallel with a sensible cap.

### 11.6 Startup

Use the Android 12 splash API for an instant first frame. Defer non-critical work (printer discovery, realtime connection, sync, analytics-style instrumentation) until after the first interactive frame. Measure with a profile build and the timeline.

### 11.7 No layout jumps

Reserve space for everything that loads. Animate size changes. When content is inserted above the viewport, preserve the scroll anchor so the user’s eyes stay on the same row.

### 11.8 Long operations

Exports, PDFs and heavy reports run in an isolate with a localised, labelled progress state. The user can leave the screen; completion is announced quietly.

---

## 12. Optimistic UI, undo and trust

### 12.1 What may be optimistic

Because CaféOS is local-first, “optimistic” mostly means **commit locally, show it instantly, show sync status separately**. Safe to apply instantly: cart edits, availability toggles, kitchen status bumps, stock views, filters, favourites, reordering.

### 12.2 What is never optimistic

- A digital payment is not successful until the provider confirms it; show **Awaiting confirmation** with a cancel option.
- A cash payment is shown as **Recorded** only after the local transaction has committed, with a “will sync” chip while offline, exactly per the existing offline rules.
- Refunds, invoice issuance, cash-session closure and anything that needs approval show a pending state until durable.

### 12.3 Failure recovery

Restore the previous state, keep everything the user typed, explain in one line, offer **Retry** where it makes sense. Add a small shared helper for optimistic actions only if it removes duplication in at least three features.

### 12.4 Confirm, undo or neither

| Action class | Pattern |
| --- | --- |
| Reversible and cheap (remove a cart line, bump a status, toggle availability, discard a held cart) | No confirmation. Undo toast for about 5 seconds. |
| Reversible but consequential (cancel an order, void an item) | Confirmation that names the consequence; audit record. |
| Irreversible or financial (refund, close cash session, adjust stock) | Explicit confirmation with specifics (“Refund ₹250 to Cash?”). Reversals are new records, never undo. |
| Deleting master data | Archive by default; permanent delete only when no history exists. |

Undoing an unsent, non-financial UI change may drop it. Anything in a financial or inventory **ledger** is only ever reversed by a new compensating entry.

### 12.5 Single-flight and idempotency

Wrap every mutating action in a `SingleFlight` guard: the first tap runs, further taps are ignored while pending, and the button shows a localised progress state (not a greyed-out dead button). The operation also carries an idempotency key from the existing sync layer. Write a double-tap test for every mutating control found in the audit.

### 12.6 Back and gestures during critical operations

While a payment, refund or sync-critical write is in flight and not yet durable, intercept back and dismiss gestures with a short explanation (“Recording payment…”), and release them as soon as the state is durable.

---

## 13. Micro-interactions and moments that matter

### 13.1 Core controls

- **Buttons:** pressed state in one frame via a shared `Pressable` primitive (subtle scale or tonal change); keep the Android ripple; minimum 48 dp target; never delay the action.
- **Cards and rows:** consistent press feedback, no bouncing, selection that crossfades.
- **Checkboxes and toggles:** animate state, never show an inconsistent intermediate state.
- **Quantity steppers:** instant value, brief number swap animation, hold-to-repeat, clamped at stock or limits with inline explanation, totals always in sync even under rapid taps.
- **Search:** see section 15.

### 13.2 Forms

- Validate on blur after first interaction and on submit (`AutovalidateMode.onUserInteraction`); no red before the user has touched a field.
- On submit failure, focus and scroll to the first invalid field; keep all entered data.
- `TextInputAction.next` through the form and `done` at the end; the correct keyboard for each field; numeric fields select all on focus and use locale formatting (`en_IN` grouping for rupees).
- Keep the focused field visible above the keyboard.
- Auto-save drafts for long forms (product, supplier, purchase order). Back on a dirty form offers Keep editing, Save draft or Discard.
- Keep the submit button enabled and tell the user what is wrong rather than disabling it silently.
- On success, give inline confirmation and move to a meaningful place (see 10.5).

### 13.3 Moments that matter (the delight budget)

| Moment | Treatment | Limits |
| --- | --- | --- |
| Payment recorded | Drawn checkmark (about 400 ms), success haptic, amount and change due, optional sound | Always skippable by tapping **New sale**; never blocks the next sale |
| First sale ever | One quiet line such as “First sale recorded.” | Once only |
| Order ready (for waiter or cashier) | One subtle badge pulse | Once per order |
| Day closed | Clean summary with total, order count and best seller; share action | Once per day |
| Low-stock item resolved | Small tick | Brief |

**Never** gamify money (no streaks, confetti or points around payments), never stack two delight moments, never show one during a rush interruption, and always provide a static variant for reduced motion.

---

## 14. Feedback hierarchy and microcopy

### 14.1 Feedback hierarchy

| Level | Use | Example |
| --- | --- | --- |
| 0 | Visible state change, no extra feedback | Item appears in cart |
| 1 | Inline micro-feedback | Number tick, check mark, field highlight |
| 2 | Transient toast, with Undo when relevant | “Item removed · Undo” |
| 3 | Persistent slim banner | Offline, sync needs attention, not receiving live orders |
| 4 | Sheet or dialog | A decision with consequences |
| 5 | Full-screen blocking | Only for truly fatal states |

**Toast rules:** one at a time, replacing rather than stacking; placed above the bottom bar or cart bar and never over a primary action; 4 s (8 s when it has an action); screen-reader announced; never for background sync success or anything already visible.

**Banner rules:** at most one at a time; tappable for details; collapses to a small status chip while a cart is active.

### 14.2 Microcopy rules

- Plain verbs, sentence case, say what will happen (“Charge ₹250”, not “Submit”).
- No blame, no jargon. Never show words such as outbox, idempotency or conflict; say “Needs your review”.
- Confirm buttons repeat the verb (“Cancel order” / “Keep order”).
- Sync vocabulary, used everywhere: **Saving… · Saved on this device · Synced · Needs attention**.
- Every error follows the three-part pattern: what happened, whether the data is safe, what to do next.
- Centralise all strings in ARB files and keep a glossary in `docs/UX_COPY.md`.

---

## 15. Speed tools: search, favourites and smart defaults

### 15.1 Search

- Local-first indexed search (Drift FTS or an in-memory index) with prefix and token matching, case and diacritic tolerance, optional light typo tolerance.
- Results update as the user types; previous results stay visible while refreshing; query and filters persist per screen; clear button; last five recents per feature.
- **In POS:** after tapping a result the item is added, a brief “Added” mark appears, and the search field stays focused, so rapid multi-add works. The keyboard closes only on scroll drag or an explicit action.
- **SKU and barcode:** a hardware scanner (which types like a keyboard) adds the matching item anywhere in POS. Camera scanning is optional.

### 15.2 Smart defaults (rule-based, local, transparent, switchable)

- Remember the last category per cashier and device.
- A **Frequently sold** row computed from the last 14 days for the branch.
- Default order type from context (a selected table implies dine-in; otherwise the last used).
- Remember the last payment method; suggest quick cash amounts.
- “Same as last time” chip for a product’s customisation.
- Recent customers.
- Inventory: items below reorder level grouped by supplier, with a one-tap **draft** purchase order that still needs review.
- Report date range defaults to Today.

**Muscle-memory rule:** the main menu grid never reorders itself. Only the dedicated Frequent row adapts. Every default can be turned off in Settings, and nothing is hidden behind opaque ranking.

### 15.3 Hardware keyboard (tablets)

Nice to have: `/` focuses search, Enter charges, Esc closes the topmost sheet.

---

## 16. Scrolling and runtime performance engineering

### 16.1 Lists

Use builders and slivers; `itemExtent` or `prototypeItem` for fixed-height rows; stable keys from entity IDs plus `findChildIndexCallback`; `const` item widgets that receive immutable view-models rather than watching providers; no `ListView` inside a `Column` without constraints; platform-default scroll physics; `AutomaticKeepAlive` only where measured to help.

### 16.2 Pagination

Use keyset pagination (cursor on `created_at` and `id`), not offsets; page size 30–50; prefetch at about 70 % of the scroll extent; de-duplicate by ID; show a footer loader; never block on a total count. Remote pages merge into Drift so the UI only reads from local storage.

### 16.3 Pull to refresh

Content stays, filters stay, no flash. Show “Updated just now”. On failure, show an inline retry banner instead of wiping the list.

### 16.4 Realtime

Scope subscriptions to the relevant branch and visible screens and dispose them on leave. Buffer bursts for 100–200 ms. De-duplicate by ID and version. On reconnect, reconcile with a delta fetch from the last cursor. New items while the user is scrolled down appear as an **“N new” pill** (never a jump); at the top they insert with a brief highlight of at most 1.5 seconds.

### 16.5 Riverpod

Use `select` to watch only what a widget needs; split providers by concern; use `ref.listen` for side effects; key families by branch and filter; compute totals once in a dedicated provider; never run heavy work in `build`. Keep the cart in an isolated provider tree so a quantity change does not rebuild the catalogue; a product tile rebuilds only when its own quantity or availability changes.

### 16.6 Drift

Run the database on a background isolate; keep `.watch()` queries narrow; add indexes for filter and sort columns; batch writes in transactions; avoid N+1 patterns; inspect slow queries with the query planner.

### 16.7 Off the UI isolate

CSV and PDF export, report aggregation, large JSON parsing and image processing run in `Isolate.run` or `compute`.

### 16.8 Rendering

Confirm which renderer is active and check for shader-compilation jank on the reference devices. Use `RepaintBoundary` around constantly updating regions (cart total, timers). Avoid `saveLayer` triggers (`Opacity`, anti-aliased clips, `ShaderMask` over large areas). **Kitchen timers share one 1 Hz ticker for the whole board**, not one per card.

### 16.9 Memory and lifecycle

Dispose every controller and subscription; cap the image cache; pause streams and tickers when the app is backgrounded (the kitchen board intentionally keeps listening); verify no sustained memory growth after 50 navigation round trips.

### 16.10 Process

Profile on real devices in profile mode with DevTools (Performance, Memory, rebuild tracking). Record before and after numbers in `docs/UX_BENCHMARKS.md`. Optimise only what was measured. Add automated frame-timing checks for the three heaviest screens.

### 16.11 Cache correctness

Key every cache by tenant and branch. Every cached financial or inventory figure carries an `asOf` time and is invalidated by the writes that affect it. Never serve cached data across a branch or role switch. Never let a cache make a number look more current than it is.

---

## 17. Café-specific flows

A café employee is fast, interrupted, often one-handed and rarely looking at the screen for long. Every flow below is judged against that person.

### 17.1 POS and billing (highest priority)

**The path:** open POS → tap items → (modifiers only when required) → **Charge** → tender → success → **New sale**.

**Layout behaviour**

- **Phone:** sticky category chips, a stable-order product grid, and a bottom **cart bar** (item count, total, Charge). The cart bar expands by dragging into a cart sheet with snap points (peek, half, full), like a map’s bottom sheet. Switching category never closes or resets the cart.
- **Tablet landscape:** product grid on the left, persistent cart pane on the right. **Tablet portrait:** grid with a bottom cart.

**Adding items**

- A product with no required choices is added **instantly** on tap: light haptic, quantity badge on the tile, cart total ticks.
- After the first add, the tile’s Add control turns into an inline **− / +** stepper (the pattern food-delivery apps use), so quantity changes never reopen product details.
- Long-press opens customisation and notes. Required modifiers open a bottom sheet with sensible defaults preselected, a **Same as last time** chip, a running price and a one-handed **Add · ₹X** button.

**Holds and discounts**

- **Hold** is a secondary action; held carts appear as a chip strip with a count; resume in one tap.
- Discount presets as chips plus a custom value, always respecting the permission engine. If the user lacks permission, show **Needs manager approval** and a pluggable approval hand-off. Do not build real authentication.
- Customer selection is optional and never blocks billing.

**Checkout**

- Phone: a sheet over the cart. Tablet: a side panel. Totals cannot change after **Charge** is tapped.
- **Cash:** the **Exact amount** button is primary; quick denominations derived from the total and the currency (configurable); a large numeric keypad with haptics; change due shown large.
- **Split:** “Add another payment”, with a running remainder.
- **UPI and card:** show **Awaiting confirmation** with a cancel option; success only on provider confirmation; failure offers retry or another method.

**Success**

Amount, change due, drawn checkmark, success haptic. **New sale** is the primary action; **Print**, **Share receipt** and **View bill** are secondary. Printing is a non-blocking chip (**Printing… / Printed / Printer not connected · Retry · Skip**) and never delays the next sale. Optionally auto-start a new sale after a configurable delay.

**Tap budget:** a two-item cash sale from the cashier landing screen is item, item, Charge, Exact amount: **four taps**.

### 17.2 Customer QR ordering (if present in the codebase)

This is the most important first-use moment because the customer has never seen the app.

- Menu visible in ≤ 2.5 s on a typical 4G connection; no sign-in wall; skeleton first; the table is shown clearly.
- Sticky cart bar, modifier sheet, one-tap order placement protected by an idempotency key against double submission.
- After ordering: order number and a live **status timeline** (Received → Preparing → Ready → Served), in the spirit of food-delivery trackers. A **Request bill** action.
- Friendly handling of invalid, expired or revoked QR codes. Cart survives a refresh. No path into staff features. Works with large text.

### 17.3 Orders

- Status segments with counts and persistent filter chips; search by number, table or customer; date-range sheet.
- New orders appear without refresh: inserted at the top with a brief highlight, or an **“N new” pill** if the user has scrolled.
- Swipe to advance a status, with Undo. Status changes animate the row out of or into the filtered view in place; no page reload.
- Order detail opens with a container transform and a timeline; back restores the list exactly as it was.

### 17.4 Tables

- Tiles show status and elapsed time. Tapping an empty table opens POS with it preselected; tapping an occupied table opens a session summary sheet (orders, running total, add items, request bill, transfer, merge).
- Long-press for quick actions; drag a table or order onto another to transfer or merge, with a confirmation that names the effect.
- QR generation and sharing in one tap.

### 17.5 Kitchen display

- Very large, glanceable cards; tap a card to advance it; **Undo** for five seconds; a “recently bumped” drawer to recall a ticket.
- New tickets get a brief highlight and a chime (optional repeat until seen, capped); no infinite pulsing. Aging indicators use the existing colour tokens with icon and text, not colour alone.
- Per-station filtering. Keep the screen awake in kitchen mode.
- **Silent failure is dangerous here:** if live updates drop, show a prominent but calm **“Not receiving new orders · reconnecting”** banner, reconnect automatically, reconcile on return and optionally sound once when the connection is lost.

### 17.6 Inventory

- Instant local search; stock operations confirm inline (“Milk 12 L → 10 L · Undo”). Undo creates a reversing ledger entry; it never rewrites history.
- **Quick count mode:** one ingredient per screen with a big numeric stepper, unit chips, next and previous, auto-save per item, and progress (“12 of 48”).
- Wastage with one-tap reason chips. Low-stock indicators update the moment fresh data arrives, without a full refresh.

### 17.7 Suppliers and purchases

Goods receipt is a checklist: tap a line to confirm full quantity, expand it for partial, damaged or missing, or use **Receive all**. A summary precedes confirmation; stock updates with clear feedback. Supplier phone and messaging shortcuts one tap away.

### 17.8 Employees and attendance

Clock in and out in one tap from the shell, with the current state always visible. Offline entries are labelled “Recorded on this device”. Correction requests and manager approvals are short, list-based flows.

### 17.9 Dashboard and reports

- First viewport is a glance: today’s revenue, orders, average order value, pending orders, each with a quiet comparison to the same weekday last week.
- Cached summaries show first; refreshed values update in place without re-skeletoning; each card rebuilds independently.
- Charts update subtly; touch-scrubbing shows values with selection ticks. Tap a metric for a container transform into its report; the period and filters persist.
- Freshness label on money figures. Empty state: “No sales yet today. Your first sale will appear here.”

### 17.10 Close the day

A guided, resumable flow: count cash → review variance (with an explanation of how it was calculated) → summary → share or print → done. Reachable from the dashboard and POS. Offer an optional local reminder at the configured closing time.

---

## 18. Offline-first experience

### 18.1 Two separate ideas

Show **connectivity** (online, offline, flaky) and **sync state** (idle, syncing, N pending, needs attention) as one small `SyncStatusChip` in the shell. When everything is fine it is nearly invisible; it grows only when attention is needed.

### 18.2 Per-record states

Bills, orders, payments, stock movements and attendance rows carry one of **Saving… · Saved on this device · Synced · Needs attention**, as a small glyph (clock → check → double check, in the spirit of WhatsApp ticks), shown in lists only when not yet synced.

### 18.3 Payment wording

- Cash, offline: **Recorded on this device · will sync**.
- UPI or card, offline: **Can’t confirm this payment without internet. Take cash or try again when you are back online.** Never mark it successful.

### 18.4 What works offline

Works: cached menu, cart, order creation, cash billing, invoice and receipt from the local snapshot, printing, viewing cached stock (flagged with its age). Needs connectivity: digital payment confirmation, QR customer orders, live cross-device kitchen updates, fresh reports. Say so in plain language at the point where it matters.

### 18.5 Connectivity changes

Debounce by about 3 seconds. No modals. On loss: a slim banner, “You’re offline. Sales are being saved on this device.” On return: “Back online · syncing 3 items”, then quiet. Never block the cashier because sync is running.

### 18.6 Sync centre

A plain-language screen listing pending, failed and review-required items, with **Retry**, **View** and **Resolve** per item and a count badge in the menu. Retries use visible, bounded back-off.

### 18.7 Conflicts

Explain in one sentence, show both versions, offer one-tap choices with their consequences. Never discard automatically. Review-required items persist until resolved. Financial conflicts are restricted by the permission engine.

### 18.8 Background sync honesty

Sync on app resume, on connectivity return and periodically with back-off. Android may defer background work, so never promise it. If data has not synced, say so and say what to do (“Open the app on Wi-Fi to finish syncing”).

---

## 19. Errors and recovery

Every error answers three questions: **what happened, is my data safe, what can I do now.** Never show stack traces or raw backend messages.

| Situation | Treatment |
| --- | --- |
| No network | Keep working with cached data; slim banner; supported actions queue |
| Request timed out | Inline retry on the affected component; the rest of the screen stays usable |
| Could not save | Keep the form as typed; say what failed; **Retry** and **Save draft** |
| Validation | Inline at the field, after interaction, with how to fix it |
| Printer unavailable | Payment unaffected; chip with **Retry**, **Choose another printer**, **Skip** |
| Sync conflict | “Needs your review” with both versions |
| Product no longer available | Highlight the line, offer **Remove** or **Replace**, keep the rest of the cart |
| Permission denied | Explain what is needed and who can do it; offer the approval hand-off |
| Payment failed | Clear reason, nothing recorded, offer retry or another method |
| Unexpected error | Friendly message, work preserved; technical details only in development builds |

Use inline errors for fields, banners for ongoing states, sheets for decisions, and full-screen only for fatal states. Route global Flutter and platform errors through one handler that logs safely and shows a recoverable message.

---

## 20. Accessibility, inclusion and localisation

- **Targets and focus:** minimum 48 dp targets (larger on the kitchen board); clear focus indicators; logical focus order; full keyboard operability on tablets.
- **Screen readers:** labels that include price and quantity; custom semantics actions for every gesture; live-region announcements for important changes (a new kitchen order, an error), throttled so they never flood.
- **Text scale:** layouts must survive 200 % without clipping or hidden primary actions; test at 1.3 and 2.0.
- **Colour:** meaning never depends on colour alone (status uses icon and text). Where the existing palette fails contrast, report it under **UI-phase handoff** rather than redesigning.
- **Motion and haptics:** reduced-motion support and an in-app haptics toggle.
- **Inputs:** one-handed reach, left- and right-handed comfort, external keyboard, hardware barcode scanner.
- **Localisation readiness:** all strings in ARB; Hindi and Marathi readiness (Devanagari renders without clipping); 40 % text-expansion tolerance; `en_IN` number and currency formatting (lakh and crore grouping); 12 or 24 hour time by locale.
- Use Flutter’s accessibility guideline checks in widget tests for tap-target size, labelled targets and text contrast.

---

## 21. Android platform craft and tablets

- **Edge-to-edge** with correct inset handling; system bar contrast.
- **Predictive back** (see 7.4) and consistent back semantics (see 10.6).
- **Native splash** and a fast first frame (see 11.6).
- **Keep screen on** in kitchen mode and, optionally, during an active POS session.
- **Notification channels** with sensible importance: new orders, low stock, sync needs attention, daily close reminder. Notifications deep-link to the exact screen.
- **App shortcuts** (long-press on the launcher icon): New sale, Kitchen. Treat as a stretch goal.
- **Orientation and window changes:** rotation, split-screen and resizable windows never lose state.
- **Tablets:** dedicated two-pane layouts for POS, orders and kitchen; never a stretched phone layout.
- **Battery and heat:** no busy loops, pause tickers when backgrounded, avoid wake-ups.

---

## 22. UX architecture and instrumentation

### 22.1 Structure

Keep the current architecture. Add the UX layer in one place, with no business logic in it:

```text
lib/core/ux/
  motion/        tokens, Motion.of(context), transitions, reduced-motion
  haptics/       HapticService
  sound/         SoundService
  feedback/      toast, banner, undo, status chip
  loading/       skeleton kit, delayed-loading helper
  interaction/   Pressable, SingleFlight, NavigationGuard, HoldRepeat
  restoration/   state restoration and persisted UI state
  hints/         HintService
  metrics/       UxMetrics, FrameMonitor, dev HUD
  copy/          string keys and glossary helpers
  a11y/          semantics helpers
```

Upgrade the **existing** design-system components (`PrimaryButton`, `AppCard`, `ProductCard`, `OrderCard`, and so on) in place so that they gain these behaviours without any visual change. Feature code consumes the UX layer; it never reimplements it.

### 22.2 Instrumentation (local and privacy-safe)

- A local `ux_metrics` table records flow start and end, tap counts, duration, frame-timing summaries and error categories. **No personal data, no network upload, no third-party analytics.**
- A development-only **UX HUD** overlay: FPS and jank, rebuild counts, connectivity and latency simulation, forced-failure injection, motion-lab shortcut.
- Metrics export as JSON to feed `docs/UX_BENCHMARKS.md`.
- A latency and failure injection layer in the repository boundary so slow networks and failures are testable without touching the real network.

---

## 23. Testing and quality assurance

**Interaction tests:** repeated taps never duplicate an action; sheets open and close correctly; navigation preserves state; forms preserve data after validation failure; search and filters persist; keyboard behaviour; loading states transition correctly.

**Performance tests:** scroll the longest lists; 50 navigation round trips; open and close sheets repeatedly; switch dashboard sections; large datasets; slow network; temporary disconnection; automated frame-timing checks on the three heaviest screens.

**Business workflow tests:** create and modify an order; complete billing; confirm payment safely; handle a failed operation; update inventory; receive a realtime update; return without losing context; offline sale then sync; duplicate sync produces no duplicate invoice.

**Accessibility tests:** guideline checks in widget tests; a TalkBack walkthrough of the first sale; 200 % text; reduced motion on.

**Skeleton parity tests:** geometry comparison between skeleton and loaded states.

**Rush simulation:** a scripted run of 30 sales in 10 minutes with injected interruptions (sync events, realtime orders, an offline period) that must never steal focus from the active cart.

**Device matrix:** a normal phone, a small phone, a large phone, a 7-inch tablet and a 10-inch tablet, at 60 Hz and at a higher refresh rate where available.

**First-use usability test (required):** five people who have never seen the app, ideally real café staff, each given only a role: ring up a first sale; add a product; mark an order ready; receive stock; find today’s revenue. Record time, taps and every hesitation. Fix the top issues and retest. Target: first sale in ≤ 90 seconds, unaided.

---

## 24. Execution stages

Work incrementally. After every stage: run `flutter analyze` and the relevant tests, verify existing features still work, update docs, record benchmark deltas. Do not proceed with an unresolved Critical regression. If a UX improvement would require changing business logic, stop and write a short ADR first.

| Stage | Work | Exit gate |
| --- | --- | --- |
| **0 Baseline** | Reference devices, profile builds, baseline numbers | `UX_BASELINE.md` committed |
| **1 Audit** | Full audit, friction scorecard, UI-phase handoff list, principles | `UX_AUDIT.md`, `UX_PRINCIPLES.md` reviewed |
| **2 UX foundation** | `core/ux` modules, motion tokens, haptics, feedback, skeleton kit, interaction primitives, HUD | Motion lab and component gallery work; unit tests pass |
| **3 Navigation and context** | Shell routes, state preservation, restoration, back behaviour, double-tap guard | Context survives every round trip in the audit list |
| **4 Loading and perceived performance** | Stale-while-revalidate, skeletons, image handling, prefetch, startup | Startup and skeleton budgets met |
| **5 Micro-interactions** | Pressable, steppers, forms, search, gestures, haptics, sound, microcopy | Interaction tests pass; double-tap audit clear |
| **6 Scrolling and runtime performance** | Lists, pagination, rebuild reduction, Drift and isolate work | Frame and memory budgets met on reference devices |
| **7 Core café flows** | POS, checkout, orders, tables, kitchen, QR customer flow | Four-tap cash sale; rush simulation passes |
| **8 First-run** | Role-aware onboarding, sample menu, practice mode, hints, empty states | First-use test target met |
| **9 Remaining modules** | Inventory, purchases, employees, dashboard, reports, settings, day close | All modules pass the state-matrix audit |
| **10 Offline experience** | Status chip, per-record states, sync centre, conflicts, realtime-absence handling | Offline workflows pass in airplane mode; no duplicates on replay |
| **11 Accessibility, localisation, platform craft** | Semantics, text scale, contrast handoff, ARB, predictive back, notifications | Accessibility tests green |
| **12 Verification and handoff** | Full regression, usability sessions, final benchmarks, UI-phase handoff | Acceptance criteria all evidenced |

---

## 25. Agent operating protocol

**Documents to create and maintain:** `UX_BASELINE.md`, `UX_AUDIT.md`, `UX_PRINCIPLES.md`, `MOTION_SYSTEM.md`, `NAVIGATION.md`, `UX_COPY.md`, `UX_BENCHMARKS.md`, `UX_PROGRESS.md` (current stage, next task, blockers, evidence log), `UX_CHANGELOG.md`.

**Session kickoff:** read this prompt and `UX_PROGRESS.md`; run `git status` and `flutter analyze`; state the next task, the files you expect to touch and the tests you will write; implement; run analyze and tests; update docs and the evidence log; commit; report.

**Definition of done for a task:** compiles with no new analyzer issues; behaviour verified on a reference device; budgets rechecked where relevant; tests added; no visual change unless recorded as a usability fix; docs updated; **no claim of improvement without a measurement.**

**Report at the end of each stage:** what changed, files created and modified, metrics before and after, tests run and results, known limitations, remaining work, and the exact commands to run the app.

---

## 26. Final acceptance criteria

The UX phase is complete only when all of the following are evidenced:

1. Navigation is consistent; returning to any screen restores search, filters, sort, tab, scroll position and drafts.
2. Cached data shows instantly; fresh data never blocks the interface; skeletons appear only when needed and never cause layout jumps.
3. Every mutating action is single-flight and idempotent; no double-tap creates duplicates.
4. A two-item cash sale takes four taps from the cashier landing screen; a first-time user completes a first sale in ≤ 90 seconds unaided.
5. Orders and the kitchen board update live, reconnect safely and warn clearly if live updates stop.
6. Offline states are understandable; every record shows its sync state; no duplicate invoice, payment or stock deduction after replay.
7. Every error explains what happened, whether data is safe and what to do next.
8. Animations, haptics and sounds come from central tokens, are purposeful, and respect reduced-motion and haptics settings.
9. Accessibility checks pass at 200 % text, with a screen reader, and without relying on colour alone.
10. All performance budgets in section 4 are met on the reference devices, with numbers recorded.
11. No regression in business logic, security, tenant isolation or the development identity system.
12. The visual design is unchanged except for documented usability fixes; all visual findings are in the UI-phase handoff list.

---

## 27. Anti-patterns and the most important instruction

**Do not:**

- Add animation everywhere. Most great interactions are barely noticed.
- Use full-screen spinners for data you already have.
- Show a toast for every small action.
- Use confirmation dialogs where undo would do.
- Reorder the main menu grid unexpectedly.
- Gamify payments.
- Interrupt an active cashier with anything non-critical.
- Ship an optimisation you did not measure.
- Let a cache make an old number look current.
- Redesign the UI.

A user should never think:

- Why is this taking so long?
- Did my tap work?
- Why did my page reset?
- Where did my data go?
- Why do I have to do this again?
- Why does this screen behave differently?
- Why am I seeing a loading screen again?

**Make CaféOS feel like it understands what the person is trying to do: fast for the expert, obvious for the newcomer, and honest about its state at all times.**

Start with Stage 0 and Stage 1. Do not redesign the UI. Do not break existing functionality. Verify every change.
