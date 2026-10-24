---
id: FW-RUNTIME-ACCEPTANCE
title: "Runtime acceptance"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-RUNTIME-ACCEPT-001]
---

# Runtime acceptance

Consolidated acceptance for the runtime subtree. Individual files carry their own ACs.

## Acceptance criteria

| ID | Requirement | Evidence |
|---|---|---|
| `AC-FW-RUNTIME-ACCEPT-001` | All `AC-FW-RUNTIME-*`, `AC-FW-MIRUI-*`, `AC-FW-ECS-*`, `AC-FW-LAYOUT-*`, `AC-FW-TEXT-*`, `AC-FW-DAMAGE-*`, `AC-FW-INPUT-*`, `AC-FW-ANIM-*`, `AC-FW-STATE-*`, `AC-FW-SCHED-*`, `AC-FW-TEST-*`, `AC-FW-FAIL-*` pass. | Test suite. |
| `AC-FW-RUNTIME-ACCEPT-002` | An app builds, runs headless, commits a still, handles input, animates, persists and restores, on the weakest supported envelope. | Golden flow. |
| `AC-FW-RUNTIME-ACCEPT-003` | Idle cost is zero (measured) for one hour. | Measurement. |
| `AC-FW-RUNTIME-ACCEPT-004` | No second ECS, layout engine, theme, scheduler or event loop. | Audit. |
| `AC-FW-RUNTIME-ACCEPT-005` | All MirUI claims cite `file:line` in vendored 0.51.0. | Citation audit. |