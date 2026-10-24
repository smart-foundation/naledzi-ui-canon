---
id: SHELL-STATUS-INDEX
title: Status Rail
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STATUS-000]
children:
  - 01-model.md
  - 02-indicators.md
  - 03-priority-and-collapse.md
  - 04-interaction.md
  - 05-accessibility.md
  - 06-performance.md
  - 07-failure.md
  - 08-acceptance.md
---

# Status Rail

> The status rail is an **adaptive, UX-owned indicator rail** (`ADR-0007`). It is not a
> fixed status bar. It carries the facts a person always needs on this envelope — time,
> power, connectivity, privacy, safety — and nothing else. It collapses, reorders and hides
> by priority. The OS supplies facts; the envelope's policy decides what is always visible.

**Scope:** model, indicators, priority and collapse, interaction, accessibility,
performance, failure, acceptance.

**Non-goals:** rendering (`rendering/`); app internals (`05-apps/`); a fixed vendor bar
(rejected by `ADR-0007`); decorative chrome (`LAW-010`).

---

## 1. The single question this branch answers

> What must a person always be able to see about the state of the system, and how does it
> adapt when there is no room?

---

## 2. The model in one page

```text
    OS FACTS (time, power, connectivity, privacy, notifications, safety)
        │
        ▼
    INDICATOR REGISTRY  (named indicators, each with priority, scope, envelope rules)
        │
        ▼
    POLICY COLLAPSE    (priority order; collapse low-priority first; never truncate a
                        critical warning; safety overrides everything)
        │
        ▼
    RAIL RENDER         (commit at system elevation; updates on change only)
```

- The OS never draws a fixed bar. It declares indicators; policy ranks and collapses.
- Safety indicators (EV warnings, spaceship alarms) are protected: they never collapse,
  never animate through occlusion, and override entertainment indicators.
- Hidden rail costs zero (`LAW-004`).

---

## 3. Directory map

| File | Question |
|---|---|
| [01-model.md](01-model.md) | What the status rail is; OS facts vs policy-owned presentation |
| [02-indicators.md](02-indicators.md) | The indicator set: time, power, connectivity, privacy, notifications, safety, activity |
| [03-priority-and-collapse.md](03-priority-and-collapse.md) | Priority table, collapse order, protected zones, per-envelope |
| [04-interaction.md](04-interaction.md) | Tap/click to open control centre, long-press, remote, voice |
| [05-accessibility.md](05-accessibility.md) | Screen reader, announcements, high contrast, 200% text |
| [06-performance.md](06-performance.md) | Budget, idle zero, update-on-change |
| [07-failure.md](07-failure.md) | Missing fact, stale fact, denied sensor, overflow |
| [08-acceptance.md](08-acceptance.md) | How it is proved |

---

## 4. Envelope coverage

| Envelope | Visible by default | Collapsed to |
|---|---|---|
| Watch | time, activity, battery | time only on extreme low power |
| Phone | time, signal, battery, privacy | time + battery in landscape/compact |
| Tablet | time, signal, battery, privacy | time + battery |
| Desktop | minimal; on demand | none (hidden) unless safety |
| TV | minimal, readable at 3 m | time only |
| EV | speed, range, warnings (protected) | warnings never collapse |
| Spaceship | alarms, procedures, redundancy | alarms never collapse |
| IoT | none or single LED | n/a |
| Spatial | anchored rail, time, safety | time only on low power |
| Remote browser | browser chrome only | browser-mediated |

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-STATUS-001` | Each envelope's rail has a priority table and a collapse test. |
| `AC-SHELL-STATUS-002` | A critical warning is never truncated or collapsed on any envelope. |
| `AC-SHELL-STATUS-003` | Hidden rail costs zero messages/wakeups/GPU over one hour. |