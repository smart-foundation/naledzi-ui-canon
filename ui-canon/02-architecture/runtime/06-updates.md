---
id: ARCH-RUNTIME-UPDATES
title: Updates
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-RUNTIME-UPD-001, AC-RUNTIME-UPD-002]
---

# Updates

> Atomic, rollback, data compatibility. An update either fully applies or
> fully reverts; user data and still truth survive.

---

## 1. Atomic

An update is applied atomically: all components update together or none do.
`update.capnp` carries update contracts. A partial update leaves the system in
the previous consistent state.

---

## 2. Rollback

On failure (boot failure, health check failure), the system rolls back to the
previous version automatically. Rollback preserves user data and the authority's
still history.

---

## 3. Data compatibility

Updates must maintain data compatibility: new versions read old data; old
versions (after rollback) read new data where possible. Schema evolution rules
(`protocol/05-schema-evolution.md`) apply to persistent data.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-RUNTIME-UPD-001` | A failed update rolls back automatically. |
| `AC-RUNTIME-UPD-002` | User data survives update and rollback. |

---

## 5. Open questions

See `08-open-questions.md`.

---

## 6. References

See `10-references.md`. `update.capnp` for update contracts.