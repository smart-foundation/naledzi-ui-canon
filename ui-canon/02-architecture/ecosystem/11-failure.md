---
id: ARCH-ECO-FAILURE
title: Failure (Ecosystem)
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-FAIL-001, AC-ECO-FAIL-002]
---

# Failure

> Partition, stale peer, version skew, revoked device, clock skew. Failures are
> declared and recoverable.

---

## 1. Failure classes

| Class | Behaviour |
|---|---|
| Partition | local continues; sync queues; reconciliation on reconnect |
| Stale peer | peer is ignored until re-paired/re-synced; honest "stale" state shown |
| Version skew | ordinal-based compat applies; incompatible peer is rejected by name |
| Revoked device | all sessions/capabilities invalidated; typed errors |
| Clock skew | timestamps are observations with validity; still numbers are the truth |

---

## 2. Local-first recovery

The local device never blocks on a remote peer. A partitioned device keeps
working; sync catches up later. No data loss.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-FAIL-001` | Partitioned device continues working locally. |
| `AC-ECO-FAIL-002` | Reconnection reconciles without data loss. |

---

## 4. Open questions

See `13-open-questions.md`.

---

## 5. References

See `15-references.md`. `tunnel.capnp`, `network.capnp`, `time.capnp`.