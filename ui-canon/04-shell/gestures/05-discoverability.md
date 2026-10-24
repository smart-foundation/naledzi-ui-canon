---
id: SHELL-GESTURES-DISCOVER
title: Gestures — Discoverability
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-GRAMMAR, APP-INPUT]
acceptance: [AC-SHELL-GESTURES-050]
---

# Gestures — Discoverability

---

## 1. Principles

- A gesture that is not discoverable is a secret; secrets are forbidden
  (`APP-INPUT` §3).
- System gestures are taught during first-run and are always reachable from Help and the
  palette ("show gestures").
- App gestures must have a visible affordance or be listed in the app's help.

## 2. Surfaces

- First-run tutorial demonstrates edge swipes with a live, guided practice.
- A "Gestures" panel in Settings lists all system gestures with animations.
- The palette command "show gestures" opens the panel.
- Contextual hints appear once for new gestures, then stop.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-050` | Every gesture has a discoverable path. |
| `AC-SHELL-GESTURES-051` | First-run teaches system gestures. |