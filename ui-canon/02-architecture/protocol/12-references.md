---
id: ARCH-PROTO-REFERENCES
title: References
kind: architecture
entity: protocol
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PROTO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PROTO-046]
---

# References

## Sources

1. Dennis, J. B. & Van Horn, E. C. (1966). *Programming semantics for
   multiprogrammed computations.* CACM 9(3). https://dl.acm.org/doi/10.1145/365230.365252
   — accessed 23 October 2026.
2. Miller, M. S. (2006). *Robust Composition.* https://www.erights.org/talks/thesis/
   — accessed 23 October 2026.
3. Cap'n Proto documentation. https://capnproto.org/ — accessed 23 October 2026.
4. Wayland protocol. https://wayland.freedesktop.org/docs/html/ — accessed 23 October 2026.

## Schema citations

- `compositor.capnp:46-62` HandshakeRequest/Response
- `compositor.capnp:529-541` SurfaceCommit
- `framebuffer.capnp:248-266` AtomicRejection
- `display.capnp:267-376` validity flags
- `capability.capnp`, `access.capnp`, `discovery.capnp`, `types.capnp`

## Limits

- Cap'n Proto is an implementation choice for the contract; the contract concept
  is durable even if the encoding changes.

## Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PROTO-046` | Every cited source has author, title, year, URL, access date. |