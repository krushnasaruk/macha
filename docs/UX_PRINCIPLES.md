# CaféOS — Experience Engineering Principles

This document defines the core interaction philosophies, behavioural rules, and architectural guidelines that govern every user experience decision in CaféOS.

---

## 1. The Six Pillars (The Acceptance Lens)

Every proposed UX change, micro-interaction, or animation must serve at least one of these six pillars. If a change serves none, it must not be built.

| Pillar | Core Question | Acceptance Standard in CaféOS |
|---|---|---|
| **Instant** | *Does the interface react within one frame and never wait for the network to show something it already knows?* | • Taps yield visual press state within ≤ 16 ms.<br>• Data is read from local SQLite (Drift) first.<br>• Cart totals update synchronously in the next frame. |
| **Continuous** | *After any navigation, is the user exactly where they expect to be, with search, filters, scroll, and drafts intact?* | • Navigating to another tab and returning preserves scroll offsets, filter chips, and entered text.<br>• Unfinished carts survive app backgrounding, tab switches, and app restarts.<br>• Spatial motion (Hero transitions, shared axis) connects source items to detail sheets. |
| **Honest** | *Can the user always tell what is saved, pending, confirmed, or failed without guessing?* | • Every record shows explicit sync status (Saved locally, Syncing, Synced).<br>• Financial transactions NEVER fake success; unconfirmed network requests show honest pending states.<br>• Timers in the kitchen display exact elapsed minutes with unmistakable color coding. |
| **Forgiving** | *Can a mistake be undone or recovered in one step, without losing work or panic?* | • Non-destructive actions use 5-second undo snackbars rather than blocking confirmation dialogs.<br>• Accidental kitchen ticket bumps can be recalled immediately from a recall drawer.<br>• Form validation failures preserve all entered inputs without clearing fields. |
| **Calm** | *Would a stressed cashier with a queue in front of them be interrupted, distracted, or slowed down?* | • Zero non-critical popups, tips, or sync alerts while an active cart or payment is in progress.<br>• Background sync, printing, and inventory adjustments operate silently without blocking the UI.<br>• Animations are concise, restrained, and purposeful—never flashy or distracting. |
| **Inclusive** | *Does it work with 200% text scale, a screen reader, one hand, bright outdoor sunlight, and a cheap device?* | • Touch targets meet or exceed 48×48 dp.<br>• High-contrast typography and semantic icons ensure usability in high glare.<br>• UI layouts adapt gracefully without clipping or text overflow at 200% font scaling. |

---

## 2. Two-Speed Design Architecture

A busy café environment operates at two fundamentally different tempos:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           CAFÉOS INTERFACE LAYERS                           │
├─────────────────────────────────────────────────────────────────────────────┤
│  SPEED 1: THE DISCOVERABLE PATH (New Cashier, First-Time Café Owner)        │
│  • Fully labeled buttons with plain descriptive text ("Proceed to Checkout")│
│  • Category chips and catalog search visible and prominently placed         │
│  • Guided setup checklist on the owner dashboard                            │
│  • Contextual first-time hints (maximum one per screen, dismissible)        │
├─────────────────────────────────────────────────────────────────────────────┤
│  SPEED 2: THE ACCELERATOR LAYER (Expert Cashier in Saturday Morning Rush)   │
│  • 1-tap exact cash tender button on tablet POS (bypasses checkout sheet)   │
│  • Quick cash denomination chips (+₹100, +₹200, +₹500, +₹2,000)             │
│  • Numeric stepper hold-to-repeat for rapid item quantity changes           │
│  • Swipable actions for item removal in cart and quick table status toggles │
│  • Hardware keyboard / barcode scanner accelerators on desktop/tablet POS   │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Golden Rule of Accelerators:
> **Accelerators sit ON TOP OF the discoverable path—they NEVER replace it.**
> An expert cashier can ring up a 2-item cash order in under 3 seconds using accelerators; a novice cashier can execute the exact same sale unaided by following clear, labeled buttons.

---

## 3. Rush-Hour Interruption Policy

During peak counter rushes, split-second cashier focus is sacred. Any modal interruption can lead to incorrect change, miskeyed orders, and angry customers.

### Strict Interruption Rules:
1. **Modal Purity During Active Cart**:
   - When the cart has ≥ 1 item or a tender sheet is active, **NO non-critical modals, permission prompts, sync warnings, or onboarding hints may appear**.
2. **Silent Background Operations**:
   - If network connectivity is lost during an order, do not show a blocking alert. The app is local-first; the transaction is committed to local Drift SQLite and enqueued in `sync_outbox_table` automatically.
   - Cloud sync errors, catalog update notifications, and background inventory warnings are queued quietly in a subtle notification badge, visible only after the checkout completes.
3. **Sound Restraint**:
   - Audio feedback is reserved exclusively for critical operational signals: new incoming kitchen order, cash payment success confirmation, or printer error requiring physical cashier intervention.

---

## 4. Progressive Disclosure

Keep primary operational screens focused on the 90% common case, hiding complex, rarely used edge cases behind explicit, low-friction secondary actions:

- **Cart View**: Shows Item, Quantity, Subtotal, Discount, Grand Total. Split payments, custom item notes, tax exemptions, and custom percentage overrides live behind a compact "More Options (•••)" action.
- **KDS View**: Shows Order Number, Elapsed Minutes, Item List, and Status Bump. Allergen warnings and detailed table merge histories expand on tap rather than cluttering the ticket card.
- **Table View**: Shows Table Number, Capacity, Status, and Guest Count. Table transfer, merge, and QR regeneration are housed inside a bottom sheet triggered on table selection.

---

## 5. Honest State & Non-Faking Guarantee

In financial and inventory systems, honesty is the foundation of user trust:
1. **Never Fake Payment Success**: If a card terminal or dynamic QR payment has not received an authoritative webhook or gateway confirmation, it must NEVER display a green "Payment Confirmed" state. It displays "Waiting for Payment Confirmation" with a clear retry / cash fallback option.
2. **Explicit Offline Markers**: Records created while offline display a subtle pending sync indicator (`SyncStatus.pending`). Once the outbox transaction completes upstream, the status quietly transitions to confirmed (`SyncStatus.synced`).
3. **No Phantom Reversals**: Refunds and voids create new explicit ledger reversal entries and outbox records; they never silently mutate historic records in place.
