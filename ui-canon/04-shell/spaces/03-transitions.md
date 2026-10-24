---
id: SHELL-SPACES-TRANSITIONS
title: Spaces — Transitions
kind: shell
entity: spaces
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-SPACES-MODEL, FOUND-MOTION-INDEX, FOUND-DEPTH-INDEX]
acceptance: [AC-SHELL-SPACES-030]
---

# Spaces — Transitions

---

## 1. Switching

- Switch via: strip fan-out, gesture (3/4-finger swipe), keyboard shortcut, palette,
  or voice.
- The transition swaps the visible surface set with a named spring; content moves as a
  unit (not per-window) to preserve object identity (`FOUND-MOTION-001`).
- Velocity from a gesture handoff is preserved across the switch; interrupting mid-switch
  continues from current velocity without a jump.
- Focus moves to the previously-focused surface in the target space; if none, the first
  focusable.

## 2. Visual

- Direction of motion indicates direction in the space order (left/right or up/down per
  envelope).
- Reduced motion: instant swap with a state announcement; no travel.
- Safety envelopes use bounded, non-overshooting motion (`ADR-0017`).

## 3. Multi-display

- On multi-display, each display may show a different space, or one space may span
  displays; the policy declares which. Switching on one display does not force the other.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-SPACES-030` | Switch preserves velocity, focus and scroll. |
| `AC-SHELL-SPACES-031` | Reduced motion removes travel. |
| `AC-SHELL-SPACES-032` | Interrupt mid-switch continues without a jump. |