---
id: ARCH-SEC-SECURE
title: Secure Surfaces
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SEC-SURF-001, AC-SEC-SURF-002]
---

# Secure Surfaces

> Lock, auth, protected zones, DRM-like content. Surfaces that must not be
> observed or captured are marked protected.

---

## 1. Lock and auth

Lock screen and authentication are secure surfaces: they are not observable by
other sessions/apps, not capturable, and not thumbnailable. `screenlock.capnp`,
`auth.capnp`, `biometric.capnp` carry auth contracts.

---

## 2. Protected zones

Safety-critical indicators (EV, spaceship) have protected zones that never
animate through occlusion and are never captured/observed by untrusted peers.
`compositor` `SurfaceAccessControl` and `DisplayZone` carry zone permissions.

---

## 3. DRM-like content

Content with DRM is presented on protected buffers (`BufferUsage.protected`).
Such buffers are not zero-copyable to untrusted consumers and are not
capturable. The authority enforces protected status.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SEC-SURF-001` | Protected surfaces are not capturable/thumbnailable. |
| `AC-SEC-SURF-002` | DRM content stays on protected buffers. |

---

## 5. Open questions

See `07-open-questions.md`.

---

## 6. References

See `09-references.md`. `screenlock.capnp`, `auth.capnp`, `biometric.capnp`.