---
id: SHELL-STATUS-PERF
title: Status Rail — Performance
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-MODEL, LAW-004, LAW-016]
acceptance: [AC-SHELL-STATUS-060]
---

# Status Rail — Performance

---

## 1. Budgets

| Metric | Budget |
|---|---|
| Idle cost (hidden) | 0 messages, 0 wakeups, 0 GPU time per hour |
| Idle cost (visible) | Only the declared clock tick; no redraw without a fact change |
| Commit cost | One commit per fact change; no batched timers |
| Collapse animation | Settles within 240 ms at 60 Hz; no overshoot on safety envelopes |
| Memory | Indicator set + one commit buffer; no per-indicator allocations on the hot path |

## 2. Rules

- **SHELL-STATUS-061.** The rail MUST NOT poll any fact owner. It receives change
  notifications and commits on change (`LAW-004`).
- **SHELL-STATUS-062.** A fact that changes faster than 1 Hz MUST be coalesced or
  displayed as a smoothed value; the rail must not commit 60 times a second for a
  rapidly-changing sensor.
- **SHELL-STATUS-063.** Thumbnails and icons are cached by ID; no decode on the commit
  path.
- **SHELL-STATUS-064.** On the weakest supported envelope (watch), the rail's commit must
  complete within the envelope's frame budget.

## 3. Degradation ladder

1. Reduce animation (instant collapse).
2. Drop ambient indicators.
3. Drop contextual indicators.
4. Keep only essential + safety.
5. Hide the rail entirely except safety indicators (never hide safety).

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-060` | Hidden rail costs zero over one hour on a watch. |
| `AC-SHELL-STATUS-061` | Visible rail commits only on fact change. |
| `AC-SHELL-STATUS-062` | Weakest envelope meets frame budget. |