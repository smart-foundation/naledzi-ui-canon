---
id: SHELL-LIFECYCLE-FIRSTRUN
title: Lifecycle — First-Run
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-020]
---

# Lifecycle — First-Run

---

## 1. First-run flow

1. Welcome (language, region, accessibility quick picks).
2. Account creation / sign-in (optional; local account always possible).
3. Privacy choices (telemetry off by default; `LAW-020`).
4. Connectivity (optional; offline-capable).
5. Key features tour (gestures, strip, palette) — skippable.
6. Finish: land on home/session.

## 2. Rules

- **SHELL-LIFECYCLE-021.** First-run MUST be skippable in full after the account step;
  no forced tour.
- **SHELL-LIFECYCLE-022.** Telemetry and cloud features are off by default; opt-in is
  explicit and revocable (`LAW-020`).
- **SHELL-LIFECYCLE-023.** A local account with no network MUST be possible.
- **SHELL-LIFECYCLE-024.** First-run MUST be accessible: screen reader, keyboard,
  switch, voice.
- **SHELL-LIFECYCLE-025.** Re-running first-run is available from Settings (replay).

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-020` | First-run completable offline with a local account. |
| `AC-SHELL-LIFECYCLE-021` | Tour is skippable. |
| `AC-SHELL-LIFECYCLE-022` | Telemetry off by default. |