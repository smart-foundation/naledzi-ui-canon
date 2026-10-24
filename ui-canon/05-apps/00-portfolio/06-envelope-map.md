---
id: PORTFOLIO-ENVELOPES
title: Envelope Map
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-CANDIDATES, PORTFOLIO-ADMISSION, ENV-README, APP-ENVELOPE-ADAPTATION, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-ENVELOPES-001, AC-PORTFOLIO-ENVELOPES-002, AC-PORTFOLIO-ENVELOPES-003, AC-PORTFOLIO-ENVELOPES-004]
---

# Envelope Map

> Which job domains and candidate apps must exist on which envelope. Status is one of:
> `mandatory` (the envelope is not complete without it), `contextual` (present under a
> declared condition), `peer-only` (reachable via a peer device, not native here),
> `absent` (declared absence with reason). A blank cell is a defect.

---

## 1. Status definitions

| Status | Meaning | Rule |
|---|---|---|
| `mandatory` | The app is a required part of this envelope's experience. Without it the envelope fails its job. | Must ship; must pass the app standard on this envelope. |
| `contextual` | Present only under a declared condition (passenger, parked, large screen, external keyboard, account present). | Condition must be named in the app's envelope file and in the envelope's adaptation ladder. |
| `peer-only` | Not native; reachable through a paired peer (phone drives watch, phone projects to EV). | The peer path must be specified in `06-envelopes/_standard/11-cross-device-continuity.md`. |
| `absent` | Deliberately not present. | Must be declared with a reason in the app README and the envelope README. Not rendered disabled. |

**Rules.**

- `PORTFOLIO-ENV-001`. An envelope that cannot render an app at all exposes the same
  model through a peer or a declared alternative; absence of a screen is not absence of
  the capability (`settings/README.md` §7 for the pattern).
- `PORTFOLIO-ENV-002`. A `contextual` app MUST name its gating condition in both the app
  envelope file and the envelope's adaptation ladder. A condition that is not named is a
  defect.
- `PORTFOLIO-ENV-003`. No app is `mandatory` on an envelope where its primary input is
  unavailable. (A keyboard app is not mandatory on a watch.)
- `PORTFOLIO-ENV-004`. Safety envelopes (EV driver, spaceship) downgrade `mandatory` to
  `contextual` or `peer-only` for any app whose use would violate the safety class. The
  safety class is a property of the envelope, not of the app
  (`06-envelopes/README.md` §2).

---

## 2. Job domain × envelope

`●` = mandatory, `○` = contextual, `→` = peer-only, `—` = absent.

| Job domain | Watch | Phone | Tablet | Desktop | TV | EV (driver) | EV (passenger) | Spaceship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|---|
| JD-01 Communicate | ○ | ● | ● | ● | ○ | → | ● | ○ | — | ○ | ● |
| JD-02 Remember | ○ | ● | ● | ● | ○ | → | ● | ○ | — | ○ | ● |
| JD-03 Create | → | ● | ● | ● | — | → | ○ | ○ | — | ● | ○ |
| JD-04 Compute | ○ | ● | ● | ● | ○ | → | ● | ○ | — | ● | ○ |
| JD-05 Navigate | → | ● | ● | ● | ○ | ● (safety) | ● | ● (procedure) | — | ● | ○ |
| JD-06 Care | ○ | ● | ● | ○ | — | ● (driver alert) | ○ | ● | ○ | ○ | ○ |
| JD-07 Learn | — | ● | ● | ● | ○ | → | ● | ○ | — | ● | ○ |
| JD-08 Transact | — | ● | ● | ● | ○ | → | ○ | — | — | ○ | ○ |
| JD-09 Control env. | ○ | ● | ● | ● | ○ | ● (vehicle) | ● | ● (ops) | ● (self) | ● | ○ |
| JD-10 Observe | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● | ● |
| JD-11 Rest | ● | ● | ● | ● | ● | → | ● | ○ | ○ | ● | ○ |
| JD-12 Coordinate | → | ● | ● | ● | ○ | → | ● | ● | — | ● | ○ |

**Notes.**

- `JD-03 Create` is `peer-only` on watch because creation happens elsewhere and the watch
  is a capture trigger (voice note), not an editor.
- `JD-06 Care` on EV driver is safety-gated (driver alertness) and is `mandatory` for the
  driver state; on spaceship it is mandatory (crew health).
- `JD-09 Control environment` on IoT is `mandatory` because the device *is* the environment
  controller; the "app" is the device's own surface.
- `JD-10 Observe` is the only domain mandatory on every envelope including IoT and
  spaceship. Observation is the universal job.

---

## 3. App × envelope (summary)

Full table in `04-candidate-portfolio.md` §7. Reproduced here with status symbols for
audit.

| App | Watch | Phone | Tablet | Desktop | TV | EV (drv) | EV (psg) | Ship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|---|
| calculator | C | M | M | M | C | P | M | A | A | M | C |
| converter | C | M | M | M | A | A | A | A | A | C | C |
| terminal | A | C | C | M | A | A | A | A | A | A | C |
| notes | C | M | M | M | A | P | C | C | A | M | C |
| files | A | M | M | M | A | P | C | C | A | C | M |
| camera | A | M | C | C | A | A | A | A | A | C | A |
| photos | A | M | M | M | C | A | C | A | A | C | C |
| music | C | M | M | M | C | P | M | C | P | C | C |
| video | P | M | M | M | M | P | M | C | A | C | C |
| studio | A | A | M | M | A | A | C | A | A | C | C |
| browser | P | M | M | M | C | P | M | C | A | C | M |
| mail | A | M | M | M | C | A | C | A | A | A | M |
| messages | C | M | M | M | A | A | C | A | A | C | C |
| people | C | M | M | M | A | A | C | A | A | A | C |
| calendar | P | M | M | M | C | P | M | C | A | C | C |
| tasks | C | M | M | M | A | A | C | A | A | C | A |
| maps | P | M | C | C | A | C | M | A | A | C | A |
| weather | C | M | C | C | C | C | M | A | P | C | C |
| health | C | M | C | C | A | C | C | M | A | A | C |
| clock | M | M | M | M | M | M | M | M | M | C | C |
| wallet | A | M | C | C | A | C | C | A | A | C | C |
| store | A | M | M | M | C | A | C | A | A | C | A |
| home-control | P | M | M | M | C | M | M | A | P | C | C |
| settings | M | M | M | M | M | C | M | C | C | C | C |
| agent-console | A | C | C | M | A | A | C | A | A | A | C |

---

## 4. Envelope-specific mandatory sets

The minimum viable app set per envelope (mandatory only):

| Envelope | Mandatory apps |
|---|---|
| Watch | clock, (observe job via status rail). Communicate/remember/compute are contextual. |
| Phone | calculator, notes, files, camera, photos, music, video, browser, mail, messages, people, calendar, tasks, maps, weather, health, clock, wallet, store, home-control, settings. |
| Tablet | notes, files, photos, music, video, browser, mail, messages, people, calendar, tasks, studio, settings + contextual. |
| Desktop | terminal, notes, files, photos, music, video, browser, mail, messages, people, calendar, tasks, studio, maps (planning), settings, agent-console. |
| TV | video, music (shared), weather, clock, settings (root), browser (reading). |
| EV (driver) | maps (safety), home-control (vehicle), health (alertness), clock, settings (safety subset). |
| EV (passenger) | video, music, browser, calendar, notes, settings (full). |
| Spaceship | clock, health, home-control (operations), settings (operations), browser (procedure), calendar (mission). |
| IoT | clock, home-control (self), settings (thin). |
| Spatial | calculator, notes, browser, music, video, studio, maps, settings. |
| Remote browser | files, browser, mail, settings (scope shown). |

---

## 5. Cross-envelope handoff (peer-only paths)

Peer-only apps are not missing; they are reached through a paired device. The peer path is
specified in `06-envelopes/_standard/11-cross-device-continuity.md`.

| App | Peer path |
|---|---|
| calculator on TV | Phone or remote drives entry; TV displays. |
| video on watch | Watch shows transport controls; phone/TV shows video. |
| maps on watch | Watch shows turn-by-turn glance; phone holds the map. |
| calendar on watch | Watch shows next event; phone holds the full calendar. |
| music on IoT | IoT speaker is the output; phone is the control. |
| notes on watch | Voice capture on watch; phone/desktop for editing. |
| tasks on watch | Glance + check-off; phone holds the list. |
| weather on IoT | Ambient display; phone holds detail. |
| health on spaceship | Crew health is aggregated on the operations console; personal device is peer. |

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-ENVELOPES-001` | Every candidate has an envelope status in §3. |
| `AC-PORTFOLIO-ENVELOPES-002` | Every `contextual` status names its gating condition. |
| `AC-PORTFOLIO-ENVELOPES-003` | Every `absent` status has a reason in the app README. |
| `AC-PORTFOLIO-ENVELOPES-004` | Every `peer-only` status has a peer path in §5. |
| `AC-PORTFOLIO-ENVELOPES-005` | The mandatory set in §4 is consistent with the safety class of each envelope. |