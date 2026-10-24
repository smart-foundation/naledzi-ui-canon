---
id: ARCH-ECO-REFERENCES
title: References
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-ECO-046]
---

# References

## Sources

1. `ADR-0013` remote browser is an executor, not VNC.
2. `ADR-0017` safety envelopes use bounded motion.
3. `ADR-0019` local first; remote is a peer.
4. Lamport, L. (1978). *Time, clocks, and the ordering of events.* https://dl.acm.org/doi/10.1145/359545.359563 — accessed 23 October 2026.
5. Shapiro, M. et al. (2011). *Conflict-free Replicated Data Types.* https://hal.inria.fr/hal-00932836 — accessed 23 October 2026. Limits: CRDTs suit mergeable types only.
6. Miller, M. S. (2006). *Robust Composition.* https://www.erights.org/talks/thesis/ — accessed 23 October 2026.

## Schema citations

- `discovery.capnp`, `tunnel.capnp`, `network.capnp`, `clipboard.capnp`, `notification.capnp`, `intent.capnp`, `crypto.capnp`, `signature.capnp`, `key_management.capnp`, `time.capnp`, `windowmanager.capnp`, `shell.capnp`, `user.capnp`, `auth.capnp`

## Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-ECO-046` | Every cited source has author, title, year, URL, access date. |