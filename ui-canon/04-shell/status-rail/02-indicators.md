---
id: SHELL-STATUS-INDICATORS
title: Status Rail — Indicators
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-MODEL, SHELL-MODEL-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-STATUS-020]
---

# Status Rail — Indicators

> An indicator is a single fact made visible. It has a name, a priority, an update rule
> and an envelope allow-list. It is not a widget an app can add to.

---

## 1. The indicator set

| Indicator | Fact | Update trigger | Default on |
|---|---|---|---|
| `time` | current time | per-minute tick (or per-second when seconds shown) | all envelopes except IoT |
| `date` | current date | day change | watch, phone, tablet, TV, spatial |
| `battery` | level + charging state | level change or charging change | watch, phone, tablet, EV, spatial |
| `signal` | connectivity quality | quality change | phone, tablet, EV |
| `offline` | no network | state change | all when offline |
| `privacy` | an observation capability is active | capability grant/use change | all |
| `notifications` | unread count / do-not-disturb / safety | notification state change | watch, phone, tablet, TV, spatial |
| `activity` | motion/activity summary | activity change | watch |
| `speed` | vehicle speed | change (EV, safety-gated) | EV |
| `range` | remaining range | change | EV |
| `safety-warning` | EV/spaceship warning | any change | EV, spaceship |
| `procedure` | active procedure (spaceship) | procedure change | spaceship |
| `redundancy` | redundancy state | change | spaceship |
| `alarm` | active alarm | any change | EV, spaceship, IoT (LED) |
| `alarm-count` | number of active alarms | change | spaceship |
| `time-zone` | current zone | change | watch, phone (travel) |
| `focus-mode` | do-not-disturb / focus | change | phone, tablet, desktop |

## 2. Rules

- **SHELL-STATUS-021.** An indicator MUST have a named fact owner. An indicator with no
  owner is forbidden (`LAW-001`).
- **SHELL-STATUS-022.** An indicator MUST update on change, never on a timer except the
  declared clock tick (`LAW-004`).
- **SHELL-STATUS-023.** An indicator MUST declare its envelope allow-list. An indicator
  that appears on every envelope without justification is permanent chrome without a job
  (`LAW-010`).
- **SHELL-STATUS-024.** Safety indicators (`safety-warning`, `alarm`, `procedure`,
  `redundancy`) are protected: they never collapse, never hide, and override all other
  indicators (`ADR-0017`).
- **SHELL-STATUS-025.** The `privacy` indicator is mandatory whenever an observation
  capability (camera, microphone, screen capture, location, clipboard read) is active. It
  is the visible proof of `LAW-020`.
- **SHELL-STATUS-026.** An app may not add an indicator. App-local status lives in the app
  frame's Status region (`APP-STANDARD` §3.1).

## 3. Indicator anatomy

Each indicator declares:

- `name` (stable ID),
- `fact` (owner + field),
- `priority` (integer, lower = higher; see `03-priority-and-collapse.md`),
- `envelopes` (allow-list),
- `render` (icon + optional text + optional count),
- `interaction` (tap target; see `04-interaction.md`),
- `announcement` (screen-reader text),
- `collapse` (whether it may be collapsed, and at what threshold),
- `safety` (protected flag).

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-020` | Every indicator has an owner, a priority, an envelope allow-list and an announcement. |
| `AC-SHELL-STATUS-021` | No app adds an indicator; the set is closed and owned by this spec. |
| `AC-SHELL-STATUS-022` | Privacy indicator appears whenever an observation capability is active. |
| `AC-SHELL-STATUS-023` | Safety indicators are never collapsed on any envelope. |