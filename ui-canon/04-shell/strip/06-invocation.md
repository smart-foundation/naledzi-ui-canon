---
id: SHELL-STRIP-INVOCATION
title: Strip Invocation
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, APP-INPUT, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-060, AC-SHELL-STRIP-061]
---

# Strip Invocation

> How the strip is summoned: edge, keyboard, gesture, remote, voice, watch crown. Every
> envelope has at least one path, and every path is discoverable.

---

## 1. Invocation paths

| Path | Envelope | Notes |
|---|---|---|
| Edge hover/swipe from bottom | phone, tablet, desktop | Primary touch/pointer path |
| Keyboard shortcut (Super+Space) | desktop, tablet (keyboard) | Discoverable in palette |
| Gesture (edge swipe up + hold) | phone, tablet | System-reserved |
| Remote (Menu/long-press Home) | TV, EV | Discoverable |
| Voice ("show windows", "show apps") | all with voice | Maps to command ID |
| Watch crown press/turn | watch | Crown is the strip key |
| Spatial gesture | spatial | Declared |

---

## 2. Rules

1. Every envelope has at least one invocation path.
2. Every path is discoverable (shown in settings, palette, onboarding).
3. No path is the only path to a primary action (`ADR-0021`).
4. Invocation never traps input; the strip is dismissible.
5. The strip may be invoked during fullscreen (immersive) per `fullscreen/02-system-ui.md`.

---

## 3. Dismissal

- Escape, outside action, swipe down, Back (remote), voice ("close").
- Dismissal restores focus to the previous surface.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-060` | Every envelope has at least one invocation path. |
| `AC-SHELL-STRIP-061` | Every path is discoverable. |
| `AC-SHELL-STRIP-062` | Dismissal restores focus. |