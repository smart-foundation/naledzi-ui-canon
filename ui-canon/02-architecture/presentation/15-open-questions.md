---
id: ARCH-PRESENT-OQ
title: Open Questions
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-044]
---

# Open Questions

> Unresolved questions for the presentation branch, with owner and deadline.

---

## 1. Consolidated list

| ID | Question | Owner | Deadline | Status |
|---|---|---|---|---|
| `OQ-PRESENT-001` | Should still numbers be 64 or 128 bit? | Architecture Editor | 2026-11-15 | proposed |
| `OQ-PRESENT-002` | Current-still subscription vs poll? | Architecture Editor | 2026-11-15 | proposed |
| `OQ-PRESENT-003` | How does remote peer request a specific still (number/timestamp/latest)? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-COMMIT-001` | Unify SurfaceCommit and FrameSubmission? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-COMMIT-002` | Is `custom :Data` damage a contract gap? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-AUTH-001` | Schema gap G-01: no still-number field; propose StillRecord struct. | Architecture Editor | 2026-11-30 | open |
| `OQ-AUTH-002` | Current-still subscription? | Architecture Editor | 2026-11-15 | proposed |
| `OQ-POLICY-001` | Policy timeout threshold? | Architecture Editor | 2026-11-15 | proposed |
| `OQ-POLICY-002` | Remote policy for safety envelope? | Architecture Editor | 2026-12-01 | open (safety review) |
| `OQ-EXEC-001` | Executor re-attachment protocol after crash? | Architecture Editor | 2026-11-30 | proposed |
| `OQ-INPUT-001` | Capture-lease expiry wall-clock or frame-count? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-REJ-001` | Rejections carry retry-after hint? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-CRASH-001` | Authority state persistence cadence? | Architecture Editor | 2026-11-30 | proposed |
| `OQ-CRASH-002` | Max blank-screen duration on executor crash? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-NUM-001` | Still numbers 64 or 128 bit? | Architecture Editor | 2026-11-15 | proposed |
| `OQ-OBS-001` | Observation per-still or per-stream default? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-DAMAGE-001` | Damage rects overlap or producer merges? | Architecture Editor | 2026-11-20 | proposed |
| `OQ-INTENT-001` | Promote periodic intent into compositor.capnp? | Architecture Editor | 2026-11-30 | proposed |
| `OQ-BUF-001` | Expose buffer state as subscription? | Architecture Editor | 2026-11-20 | proposed |

---

## 2. Contract gaps

- `G-01`: no schema field for still number. Recorded in `03-authority.md` and
  `protocol/07-error-model.md` / `protocol/09-handles-lifetimes.md`.
- `G-02`: `custom :Data` damage is opaque and unauditable.

---

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-044` | Every open question has an owner and a deadline. |

---

## 4. References

See `17-references.md`.