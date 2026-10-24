---
id: ARCH-ECO-SYNC
title: Sync and Conflict
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-SYNC-001, AC-ECO-SYNC-002]
---

# Sync and Conflict

> Local-first, CRDT/version vectors, conflict UX, no last-writer-wins. Sync is
> explicit and reconcilable.

---

## 1. Local-first

The local device is always fully usable without a network (`LAW-017`).
Sync happens when connectivity returns, reconciling via version vectors, not
blind replay.

---

## 2. CRDT / version vectors

State changes carry version vectors. Concurrent edits produce a conflict that
is detected, not overwritten. Resolution is either automatic (for CRDT-merged
types) or surfaced to the user (for non-mergeable content). Last-writer-wins
is forbidden.

---

## 3. Conflict UX

On conflict, the user sees both versions and chooses or merges. No silent data
loss. Conflicts are recorded and auditable.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-SYNC-001` | Concurrent edits produce a detected conflict, not silent overwrite. |
| `AC-ECO-SYNC-002` | Offline core flows pass; reconnection reconciles. |

---

## 5. Open questions

See `13-open-questions.md`.

---

## 6. References

See `15-references.md`. `sync`-related schemas, `database.capnp`.