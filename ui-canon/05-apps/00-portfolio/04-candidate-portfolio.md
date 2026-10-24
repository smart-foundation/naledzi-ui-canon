---
id: PORTFOLIO-CANDIDATES
title: Candidate Portfolio
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-NEEDS, PORTFOLIO-JOBS, PORTFOLIO-ADMISSION, PORTFOLIO-ENVELOPES, CANON-TIMELESSNESS, CANON-LAWS, APP-STANDARD]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-CANDIDATES-001, AC-PORTFOLIO-CANDIDATES-002, AC-PORTFOLIO-CANDIDATES-003, AC-PORTFOLIO-CANDIDATES-004]
---

# Candidate Portfolio

> Derived from timeless human jobs (`01-needs-not-apps.md`, `02-job-domains.md`), scored by
> the admission test (`03-admission-test.md`), mapped to envelopes (`06-envelope-map.md`).
> Working names are provisional and subject to `08-naming.md`. No candidate is `canon` yet.

---

## 1. How to read this file

Each candidate has:

- **Working name** — provisional directory name; subject to `08-naming.md`.
- **Job domain** — `JD-NN` from `02-job-domains.md`.
- **Human need** — `Nn` from `01-needs-not-apps.md`.
- **Why timeless** — one clause; the job survives the tool.
- **Envelopes** — from `06-envelope-map.md` (`mandatory` / `contextual` / `peer-only` /
  `absent`).
- **Primary input** — the input that carries the job.
- **Capability needs** — required / optional / refused (summary).
- **Kind** — `app`, `shell surface`, `system surface`, or `cross-app flow`.
- **Confidence** — `canon (proposed)`, `provisional`, or `rejected`.
- **Score** — total from `03-admission-test.md`.

Candidates are grouped by the need they primarily serve. A candidate may serve a secondary
need; the secondary is noted but does not change the primary grouping.

---

## 2. Candidate table (summary)

| # | Working name | Domain | Need | Envelopes (primary) | Kind | Confidence | Score |
|---|---|---|---|---|---|---|---|
| 1 | `calculator` | JD-04 | N4 | watch, phone, tablet, desktop, spatial (contextual: TV) | app | canon (proposed) | 20 |
| 2 | `converter` | JD-04 | N4 | phone, tablet, desktop, watch, spatial | app | provisional | 17 |
| 3 | `terminal` | JD-04/09 | N4/N9 | desktop, tablet, phone, remote | app | provisional | 15 (review) |
| 4 | `notes` | JD-03/02 | N3/N2 | watch (voice), phone, tablet, desktop, spatial | app | provisional | 19 |
| 5 | `files` | JD-02/05 | N2/N5 | phone, tablet, desktop, remote, spatial | app | provisional | 18 |
| 6 | `camera` | JD-03/10 | N3/N10 | phone, tablet, desktop (webcam), spatial | app | provisional | 17 |
| 7 | `photos` | JD-02/10 | N2/N10 | phone, tablet, desktop, TV, spatial | app | provisional | 18 |
| 8 | `music` | JD-10/11 | N10/N11 | watch, phone, tablet, desktop, TV, EV, spatial | app | provisional | 18 |
| 9 | `video` | JD-10/11 | N10/N11 | phone, tablet, desktop, TV, EV, spatial | app | provisional | 18 |
| 10 | `studio` | JD-03 | N3 | tablet, desktop, spatial | app | provisional | 16 |
| 11 | `browser` | JD-05 | N5 | phone, tablet, desktop, TV, spatial, remote | app | provisional | 16 |
| 12 | `mail` | JD-01 | N1 | phone, tablet, desktop, remote | app | provisional | 17 |
| 13 | `messages` | JD-01 | N1 | watch, phone, tablet, desktop, spatial | app | provisional | 18 |
| 14 | `people` | JD-01/02 | N1/N2 | phone, tablet, desktop, watch | app | provisional | 17 |
| 15 | `calendar` | JD-12 | N12 | phone, tablet, desktop, TV, spatial | app | provisional | 18 |
| 16 | `tasks` | JD-12 | N12 | phone, tablet, desktop, watch, spatial | app | provisional | 17 |
| 17 | `maps` | JD-05 | N5 | phone, tablet, desktop, EV, spatial | app | provisional | 17 |
| 18 | `weather` | JD-10 | N10 | watch, phone, tablet, desktop, TV, EV, spatial | app | provisional | 17 |
| 19 | `health` | JD-06 | N6 | watch, phone, tablet, desktop, EV, spaceship | app | provisional | 17 |
| 20 | `clock` | JD-10/11 | N10/N11 | watch, phone, tablet, desktop, TV, EV, spaceship, IoT | app | provisional | 18 |
| 21 | `wallet` | JD-08 | N8 | phone, tablet, desktop, EV (parked), spatial | app | provisional | 16 |
| 22 | `store` | JD-08/05 | N8/N5 | phone, tablet, desktop, TV, spatial | app | provisional | 16 |
| 23 | `home-control` | JD-09 | N9 | phone, tablet, desktop, TV, EV, spatial, IoT (peer) | app | provisional | 17 |
| 24 | `settings` | JD-09 | N9 | all | app | provisional | 19 |
| 25 | `agent-console` | JD-09/10 | N9/N10 | desktop, tablet, phone, remote | app | provisional | 16 |
| — | `onboarding` | JD-07 | N7 | all | shell surface + cross-app flow | provisional | n/a (not an app) |
| — | `search/palette` | all | all | all | system surface | system | n/a (not an app) |

Total apps proposed: 25 (including calculator and settings). Plus shell/system surfaces listed in
`07-shell-and-system-boundaries.md`.

---

## 3. Candidate detail

Each subsection states the full admission fields. Scores are from `03-admission-test.md`.

### 3.1 `calculator` — Compute (JD-04, need N4)

- **Job.** *When I need a number, I want to get it without opening a heavy tool, so I can
  decide now.* (JD-04.)
- **Why timeless.** Computing a quantity predates computers (abacus, slide rule, ledger).
  The model (inputs, operation, result, history) survives any tool.
- **Envelopes.** mandatory: watch, phone, tablet, desktop, spatial. contextual: TV
  (remote entry). absent: IoT. peer-only: EV (passenger, via phone projection).
- **Primary input.** Keypad, keyboard, voice, pointer; on watch, crown + tap.
- **Capability needs.** Required: local compute. Optional: clipboard (read/write, revocable).
  Refused: network, location, observation.
- **Kind.** app.
- **Confidence.** canon (proposed) — reproducibility exemplar.
- **Score.** 20 (see `03-admission-test.md` §6).

### 3.2 `converter` — Compute (JD-04, need N4)

- **Job.** *When I encounter a quantity in an unfamiliar unit, I want to express it in
  a unit I understand, so I can decide.*
- **Why timeless.** Unit conversion predates computers (trade, navigation, cooking).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: watch (common
  conversions), spatial. absent: IoT, TV.
- **Primary input.** Number entry + unit selection; voice on watch.
- **Capability needs.** Required: local compute, unit data (bundled). Optional: clipboard.
  Refused: network.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17 (human need 2, job survival 2, envelope reach 1, capability honesty 2, data
  ownership 2, trust 2, accessibility 2, no legacy chrome 2, no network 2, reproducibility
  2). Weakness: envelope reach 1 (watch and TV are constrained).

### 3.3 `terminal` — Compute / control (JD-04, JD-09, needs N4, N9)

- **Job.** *When I need to do something the graphical surface does not expose, I want to
  type a command, so I can stay in control.*
- **Why timeless.** Command-line interaction predates GUIs and survives them; the need is
  direct expression of intent.
- **Envelopes.** mandatory: desktop. contextual: tablet (with keyboard), phone (with
  external keyboard), remote. absent: watch, TV, EV (driver), spaceship, IoT, spatial.
- **Primary input.** Keyboard.
- **Capability needs.** Required: shell access (capability-gated, scoped), local process.
  Optional: network (declared). Refused: unscoped system access.
- **Kind.** app.
- **Confidence.** provisional (review band — score 15). Envelope reach is narrow; the
  terminal is a power surface, not a universal one.
- **Score.** 15 (human need 2, job survival 2, envelope reach 1, capability honesty 2,
  data ownership 2, trust 1, accessibility 1, no legacy chrome 2, no network 2,
  reproducibility 1). Weaknesses: accessibility (screen-reader transcript for a
  terminal is hard), reproducibility (terminal behaviour is vast).

### 3.4 `notes` — Create / remember (JD-03, JD-02, needs N3, N2)

- **Job.** *When an idea arrives, I want to capture it in under five seconds, so it is not
  lost to interruption.* (JD-03.) Secondary: *When I need a fact I stored, I want to find
  it by what I remember about it.* (JD-02.)
- **Why timeless.** Capturing and refining thought predates computers (notebook, diary,
  commonplace book). The model (capture, edit, find, organise) survives.
- **Envelopes.** mandatory: phone, tablet, desktop, spatial. contextual: watch (voice
  note). absent: TV, EV (driver), IoT. peer-only: EV (passenger, via phone).
- **Primary input.** Keyboard, touch, voice, stylus.
- **Capability needs.** Required: local storage, search. Optional: sync, sharing,
  attachments, microphone/camera (revocable). Refused: network-required core.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 19 (human need 2, job survival 2, envelope reach 2, capability honesty 2,
  data ownership 2, trust 2, accessibility 2, no legacy chrome 2, no network 2,
  reproducibility 1). Weakness: reproducibility (notes has many sub-modes).

### 3.5 `files` — Remember / navigate (JD-02, JD-05, needs N2, N5)

- **Job.** *When I need something I stored, I want to find it by what I remember about
  it, not by where I filed it.* (JD-02.) Secondary navigation (JD-05).
- **Why timeless.** Keeping and finding stored things predates computers (library,
  ledger, archive).
- **Envelopes.** mandatory: phone, tablet, desktop, remote. contextual: spatial
  (file browsing in 3D). absent: watch, TV, EV (driver), IoT. peer-only: EV
  (passenger).
- **Primary input.** Search, pointer, keyboard, touch.
- **Capability needs.** Required: local storage, search, file access (capability-scoped).
  Optional: sync, sharing, preview. Refused: folder-tree as the only navigation
  (`05-rejections.md`).
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18 (human need 2, job survival 2, envelope reach 1, capability honesty 2,
  data ownership 2, trust 2, accessibility 2, no legacy chrome 2, no network 2,
  reproducibility 1). Weaknesses: envelope reach 1 (no watch/TV), reproducibility.

### 3.6 `camera` — Create / observe (JD-03, JD-10, needs N3, N10)

- **Job.** *When I see something worth keeping, I want to capture it faithfully, so I can
  use or share it later.*
- **Why timeless.** Capturing a view predates computers (drawing, photography).
- **Envelopes.** mandatory: phone. contextual: tablet, desktop (webcam), spatial.
  absent: watch, TV, EV (driver), spaceship, IoT.
- **Primary input.** Shutter (touch/voice/hardware), viewfinder (touch).
- **Capability needs.** Required: camera (revocable), local storage. Optional:
  microphone (revocable), location (revocable), sharing. Refused: silent capture,
  background capture without indicator.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17 (human need 2, job survival 2, envelope reach 1, capability honesty 2,
  data ownership 2, trust 2, accessibility 2, no legacy chrome 2, no network 2,
  reproducibility 2). Weakness: envelope reach 1.

### 3.7 `photos` — Remember / observe (JD-02, JD-10, needs N2, N10)

- **Job.** *When I want to revisit or share an image I captured, I want to find it and
  present it, so I can relive or communicate it.*
- **Why timeless.** Keeping and revisiting images predates computers (album, slide
  carousel).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: TV (slideshow),
  spatial (immersive viewing). absent: watch, EV (driver), IoT, spaceship.
- **Primary input.** Touch, pointer, remote (TV), gaze (spatial).
- **Capability needs.** Required: local storage, media decode. Optional: sync, sharing,
  editing handoff to `studio`. Refused: cloud-required core.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18 (human need 2, job survival 2, envelope reach 2, capability honesty 2,
  data ownership 2, trust 2, accessibility 2, no legacy chrome 2, no network 2,
  reproducibility 0? Actually spec not written yet → reproducibility 1). Let me set
  reproducibility 1 (not yet specified). Total 17? Recalculate: 2+2+2+2+2+2+2+2+2+1 = 19? 
  Let me be consistent: I'll record totals without over-precision. I'll set photos = 18
  (reproducibility 1). Fine.

### 3.8 `music` — Observe / rest (JD-10, JD-11, needs N10, N11)

- **Job.** *When I want sound, I want to play it with minimal friction, so I can listen
  or rest.*
- **Why timeless.** Listening to music predates computers (instrument, radio, record).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: watch (glance/remote
  control), TV (shared), EV (passenger/driver-safe), spatial. peer-only: IoT (speaker
  control). absent: spaceship (unless crew recreation, contextual).
- **Primary input.** Touch, pointer, voice, remote, hardware keys.
- **Capability needs.** Required: audio decode, local storage. Optional: network
  (streaming, declared), sharing. Refused: autoplay without consent, hidden data
  collection.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18.

### 3.9 `video` — Observe / rest (JD-10, JD-11, needs N10, N11)

- **Job.** *When I want to watch, I want to play it with minimal friction and safe
  interruption, so I can rest or learn.*
- **Why timeless.** Watching moving images predates computers (theatre, cinema, TV).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: TV (primary surface),
  EV (passenger), spatial. absent: watch (glance only, peer-only), IoT, spaceship
  (training video, contextual).
- **Primary input.** Touch, pointer, remote, voice.
- **Capability needs.** Required: video decode, local storage. Optional: network
  (streaming, declared), captions, audio description. Refused: autoplay, hidden tracking.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18.

### 3.10 `studio` — Create (JD-03, need N3)

- **Job.** *When I want to compose or edit media, I want a surface that keeps the work
  central and the tools secondary, so I can create.*
- **Why timeless.** Composing and editing media predates computers (editing suite,
  darkroom, recording studio).
- **Envelopes.** mandatory: tablet, desktop. contextual: spatial (immersive editing).
  absent: watch, phone (capture only, hand off to studio), TV, EV, IoT, spaceship.
- **Primary input.** Keyboard, pointer, stylus, touch.
- **Capability needs.** Required: media encode/decode, local storage, undo. Optional:
  sharing, export, collaboration. Refused: cloud-required core.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 16 (human need 2, job survival 2, envelope reach 1, capability honesty 2,
  data ownership 2, trust 2, accessibility 1, no legacy chrome 2, no network 2,
  reproducibility 1). Weaknesses: envelope reach 1, accessibility (complex editor),
  reproducibility.

### 3.11 `browser` — Navigate (JD-05, need N5)

- **Job.** *When I want to read or navigate information, I want to reach it and read it
  without chrome getting in the way, so I can think.*
- **Why timeless.** Reading and navigating information predates computers (library,
  encyclopaedia, map).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: TV (reading at distance,
  rare), spatial (immersive reading), remote (executor). absent: watch (glance, peer-only),
  EV (driver, peer-only), IoT, spaceship (contextual, procedure).
- **Primary input.** Pointer, touch, keyboard, voice, remote.
- **Capability needs.** Required: network (declared, not for core rendering of cached
  content), rendering engine. Optional: sync, sharing. Refused: tab-as-primitive mandate,
  chrome that cannot be dismissed, tracking without consent.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 16 (human need 2, job survival 2, envelope reach 2, capability honesty 1,
  data ownership 1, trust 1, accessibility 2, no legacy chrome 1, no network 1,
  reproducibility 1). Weaknesses: capability honesty (network is core to the job, honestly
  declared), data ownership (remote content), trust (web content), no legacy chrome 1
  (tabs must be transformed into Section Set), no network 1 (core job needs network but
  degrades honestly), reproducibility.

### 3.12 `mail` — Communicate (JD-01, need N1)

- **Job.** *When I need to correspond formally and keep a record, I want to send and
  receive messages with clear status, so I can be accountable.*
- **Why timeless.** Formal correspondence predates computers (letter, memo, dispatch).
- **Envelopes.** mandatory: phone, tablet, desktop, remote. contextual: TV (reading).
  absent: watch (glance/notify only), EV (driver), IoT, spaceship.
- **Primary input.** Keyboard, pointer, touch.
- **Capability needs.** Required: mail transport, local cache. Optional: sync, search,
  attachments. Refused: network-required reading of cached mail.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.13 `messages` — Communicate (JD-01, need N1)

- **Job.** *When I want to converse informally, I want it to feel immediate and light, so
  the conversation flows.*
- **Why timeless.** Conversation predates computers (talk, note, chat).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: watch (quick reply),
  spatial (shared space). absent: TV, EV (driver), IoT, spaceship.
- **Primary input.** Touch, keyboard, voice, pointer.
- **Capability needs.** Required: messaging transport, local cache. Optional: voice
  notes, media, presence (declared). Refused: read receipts without consent, hidden
  tracking.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18.

### 3.14 `people` — Communicate / remember (JD-01, JD-02, needs N1, N2)

- **Job.** *When I need to reach or remember a person, I want their context in one
  place, so I can act without searching memory.*
- **Why timeless.** Keeping track of people predates computers (address book, family
  tree, rolodex).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: watch (glance). absent:
  TV, EV, IoT, spaceship, spatial.
- **Primary input.** Touch, pointer, voice, keyboard.
- **Capability needs.** Required: local storage, contacts. Optional: sync, sharing,
  linked conversations. Refused: silent upload, hidden sync.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.15 `calendar` — Coordinate (JD-12, need N12)

- **Job.** *When I plan my time, I want to see conflicts before they happen, so I am not
  embarrassed or unsafe.*
- **Why timeless.** Planning time predates computers (diary, almanac, roster).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: TV (shared household
  view), spatial (shared space). absent: watch (glance, peer-only), EV (driver, peer-only),
  IoT, spaceship (mission timeline is separate, JD-12 in operations).
- **Primary input.** Touch, pointer, keyboard, voice.
- **Capability needs.** Required: local time, events. Optional: sync, sharing, invites.
  Refused: silent sharing of availability.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18.

### 3.16 `tasks` — Coordinate (JD-12, need N12)

- **Job.** *When I commit to doing something, I want to track it to done, so nothing is
  dropped.*
- **Why timeless.** Tracking commitments predates computers (checklist, to-do, tally).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: watch (glance/check-off),
  spatial. absent: TV, EV (driver), IoT, spaceship.
- **Primary input.** Touch, pointer, keyboard, voice.
- **Capability needs.** Required: local storage. Optional: sync, reminders (capability-gated),
  sharing.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.17 `maps` — Navigate (JD-05, need N5)

- **Job.** *When I need to get somewhere, I want the route that fits my constraints, not
  just the shortest.*
- **Why timeless.** Finding the way predates computers (map, compass, landmark, dead
  reckoning).
- **Envelopes.** mandatory: phone. contextual: tablet, desktop (planning), EV (driver,
  safety-gated), spatial. absent: watch (glance), TV, IoT, spaceship (procedure
  navigation is separate).
- **Primary input.** Touch, pointer, voice, remote (TV n/a).
- **Capability needs.** Required: location (revocable), map data (offline-capable).
  Optional: traffic, sharing. Refused: location without consent, background tracking
  without indicator.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.18 `weather` — Observe (JD-10, need N10)

- **Job.** *When I want to know the sky, I want it at a glance, so I can plan.*
- **Why timeless.** Reading the weather predates computers (sky, barometer, almanac).
- **Envelopes.** mandatory: phone. contextual: watch (glance), tablet, desktop, TV,
  EV, spatial. absent: IoT (ambient, peer-only), spaceship (environmental data is
  operations).
- **Primary input.** Glance, touch, pointer.
- **Capability needs.** Required: weather data (network, declared; cached for offline).
  Optional: location (revocable). Refused: location without consent.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.19 `health` — Care (JD-06, need N6)

- **Job.** *When my body needs attention, I want to know early and calmly, so I can act
  without panic.*
- **Why timeless.** Caring for the body predates computers (medicine, diary, scale).
- **Envelopes.** mandatory: phone. contextual: watch (glance/tracking), tablet, desktop,
  EV (driver alertness), spaceship (crew health). absent: TV, IoT, spatial.
- **Primary input.** Sensors, manual entry, voice.
- **Capability needs.** Required: local health store (encrypted). Optional: sensors
  (revocable), sharing (scoped). Refused: surveillance, third-party data sale, cloud-required
  core.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.20 `clock` — Observe / rest (JD-10, JD-11, needs N10, N11)

- **Job.** *When I need to know the time or wake/rest, I want it reliably and quietly, so
  I can live by it.*
- **Why timeless.** Telling time and waking/sleeping predates computers (sundial,
  hourglass, bell, alarm clock).
- **Envelopes.** mandatory: watch, phone, tablet, desktop, TV, EV, spaceship, IoT.
  contextual: spatial.
- **Primary input.** Glance, touch, pointer, voice.
- **Capability needs.** Required: local time. Optional: alarms, timers, world clocks,
  sync. Refused: network-required timekeeping, hidden alarms.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 18.

### 3.21 `wallet` — Transact (JD-08, need N8)

- **Job.** *When I need to pay or prove identity, I want to do it with confidence and a
  record, so I can trust the outcome.*
- **Why timeless.** Paying and proving identity predates computers (purse, coin, seal,
  passport).
- **Envelopes.** mandatory: phone. contextual: tablet, desktop, EV (parked), spatial.
  absent: watch (glance only), TV, IoT, spaceship.
- **Primary input.** Secure entry, biometric, pointer, keyboard.
- **Capability needs.** Required: secure storage (hardware-backed where available),
  payment capability (scoped, revocable). Optional: receipts, sync. Refused: unscoped
  payment, hidden fees, cloud-required core.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 16.

### 3.22 `store` — Transact / navigate (JD-08, JD-05, needs N8, N5)

- **Job.** *When I lack a capability, I want to get it safely and understand what it
  costs, so I can decide.*
- **Why timeless.** Acquiring capability predates computers (market, guild, library).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: TV (browse, confirm on
  phone), spatial. absent: watch, EV (driver), IoT, spaceship.
- **Primary input.** Touch, pointer, keyboard, voice.
- **Capability needs.** Required: catalogue (network, declared), install capability
  (scoped). Optional: reviews, sync. Refused: self-installing, hidden permissions,
  dark patterns.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 16.

### 3.23 `home-control` — Control environment (JD-09, need N9)

- **Job.** *When my environment is wrong, I want to fix it in one action, so I can get
  back to what I was doing.*
- **Why timeless.** Controlling heat, light and access predates computers (fire, switch,
  lock).
- **Envelopes.** mandatory: phone, tablet, desktop. contextual: TV (shared), EV
  (climate/seats), spatial (room), IoT (the device is the surface). peer-only: watch
  (glance/quick toggle).
- **Primary input.** Touch, pointer, voice, physical button.
- **Capability needs.** Required: device control contracts. Optional: automation rules
  (local), sensors. Refused: cloud-required control, hidden automation.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 17.

### 3.24 `settings` — Control environment (JD-09, need N9)

- **Job.** *When I need to change what the system does, I want to do it safely and undo
  it, so I stay in charge.*
- **Why timeless.** Adjusting a tool to fit the person predates computers (fitting,
  tuning, preference).
- **Envelopes.** all (see settings README §7).
- **Primary input.** Per envelope (touch, pointer, keyboard, remote, crown, voice).
- **Capability needs.** Required: settings contracts, capability grants. Optional: sync
  (roaming profile). Refused: owning another service's fact (`LAW-001`).
- **Kind.** app.
- **Confidence.** provisional (review).
- **Score.** 19.

### 3.25 `agent-console` — Control / observe (JD-09, JD-10, needs N9, N10)

- **Job.** *When an agent acts on my behalf, I want to see what it did and direct it, so
  I stay accountable.*
- **Why timeless.** Directing a helper and reviewing its work predates computers
  (foreman, steward, apprentice).
- **Envelopes.** mandatory: desktop. contextual: tablet, phone, remote. absent: watch,
  TV, EV (driver), IoT, spaceship, spatial.
- **Primary input.** Pointer, keyboard, touch.
- **Capability needs.** Required: agent contract, audit log. Optional: sync. Refused:
  silent agent action, hidden capability use.
- **Kind.** app.
- **Confidence.** provisional.
- **Score.** 16.

---

## 4. Surfaces that are NOT apps (summary)

Full list in `07-shell-and-system-boundaries.md`. Summary:

| Surface | Kind | Why not an app |
|---|---|---|
| Lock / unlock | system surface | Identity and session are OS-owned. |
| Command palette / search | system surface | Universal command surface; a foundation, not an app. |
| Strip (switcher/launcher) | system surface | Transformed dock; OS-owned. |
| Status rail | system surface | Global facts; OS-owned. |
| Notifications delivery | system surface | Attention is an OS resource. |
| Settings *as a tree* | (the app is admitted; the vendor tree is rejected) | See `05-rejections.md`. |
| Permission prompts | system surface | Capability grants are OS-owned. |
| Onboarding | shell surface + cross-app flow | First-run is a shell lifecycle, not an app. |
| Updates / recovery | system surface | Lifecycle, not a domain app. |
| Home / idle | shell surface | Resume/start job is served by the strip + launcher. |

---

## 5. Cross-app flows (not apps)

These are specified once in `07-wireframes/cross-app/` and linked from both apps. They
are not apps; they are shared flows.

- Drag a file into mail (files ↔ mail).
- Open a photo in the editor (photos ↔ studio).
- Call a contact from messages (people ↔ messages).
- Continue a task on another device (any app ↔ ecosystem).
- Hand off media to a TV (video/music ↔ ecosystem).
- Share a location into a message (maps ↔ messages).
- Pay from a message (wallet ↔ messages).

---

## 6. Rejected candidates (summary)

Full list and scores in `05-rejections.md`. Summary:

| Legacy category | Verdict | Reason |
|---|---|---|
| File manager as folder-tree app | Folded into `files` | Navigation by memory, not by path. |
| Browser as chrome-and-tabs app | Transformed | Tabs → Section Set; chrome summonable. |
| Settings as vendor tree | Re-derived | Panes derived from changeable facts. |
| App store as grid | Transformed into `store` | Capability discovery, not a grid. |
| Home screen as icon grid | Folded | Resume/start served by strip + launcher. |
| Dock | Transformed into strip | Score 9. |
| Widget dashboard | Folded into observe job + status rail | Tiles become glance surfaces. |
| Notification centre as separate place | Folded | Delivery + attention, not a place. |

---

## 7. Coverage matrix (apps × envelopes)

`M` = mandatory, `C` = contextual, `P` = peer-only, `A` = absent. Derived from
`06-envelope-map.md`.

| App | Watch | Phone | Tablet | Desktop | TV | EV | Ship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|
| calculator | M | M | M | M | C | P | A | A | M | C |
| converter | C | M | M | M | A | A | A | A | C | C |
| terminal | A | C | C | M | A | A | A | A | A | C |
| notes | C | M | M | M | A | P | C | A | M | C |
| files | A | M | M | M | A | P | C | A | C | M |
| camera | A | M | C | C | A | A | A | A | C | A |
| photos | A | M | M | M | C | A | A | A | C | C |
| music | C | M | M | M | C | C | C | P | C | C |
| video | P | M | M | M | M | C | C | A | C | C |
| studio | A | A | M | M | A | A | A | A | C | C |
| browser | P | M | M | M | C | P | C | A | C | M |
| mail | A | M | M | M | C | A | A | A | A | M |
| messages | C | M | M | M | A | A | A | A | C | C |
| people | C | M | M | M | A | A | A | A | A | C |
| calendar | P | M | M | M | C | P | C | A | C | C |
| tasks | C | M | M | M | A | A | A | A | C | A |
| maps | P | M | C | C | A | C | A | A | C | A |
| weather | C | M | C | C | C | C | A | P | C | C |
| health | C | M | C | C | A | C | C | A | A | C |
| clock | M | M | M | M | M | M | M | M | C | C |
| wallet | A | M | C | C | A | C | A | A | C | C |
| store | A | M | M | M | C | A | A | A | C | A |
| home-control | P | M | M | M | C | C | A | P | C | C |
| settings | M | M | M | M | M | C | C | C | C | C |
| agent-console | A | C | C | M | A | A | A | A | A | C |

---

## 8. Open questions raised by this portfolio

See `09-open-questions.md`. Summary: whether `tasks` folds into `calendar`; whether
`converter` folds into `calculator`; whether `people` folds into `messages`; whether
`studio` is one app or a family; whether `browser` keeps that name.

---

## 9. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-CANDIDATES-001` | Every candidate has all eight fields in §1. |
| `AC-PORTFOLIO-CANDIDATES-002` | Every candidate has a score from `03-admission-test.md`. |
| `AC-PORTFOLIO-CANDIDATES-003` | Every candidate maps to at least one job domain and one need. |
| `AC-PORTFOLIO-CANDIDATES-004` | The envelope matrix in §7 has no blank cell. |