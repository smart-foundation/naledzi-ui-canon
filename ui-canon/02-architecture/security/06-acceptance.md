---
id: ARCH-SEC-ACCEPTANCE
title: Security Acceptance
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-SEC-000]
---

# Security Acceptance

## 1. Index

| ID | Test |
|---|---|
| `AC-ARCH-SEC-000` | Branch coverage complete. |
| `AC-SEC-THREAT-001` | Malicious app cannot read another's buffer. |
| `AC-SEC-THREAT-002` | Compromised service cannot lie without detection. |
| `AC-SEC-REV-001` | Revocation mid-op delivers typed event; no crash. |
| `AC-SEC-REV-002` | No fake success after revocation. |
| `AC-SEC-REV-003` | Revoked buffer enters revoked state and recovers. |
| `AC-SEC-SURF-001` | Protected surfaces not capturable. |
| `AC-SEC-SURF-002` | DRM content stays on protected buffers. |
| `AC-SEC-OBS-001` | Active observation shows unhidable indicator. |
| `AC-SEC-OBS-002` | Observation off by default; explicit consent. |
| `AC-SEC-REMOTE-001` | Unpaired peer cannot observe/control. |
| `AC-SEC-REMOTE-002` | Revoked device loses access immediately. |

## 2. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-SEC-000` | Branch coverage complete. |

## 3. Open questions

See `07-open-questions.md`.

## 4. References

See `09-references.md`.