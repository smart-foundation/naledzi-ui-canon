---
id: ARCH-PRESENT-NUMBERED
title: Numbered Truth
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX, ARCH-PRESENT-STILL]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-005, AC-ARCH-PRESENT-009]
---

# Numbered Truth

> Why numbered stills enable forensics, remote output, crash recovery, and
> testing. A timestamp tells you when; a still number tells you what.

---

## 1. Why numbers

A numbered still is a still with a stable identity. The number is the identity of
"what the user saw." This enables:

- **Forensics.** "What did the user see at 10:05:03?" is answered by a still
  number. The still can be retrieved, compared, and replayed.
- **Remote output.** A remote peer receives still numbers. It can request a
  specific still, detect gaps, and reconcile without guessing.
- **Crash recovery.** The authority's last still number tells the new policy and
  executor what was on screen. No reconstruction needed.
- **Testing.** A test asserts a still number. The test is deterministic because
  the still is immutable.

---

## 2. Numbers vs timestamps

Still numbers are not timestamps. A timestamp tells you when; a still number
tells you what. The authority may record a timestamp alongside the still
number, but the still number is the identity. Timestamps are observations with
validity flags (`display.capnp:267-376`); still numbers are decisions.

---

## 3. Remote reconciliation

A remote peer that misses a still detects a gap in the sequence and requests
the missing still by number. Reconnection reconciles unknown actions instead of
replaying blindly (`ADR-0013`, `LAW-017`). The remote peer never guesses what
was on screen.

---

## 4. Testing determinism

Because a still is immutable and numbered, a test can assert "after this
sequence, the current still is N" and be deterministic. Flaky tests from
timing races are eliminated because the still number is a decision, not an
observation.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-005` | No two commits share a still number on the same output. |
| `AC-ARCH-PRESENT-009` | A remote peer receives a still number and can request that still; the retrieved still matches. |
| `AC-ARCH-PRESENT-030` | A test asserting a still number is deterministic across runs. |

---

## 6. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-NUM-001` | Should still numbers be 64-bit or 128-bit? | Architecture Editor | proposed |

---

## 7. References

- Lamport, L. (1978). *Time, clocks, and the ordering of events in a
  distributed system.* CACM. https://dl.acm.org/doi/10.1145/359545.359563
- Wayland, frame callbacks. https://wayland.freedesktop.org/docs/html/