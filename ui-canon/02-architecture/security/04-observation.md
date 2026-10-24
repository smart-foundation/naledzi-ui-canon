---
id: ARCH-SEC-OBSERVATION
title: Observation (Security)
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SEC-OBS-001, AC-SEC-OBS-002]
---

# Observation (Security)

> Camera/mic/screen/clipboard indicators, consent, audit. Observation is
> explicit, indicated, consensual, and auditable.

---

## 1. Indicators

Active camera, microphone, screen capture, and clipboard access MUST show a
visible indicator while active. Indicators are system-owned and cannot be
hidden by apps.

---

## 2. Consent

Observation capabilities are off by default (`LAW-020`). Granting requires
explicit, informed, revocable user consent. Consent is recorded and auditable.

---

## 3. Audit

Every observation grant and use is recorded in the still history / audit log.
Revocation is immediate and enforced mid-operation.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SEC-OBS-001` | Active observation shows an indicator that cannot be hidden. |
| `AC-SEC-OBS-002` | Observation is off by default and requires explicit consent. |

---

## 5. Open questions

See `07-open-questions.md`.

---

## 6. References

See `09-references.md`. `camera.capnp`, `capture.capnp`, `clipboard.capnp`.