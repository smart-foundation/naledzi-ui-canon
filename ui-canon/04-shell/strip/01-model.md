---
id: SHELL-STRIP-MODEL
title: Strip Model
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-010, AC-SHELL-STRIP-011]
---

# Strip Model

> The strip is a summon-only depth reel of live stills. It is a launcher and a switcher.
> It is not a dock. It has no permanent visibility, no memorized icons, and no second copy
> of app content.

---

## 1. What the strip is

The strip is a surface at `system` elevation that, when summoned, shows a reel of cards —
one per eligible surface — each card being a live thumbnail of that surface's last
committed still. It lets a person:

- see what is running and what it currently shows,
- switch to any of them,
- launch a new app/surface,
- close, move to a space, or group.

It is the single place for "what exists". There is no separate dock, taskbar, or app
grid as permanent chrome (`LAW-010`, `ADR-0006`).

---

## 2. What the strip is NOT

1. **Not a dock.** A dock is permanent, icon-based, pointer-assuming. The strip is
   summon-only, content-based, and works on touch/remote/voice.
2. **Not a window list of titles.** Cards show live content, not just names.
3. **Not a second copy of app content.** Thumbnails are derived from numbered stills under
   an observation capability; the strip holds no app state (`LAW-001`).
4. **Not permanent.** Hidden cost is zero.

---

## 3. Eligibility

A surface appears in the strip if:

- it is a top-level app surface or a declared switchable system surface,
- it is not opted out (privacy, kiosk, single-app space),
- it has an observation capability granted (or a placeholder card is shown),
- it exists in the current space (or "all spaces" view in fan-out).

Surfaces that are not switchable (transient overlays, PiP) do not get cards. A surface
with revoked observation shows a placeholder card with the app's identity and a "content
hidden" label, never a stale thumbnail.

---

## 4. The two modes

| Mode | Trigger | Shape |
|---|---|---|
| Reel | Summon (edge, key, gesture, voice, crown) | Linear reel of cards with magnification |
| Fan-out | Pull up / expand / search | Spatial switcher with grouping, search, close, move |

The transition between them is a named spring with velocity preservation.

---

## 5. Strip and spaces

- By default the strip shows surfaces in the **current space**.
- A toggle shows all spaces (fan-out).
- Moving a card to another space is a drag or a palette action.

---

## 6. Strip and focus

- Summoning the strip moves focus into the reel.
- The focused card is magnified and announced.
- Dismissing (Escape, outside action, gesture) restores focus to the previous surface.
- The strip never steals focus permanently; it is a transient surface.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-010` | Hidden strip costs zero messages/wakeups/GPU over one hour. |
| `AC-SHELL-STRIP-011` | Strip shows live thumbnails derived from numbered stills under an observation capability. |
| `AC-SHELL-STRIP-012` | Revoked observation shows a placeholder card, never a stale thumbnail. |
| `AC-SHELL-STRIP-013` | Summoning moves focus into the reel; dismissing restores focus. |