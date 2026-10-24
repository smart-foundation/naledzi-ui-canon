---
id: SHELL-LIFECYCLE-UPDATE
title: Lifecycle — Update
kind: shell
entity: lifecycle
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LIFECYCLE-INDEX, CANON-LAWS]
acceptance: [AC-SHELL-LIFECYCLE-040]
---

# Lifecycle — Update

---

## 1. Update flow

1. Check (manual or scheduled; respects metered networks).
2. Download (background, pausable, progress visible).
3. Stage (verify signature + integrity).
4. Apply (on next restart or hot-swap where supported; user chooses timing).
5. Verify (boot marker; rollback if it fails).

## 2. Rules

- **SHELL-LIFECYCLE-041.** Updates MUST be signed and verified; an unverified update
  is never applied.
- **SHELL-LIFECYCLE-042.** The user chooses when to restart for an update; never
  forced mid-work without warning.
- **SHELL-LIFECYCLE-043.** Rollback to the previous version is available for a
  declared window (default 7 days).
- **SHELL-LIFECYCLE-044.** An update that fails to boot triggers automatic rollback
  to the last known good version.
- **SHELL-LIFECYCLE-045.** Updates never reset user data or settings.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LIFECYCLE-040` | Update applies and rolls back on boot failure. |
| `AC-SHELL-LIFECYCLE-041` | User controls restart timing. |
| `AC-SHELL-LIFECYCLE-042` | Rollback available within window. |