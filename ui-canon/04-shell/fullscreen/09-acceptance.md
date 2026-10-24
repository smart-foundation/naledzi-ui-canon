---
id: SHELL-FULLSCREEN-ACCEPTANCE
title: Fullscreen Acceptance
kind: shell
entity: fullscreen
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-FULLSCREEN-INDEX, SHELL-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-FULLSCREEN-090]
---

# Fullscreen Acceptance

## 1. The criteria

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-FULLSCREEN-000` | Every file in `fullscreen/` exists; no `TODO` or empty section. | Tree audit. |
| `AC-SHELL-FULLSCREEN-010` | Fullscreen request without a kind is rejected. | Conformance test. |
| `AC-SHELL-FULLSCREEN-011` | Each kind's system-UI behaviour matches spec per envelope. | Envelope test. |
| `AC-SHELL-FULLSCREEN-012` | Fullscreen is a placement hint, not an app flag. | Contract test. |
| `AC-SHELL-FULLSCREEN-020` | Critical indicators remain visible in immersive. | Visual test. |
| `AC-SHELL-FULLSCREEN-021` | Cursor auto-hide does not hide during capture lease. | Input test. |
| `AC-SHELL-FULLSCREEN-022` | IME works in fullscreen. | Input test. |
| `AC-SHELL-FULLSCREEN-023` | Reserved edges work in immersive. | Gesture test. |
| `AC-SHELL-FULLSCREEN-030` | Every kind has at least one exit path per envelope. | Flow test. |
| `AC-SHELL-FULLSCREEN-031` | Escape exits immersive on keyboard envelopes. | Input test. |
| `AC-SHELL-FULLSCREEN-032` | Kiosk exit requires declared gesture + PIN. | Flow test. |
| `AC-SHELL-FULLSCREEN-033` | Safety-fullscreen is not user-exitable. | Safety test. |
| `AC-SHELL-FULLSCREEN-040` | Non-modal fullscreen does not trap focus. | Focus test. |
| `AC-SHELL-FULLSCREEN-041` | Capture lease expires correctly. | Input test. |
| `AC-SHELL-FULLSCREEN-042` | Reserved shortcuts work inside fullscreen. | Input test. |
| `AC-SHELL-FULLSCREEN-043` | Focus returns to invoker on exit. | Focus test. |
| `AC-SHELL-FULLSCREEN-050` | Safety notifications appear in immersive. | Notification test. |
| `AC-SHELL-FULLSCREEN-051` | Queued notifications appear on exit/summon. | Notification test. |
| `AC-SHELL-FULLSCREEN-052` | Safety overrides do-not-disturb. | Notification test. |
| `AC-SHELL-FULLSCREEN-053` | Expired queued notifications recorded. | History test. |
| `AC-SHELL-FULLSCREEN-060` | Fullscreen occludes but does not destroy surfaces. | Multi-window test. |
| `AC-SHELL-FULLSCREEN-061` | PiP survives fullscreen unless occluding safety. | Safety test. |
| `AC-SHELL-FULLSCREEN-062` | Fullscreen per-space suspension rules hold. | Space test. |
| `AC-SHELL-FULLSCREEN-070` | Every envelope has a fullscreen behaviour or declared absence. | Tree audit. |
| `AC-SHELL-FULLSCREEN-071` | No "similar to phone". | Stub audit. |
| `AC-SHELL-FULLSCREEN-072` | Safety indicators remain visible on EV/spaceship. | Safety test. |
| `AC-SHELL-FULLSCREEN-073` | Every envelope has at least one exit path. | Flow test. |
| `AC-SHELL-FULLSCREEN-080` | Lost exit recovers within timeout. | Failure test. |
| `AC-SHELL-FULLSCREEN-081` | Crashed fullscreen app restores arrangement. | Recovery test. |
| `AC-SHELL-FULLSCREEN-082` | Display disconnect exits fullscreen and restores. | Recovery test. |
| `AC-SHELL-FULLSCREEN-090` | A second team can implement fullscreen behaviour on one envelope from this directory. | Stranger test. |

## 2. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-SHELL-FULLSCREEN-001` | What is the default idle timeout before the status rail reappears in immersive? | Shell Guild | proposed (3 s) |

## 3. References

- Apple. *Human Interface Guidelines — Fullscreen and immersive experiences*. https://developer.apple.com/design/human-interface-guidelines/ — accessed 23 October 2026.
- Google. *Material Design — Immersive mode*. https://m3.material.io/ — accessed 23 October 2026.
- Nielsen, J. *Visibility of system status*. https://www.nngroup.com/articles/ten-usability-heuristics/ — accessed 23 October 2026.