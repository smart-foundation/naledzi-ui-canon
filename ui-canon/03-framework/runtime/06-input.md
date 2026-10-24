---
id: FW-RUNTIME-INPUT
title: "Input: event model, focus, capture leases, gestures, remote, voice, IME"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, CANON-LAWS, FOUND-ACCESSIBILITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-INPUT-001]
---

# Input

> One input grammar across all envelopes (APP-STANDARD §5). No operation is hover-only,
> right-click-only or long-press-only.

---

## 1. Event model

MirUI's input module provides events, focus, hit-testing, listeners, bindings, gestures and
scroll (`src/input/*`). The framework maps `input.capnp` events into MirUI events through
the adapter.

- FW-INPUT-001. An event carries: kind, target, position, modifiers, timestamp (from
  injected clock), and a capability handle where relevant.
- FW-INPUT-002. Events are dispatched to the focused/pointed target first; bubbling follows
  the declared tree, not insertion order.
- FW-INPUT-003. An event that is not handled is reported (honest absence), not swallowed.
- FW-INPUT-004. Synthetic events (scripted tests) use the same path as real events.

## 2. Focus

- FW-INPUT-005. Focus is an explicit, owned fact (no global "current window"). It is part
  of the still (LAW-005).
- FW-INPUT-006. Focus order follows reading order in the resolved direction, then visual
  order; declared per composition, not inferred (`../README.md` §7.5).
- FW-INPUT-007. Focus indicator meets 3:1 against adjacent colours (WCAG 2.2 SC 1.4.11)
  and scales with text.
- FW-INPUT-008. `focus-visible`: keyboard/remote focus shows the indicator; pointer focus
  MAY be quieter.
- FW-INPUT-009. Focus never traps except in modal overlays (dialog, sheet, palette while
  modal); a non-modal popover does not steal focus.
- FW-INPUT-010. On remote/d-pad, every action is reachable; focus moves by discrete
  direction; no diagonal-only reachability.

## 3. Capture leases

- FW-INPUT-011. A gesture that begins on a target holds a capture lease until completion or
  cancellation; the lease is released on pointer-up/escape.
- FW-INPUT-012. A lease prevents other targets from receiving the same pointer stream.
- FW-INPUT-013. Leases expire safely if the owning component is destroyed mid-gesture
  (recovery path in `11-failure.md`).
- FW-INPUT-014. Drag-and-drop uses a drag ghost at `floating` elevation and a declared
  drop target (`components/drag-ghost`, `components/drop-target`).

## 4. Gestures

- FW-INPUT-015. Gestures are recognised from the pointer stream by the framework's gesture
  recogniser (`src/input/event/gesture/*`), not by ad-hoc component code.
- FW-INPUT-016. A gesture's velocity on release feeds the spring initial velocity
  (FOUND-MOTION-004): gesture handoff.
- FW-INPUT-017. Gestures have declared thresholds (tap, long-press, swipe, pinch) and a
  reduced-motion/switch alternative.
- FW-INPUT-018. No operation is gesture-only; a keyboard/remote path always exists.

## 5. Remote

- FW-INPUT-019. Remote input (d-pad, select, back, menu, voice) maps to the same commands
  as pointer/keyboard.
- FW-INPUT-020. Remote focus moves in declared directions; wrap-around is declared, not
  default.
- FW-INPUT-021. On TV, the palette is reachable and usable with d-pad.

## 6. Voice

- FW-INPUT-022. Voice commands resolve to the same command ids as the palette
  (`palette/`). No voice-only commands.
- FW-INPUT-023. Voice requires confirmation for destructive/irreversible actions.
- FW-INPUT-024. Transcript is shown when available; failure is honest (`NOT REPORTED`).

## 7. IME

See `04-text.md` §4. Input routes composition events to the focused text field; the
framework owns IME state, not the component.

## 8. Accessibility semantic tree

- FW-INPUT-025. The semantic tree is derived from the same component data that draws the
  pixels (LAW-009). It is not scraped from pixels and not maintained by hand.
- FW-INPUT-026. Every component declares role, name, value, state and actions. The tree
  rides the same commit as the pixels (LAW-005).
- FW-INPUT-027. The host adapter (pending `protocol/schemas/` contract, FW-Q-002) exposes
  the tree to the platform assistive tech.
- FW-INPUT-028. Focus order, announcements and target sizes are specified per flow.

## 9. Pointer input gap (honest)

Pointer/touch input is not wired in the OS today (`ui-layer-mirui.md` §2 gap): `input.capnp`
has no pointer arm; `input-service` polls only PS/2 keyboard. Phase 3 collapses the
duplicate `compositor.capnp` input event. The framework specifies the contract; the
implementation gap is named, not hidden.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-INPUT-001` | A golden flow completes with keyboard only, with d-pad only, and with a screen reader only. |
| `AC-FW-INPUT-002` | Focus order matches the declared order in LTR and RTL. |
| `AC-FW-INPUT-003` | Capture lease expiry on mid-gesture destruction recovers cleanly. |