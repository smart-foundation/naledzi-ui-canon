---
id: SHELL-STATUS-PRIORITY
title: Status Rail — Priority and Collapse
kind: shell
entity: status-rail
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STATUS-INDICATORS, SHELL-STATUS-MODEL, CANON-LAWS, CANON-DECISIONS]
acceptance: [AC-SHELL-STATUS-030]
---

# Status Rail — Priority and Collapse

> Priority is the rule by which the rail decides what survives when space runs out. It is
> not a vendor's ordering. Safety always wins. Collapse removes low-priority indicators
> first; it never truncates a critical warning.

---

## 1. Priority bands

| Band | Priority range | Meaning | Collapse behaviour |
|---|---|---|---|
| `safety` | 0–9 | Safety-critical facts (warnings, alarms, procedures, redundancy) | Never collapse, never hide |
| `essential` | 10–29 | Facts needed on every task (time, battery, offline, privacy) | Collapse only in extreme scarcity, after all other bands |
| `contextual` | 30–59 | Facts useful on this envelope (signal, activity, speed, range) | Collapse first when space is tight |
| `ambient` | 60–99 | Nice-to-have (date, focus mode, time zone) | Collapse on compact density or small envelopes |

Lower number = higher priority. Within a band, order is by the indicator's declared
`priority` value.

## 2. Collapse algorithm

1. Compute available width/height for the rail on this envelope at this density.
2. Place indicators in priority order.
3. If an indicator does not fit, collapse the lowest-priority *collapsible* indicator.
4. Repeat until everything fits or only non-collapsible indicators remain.
5. If non-collapsible indicators alone do not fit, the envelope's layout is wrong — record
   as a failure (`07-failure.md`), do not truncate a safety indicator.

Rules:

- **SHELL-STATUS-031.** Collapse MUST remove whole indicators, never truncate their text.
  A truncated warning is a lie (`LAW-011`).
- **SHELL-STATUS-032.** Safety indicators are non-collapsible on every envelope.
- **SHELL-STATUS-033.** Collapse MUST be announced to assistive tech (`05-accessibility.md`).
- **SHELL-STATUS-034.** Collapse MUST animate with a settle-and-stop spring and respect
  reduced motion (`FOUND-MOTION`).
- **SHELL-STATUS-035.** The rail MUST NOT reflow app content. It occupies its declared
  region; if it needs more, it collapses instead.

## 3. Per-envelope priority tables

### Watch

| Order | Indicator | Band |
|---|---|---|
| 1 | time | essential |
| 2 | activity | contextual |
| 3 | battery | essential |
| 4 | notifications | contextual |
| 5 | alarm | safety |

### Phone

| Order | Indicator | Band |
|---|---|---|
| 1 | time | essential |
| 2 | privacy | essential |
| 3 | battery | essential |
| 4 | signal | contextual |
| 5 | offline | essential |
| 6 | notifications | contextual |
| 7 | focus-mode | ambient |

### Desktop

Rail hidden by default; when summoned or when a safety fact changes, show:

| Order | Indicator | Band |
|---|---|---|
| 1 | safety-warning / alarm | safety |
| 2 | time | essential |
| 3 | privacy | essential |
| 4 | offline | essential |

### EV

| Order | Indicator | Band |
|---|---|---|
| 1 | safety-warning | safety |
| 2 | alarm | safety |
| 3 | speed | contextual |
| 4 | range | contextual |
| 5 | battery (vehicle) | essential |
| 6 | time | essential |

Safety indicators occupy protected zones and never animate through occlusion
(`ADR-0017`).

### Spaceship

| Order | Indicator | Band |
|---|---|---|
| 1 | alarm / alarm-count | safety |
| 2 | procedure | safety |
| 3 | redundancy | safety |
| 4 | safety-warning | safety |

Only safety band is shown on spaceship; there is no ambient or contextual rail.

### TV

| Order | Indicator | Band |
|---|---|---|
| 1 | time | essential |
| 2 | notifications | contextual |

Readable at 3 m; no small icons without a text label.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STATUS-030` | Each envelope's priority table is implemented and tested. |
| `AC-SHELL-STATUS-031` | Collapse removes whole indicators and never truncates. |
| `AC-SHELL-STATUS-032` | Safety indicators never collapse on any envelope. |
| `AC-SHELL-STATUS-033` | Collapse is announced and animated with reduced-motion alternative. |