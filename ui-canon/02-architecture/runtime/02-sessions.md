---
id: ARCH-RUNTIME-SESSIONS
title: Sessions
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-RUNTIME-SES-001, AC-RUNTIME-SES-002]
---

# Sessions

> User session, capability scope, multi-user. A session is the authenticated,
> capability-scoped context of one user.

---

## 1. What a session is

A session is the authenticated, capability-scoped context of one user
(`session.capnp`, `user.capnp`). It carries the user's identity, capability
set, and presentation domain. One session per app at the compositor
(`compositor.capnp:40-42` "One session per app").

---

## 2. Capability scope

Every operation is checked against the session's capability set. Capabilities
are granted at handshake (`compositor.capnp:46-62`) and may be revoked later.
A session cannot exceed its granted scope; attempting to does not crash, it
returns a typed denial.

---

## 3. Multi-user

Multiple sessions may coexist (multi-seat, fast user switching). Each session
has its own presentation domain and capability scope. Switching sessions does
not leak capabilities or state. Guest/kiosk sessions are restricted scopes
with no persistence of user data.

---

## 4. Session end

On session end, all capabilities are revoked, all handles invalidated, and all
buffers released. The presentation authority tears down the session's outputs
honestly.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-RUNTIME-SES-001` | Session end revokes all capabilities and invalidates handles. |
| `AC-RUNTIME-SES-002` | Multi-user switching does not leak state or capabilities. |

---

## 6. Open questions

See `08-open-questions.md`.

---

## 7. References

See `10-references.md`.