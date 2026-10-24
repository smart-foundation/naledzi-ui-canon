---
id: SHELL-MODEL-SYSTEMUI
title: System UI — What the System Draws vs the App
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, SHELL-MODEL-SURFACES, FOUND-DEPTH-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-070, AC-SHELL-MODEL-071]
---

# System UI

> The system draws a small, declared set of surfaces at `system` elevation. Everything
> else is the app's. The boundary is enforced by elevation: an app may not draw at
> `system`, and the system may not draw app content.

---

## 1. The boundary

| Drawn by | What | Elevation |
|---|---|---|
| System (shell) | Status rail, strip host, lock screen, notification surface, palette host, permission prompt host, on-screen keyboard host, safety indicators, toasts/banners (system-owned) | `system` |
| App | Content, navigation, actions, status (app-local), overlays, popovers, sheets | base/raised/floating/overlay |

Rules:

1. An app may not draw at `system` elevation. The renderer and authority reject it.
2. The system may not draw app content. It may draw the app's *still* (as a thumbnail in
   the strip) only under an observation capability.
3. System surfaces are commits like any producer's, with buffer, damage, fence and present
   intent.
4. System surfaces never depend on app state directly; they consume declared facts (time,
   power, connectivity, notifications, capabilities).

---

## 2. What the system draws (per envelope)

| Surface | Watch | Phone | Tablet | Desktop | TV | EV | Spaceship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|
| Status rail | time, activity | time, signal, battery, privacy | same | minimal/on-demand | readable at 3 m | speed, range, warnings (protected) | alarms, procedures, redundancy | LED/none | anchored rail | browser chrome only |
| Strip host | crown reel | edge reel | edge reel | edge reel | remote reel | passenger-only | procedure-gated | n/a | spatial reel | browser-mediated |
| Lock screen | yes | yes | yes | yes | optional | yes | yes | optional | yes | account |
| Notification surface | yes | yes | yes | yes | yes | yes (safety override) | yes (alarm) | n/a | yes | yes |
| Palette host | yes (voice) | yes | yes | yes | yes | yes (driver-safe) | yes | n/a | yes | yes |
| Permission prompt host | yes | yes | yes | yes | yes | yes | yes | n/a | yes | yes |
| On-screen keyboard host | yes | yes | yes | optional | yes | yes | yes (gloves) | n/a | yes | browser |
| Safety indicators | n/a | n/a | n/a | n/a | n/a | protected | protected | n/a | n/a | n/a |

A cell that says `n/a` is a declared absence.

---

## 3. What the system does NOT draw

- App content, navigation, or actions.
- App status that is app-local and not a system fact.
- Decorative chrome without a timeless job (`LAW-010`).
- A dock (the strip replaces it, `ADR-0006`).
- A fixed status bar on envelopes that do not earn one (`ADR-0007`).

---

## 4. System UI and honesty

- Unknown state renders `NOT REPORTED`, never a plausible default (`LAW-011`).
- A denied capability renders a visible state with a request path.
- A missing service is named, not hidden.
- Safety indicators never fake a value; if a sensor is unavailable, it says so.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-070` | No app draws at `system` elevation; the renderer rejects it. |
| `AC-SHELL-MODEL-071` | Every system surface in §2 has a spec in its directory or a declared absence. |
| `AC-SHELL-MODEL-072` | Unknown state renders `NOT REPORTED` on every system surface. |
| `AC-SHELL-MODEL-073` | System surfaces commit with buffer, damage, fence and present intent. |