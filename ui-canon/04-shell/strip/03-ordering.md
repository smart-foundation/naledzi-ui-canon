---
id: SHELL-STRIP-ORDERING
title: Strip Ordering
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, SHELL-STRIP-MODEL, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-030, AC-SHELL-STRIP-031]
---

# Strip Ordering

> Recency by default, user-arranged on request. Per-window or per-app, per space or all
> spaces. The order is a plan, never a fact about the world.

---

## 1. Default order

- **Recency of focus:** most recently focused surface first. This is the default and
  requires no user arrangement.
- Ties broken by commit order (most recent commit first).
- Pinned surfaces (user-pinned) always appear first, in user order, then recency.

---

## 2. User-arranged

- The user may drag cards to reorder. The order persists per space (and globally if "all
  spaces" view).
- User order overrides recency until reset.
- Reset to recency is a declared action (palette, context menu).

---

## 3. Per-window vs per-app

- By default, the strip shows **one card per surface** (per-window). An app with three
  windows shows three cards.
- A toggle groups by app: one card per app, expanding to its surfaces. Grouping is a view,
  not a data change.
- The user's choice (per-window vs grouped) persists.

---

## 4. Spaces

- Default: current space only.
- Toggle: all spaces, grouped by space with space names.
- A card can be moved to another space by drag or palette action; the surface's space
  membership changes.

---

## 5. Special positions

- Pinned cards: first, in user order.
- The "launch" card (open a new app/surface) is always last or in a declared position.
- Recently closed surfaces may appear as ghost cards for a short window (declared, default
  10 s) to allow undo; after that they are gone.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-030` | Default order is recency of focus; pinned first. |
| `AC-SHELL-STRIP-031` | User order persists per space and can be reset. |
| `AC-SHELL-STRIP-032` | Per-window and grouped views are both available and toggle without data change. |
| `AC-SHELL-STRIP-033` | Ghost cards for recently closed surfaces disappear after the declared window. |