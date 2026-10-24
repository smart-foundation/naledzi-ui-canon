---
id: FW-RUNTIME-SCHEDULER
title: "Scheduler: frame budget, priority, idle, background work, safety timing"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-FW-SCHED-001]
---

# Scheduler

> One scheduler per app, owned by MirUI. Frame budget is a design constraint (LAW-016).
> Idle is silent (LAW-004).

---

## 1. Frame budget

- FW-SCHED-001. Every app declares a frame budget for its weakest supported envelope
  (APP-STANDARD §7/§8). The scheduler measures against it.
- FW-SCHED-002. A frame consists of: input -> update -> layout -> render -> commit.
  Each phase has a sub-budget; overrun is recorded, not hidden.
- FW-SCHED-003. If the budget cannot be met, the degradation ladder applies
  (`10-testing.md`, app standard §7).

## 2. Priority

| Priority | Work | Rules |
|---|---|---|
| Critical | Safety indicators, alarms, input echo | Never delayed by lower priority. |
| High | Frame commit, input handling | Runs every frame if needed. |
| Normal | Layout, render, app update | Budgeted. |
| Idle | Persistence, prefetch, analytics | Runs only when no higher work; MUST NOT delay frames. |

- FW-SCHED-004. Safety timing (EV, spaceship) overrides normal scheduling; critical
  indicators are never starved.
- FW-SCHED-005. No priority inversion without a documented reason.

## 3. Idle

- FW-SCHED-006. When nothing changed, the scheduler schedules nothing (LAW-004). No
  heartbeat, no polling.
- FW-SCHED-007. An animation is the only legitimate self-scheduling source, and it settles.
- FW-SCHED-008. Background work that needs periodic execution declares its period and
  justifies it.

## 4. Background work

- FW-SCHED-009. Background work runs at idle priority and is cancellable.
- FW-SCHED-010. Long work is chunked so frames are not starved.
- FW-SCHED-011. Background work MUST NOT allocate on the hot path beyond declared budgets.

## 5. Safety timing

- FW-SCHED-012. EV and spaceship envelopes use bounded, non-overshooting motion; critical
  indicators have protected zones and never animate through occlusion.
- FW-SCHED-013. Safety-critical frames are committed even under load; non-critical work
  degrades first.

## 6. Measurement

- FW-SCHED-014. Frame time, phase time, wakeups and allocations are measured and reported
  (performance harness). Numbers are reported even if bad (AGENTS.md §6).

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-SCHED-001` | Idle app schedules zero frames for one hour (measured). |
| `AC-FW-SCHED-002` | p95 frame time within budget on the weakest supported envelope. |
| `AC-FW-SCHED-003` | Safety indicator commits within its declared bound under load. |