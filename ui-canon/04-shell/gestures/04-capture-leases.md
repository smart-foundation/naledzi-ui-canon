---
id: SHELL-GESTURES-CAPTURE
title: Gestures — Capture Leases
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-GRAMMAR, ARCH-PRESENT-INDEX]
acceptance: [AC-SHELL-GESTURES-040]
---

# Gestures — Capture Leases

---

## 1. What a capture lease is

A drag, long-press or modal interaction needs input even when the pointer leaves the
surface. Capture is a **lease**: time-bound, revocable, scoped to the interaction
(`APP-INPUT` §4).

## 2. Rules

- **SHELL-GESTURES-041.** A lease is granted by the policy on a declared interaction
  start; it expires on release, cancel, timeout, or revocation.
- **SHELL-GESTURES-042.** A crashed app's lease expires; no stuck pointer remains
  (`LAW-015`).
- **SHELL-GESTURES-043.** The lease holder is named in the still; input ownership is
  explicit (`LAW-005`).
- **SHELL-GESTURES-044.** A lease may be revoked by the policy (e.g. safety override);
  revocation is announced and the interaction cancels cleanly.
- **SHELL-GESTURES-045.** Capture is not a global grab; it is a capability with an
  expiry (`ADR-0009`).

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-GESTURES-040` | Leases expire on release, cancel, timeout, crash. |
| `AC-SHELL-GESTURES-041` | Revocation cancels cleanly and is announced. |