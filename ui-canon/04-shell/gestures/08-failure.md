---
id: SHELL-GESTURES-FAILURE
title: Gestures — Failure
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-CAPTURE, CANON-LAWS]
acceptance: [AC-SHELL-GESTURES-080]
---

# Gestures — Failure

---

## 1. Failure modes

| Failure | Behaviour |
|---|---|
| Stuck capture lease | Expires on timeout; pointer released; announced |
| Misrecognition (wrong gesture) | No action; user can retry; no partial state |
| Ambiguous gesture (could be two) | No action until disambiguated; hint shown |
| Gesture disabled by safety | Redirected to voice/button; explained |
| Input device lost mid-gesture | Gesture cancels; state restored |

## 2. Rules

- **SHELL-GESTURES-081.** A failed or cancelled gesture leaves no partial state.
- **SHELL-GESTURES-082.** Misrecognition is never silently treated as a different gesture.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-080` | Every failure mode exercised. |