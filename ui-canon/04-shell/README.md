---
id: SHELL-INDEX
title: Shell
kind: shell
entity: shell
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [CANON-LAWS, CANON-DECISIONS, ARCH-PRESENT-INDEX, APP-STANDARD, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-INDEX-001, AC-SHELL-INDEX-002]
children:
  - model/README.md
  - fullscreen/README.md
  - strip/README.md
  - status-rail/README.md
  - notifications/README.md
  - spaces/README.md
  - gestures/README.md
  - lock/README.md
  - lifecycle/README.md
  - shortcuts/README.md
---

# Shell

> The shell is the **OS behaviour layer**: the model of surfaces, focus, spaces, the strip,
> the status rail, notifications, gestures, lock, lifecycle and shortcuts. It is the part of
> the system a person actually lives inside. It is not a compositor, not a window manager in
> the legacy sense, and not a pile of chrome. It is the contract by which a person moves
> between what they are doing, what else exists, and what the OS needs to tell them.

**Scope:** everything the OS draws and owns that is not app content and not the presentation
authority's truth. The shell consumes numbered stills, produces plans under policy, and
declares system surfaces at `system` elevation. It runs on every envelope, in a form each
envelope earns.

**Non-goals:** rendering algorithms, buffer lifetimes, GPU/CPU paths (those are
`rendering/` and `presentation/`); app domain logic (`05-apps/`); component anatomy
(`03-framework/`); and any permanent chrome that cannot name a timeless job
(`LAW-010`).

---

## 1. What the shell owns

| Concern | Owner file | One-line job |
|---|---|---|
| What the shell is and is not | `model/01-what-the-shell-is.md` | Define the boundary between truth, policy and chrome |
| Policy and arbitration | `model/02-policy.md` | Optional placement/stacking/focus/arbitration |
| Surfaces | `model/03-surfaces.md` | Windows, surfaces, stills, cards; not legacy windows |
| Focus | `model/04-focus.md` | Ownership, rings, restoration, cross-device |
| Spaces | `model/05-spaces.md` | Workspaces, named contexts, transitions, persistence |
| Multi-window | `model/06-multi-window.md` | Split, tiling, floating, fullscreen, PiP, multi-display |
| System UI | `model/07-system-ui.md` | What the system draws vs the app |
| Fullscreen behaviour | `fullscreen/` | Declared, per-envelope, with exits |
| The strip | `strip/` | Summon-only depth reel of live stills |
| Status rail | `status-rail/` | Adaptive, UX-owned indicator rail |
| Notifications | `notifications/` | Time-sensitive facts, priority, history, cross-device |
| Spaces (deep) | `spaces/` | Creation, naming, transitions, persistence, safety |
| Gestures | `gestures/` | System vs app grammar, reserved edges, capture leases |
| Lock | `lock/` | Lock vs login vs session; auth; recovery |
| Lifecycle | `lifecycle/` | Boot, first-run, login, session, update, recovery, shutdown, power |
| Shortcuts | `shortcuts/` | Accelerators, registry, bindings, palette integration |

---

## 2. The shell's relationship to the presentation truth

The shell never owns truth. It consumes numbered stills from the presentation authority
(`ARCH-PRESENT-AUTHORITY`) and, where a policy is present, produces a **plan** (placement,
stacking, focus, arbitration). The executor presents. The shell's surfaces are commits like
any other producer's, but they carry the `system` elevation and the system's input ownership
when they are on screen.

```text
   app commits ──► authority ──► numbered still ──► executor ──► pixels
                       ▲
                       │ plan (optional)
                       │
                  shell policy  (optional; absent on watch/IoT)
                       │
                       │ system surfaces (status rail, strip, lock, …)
                       ▼
                  authority (as producer)
```

Killing the shell policy leaves the stills intact and the input leases expiring
(`LAW-006`, `AC-ARCH-PRESENT-001`). The shell is therefore two things: an always-present
set of system surfaces that commit like any producer, and an optional policy that advises
placement. The first is mandatory in form; the second is optional in presence.

---

## 3. Envelope coverage

The shell exists on every envelope, but what it shows is earned per envelope. A watch has a
status rail of time and activity and a crown-driven strip; a spacecraft has a protected
status rail of alarms and procedures and no strip fan-out that could occlude a warning. No
surface is inherited from a legacy OS (`00-master-brief.md` §3.1).

| Envelope | Status rail | Strip | Spaces | Gestures | Lock | Shortcuts |
|---|---|---|---|---|---|---|
| Watch | time, activity, battery | crown-summoned reel | single space | crown, edge | PIN/biometric | crown, voice |
| Phone | time, signal, battery, privacy | edge-summoned reel | named spaces | touch edges | biometric/PIN | keyboard where present |
| Tablet | time, signal, battery, privacy | edge-summoned reel | named spaces | touch + pointer | biometric/PIN | keyboard |
| Desktop | minimal/hidden; on demand | edge-summoned reel | named spaces | pointer edges | password/key | full keyboard |
| TV | minimal, readable at 3 m | remote-driven reel | single/pinned | d-pad, remote | PIN (optional) | remote |
| EV | speed, range, warnings (protected) | passenger-only summon | protected spaces | driver-safe | PIN/key | wheel/voice |
| Spaceship | alarms, procedures, redundancy | procedure-gated | protected, redundant | gloves, voice | multi-factor | procedure keys |
| IoT | none or single LED | n/a | n/a | n/a | PIN (optional) | n/a |
| Spatial | anchored rail | spatial reel | spatial spaces | 6-DOF | biometric | gesture/voice |
| Remote browser | browser chrome only | browser-mediated | browser-mediated | pointer/keyboard | account | browser shortcuts |

A cell that says `n/a` is a declared absence, not an omission (`PROC-COMPLETENESS`).

---

## 4. The laws the shell binds

| Law | Shell consequence |
|---|---|
| `LAW-001` one fact, one owner | The strip's thumbnails are derived from numbered stills, never a second copy of app content |
| `LAW-004` idle is silent | Hidden strip costs zero; status rail updates on change; no heartbeat |
| `LAW-005` numbered stills | System surfaces are commits with their own still numbers |
| `LAW-006` authority mandatory, policy optional | Shell policy is replaceable; killing it leaves stills |
| `LAW-007` depth communicates hierarchy | `system` elevation is the highest; safety indicators never occluded |
| `LAW-008` motion explains change | Strip magnification is one spring; spaces transition with velocity preservation |
| `LAW-009` accessibility structural | Status rail, strip and notifications are derived from the same semantics that draw them |
| `LAW-010` no permanent chrome | Strip is summon-only; status rail collapses; nothing is always on without a job |
| `LAW-011` honesty over polish | Unknown state renders `NOT REPORTED`; denied capability is visible |
| `LAW-015` reversibility | Lock recovery, update rollback, undo for destructive shell actions |
| `LAW-016` performance budget | Per-envelope budgets for strip thumbnails, status rail, notifications |
| `LAW-020` user owns attention | Quiet hours, notification budgets, no dark patterns |

---

## 5. Directory map

| Directory | Question |
|---|---|
| `model/` | What the shell is, its surfaces, focus, spaces, multi-window, system UI |
| `fullscreen/` | What fullscreen means and how it behaves per envelope |
| `strip/` | The depth card reel: model, cards, ordering, magnification, fan-out, invocation, privacy, performance, failure |
| `status-rail/` | Adaptive indicator rail: model, indicators, priority/collapse, interaction, accessibility, failure |
| `notifications/` | Time-sensitive facts: model, priority, delivery, actions, history, quiet hours, cross-device, failure, accessibility |
| `spaces/` | Workspaces: model, creation/naming, transitions, persistence, cross-device, safety, failure |
| `gestures/` | Global gesture grammar: grammar, back/home/strip/palette, conflict, capture leases, discoverability, accessibility, per-envelope, failure |
| `lock/` | Lock and session: model, authentication, lock screen, session/users, recovery, accessibility, failure |
| `lifecycle/` | Boot, first-run, login, session, update, recovery, shutdown, power/thermal, failure |
| `shortcuts/` | Accelerators: model, registry, default bindings, palette integration, accessibility, failure |

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-INDEX-001` | Every directory listed in §5 exists with a `README.md` and the declared files, or declares `n/a — reason`. |
| `AC-SHELL-INDEX-002` | No file in the shell subtree contains `TODO`, an empty section, or "similar to". |
| `AC-SHELL-INDEX-003` | The envelope coverage table in §3 has a frame or a declared absence for every cell. |
| `AC-SHELL-INDEX-004` | A second team can implement the shell's behaviour on one envelope from this subtree alone. |

---

## 7. Open questions

| ID | Question | Owner | Status |
|---|---|---|---|
| `OQ-SHELL-001` | Which envelopes ship a multi-space policy by default? | Shell Guild | open |
| `OQ-SHELL-002` | Does the EV passenger summon the strip while the vehicle is in motion? | Safety review | open |
| `OQ-SHELL-003` | What is the maximum number of spaces before fan-out switches to search-first? | UX research | open |

---

## 8. References

- Apple. *Human Interface Guidelines — System Experiences*. https://developer.apple.com/design/human-interface-guidelines/ — accessed 23 October 2026.
- Google. *Material Design 3 — System bars and navigation*. https://m3.material.io/ — accessed 23 October 2026.
- Microsoft. *Fluent Design System*. https://fluent2.microsoft.design/ — accessed 23 October 2026.
- GNOME. *GNOME Human Interface Guidelines*. https://developer.gnome.org/hig/ — accessed 23 October 2026.
- KDE. *KDE Human Interface Guidelines*. https://develop.kde.org/hig/ — accessed 23 October 2026.
- Nielsen, J. *10 Usability Heuristics for User Interface Design*. https://www.nngroup.com/articles/ten-usability-heuristics/ — accessed 23 October 2026.
- Norman, D. A. *The Design of Everyday Things*. Basic Books, 2013. ISBN 978-0465050659.
- Endsley, M. R. *Toward a Theory of Situation Awareness in Dynamic Systems*. Human Factors, 1995. https://doi.org/10.1518/001872095779049543
- Parasuraman, R. & Riley, V. *Humans and Automation: Use, Misuse, Disuse, Abuse*. Human Factors, 1997. https://doi.org/10.1518/001872097778543886