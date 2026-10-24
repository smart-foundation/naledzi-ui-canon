---
id: FW-PALETTE-SEARCH
title: Search and ranking
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-003]
---

# Search and ranking

---

## 1. Matching

- Tokenise the query on whitespace and punctuation.
- Match case-insensitively against title, subtitle, keywords and group.
- Support fuzzy subsequence matching with a documented penalty (transpositions cost more
  than skips).
- Match diacritics-insensitively where the locale permits.
- No-result state explains what was searched and offers "search everywhere" / "clear".

## 2. Ranking

Rank by a weighted sum, weights published and testable:

| Factor | Weight | Notes |
|---|---|---|
| Exact prefix match on title | high | |
| Context match (scope) | high | Object/selection commands first when applicable |
| Recency | medium | Last invoked commands bubble up |
| Frequency | medium | Decayed over 30 days |
| Capability available | required | Unavailable commands rank below available ones |
| Destructive | low penalty | Shown, never hidden |
| Safety-relevant | boost | In EV/spaceship, safety commands rank first |

## 3. Scopes

- `global`: commands available everywhere (lock, search, settings).
- `app`: commands of the foreground app.
- `selection`: commands operating on the current selection.
- `object`: commands for the focused object.

The palette shows the union, filtered by availability, grouped by scope with clear
separators.

## 4. Recents and no-result

- Recents are stored per user, capped at 20, privacy-respecting (no sensitive command
  titles in incognito/guest).
- No-result shows the query, "no matching command", and a link to browse all commands.

## 5. Performance

- First keystroke to first result ≤ 16 ms p95 on desktop; ≤ 33 ms on phone.
- Ranking runs on the palette's own scheduler slice; never blocks input.
