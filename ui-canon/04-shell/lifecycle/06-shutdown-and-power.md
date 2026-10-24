---
id: SHELL-LIFECYCLE-SHUTDOWN
title: Lifecycle — Shutdown and Power
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-060]
---

# Lifecycle — Shutdown and Power

---

## 1. Power states

| State | Meaning |
|---|---|
| `on` | Active use |
| `idle` | Screen off, session alive, wake on input |
| `sleep` | Low power; session preserved; wake in < 2 s |
| `hibernate` | Session to disk; wake slower; zero power |
| `off` | Shut down |

## 2. Shutdown / restart

- Shutdown flushes data and closes surfaces with unsaved-work protection.
- Restart is a shutdown + boot; update apply happens here if staged.
- Force shutdown (hardware) is always available; data loss risk is stated.

## 3. Thermal

- Thermal throttling is visible: performance degrades gracefully; the user is told
  when throttling affects their task.
- On extreme thermal, the OS protects itself (shutdown) with a clear message.

## 4. Battery

- Low battery triggers a declared sequence: dim, disable non-essential, warn, then
  sleep/shutdown.
- Battery saver mode reduces motion, brightness and background work; announced.

## 5. Rules

- **SHELL-LIFECYCLE-061.** Shutdown MUST protect unsaved work (prompt or auto-save draft).
- **SHELL-LIFECYCLE-062.** Thermal throttling MUST be visible, not silent.
- **SHELL-LIFECYCLE-063.** Low-battery sequence is declared and reversible.

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-060` | Shutdown protects unsaved work. |
| `AC-SHELL-LIFECYCLE-061` | Thermal throttling visible. |
| `AC-SHELL-LIFECYCLE-062` | Low-battery sequence declared. |