---
id: SHELL-FULLSCREEN-MODEL
title: Fullscreen Model
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-010, AC-SHELL-FULLSCREEN-011]
---

# Fullscreen Model

> Fullscreen is a declared behaviour, not a hidden mode. It names what happens to every
> system surface and input. An app that merely draws over everything is not fullscreen; it
> is broken.

---

## 1. What fullscreen is

Fullscreen is a **placement hint** (`fullscreen`) accepted by the authority and honoured by
the policy per envelope. It means: this surface intends to occupy the output, and the shell
must reconfigure system UI, focus, gestures and notifications according to the declared
kind.

Fullscreen is not:

- a flag the app sets on its window (there is no window),
- a hidden mode the OS detects,
- a request to disable the OS.

It is a contract between the app (intent) and the shell (behaviour), enforced by the
authority.

---

## 2. The four kinds (detail)

### 2.1 Immersive

- App content fills the output.
- Status rail and strip are **hidden** until summoned by an edge gesture, hot corner or
  key.
- Notifications appear only at safety priority or above (see `05-notifications.md`).
- Gestures are mostly app-owned inside the content; reserved edges still work.
- Focus stays in the app; no trap for non-modal.
- Exit is always available (Escape, F11, gesture, voice, remote).

Use: games, video, reading, drawing, any app that wants the whole screen.

### 2.2 Maximised

- App fills the work area (output minus system surfaces that remain).
- Status rail adapts (may collapse to minimal).
- Strip remains summonable.
- Notifications appear normally.
- Exit is not needed; the app is just large.

Use: default large view of an editor, browser, map.

### 2.3 Presentation

- A declared presentation mode: the app specifies which system UI remains and how input
  behaves.
- Used for slides, demos, kiosk-like in-app presentation.
- Safety zones remain protected even in presentation.
- The declaration is part of the app's contract; the shell validates it.

### 2.4 Safety-fullscreen

- The safety envelope (EV, spaceship) takes the whole output.
- No app surface may show.
- Only safety indicators and procedures are visible.
- Cannot be exited by the app; exited only by the safety system.

---

## 3. Declared fullscreen

An app declares fullscreen in its commit via `placement_hint: fullscreen` plus a
`fullscreen_kind` and, for `presentation`, a `presentation_declaration`. The authority
validates:

- the kind is one of the four,
- the app has the capability to request fullscreen on this envelope,
- the request does not violate safety zones.

A rejected request is a named rejection, not a silent ignore.

---

## 4. Fullscreen and the strip

When fullscreen is active and the strip is summoned, it appears over the app at `system`
elevation and returns to hidden on release. The app does not need to know the strip was
shown; its still is unchanged (the strip is a separate surface).

---

## 5. Fullscreen and system UI (summary)

| System surface | Immersive | Maximised | Presentation | Safety-fullscreen |
|---|---|---|---|---|
| Status rail | hidden (edge reveal) | adaptive/collapsed | per declaration | safety only |
| Strip | summoned only | summonable | per declaration | n/a |
| Notifications | safety+ only | normal | per declaration | safety only |
| Gestures | reserved edges | normal | per declaration | safety only |
| Focus | in app, no trap | in app | per declaration | safety system |
| Multi-window | others hidden/suspended | others remain | per declaration | n/a |

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-010` | A fullscreen request without a kind is rejected with a named reason. |
| `AC-SHELL-FULLSCREEN-011` | Each kind's system-UI behaviour matches §5 on every envelope that supports it. |
| `AC-SHELL-FULLSCREEN-012` | Fullscreen is a placement hint validated by the authority, not an app flag. |