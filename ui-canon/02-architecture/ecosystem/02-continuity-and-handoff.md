---
id: ARCH-ECO-CONTINUITY
title: Continuity and Handoff
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-CONT-001, AC-ECO-CONT-002]
---

# Continuity and Handoff

> Continue editing, call handoff, media handoff, focus transfer; state
> ownership; conflict. Work moves; truth stays local-first.

---

## 1. Principles

- State ownership stays with the origin device until handoff completes; the
  receiving device receives a copy plus a lease, not ownership, until
  confirmed.
- Handoff is explicit or policy-driven, never silent.
- Conflict is surfaced, never resolved by last-writer-wins
  (`06-sync-and-conflict.md`).

---

## 2. Handoff types

- **Continue editing:** document/state moves to another device; origin retains
  a recovery copy until ack.
- **Call handoff:** active call moves; audio/video routes switch; old device
  releases mic/camera capability.
- **Media handoff:** playback moves; position preserved.
- **Focus transfer:** input focus moves to the receiving device's surface.

---

## 3. State ownership and conflict

During handoff, both devices may briefly hold state. Conflict resolution
follows version vectors (`06-sync-and-conflict.md`), not last-writer-wins.
The user is shown a conflict if one arises.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-CONT-001` | Handoff preserves document position and state. |
| `AC-ECO-CONT-002` | Conflict during handoff is surfaced, not silently resolved. |

---

## 5. Open questions

See `13-open-questions.md`.

---

## 6. References

See `15-references.md`. `intent.capnp` for handoff intents.