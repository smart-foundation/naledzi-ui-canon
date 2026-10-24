---
id: ARCH-ECO-SPACE
title: Space and Window Continuity
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-SPACE-001, AC-ECO-SPACE-002]
---

# Space and Window Continuity

> Window/space transfer, layout adaptation, focus. A workspace moves with the
> person; layout adapts to the new envelope.

---

## 1. Transfer

A space (workspace) and its windows can transfer to another device. The
receiving device adapts the layout to its envelope (collapse, page, re-flow).
Focus follows the transferred window.

---

## 2. Adaptation

No feature fork: content is re-flowed, collapsed, paged, or moved to a peer
(`LAW-013`). The same app grammar holds on every device.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-SPACE-001` | Transferred window adapts layout to new envelope. |
| `AC-ECO-SPACE-002` | Focus follows transferred window. |

---

## 4. Open questions

See `13-open-questions.md`.

---

## 5. References

See `15-references.md`. `windowmanager.capnp`, `shell.capnp`.