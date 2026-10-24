---
id: APP-INPUT
title: The Universal Input Grammar
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Interaction Guild
depends: [APP-STANDARD, LAW-009]
acceptance: [AC-APP-STANDARD-010]
---

# The Universal Input Grammar

> An operation is a verb. Input is how the verb is invoked. The verb is the same on every
> device; the binding changes. No verb may exist only behind a secret.

---

## 1. The verbs

Every app exposes these verbs. An app may add domain verbs; it may not rename these.

| Verb | Meaning |
|---|---|
| `activate` | Do the primary thing on the focused item |
| `context` | Show secondary actions for the focused item |
| `back` | Go to the previous state, or up one level |
| `home` | Go to the app's or system's home state |
| `palette` | Open the universal command surface |
| `select` | Select the focused item |
| `multi-select` | Add/toggle selection |
| `range-select` | Select a contiguous range |
| `drag` | Move an item or a value |
| `scroll` | Move through content |
| `zoom` | Change scale |
| `edit` | Enter text/value editing |
| `focus-next` / `focus-prev` | Move focus |
| `dismiss` | Close the current transient layer |
| `confirm` / `cancel` | Resolve a decision |
| `undo` / `redo` | Reverse/reapply an action |
| `switch` | Move to another app or surface |
| `strip` | Summon the depth reel |
| `help` | Explain the current context |

---

## 2. Bindings

The binding table is the default. An envelope may change a binding if it declares the
change and provides a visible path. An app may not silently override a system binding.

| Verb | Pointer | Touch | Keyboard | TV remote | Voice | Gesture |
|---|---|---|---|---|---|---|
| `activate` | click | tap | Enter / Space | OK | "open …" | — |
| `context` | right-click | long-press | Shift+F10 / Menu | Menu | "actions for …" | two-finger tap |
| `back` | back button | back gesture / button | Escape / Alt+Left | Back | "back" | edge swipe from left |
| `home` | — | home gesture | Super+H | Home | "home" | edge swipe from bottom (short) |
| `palette` | — | pull-down search | Ctrl/Cmd+K | Search | "search" / "command" | pull down from top |
| `select` | click | tap | Space | OK | "select" | — |
| `multi-select` | Ctrl+click | long-press → select | Ctrl+Space | — | "select also …" | — |
| `range-select` | Shift+click | two-finger drag | Shift+Arrow | — | "select through …" | — |
| `drag` | press+move | long-press+move | Space, arrows, Space | — | "move … to …" | — |
| `scroll` | wheel | swipe | arrows / PageUp/Down | Up/Down | "scroll …" | — |
| `zoom` | Ctrl+wheel | pinch | Ctrl+= / Ctrl+- | — | "zoom in/out" | pinch |
| `edit` | click field | tap field | type / F2 | OK on field | "edit …" | — |
| `focus-next` | Tab | — | Tab | Right/Down | "next" | — |
| `focus-prev` | Shift+Tab | — | Shift+Tab | Left/Up | "previous" | — |
| `dismiss` | click outside / Esc | swipe down | Escape | Back | "close" | swipe down |
| `confirm` | click primary | tap primary | Enter | OK | "confirm" | — |
| `cancel` | click secondary | tap secondary | Escape | Back | "cancel" | — |
| `undo` | — | — | Ctrl/Cmd+Z | — | "undo" | — |
| `redo` | — | — | Ctrl/Cmd+Shift+Z | — | "redo" | — |
| `switch` | — | app switch gesture | Alt+Tab / Super+Tab | — | "switch to …" | edge swipe up + hold |
| `strip` | edge hover | edge swipe | Super+Space | — | "show windows" | edge swipe from bottom |
| `help` | — | — | F1 | — | "help" | — |

Rules:

- `back` is always available on every envelope. It never traps the user.
- `home` and `strip` are system-level; the policy binds them.
- A binding shown in a menu is discoverable. A binding not shown anywhere is a secret.
- Shortcuts are accelerators, not the only path
  ([`../../00-canon/04-decision-log.md`](../../00-canon/04-decision-log.md), `ADR-0021`).

---

## 3. Discoverability

Every verb has a visible path:

- in an action region,
- in a context menu,
- in the palette,
- in a physical control,
- or in a labelled affordance.

The palette lists every command with its shortcut. A command with no visible path anywhere
is a defect.

---

## 4. Capture leases

A drag, a long-press gesture or a modal interaction needs input even when the pointer leaves
the surface.

- Capture is a **lease**: time-bound, revocable, scoped to the interaction.
- The lease ends on release, cancel, timeout, or the policy revoking it.
- A crashed app does not leave a stuck pointer; the lease expires.
- The pointer's focus is explicit in the still.

Capture is not a global grab. It is a capability with an expiry.

---

## 5. Gesture grammar

System gestures are reserved. Apps may request gestures inside their content; the policy
arbitrates.

| Gesture | Reserved for | Conflict rule |
|---|---|---|
| Left edge swipe | Back | App cannot override at the edge |
| Bottom edge swipe (short) | Home | App cannot override |
| Bottom edge swipe (hold/up) | Strip / switcher | App cannot override |
| Top edge pull | Palette / notifications | App may use inside content, not at the edge |
| Two-finger swipe | Scroll / history | App may use inside content |
| Pinch | Zoom | App may use inside content |
| Long-press | Context / select | App may use; must have a visible alternative |

Rules:

- A gesture must have a visible affordance or be a system-reserved gesture with a standard
  meaning.
- A gesture must not be the only path to a primary action.
- A gesture must be cancellable.
- Reduced-motion does not disable gestures; it changes the feedback.
- Gesture conflicts are resolved by the policy, not by an app "winning".

---

## 6. Text input

- IME composition is first-class: pre-edit, candidates, commit, cancel.
- The app never assumes a Latin keyboard or left-to-right text.
- Numerals, dates and times are localized for display; stored values are canonical.
- Paste is a capability; the app requests the format it needs.
- Voice input is a text source, not a separate mode. The user can edit the transcript before
  commit.
- Handwriting is a text source on envelopes that support it.
- Password fields never echo, never suggest, never log.

---

## 7. Remote and five-button input

A TV remote has: Up, Down, Left, Right, OK, Back, Home, Menu, and optionally voice.

Rules:

- Every action is reachable with the directional pad.
- Focus is always visible and never lost.
- Back never traps; it exits the current layer or the app.
- A long text field offers an on-screen keyboard, voice, or a companion device.
- Hover-only and pointer-only interactions are forbidden.

---

## 8. Voice

- Voice invokes the same command IDs as the palette.
- Destructive commands require confirmation, even by voice.
- The transcript is visible before the action when the command is ambiguous.
- Voice never becomes the only path.
- Microphone use is an explicit, revocable capability with a visible indicator.

---

## 9. Feedback and latency

| Time | Expectation |
|---|---|
| < 100 ms | Direct manipulation feels instant |
| 100 ms – 1 s | Show a pressed/working state; keep the UI responsive |
| > 1 s | Determinate progress or a labelled indeterminate state; cancel if possible |
| > 10 s | Explain what is happening and allow the user to leave; never block the system |

A delayed response without feedback is a defect, regardless of cause.

---

## 10. Acceptance

| ID | Test |
|---|---|
| `AC-APP-INPUT-001` | Every verb is reachable on pointer, touch, keyboard and remote (or a declared envelope exception). |
| `AC-APP-INPUT-002` | No primary action is hover-only, right-click-only or long-press-only. |
| `AC-APP-INPUT-003` | Every shortcut has a command and a visible path. |
| `AC-APP-INPUT-004` | Capture leases expire on release, cancel, timeout and crash. |
| `AC-APP-INPUT-005` | Focus is never lost on any input path. |
| `AC-APP-INPUT-006` | Text input works with an IME, RTL and non-Latin scripts. |
| `AC-APP-INPUT-007` | Voice maps to the same commands and confirms destructive actions. |
| `AC-APP-INPUT-008` | Feedback appears within 100 ms for direct manipulation. |
