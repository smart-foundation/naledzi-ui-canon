---
id: SHELL-FULLSCREEN-MULTIWINDOW
title: Fullscreen Multi-Window
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-MODEL-MULTIWINDOW, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-060, AC-SHELL-FULLSCREEN-061]
---

# Fullscreen Multi-Window

> What happens to other windows and spaces when one surface goes fullscreen, and how PiP
> and split behave.

---

## 1. Other surfaces

- When a surface goes fullscreen, other surfaces in the same space are **occluded** (not
  destroyed). Their commits continue; they are just not visible.
- On exit, the previous arrangement is restored.
- On a split that goes fullscreen, the split is suspended; on exit it returns.
- On TV/spatial, fullscreen may be the only mode; other surfaces are not shown.

---

## 2. Picture-in-picture

- PiP continues to show during fullscreen if it was active, unless it would occlude a
  safety indicator.
- PiP is user-dismissable during fullscreen.
- In immersive, PiP is the only floating surface allowed.

---

## 3. Spaces

- Fullscreen is per-space. Switching spaces exits or suspends fullscreen per policy.
- A fullscreen surface in a background space is suspended (not committing) unless declared
  background-capable (e.g., media playback).

---

## 4. Multi-display

- Fullscreen on one output does not affect other outputs.
- A surface may be fullscreen on one output and windowed on another (declared).

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-FULLSCREEN-060` | Fullscreen occludes but does not destroy other surfaces; arrangement restores on exit. |
| `AC-SHELL-FULLSCREEN-061` | PiP survives fullscreen unless it occludes a safety indicator. |
| `AC-SHELL-FULLSCREEN-062` | Fullscreen is per-space; background space fullscreen suspends unless declared. |