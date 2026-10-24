---
id: SHELL-FULLSCREEN-PERENVELOPE
title: Fullscreen Per Envelope
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-FULLSCREEN-MODEL, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-070, AC-SHELL-FULLSCREEN-071]
---

# Fullscreen Per Envelope

> Fullscreen on a watch is not fullscreen on a spacecraft. Each envelope earns its
> behaviour. No "similar to phone".

---

## 1. Watch

- Fullscreen is the default for most apps (single surface fills the display).
- System UI: time is a corner overlay; it auto-hides; crown summons the strip.
- Exit: crown press or edge swipe.
- Notifications: safety only as overlay; others queued.
- No multi-window; PiP n/a.

## 2. Phone

- Immersive hides status bar and navigation; edge reveals.
- Exit: swipe from bottom (short) or back gesture.
- Notifications: safety+ appear; others queued.
- PiP supported for media/call.
- Split n/a in immersive.

## 3. Tablet

- Immersive hides status bar; split can be suspended.
- Exit: gesture or key.
- Notifications: safety+ appear.
- PiP supported.

## 4. Desktop

- Immersive hides menu bar/dock-equivalent (strip); Escape/F11 exits.
- Maximised is the common large view; fullscreen is explicit.
- Notifications: all priorities (subject to quiet hours).
- Multi-window: others occluded; restored on exit.
- Multi-display: fullscreen per output.

## 5. TV

- Fullscreen is the default app mode.
- System UI: minimal, readable at 3 m; auto-hide.
- Exit: Back on remote.
- Notifications: safety+ appear; others queued.
- No free multitasking; one app at a time.

## 6. EV

- Immersive is restricted: a driving app may not hide safety indicators.
- Passenger media may go fullscreen only when it does not occlude protected zones.
- Exit: voice or passenger control; driver cannot be distracted.
- Notifications: safety override always; driver-critical never queued.
- Motion: bounded, non-overshooting.

## 7. Spaceship

- Fullscreen is procedure-gated; only the active procedure surface may be fullscreen.
- Safety indicators always visible.
- Exit: procedure completion or safety officer override.
- No immersive hiding of alarms.

## 8. IoT

- Fullscreen n/a (headless or single-purpose display).
- If a display exists, it shows one surface; no fullscreen concept beyond that.

## 9. Spatial

- Immersive removes the shell frame but keeps spatial anchors.
- Exit: gesture or voice.
- Notifications: appear as spatial banners.
- Multi-window: surfaces remain in space; fullscreen focuses one.

## 10. Remote browser

- Fullscreen maps to the browser's fullscreen API where available; otherwise simulated.
- Exit: Escape (browser) or the remote control.
- System UI: browser chrome only.

---

## 9. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-070` | Every envelope in §1–§10 has a fullscreen behaviour or a declared absence. |
| `AC-SHELL-FULLSCREEN-071` | No envelope says "similar to phone". |
| `AC-SHELL-FULLSCREEN-072` | Safety indicators remain visible in fullscreen on EV and spaceship. |
| `AC-SHELL-FULLSCREEN-073` | Every envelope has at least one exit path. |