---
id: APP-PERF
title: App Performance
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Performance Guild
depends: [APP-STANDARD, LAW-004, LAW-016]
acceptance: [AC-APP-STANDARD-012]
---

# App Performance

> A budget is part of the design. An app that cannot meet its budget on its weakest envelope
> is not finished, no matter how beautiful it is.

---

## 1. The budgets

Budgets are measured at **p95**, on the **weakest supported envelope**, with the app's
declared maximum content.

| Metric | Watch | Phone | Tablet | Desktop | TV | EV | Spaceship | IoT |
|---|---|---|---|---|---|---|---|---|
| Cold start to first still | 1.2 s | 800 ms | 700 ms | 600 ms | 1.5 s | 500 ms | 1.0 s | 2.0 s |
| Input to visible feedback | 100 ms | 80 ms | 80 ms | 50 ms | 120 ms | 50 ms | 50 ms | 150 ms |
| Frame time while animating | 16.6 ms | 16.6 ms | 16.6 ms | 8.3 ms | 16.6 ms | 16.6 ms | 16.6 ms | n/a |
| Commit size (typical) | ≤ 256 B | ≤ 512 B | ≤ 512 B | ≤ 1 KiB | ≤ 512 B | ≤ 512 B | ≤ 1 KiB | ≤ 256 B |
| Idle wakeups per minute | 0–1 | 0–1 | 0–1 | 0–1 | 0–1 | 0 | 0–1 | 0–2 |
| Steady memory | 24 MiB | 64 MiB | 96 MiB | 160 MiB | 64 MiB | 96 MiB | 128 MiB | 8 MiB |
| Background CPU while idle | 0% | 0% | 0% | 0% | 0% | 0% | 0% | 0% |

These are ceilings, not targets. An app may use less. It may not use more without an
approved exception.

---

## 2. What is measured

- **Startup:** from activation to the first interactive still.
- **Input latency:** from the input event to the first visible response.
- **Frame time:** the 95th percentile while the app is animating or scrolling.
- **Commit size:** the serialized commit, not the buffer.
- **Idle:** wakeups, CPU, GPU and messages over 10 minutes of no interaction.
- **Memory:** resident and peak during a declared worst-case flow.
- **Energy:** the platform's energy counter over a 10-minute golden flow, where available.
- **Damage ratio:** damaged pixels divided by surface pixels for a representative frame.

---

## 3. The degradation ladder

When a budget is exceeded, degrade in this order. Never degrade the primary action or the
content's meaning.

1. **Reduce motion** — shorten and simplify springs; disable parallax.
2. **Reduce transient effects** — drop blur, then translucency, then animated elevation.
3. **Reduce preview fidelity** — thumbnails, live previews, video quality.
4. **Reduce update frequency** — background sync, non-focused live views.
5. **Reduce non-essential content** — secondary panels, decorative media.
6. **Defer background work** — queue, pause, resume later.
7. **Ask the user** — if the app cannot meet the task's budget, say so and offer a simpler
   mode.

Never:

- hide the primary action;
- drop a warning;
- show a fake value;
- freeze the system;
- spin to appear busy.

---

## 4. Idle

- An idle app sends no commits and schedules no timers it does not need.
- A clock ticks at the interval it declares.
- A video player paused sends nothing.
- A sync that has nothing to do does not poll.
- A background operation that must run is declared, budgeted and visible.

The idle test is simple: leave the app alone for 10 minutes. The expected commit count is
zero (or the declared periodic count). The expected wakeups are in the budget table.

---

## 5. Measurement method

Every app's `08-performance.md` declares:

- the reference device for each envelope;
- the tool used (e.g., the platform's frame-time and energy counters);
- the scenario (golden flow, content size, network state);
- the result and the date;
- the degradation observed, if any.

A claim without a measurement is not a budget. It is a hope.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-APP-PERF-001` | Every budget in §1 passes at p95 on the weakest envelope. |
| `AC-APP-PERF-002` | Idle produces zero commits and zero background CPU. |
| `AC-APP-PERF-003` | The degradation ladder is implemented and tested. |
| `AC-APP-PERF-004` | No degradation hides a primary action or a warning. |
| `AC-APP-PERF-005` | Startup and input latency are measured and recorded. |
| `AC-APP-PERF-006` | The app's worst-case flow stays within memory. |
