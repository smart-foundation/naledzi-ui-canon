---
id: ARCH-RUNTIME-SERVICES
title: Services
kind: architecture
entity: runtime
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-RUNTIME-SVC-001, AC-RUNTIME-SVC-002]
---

# Services

> Lifecycle, supervision, restart, dependency on roles not names. Services are
> supervised peers; their death is handled, not fatal.

---

## 1. Lifecycle

A service is created by the init system (`init.capnp`, `process.capnp`,
`service.capnp`), registers the roles it fulfils, and begins serving. It
terminates on request or on fatal error. Lifecycle states: starting, ready,
degraded, stopping, stopped.

---

## 2. Supervision

Services are supervised: a supervisor monitors health (heartbeat/health check)
and restarts on failure per policy. `Compositor.getHealthCheck`
(`compositor.capnp` method) is the pattern. Supervision is by role, not by
name; a replacement service fulfils the same role.

---

## 3. Restart

On restart, the service re-registers its role and re-establishes capabilities.
Consumers re-resolve the role; in-flight requests fail with a typed error and
are retried by the caller. No global state is assumed across restarts
(`LAW-019`).

---

## 4. Dependency on roles, not names

A service depends on other services by role. It never hardcodes a name or
address (`protocol/03-roles-and-discovery.md`). If a dependency is absent, the
service degrades per its declared degradation, not crashes.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-RUNTIME-SVC-001` | A service restart does not crash its consumers; they re-resolve by role. |
| `AC-RUNTIME-SVC-002` | Absent dependency degrades, not crashes. |

---

## 6. Open questions

See `08-open-questions.md`.

---

## 7. References

See `10-references.md`.