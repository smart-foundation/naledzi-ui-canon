---
id: ARCH-ECO-CLIPBOARD
title: Shared Clipboard
kind: architecture
entity: ecosystem
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-ECO-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ECO-CLIP-001, AC-ECO-CLIP-002]
---

# Shared Clipboard

> Formats, privacy, expiry, cross-device paste, sensitive content. Clipboard
> content is capability-scoped and privacy-aware.

---

## 1. Formats

Clipboard carries typed formats (`clipboard.capnp`): text, rich text, image,
file references. Format negotiation happens at paste time; the producer
declares available formats.

---

## 2. Privacy

Clipboard content is not uploaded without consent. Cross-device clipboard
requires an explicit capability grant and a paired device. Sensitive content
(passwords, tokens) is marked sensitive and excluded from history and
cross-device sync by default.

---

## 3. Expiry

Clipboard entries expire per policy (default short for sensitive). Expired
entries are removed from all peers.

---

## 4. Cross-device paste

A paste on device B of content copied on device A fetches the content from A
via a capability-scoped, encrypted channel. If A is unreachable, paste fails
honestly (`LAW-011`), not with stale data.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-ECO-CLIP-001` | Sensitive content is excluded from history and cross-device sync by default. |
| `AC-ECO-CLIP-002` | Cross-device paste fails honestly when source unreachable. |

---

## 6. Open questions

See `13-open-questions.md`.

---

## 7. References

See `15-references.md`. `clipboard.capnp`.