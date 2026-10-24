---
id: ARCH-ECO-ZC
title: Zero-Copy Across Devices
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX, ARCH-REND-ZEROCOPY]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-ZC-001, AC-ECO-ZC-002]
---

# Zero-Copy Across Devices

> When zero-copy is impossible across devices; declared copies, compression,
> colour. Cross-device zero-copy is rare; copies are declared.

---

## 1. When zero-copy is impossible

Cross-device zero-copy is usually impossible (different memory domains, no
shared DMA-BUF). A declared copy is made, with compression and colour
conversion as needed. The copy is recorded in the still history with reason.

---

## 2. Declared copies

Every cross-device copy declares: source, destination, format, size,
compression, and reason zero-copy was illegal. No silent copies
(`rendering/05-zero-copy.md`).

---

## 3. Compression and colour

Compression is chosen per content type and bandwidth. Colour conversion
applies declared profiles. Both are recorded.

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-ZC-001` | Cross-device copy is declared with reason. |
| `AC-ECO-ZC-002` | No silent cross-device copy. |

---

## 5. Open questions

See `13-open-questions.md`.

---

## 6. References

See `15-references.md`. `tunnel.capnp`, `network.capnp`.