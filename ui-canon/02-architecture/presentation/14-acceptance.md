---
id: ARCH-PRESENT-ACCEPTANCE
title: Presentation Acceptance
kind: architecture
entity: presentation
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-PRESENT-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-PRESENT-000]
---

# Presentation Acceptance

> The AC index for the presentation branch. Every normative claim in this branch
> traces to an AC here.

---

## 1. Index

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-000` | Every file listed in `presentation/README.md` children exists; no TODO or empty section. |
| `AC-ARCH-PRESENT-001` | Policy kill leaves stills intact and leases expiring. |
| `AC-ARCH-PRESENT-002` | Executor kill leaves still and authority intact. |
| `AC-ARCH-PRESENT-003` | Every commit produces a numbered still or a named rejection. |
| `AC-ARCH-PRESENT-004` | No observer reads a buffer without a capability. |
| `AC-ARCH-PRESENT-005` | No two commits share a still number on the same output. |
| `AC-ARCH-PRESENT-006` | No commit is silently dropped. |
| `AC-ARCH-PRESENT-007` | A still retrieved by number matches committed pixels/hit-map/a11y/input/buffers. |
| `AC-ARCH-PRESENT-008` | Policy crash does not invalidate current still; new policy adopts it. |
| `AC-ARCH-PRESENT-009` | Remote peer receives still number and can request that still. |
| `AC-ARCH-PRESENT-010` | No observer reads a buffer without a capability, even with valid still number. |
| `AC-ARCH-PRESENT-011` | Format mismatch rejected by name; previous still remains. |
| `AC-ARCH-PRESENT-012` | Out-of-bounds damage rejected by name. |
| `AC-ARCH-PRESENT-013` | Fence already failed rejected by name. |
| `AC-ARCH-PRESENT-014` | Producer receives still number in ack and can pace on FrameSignal. |
| `AC-ARCH-PRESENT-015` | Two authorities for one output detected and rejected at startup. |
| `AC-ARCH-PRESENT-016` | Authority's last still number survives reboot; new policy adopts. |
| `AC-ARCH-PRESENT-017` | Authority never reads a pixel buffer. |
| `AC-ARCH-PRESENT-018` | No policy: default policy deterministic and identical across impls. |
| `AC-ARCH-PRESENT-019` | Policy cannot reject a valid commit. |
| `AC-ARCH-PRESENT-020` | Executor unable to realize returns typed rejection; no approximation. |
| `AC-ARCH-PRESENT-021` | Executor crash does not invalidate current still number. |
| `AC-ARCH-PRESENT-022` | Move and click never disagree (hit map + input owner one still). |
| `AC-ARCH-PRESENT-023` | Revoked capture lease delivers typed revocation; holder does not crash. |
| `AC-ARCH-PRESENT-024` | Focus never rests on invisible surface. |
| `AC-ARCH-PRESENT-025` | Input routing uses authority hit map, not executor's. |
| `AC-ARCH-PRESENT-026` | Each rejection class has a test. |
| `AC-ARCH-PRESENT-027` | Rejected commit leaves previous still current and number unchanged. |
| `AC-ARCH-PRESENT-028` | Authority crash results in honest recovery state. |
| `AC-ARCH-PRESENT-029` | After recovery, last still number current and history intact. |
| `AC-ARCH-PRESENT-030` | Test asserting still number is deterministic. |
| `AC-ARCH-PRESENT-031` | Revoking observation capability stops observation without crash. |
| `AC-ARCH-PRESENT-032` | Observation capabilities off by default on fresh install. |
| `AC-ARCH-PRESENT-033` | No code path diffs two frames for damage. |
| `AC-ARCH-PRESENT-034` | App declaring full produces correct still with more pixel work. |
| `AC-ARCH-PRESENT-035` | Out-of-bounds damage rejected by name. |
| `AC-ARCH-PRESENT-036` | Merged damage equals union of declared rects. |
| `AC-ARCH-PRESENT-037` | atTime commit presented at/after named time; slip recorded. |
| `AC-ARCH-PRESENT-038` | Fence timeout under atTime rejected by name. |
| `AC-ARCH-PRESENT-039` | FrameSignal delivered in ack and usable for pacing. |
| `AC-ARCH-PRESENT-040` | No buffer written while displayed. |
| `AC-ARCH-PRESENT-041` | Revoked buffer stops being read/written; typed event. |
| `AC-ARCH-PRESENT-042` | Release only via fence signal; timeout not release. |
| `AC-ARCH-PRESENT-043` | No raw pointer crosses boundary in buffer handle. |

---

## 2. Acceptance

| ID | Test |
|---|---|
| `AC-ARCH-PRESENT-000` | Branch coverage complete: every leaf file exists with content. |

---

## 3. Open questions

See each leaf file's open-questions section. Consolidated list in
`15-open-questions.md`.

---

## 4. References

See `17-references.md`.