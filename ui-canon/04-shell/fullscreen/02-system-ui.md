---
id: SHELL-FULLSCREEN-SYSTEMUI
title: Fullscreen System UI
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-FULLSCREEN-MODEL, SHELL-MODEL-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-020, AC-SHELL-FULLSCREEN-021]
---

# Fullscreen System UI

> What happens to the status rail, strip, notifications, hot corners/edges, pointer, cursor
> and IME when fullscreen is active.

---

## 1. Status rail

- **Immersive:** hidden. Revealed by an edge gesture, hot corner or key (per envelope).
  When revealed, it overlays at `system` elevation and auto-hides after a declared idle
  period (default 3 s, envelope-adjustable).
- **Maximised:** adapts. Collapses to minimal (time + critical) or hides per envelope
  policy. Never truncates a critical warning.
- **Presentation:** per the app's declaration, validated by the shell. Safety indicators
  cannot be hidden.
- **Safety-fullscreen:** only safety indicators.

Rules:
- A critical indicator (low battery, safety warning, alarm) is never hidden by fullscreen.
  It either remains visible or the fullscreen request is rejected.
- Revealing the rail does not change the app's still.

---

## 2. Strip

- **Immersive:** hidden. Summoned by edge gesture, hot corner, key, voice, remote. When
  summoned, overlays the app at `system` elevation; app still unchanged.
- **Maximised:** summonable as normal.
- **Presentation:** per declaration; default summonable.
- **Safety-fullscreen:** n/a.

The strip's cost while hidden is zero (`LAW-004`).

---

## 3. Notifications

See `05-notifications.md`. Summary:

- **Immersive:** only safety and critical priority appear (as a banner or toast at `system`
  elevation). Normal and ambient are queued and shown on exit or on summon.
- **Maximised:** all priorities appear, subject to quiet hours.
- **Presentation:** per declaration; safety always.
- **Safety-fullscreen:** safety only.

---

## 4. Hot corners and edges

- Reserved edges still work in immersive: bottom edge summons home/strip; left edge goes
  back; top edge summons palette/notifications (per envelope).
- The app may use edges inside the content but not the reserved edge gestures.
- Hot corners (top-left for menu, etc.) are envelope-declared and never the only path.

---

## 5. Pointer and cursor

- In immersive, the cursor may auto-hide after an idle period (declared, default 3 s) and
  reappears on movement.
- The cursor never disappears while a capture lease is active.
- On touch envelopes, there is no cursor; the pointer is the finger.
- The cursor is a system surface; the app may not draw its own system cursor.

---

## 6. IME

- IME composition remains first-class in fullscreen.
- The composition window and candidates appear at `system` elevation above the app.
- The app may not assume a Latin keyboard or LTR text.
- Fullscreen does not disable text input.

---

## 7. Gamepad / remote

- A gamepad or TV remote in fullscreen keeps its reserved bindings (Back, Home, Menu).
- The app may bind other buttons inside the content.
- Back never traps; it exits fullscreen or the app per the exit rules.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-020` | Critical indicators remain visible in immersive on every envelope. |
| `AC-SHELL-FULLSCREEN-021` | Cursor auto-hide does not hide the cursor during a capture lease. |
| `AC-SHELL-FULLSCREEN-022` | IME composition works in fullscreen with candidates visible. |
| `AC-SHELL-FULLSCREEN-023` | Reserved edges work in immersive on every envelope. |