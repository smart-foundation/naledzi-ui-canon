---
id: FW-PALETTE-REMOTE
title: Remote and small screens
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-006]
---

# Remote and small screens

---

## 1. TV / remote

- Invoked by the remote's search button or a focusable on-screen affordance.
- Full-screen overlay, d-pad navigable, large text.
- Voice input via the remote microphone where available.
- Results show icon + title + shortcut (key hint translated to remote buttons).

## 2. Watch

- Full-screen list, one result visible, crown to scroll.
- Voice-first; typing is secondary.
- Results limited to the top 5 by rank; "more" reveals the rest.

## 3. EV

- Voice-first, large touch targets, driver-safe: no small text, no dense lists.
- Safety commands always first.
- Reduced motion and no animation through occlusion.

## 4. Spatial

- Anchored panel near focus; gaze + pinch to select.
- Same registry, same ranking.

## 5. Remote browser

- Browser-native overlay; keyboard and screen reader supported.
- Command dispatch goes through the authenticated service channel (Smart UI §34).
