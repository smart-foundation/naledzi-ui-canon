---
id: SHELL-STRIP-CARDS
title: Strip Cards
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, SHELL-STRIP-MODEL, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-020, AC-SHELL-STRIP-021]
---

# Strip Cards

> A card is a surface's live representation in the strip: thumbnail, title, state, privacy,
> live vs frozen, badges. It is derived, never a second copy.

---

## 1. Card anatomy

```text
   ┌──────────────────────────────┐
   │  thumbnail (live still)      │  <- observation capability
   │                              │
   │  title                       │  <- from surface semantics
   │  state badge   ·  badges     │  <- running/paused/loading/error/offline
   └──────────────────────────────┘
```

Fields:

| Field | Source | Notes |
|---|---|---|
| `thumbnail` | Last committed still of the surface, scaled | Commit-driven; never polled |
| `title` | Surface semantics identity | Localised; never a raw ID |
| `state` | Surface/app state | running, paused, loading, error, offline, denied, degraded |
| `badges` | Counts, progress, attention flags | From app declarations |
| `privacy` | App-declared sensitivity + user grants | Blanked/omitted if sensitive |
| `live` | Whether the thumbnail is live or frozen | Frozen when app is not visible/committing |

---

## 2. Live vs frozen

- **Live:** the app is visible or committing; the thumbnail updates on each commit.
- **Frozen:** the app is backgrounded or suspended; the thumbnail shows the last committed
  still with a "paused" indicator. No updates occur (idle silence).
- A frozen card never animates. A live card updates only on commit.

---

## 3. State

The card's state badge reflects the app's universal state machine (`APP-STATE-MACHINE`):

| App state | Card badge |
|---|---|
| loading | skeleton thumbnail + "loading" |
| ready/idle | none (live thumbnail) |
| ready/busy | progress indicator |
| ready/editing | "editing" dot |
| empty | empty-state thumbnail |
| error | error glyph + reason tooltip |
| offline | offline glyph |
| denied | denied glyph |
| degraded | degraded glyph |
| closing | "closing" progress |

---

## 4. Badges

Badges are small counts/flags declared by the app: unread count, progress percentage,
attention required. Rules:

- Badges are semantic, not decorative.
- A badge with a count must be accurate or absent; never stale.
- Badges respect quiet hours (suppressed but counted in history).

---

## 5. Privacy

See `07-privacy.md`. Summary: an app may declare itself sensitive (banking, health,
private browsing). Sensitive apps show a placeholder card by default, or a blanked
thumbnail if the user grants observation. The user can override per app.

---

## 6. Accessibility

- Each card has a role (button), name (title + state), and action (activate to switch).
- The thumbnail is `aria-hidden` or has an alt derived from the surface semantics; the
  title is the accessible name.
- Magnification announces the focused card.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-020` | Every card field is derived from a numbered still or a declared fact. |
| `AC-SHELL-STRIP-021` | Live cards update only on commit; frozen cards do not update. |
| `AC-SHELL-STRIP-022` | Sensitive apps show placeholder/blanked by default. |
| `AC-SHELL-STRIP-023` | Card state badge matches app state machine. |