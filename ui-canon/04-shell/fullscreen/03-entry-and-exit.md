---
id: SHELL-FULLSCREEN-ENTRY
title: Fullscreen Entry and Exit
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-FULLSCREEN-MODEL, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-030, AC-SHELL-FULLSCREEN-031]
---

# Fullscreen Entry and Exit

> Entering fullscreen is explicit. Exiting fullscreen is always possible. There is no
> fullscreen state without an exit.

---

## 1. Entry

Fullscreen is entered by:

1. **App declaration** — the app commits `placement_hint: fullscreen` with a kind. The
   shell honours it if the app has the capability and it does not violate safety zones.
2. **User action** — a button, menu item, gesture, or voice command that invokes a
   fullscreen command (stable command ID).
3. **System policy** — on certain envelopes (TV app mode, kiosk), the system places an app
   fullscreen by policy.
4. **Remote** — a remote peer requests fullscreen on a paired display; the local shell
   honours it if the capability is granted.

Entry is never triggered by the app drawing over everything, by a timer, or by a heuristic.

---

## 2. Exit

Every fullscreen kind has at least one exit path on every envelope. Exit paths:

| Path | Immersive | Maximised | Presentation | Safety-fullscreen |
|---|---|---|---|---|
| Escape key | yes | n/a (not needed) | yes | no (safety only) |
| F11 | yes (desktop) | n/a | yes | no |
| Gesture (edge swipe) | yes | n/a | yes | no |
| Remote (Back) | yes | n/a | yes | no |
| Voice ("exit fullscreen") | yes | n/a | yes | no |
| Kiosk exit (PIN) | n/a | n/a | yes (if kiosk) | no |
| Safety system | no | no | no | yes |

Rules:

1. **Escape always exits immersive and presentation** on envelopes with a keyboard. On
   envelopes without a keyboard, an equivalent gesture or remote binding exists and is
   discoverable.
2. **Back (remote) never traps**; it exits the current layer or the app.
3. **No fullscreen without an exit.** A request that cannot be exited is rejected.
4. **Kiosk mode** requires an explicit exit gesture (e.g., a long-press on a corner plus
   PIN) and is declared; it is not a hidden mode.
5. **Safety-fullscreen** is exited only by the safety system (e.g., drive mode ends,
   procedure completes), never by the user tapping.

---

## 3. Lost exit (recovery)

If the exit path is lost (app crashes, pointer stuck, display disconnected), the shell
recovers per `08-failure.md`: a timeout reveals the status rail and strip, or a
three-finger gesture, or a remote command. The app never holds the screen hostage.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-030` | Every fullscreen kind has at least one exit path on every envelope that supports it. |
| `AC-SHELL-FULLSCREEN-031` | Escape exits immersive on every keyboard envelope. |
| `AC-SHELL-FULLSCREEN-032` | A kiosk exit requires the declared gesture + PIN. |
| `AC-SHELL-FULLSCREEN-033` | Safety-fullscreen is not user-exitable. |