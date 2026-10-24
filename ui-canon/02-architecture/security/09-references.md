---
id: ARCH-SEC-REFERENCES
title: References
kind: architecture
entity: security
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-SECURITY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-SEC-046]
---

# References

## Sources

1. Dennis, J. B. & Van Horn, E. C. (1966). https://dl.acm.org/doi/10.1145/365230.365252 — accessed 23 October 2026.
2. Miller, M. S. (2006). https://www.erights.org/talks/thesis/ — accessed 23 October 2026.
3. NIST SP 800-63 (digital identity). https://pages.nist.gov/800-63-3/ — accessed 23 October 2026. Limits: US-centric.

## Schema citations

- `capability.capnp`, `access.capnp`, `auth.capnp`, `sandbox.capnp`, `screenlock.capnp`, `crypto.capnp`, `signature.capnp`, `key_management.capnp`, `biometric.capnp`, `compositor.capnp` SurfaceAccessControl, DisplayZone

## Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-SEC-046` | Every cited source has author, title, year, URL, access date. |