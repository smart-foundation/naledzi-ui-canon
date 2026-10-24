---
id: FW-PALETTE-PERF
title: Performance
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-008]
---

# Performance

---

## 1. Budgets

| Envelope | First keystroke → first result (p95) | Memory |
|---|---|---|
| Desktop | 16 ms | ≤ 8 MB resident for registry + index |
| Phone | 33 ms | ≤ 4 MB |
| Watch | 50 ms | ≤ 2 MB |
| TV | 33 ms | ≤ 6 MB |
| EV | 33 ms | ≤ 4 MB |
| Spatial | 16 ms | ≤ 8 MB |

## 2. Idle

- Closed palette schedules zero frames (`LAW-004`).
- Open palette with no query shows recents; no polling for registry changes (push only).

## 3. Degradation

1. Drop fuzzy matching → prefix only.
2. Drop recents ranking → context + prefix.
3. Drop icons → text only.
4. Full-surface fallback for the overlay if damage merging fails.

## 4. Measurement

- Frame time via the scheduler harness (runtime/09).
- Allocation count per keystroke via the testing harness (runtime/10).
