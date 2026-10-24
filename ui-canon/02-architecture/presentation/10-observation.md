---
id: ARCH-PRESENT-OBSERVATION
title: Observation
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-AUTHORITY]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-004, AC-ARCH-PRESENT-010]
---

# Observation

> Who may observe a still, on what terms. Thumbnails, capture, remote output,
> clipboard. Capability-gated. No observer reads a buffer without a capability.

---

## 1. What observation is

Observation is reading a still's pixels or semantics by a component other than
the authority/executor pipeline: thumbnails, screen capture, remote output,
clipboard paste of an image, accessibility tooling beyond the derived tree.
Every observation is capability-gated by the authority.

---

## 2. Terms

- Observation requires a capability granted at handshake or later via the
  capability system (`capability.capnp`).
- The authority checks the capability before granting any observation handle.
- Observation is scoped: to an output, a surface, a time range, or a single
  still number.
- Observation may be revoked at any time; the observer receives a typed
  revocation event (`security/02-capability-revocation.md`).

---

## 3. Forms

| Form | What it reads | Capability |
|---|---|---|
| Thumbnail | downscaled pixels of a still | `observe.thumbnail` |
| Screen capture | full pixels of a still or stream | `observe.capture` |
| Remote output | structured stills for a remote peer | `observe.remote` |
| Clipboard image | pixels copied to clipboard | `clipboard.write` |
| Accessibility observation | semantic tree (already public to AT) | derived, no extra cap |

---

## 4. What observation is NOT

- Not a side channel for pixels across a contract boundary: the observer
  receives a capability-scoped handle, not raw bytes (`LAW-002`).
- Not a way to bypass the authority: the authority decides what "delivered"
  means for an observed still (`01-model.md` INV-3).
- Not implicit: observation capabilities are off by default (`LAW-020`).

---

## 5. Audit and consent

Observation capabilities are recorded in the still history and auditable. Screen
capture and remote output MUST show an indicator while active
(`security/04-observation.md`). Consent is explicit and revocable.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-004` | No observer reads a buffer without a capability. |
| `AC-ARCH-PRESENT-010` | No observer reads a buffer without a capability, even with a valid still number. |
| `AC-ARCH-PRESENT-031` | Revoking an observation capability stops the observation without crashing the observer. |
| `AC-ARCH-PRESENT-032` | Observation capabilities are off by default on a fresh install. |

---

## 7. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-OBS-001` | Should observation be per-still or per-stream by default? | Architecture Editor | proposed |

---

## 8. References

- Dennis, J. B. & Van Horn, E. C. (1966). https://dl.acm.org/doi/10.1145/365230.365252
- Miller, M. S. (2006). https://www.erights.org/talks/thesis/
- Wayland, `wlr-screencopy`. https://wayland.freedesktop.org/docs/html/