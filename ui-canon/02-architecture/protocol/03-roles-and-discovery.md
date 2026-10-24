---
id: ARCH-PROTO-ROLES
title: Roles and Discovery
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PROTO-ROLES-001, AC-PROTO-ROLES-002]
---

# Roles and Discovery

> Nothing knows another service by name. Role tags. Absence is normal.

---

## 1. Roles

A role is a named responsibility resolved through discovery: `policy`,
`executor`, `authority`, `theme`, `input`, and others. Composition by role is
how one OS serves many devices. A service advertises the roles it fulfils; a
consumer resolves a role to a capability handle.

---

## 2. Discovery

Discovery is the mechanism by which a component finds peers by role, never by
literal name. `discovery.capnp` defines discovery structures. A consumer asks
"who fulfils role X?" and receives a capability handle (or absence). There is
no central registry of names; resolution is dynamic.

---

## 3. Absence is normal

A missing role is a declared absence, not a failure. With no policy, the
authority applies the default policy. With no theme service, the default theme
applies. Absence is a value (`01-model.md` INV-4), never a zero or default
silently substituted.

---

## 4. No hardcoding

Nothing hardcodes another service's name or address. Hardcoding would couple
implementations and break the role model. An implementation that hardcodes is
non-conformant.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-PROTO-ROLES-001` | A consumer resolves a peer by role, not by name. |
| `AC-PROTO-ROLES-002` | Absence of a role is handled as a declared value, not a crash. |
| `AC-PROTO-ROLES-003` | No service name is hardcoded in any implementation. |

---

## 6. Open questions

See `10-open-questions.md`.

---

## 7. References

- `discovery.capnp` discovery structures.
- Wayland registry. https://wayland.freedesktop.org/docs/html/