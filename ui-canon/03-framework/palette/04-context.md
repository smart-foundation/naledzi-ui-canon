---
id: FW-PALETTE-CONTEXT
title: Context
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-004]
---

# Context

---

## 1. Context resolution

The palette resolves context from the current focus and selection:

1. If a text field is focused and the selection is non-empty, scope = `selection` +
   `object` for the field's owner.
2. Else if an object is focused (list row, card, node), scope = `object` + `app`.
3. Else scope = `app` + `global`.

## 2. Global vs app vs selection vs object

| Scope | Source | Lifetime |
|---|---|---|
| global | Shell + system commands | Always |
| app | Foreground app's registry | While app is foreground |
| selection | Commands whose availability predicate matches the selection | While selection non-empty |
| object | Commands for the focused object | While object focused |

## 3. Rules

- `FW-PALETTE-CTX-001`: Context changes update the palette's result set without clearing
  the query.
- `FW-PALETTE-CTX-002`: A command whose scope no longer applies is removed from results
  and, if highlighted, focus moves to the next valid item.
- `FW-PALETTE-CTX-003`: The palette never shows a command whose capability is denied
  without marking it and offering the request path.
