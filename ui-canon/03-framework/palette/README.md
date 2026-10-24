---
id: FW-PALETTE-INDEX
title: "Palette: universal command surface"
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-README, CANON-LAWS, APP-STANDARD]
supersedes: []
superseded_by: []
acceptance: [AC-FW-PALETTE-000]
children:
  - 01-architecture.md
  - 02-commands.md
  - 03-search.md
  - 04-context.md
  - 05-voice.md
  - 06-remote.md
  - 07-accessibility.md
  - 08-performance.md
  - 09-failure.md
  - 10-acceptance.md
---

# Palette

> The palette is a foundation, not an optional app (master brief §2). It is the universal
> command surface: find and invoke any command from anywhere.

**Non-goal.** The palette is not an app launcher only; it is every command, search and
action, ranked and context-aware.

---

## 1. Directory map

| File | Question |
|---|---|
| [01-architecture.md](01-architecture.md) | Universal command surface; not an app. |
| [02-commands.md](02-commands.md) | Stable IDs, labels, shortcuts, capability requirements, visible paths. |
| [03-search.md](03-search.md) | Ranking, fuzzy matching, scopes, recents, no-result. |
| [04-context.md](04-context.md) | Global vs app vs selection vs object. |
| [05-voice.md](05-voice.md) | Same commands, confirmation, transcript. |
| [06-remote.md](06-remote.md) | Palette on TV/watch/remote. |
| [07-accessibility.md](07-accessibility.md) | Accessibility. |
| [08-performance.md](08-performance.md) | Performance. |
| [09-failure.md](09-failure.md) | Failure. |
| [10-acceptance.md](10-acceptance.md) | Acceptance. |

---

## 2. Component cross-reference

`components/command-palette/` owns parts, states and input contract; `palette/` owns model,
ranking and command semantics. Neither contradicts the other; palette wins for ranking,
component wins for structure (`../README.md` §5.3).

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-PALETTE-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-FW-PALETTE-001` | Every command has a stable ID, label, shortcut (if any), capability requirement and visible path. |