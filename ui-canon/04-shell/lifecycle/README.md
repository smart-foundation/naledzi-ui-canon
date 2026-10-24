---
id: SHELL-LIFECYCLE-INDEX
title: Lifecycle
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-INDEX, SHELL-MODEL-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-LIFECYCLE-000]
children:
  - 01-boot.md
  - 02-first-run.md
  - 03-login-and-session.md
  - 04-update.md
  - 05-recovery.md
  - 06-shutdown-and-power.md
  - 07-accessibility.md
  - 08-failure.md
  - 09-acceptance.md
---

# Lifecycle

> Lifecycle is **the OS's own life**: boot, first-run, login, session, update, recovery,
> shutdown and power. It is the part of the shell that happens before and after the user's
> work.

**Scope:** boot, first-run, login and session, update, recovery, shutdown and power/thermal,
accessibility, failure, acceptance.

**Non-goals:** kernel internals; driver details; app internals.

---

## 1. The single question this branch answers

> How does the OS start, welcome, update, recover and stop — honestly and without losing
> the user's work?

---

## 2. The model in one page

```text
    BOOT  ──►  FIRST-RUN (if new)  ──►  LOGIN  ──►  SESSION  ──►  (UPDATE / RECOVERY)  ──►  SHUTDOWN
```

Each stage is a named state with a frame, an announcement, and a failure path.

---

## 3. Directory map

| File | Question |
|---|---|
| [01-boot.md](01-boot.md) | Boot sequence and what the user sees |
| [02-first-run.md](02-first-run.md) | First-run / onboarding |
| [03-login-and-session.md](03-login-and-session.md) | Login and session establishment |
| [04-update.md](04-update.md) | Updates: check, download, apply, rollback |
| [05-recovery.md](05-recovery.md) | Recovery mode and repair |
| [06-shutdown-and-power.md](06-shutdown-and-power.md) | Shutdown, restart, sleep, power/thermal |
| [07-accessibility.md](07-accessibility.md) | A11y across lifecycle |
| [08-failure.md](08-failure.md) | Failure modes |
| [09-acceptance.md](09-acceptance.md) | How it is proved |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-000` | Every file listed in `children` exists; no `TODO` or empty section. |
| `AC-SHELL-LIFECYCLE-001` | Boot reaches a usable state or an honest failure. |
| `AC-SHELL-LIFECYCLE-002` | Update can roll back. |