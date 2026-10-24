---
id: SHELL-STRIP-FANOUT
title: Strip Fan-Out
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, SHELL-STRIP-MODEL, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-050, AC-SHELL-STRIP-051]
---

# Strip Fan-Out

> Pulling the strip up fans out into the full spatial switcher: grouping, search, close,
> move to space. This is where management happens.

---

## 1. What fan-out is

Fan-out is the expanded mode of the strip. It shows all eligible surfaces (current space or
all spaces) in a spatial layout, with:

- grouping by app or by space,
- search/filter by title or app,
- close (with confirmation for unsaved work),
- move to space,
- new surface launch,
- recently closed ghosts (undo).

---

## 2. Grouping

- Group by app: one stack per app, expanding on focus.
- Group by space: one cluster per space.
- Grouping is a view toggle; data is unchanged.
- Groups are collapsible.

---

## 3. Search

- Typing filters cards by title and app name.
- Search is the palette's search scope but scoped to surfaces.
- Voice search works where voice is available.
- Empty search result shows an honest empty state with a launch action.

---

## 4. Close

- Closing a surface from fan-out triggers the app's close path (save/discard/cancel if
  unsaved).
- Closing the last surface of an app leaves the app closed.
- Closing is reversible via the recently-closed ghost for the declared window.

---

## 5. Move to space

- A card can be dragged to a space cluster, or moved via a palette action.
- The surface's space membership changes; the surface is not destroyed.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-050` | Fan-out supports grouping, search, close, move-to-space. |
| `AC-SHELL-STRIP-051` | Close respects unsaved-work protection. |
| `AC-SHELL-STRIP-052` | Move-to-space changes membership without destroying the surface. |
| `AC-SHELL-STRIP-053` | Search filters by title and app name; empty result is honest. |