---
id: SHELL-LOCK-SESSIONS
title: Lock — Sessions and Users
kind: shell
entity: lock
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-LOCK-MODEL, CANON-LAWS]
acceptance: [AC-SHELL-LOCK-040]
---

# Lock — Sessions and Users

---

## 1. Multi-user

- A device may have multiple user accounts; each has its own session, spaces, settings
  and data.
- Switching users locks the current session and starts/switches to the other's.
- Users are isolated: no cross-user data access without explicit sharing.

## 2. Guest

- A guest session is ephemeral: no persistent data, no access to the owner's data,
  cleared on exit.
- Guest may be PIN-gated or open, per device policy.

## 3. Kiosk

- A kiosk mode locks the device to one app/surface; the user cannot exit without the
  kiosk credential.
- Kiosk is a declared mode, not a hack; it is used for public/shared devices.

## 4. Rules

- **SHELL-LOCK-041.** User switching MUST preserve each session (no data loss).
- **SHELL-LOCK-042.** Guest data MUST be cleared on exit; no residue.
- **SHELL-LOCK-043.** Kiosk exit requires the kiosk credential; no gesture bypass.

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-LOCK-040` | User switch preserves both sessions. |
| `AC-SHELL-LOCK-041` | Guest data cleared on exit. |
| `AC-SHELL-LOCK-042` | Kiosk cannot be exited without credential. |