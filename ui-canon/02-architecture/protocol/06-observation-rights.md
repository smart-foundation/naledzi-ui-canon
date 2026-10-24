---
id: ARCH-PROTO-OBS
title: Observation Rights
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-OBS-001, AC-PROTO-OBS-002]
---

# Observation Rights

> Thumbnails, capture, clipboard, remote. What may be observed, by whom, and
> on what terms.

---

## 1. Rights

Observation rights are capabilities scoped to an output, surface, or still.
Forms: thumbnail (downscaled pixels), capture (full pixels), remote output
(structured stills), clipboard image. Each requires a capability granted at
handshake or later (`presentation/10-observation.md`).

---

## 2. Consent and audit

Observation capabilities are off by default (`LAW-020`). Active observation
shows an indicator. All grants are auditable and revocable. See
`security/04-observation.md`.

---

## 3. Remote observation

Remote observation uses structured stills, not pixel streams, by default
(`ADR-0013`). Heavy media may stream as a declared exception. Reconnection
reconciles.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-OBS-001` | Observation requires a capability; none by default. |
| `AC-PROTO-OBS-002` | Revocation stops observation with a typed event. |

---

## 5. Open questions

See `10-open-questions.md`.

---

## 6. References

See `12-references.md`.