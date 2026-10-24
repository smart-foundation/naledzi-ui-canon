---
id: SHELL-MODEL-ACCEPTANCE
title: Shell Model — Acceptance
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, SHELL-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-080]
---

# Shell Model — Acceptance

> How the shell model is proved. Each criterion has a test and evidence.

---

## 1. The criteria

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-MODEL-000` | Every file in `model/` exists; no `TODO` or empty section. | Tree audit. |
| `AC-SHELL-MODEL-010` | The shell is defined as distinct from compositor, WM, authority and app. | Review of `01-what-the-shell-is.md`. |
| `AC-SHELL-MODEL-011` | Killing the shell policy leaves stills intact; killing the authority fails honestly. | Crash test. |
| `AC-SHELL-MODEL-012` | No app draws at `system` elevation; renderer rejects it. | Capability test. |
| `AC-SHELL-MODEL-013` | Every shell surface is a commit with buffer, damage, fence, present intent. | Commit audit. |
| `AC-SHELL-MODEL-020` | Policy kill leaves stills intact on every envelope. | Crash test per envelope. |
| `AC-SHELL-MODEL-021` | Watch with no policy presents single surface and crown strip. | Envelope test. |
| `AC-SHELL-MODEL-022` | Safety policy replacement rules hold on EV and spaceship. | Safety review. |
| `AC-SHELL-MODEL-023` | Policy timeout applies default policy and records failure. | Timeout test. |
| `AC-SHELL-MODEL-024` | Policy cannot reject a valid commit. | Conformance test. |
| `AC-SHELL-MODEL-030` | Surface commit carries all declared fields. | Commit audit. |
| `AC-SHELL-MODEL-031` | App requesting `system` elevation is rejected. | Capability test. |
| `AC-SHELL-MODEL-032` | Surface IDs are unique for the session. | ID audit. |
| `AC-SHELL-MODEL-033` | Crashed producer's surface removed on next policy pass. | Crash test. |
| `AC-SHELL-MODEL-034` | Cards are commit-driven; hidden strip costs zero. | Idle measurement. |
| `AC-SHELL-MODEL-040` | Focus named in still; agrees with pixels and hit map. | Still audit. |
| `AC-SHELL-MODEL-041` | Transient close restores focus to opener or fallback. | Flow test. |
| `AC-SHELL-MODEL-042` | Space switch saves/restores focus per space. | Flow test. |
| `AC-SHELL-MODEL-043` | Crash/restart restores focus. | Recovery test. |
| `AC-SHELL-MODEL-044` | Cross-device handoff transfers focus or declares fallback. | Handoff test. |
| `AC-SHELL-MODEL-045` | Non-modal fullscreen does not trap focus. | Flow test. |
| `AC-SHELL-MODEL-050` | Space saves/restores surfaces, layout, focus across restart. | Recovery test. |
| `AC-SHELL-MODEL-051` | Space transition uses named spring with reduced-motion alt. | Motion test. |
| `AC-SHELL-MODEL-052` | Protected space cannot be occluded/closed by non-safety surface. | Safety test. |
| `AC-SHELL-MODEL-053` | Cross-device space continuation adapts and declares. | Handoff test. |
| `AC-SHELL-MODEL-060` | Split/tiling/floating produce a plan; policy kill leaves stills. | Crash test. |
| `AC-SHELL-MODEL-061` | Surface below minimum in split collapses to strip. | Layout test. |
| `AC-SHELL-MODEL-062` | PiP never occludes safety indicator. | Safety test. |
| `AC-SHELL-MODEL-063` | Multi-display disconnect restores or declares. | Disconnect test. |
| `AC-SHELL-MODEL-070` | No app draws at `system` elevation. | Renderer test. |
| `AC-SHELL-MODEL-071` | Every system surface has a spec or declared absence. | Tree audit. |
| `AC-SHELL-MODEL-072` | Unknown state renders `NOT REPORTED`. | Honesty test. |
| `AC-SHELL-MODEL-073` | System surfaces commit with buffer, damage, fence, intent. | Commit audit. |
| `AC-SHELL-MODEL-080` | A second team can implement the shell model on one envelope from this directory alone. | Stranger test. |

---

## 2. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-SHELL-MODEL-001` | What is the policy timeout threshold before the default policy is applied? | Shell Guild | open |
| `OQ-SHELL-MODEL-002` | Can a remote policy be used for a safety envelope (EV)? | Safety review | open (safety review) |

---

## 3. References

- Wayland protocol. https://wayland.freedesktop.org/docs/html/ — accessed 23 October 2026.
- ARINC 661. https://www.arinc.com/ — accessed 23 October 2026.