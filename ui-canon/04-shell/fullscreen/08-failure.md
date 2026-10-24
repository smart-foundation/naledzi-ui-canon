---
id: SHELL-FULLSCREEN-FAILURE
title: Fullscreen Failure
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-FULLSCREEN-MODEL, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-080, AC-SHELL-FULLSCREEN-081]
---

# Fullscreen Failure

> Rare cases: lost exit, stuck pointer, crashed app, display disconnected. Each has a
> recovery path. The screen is never held hostage.

---

## 1. Lost exit

- If the app stops responding to the exit path, a timeout (default 5 s, envelope-
  adjustable) reveals the status rail and strip.
- A three-finger gesture (or envelope equivalent) forces exit on touch envelopes.
- A remote "exit fullscreen" command works if the device is paired.
- The recovery is recorded in the lifecycle log.

---

## 2. Stuck pointer / capture lease

- A capture lease that does not end on release is revoked by the policy after a timeout
  (default 10 s).
- The pointer returns to normal; the fullscreen may be exited by the user.
- The app is marked degraded and the failure recorded.

---

## 3. Crashed app

- A crashed fullscreen app is removed by the authority on the next policy pass.
- The previous surface arrangement is restored.
- The crash is reported honestly (not hidden).
- If the crash corrupted the still, the authority falls back to the last good still and
  records the gap.

---

## 4. Display disconnected

- On disconnect, surfaces are moved to a remaining output or suspended.
- Fullscreen is exited.
- On reconnect, the previous arrangement is restored if possible; otherwise declared.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-080` | Lost exit recovers within the timeout via timeout/gesture/remote. |
| `AC-SHELL-FULLSCREEN-081` | Crashed fullscreen app restores the previous arrangement. |
| `AC-SHELL-FULLSCREEN-082` | Display disconnect exits fullscreen and restores on reconnect. |