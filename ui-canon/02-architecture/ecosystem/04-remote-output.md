---
id: ARCH-ECO-REMOTEOUT
title: Remote Output
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX, ARCH-PRESENT-EXECUTOR]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-ROUT-001, AC-ECO-ROUT-002]
---

# Remote Output

> Phone as display for PC, PC as compute for phone, TV cast, car projection.
> Structured stills, not VNC. The remote browser is an executor, not a pixel
> stream (`ADR-0013`).

---

## 1. Model

A remote output is another executor of the same commits. It receives
structured stills/deltas over the protocol, not a pixel stream. Heavy media
may stream as a declared exception. Reconnection reconciles unknown actions
instead of replaying blindly (`LAW-017`).

---

## 2. Scenarios

- Phone as display for PC: PC's authority numbers stills; phone is a remote
  executor.
- PC as compute for phone: phone's surface commits are realized on PC (heavy
  compute) and the result returned as a still.
- TV cast: phone sends structured stills to TV executor.
- Car projection: phone projects to car display as remote output.

---

## 3. Not VNC

Whole-screen pixel streaming is bandwidth-heavy, input-latent, and creates a
second UI stack (`ADR-0013`). Structured stills carry semantics (hit map,
a11y, input ownership) that a pixel stream cannot.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-ROUT-001` | Remote output receives structured stills and renders them. |
| `AC-ECO-ROUT-002` | Reconnection reconciles without corrupting state. |

---

## 5. Open questions

See `13-open-questions.md`.

---

## 6. References

See `15-references.md`. `ADR-0013`, `tunnel.capnp`, `web.capnp`.