---
id: FW-RUNTIME-FAILURE
title: "Failure modes and recovery"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-FW-FAIL-001]
---

# Failure

> Failures are states, not crashes. Honest absence beats confident invention (LAW-011).

---

## 1. Enumeration

| Failure | Behaviour | Recovery |
|---|---|---|
| Layout constraint unsatisfiable | Render with declared fallback; record reason | Relax constraints; never silently clip required content |
| Text shaping failure | Show replacement glyph + reason | Fallback font chain; record |
| Font missing | Use declared fallback; mark `NOT REPORTED` for metrics | Load fallback; report |
| Image decode failure | Show placeholder + reason | Retry; keep layout stable |
| Allocation failure | Degrade (drop non-essential, keep core) | Report; do not panic |
| Surface commit rejected | Retry with full-surface damage; record | Re-commit; if repeated, report |
| Input queue overflow | Drop oldest non-critical; record | Report counts |
| Animation never settles | Force-settle after bound; record | Report; disable that animation |
| IME failure | Cancel composition; report | Restart composition |
| Restore failure | Start fresh; report reason | Offer retry |
| Capture lease leak | Expire lease on owner destruction | Reclaim; report |
| Theme missing token | Render `NOT REPORTED` with reason; never substitute a plausible colour | Fix theme |

## 2. Principles

- FW-FAIL-001. A failure MUST NOT be hidden, faked or replaced by a plausible default.
- FW-FAIL-002. A failure MUST leave the still coherent (LAW-005, LAW-015).
- FW-FAIL-003. A failure in one component MUST NOT crash the app or the authority.
- FW-FAIL-004. Every failure has a recovery path or a declared dead end.
- FW-FAIL-005. Failures are announced to assistive tech when they change a state.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-FAIL-001` | Each failure in §1 is injected and the resulting state matches the declared behaviour. |
| `AC-FW-FAIL-002` | No crash or half-updated still under any injected failure. |