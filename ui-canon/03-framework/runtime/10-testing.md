---
id: FW-RUNTIME-TESTING
title: "Testing: headless stills, golden flows, semantic audit, performance harness"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, PROC-COMPLETENESS]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TEST-001]
---

# Testing

> A slice is not done until it is tested. Headless stills are the reproducibility proof.

---

## 1. Headless stills

- FW-TEST-001. Every component and every flow has a headless still: pixels, hit map,
  accessibility snapshot, input ownership and buffer lifetime as one versioned fact
  (LAW-005).
- FW-TEST-002. Stills are generated without a display, so CI can run them.
- FW-TEST-003. A still mismatch fails the build unless the change is an intentional,
  reviewed update.

## 2. Golden flows

- FW-TEST-004. Each app has at least one golden flow end-to-end testable
  (APP-STANDARD §11).
- FW-TEST-005. A golden flow test runs the flow and compares stills at each frame,
  including error/offline/denied branches.
- FW-TEST-006. The stranger test: a second team implements from the directory and passes
  the same AC suite.

## 3. Semantic audit

- FW-TEST-007. The accessibility semantic tree is audited against the declared role/name/
  value/state/actions for every component.
- FW-TEST-008. Focus order, announcements and target sizes are checked per flow.
- FW-TEST-009. Colour-independence and contrast are checked in light/dark/high-contrast.

## 4. Performance harness

- FW-TEST-010. The harness measures frame time, phase time, wakeups, allocations, damage
  area, and blit count.
- FW-TEST-011. Numbers are reported even if bad (AGENTS.md §6). No fabrication.
- FW-TEST-012. Regressions beyond a declared threshold fail the gate.

## 5. Determinism

- FW-TEST-013. Replay tests verify identical inputs produce identical state and damage.
- FW-TEST-014. Motion tests verify identical paths at 60/90/120/144 Hz.

## 6. Envelope coverage

- FW-TEST-015. Every component is exercised on at least watch, phone, desktop, TV unless an
  envelope exception is declared.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TEST-001` | All fifty components have headless stills for default + focus + disabled + error + empty + reduced motion + high contrast + 200% text + RTL + remote + screen reader. |
| `AC-FW-TEST-002` | Golden flow passes on a second implementation. |
| `AC-FW-TEST-003` | Performance harness reports numbers for the weakest envelope. |