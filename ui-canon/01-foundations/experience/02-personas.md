---
id: FOUND-EXPERIENCE-PERSONAS
title: Personas — Real, Non-Marketing, With Routine, Constraints, Emotional State and Acceptance Scenarios
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-LEARNING, UX-CULTURE-LANGUAGE]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-PERSONA-001, AC-EXP-PERSONA-002]
---

# Personas

> At least eight real, non-marketing personas. Each has a routine, constraints,
> emotional state and acceptance scenarios. These are not user segments or marketing
> archetypes; they are people the design must work for.

## 1. How personas are used

Personas are used to test design decisions: "would this work for Amahle at 06:00 with
one hand and a crying child?" They are not used to justify features ("our persona
wants a dock"). A persona that produces no testable constraint is not a persona.

## 2. Personas

### P-01 — Amahle, 34, nurse, night shifts, two children

- **Routine.** Wakes 18:00, works 19:00–07:00, sleeps 08:00–16:00. Phone is the
  primary device; tablet for children's schoolwork; shared family desktop for bills.
- **Constraints.** One-handed use while holding a child; dim light at night; fatigue
  after shifts; limited data budget; phone shared with children.
- **Emotional state.** Tired, time-poor, needs reliability; distrusts systems that
  lose data or require re-entry.
- **Envelope.** Phone primary; tablet secondary; desktop occasional.
- **Acceptance scenarios.** (a) Log a medication note at 03:00 one-handed with a
  sleeping child; (b) hand the phone to a child for schoolwork without exposing
  personal data; (c) recover a half-written note after the phone died.

### P-02 — Thabo, 62, retired teacher, rural, low vision

- **Routine.** Reads news and messages in the morning; manages pension and health
  appointments; occasional video calls with grandchildren.
- **Constraints.** Presbyopia (200% text needed); low bandwidth; occasional power
  cuts; unfamiliar with new gestures; Afrikaans and English.
- **Emotional state.** Patient but frustrated by small text and hidden controls;
  values independence.
- **Envelope.** Phone and tablet; TV for calls.
- **Acceptance scenarios.** (a) Read a message at 200% text without horizontal
  scrolling; (b) complete a pension task with keyboard only; (c) recover from a
  power cut mid-task.

### P-03 — Lerato, 19, student, low income, shared devices

- **Routine.** Studies on a shared laptop at the library; phone for everything else;
  switches between campus Wi-Fi and mobile data.
- **Constraints.** No personal device ownership; limited storage; interrupted
  connectivity; must not leave personal data on shared machines.
- **Emotional state.** Anxious about data loss and privacy; values speed and
  offline capability.
- **Envelope.** Desktop (shared, remote browser) and phone.
- **Acceptance scenarios.** (a) Work offline on the shared laptop and sync later;
  (b) sign out completely leaving no trace; (c) continue an essay on phone from
  where the laptop left off.

### P-04 — Johan, 45, EV driver and fleet manager

- **Routine.** Drives 2–3 hours/day; manages a small fleet from the car and the
  office; uses voice and steering-wheel controls while driving.
- **Constraints.** Eyes on road; vibration and glare; one hand on wheel; passenger
  vs driver; legal distraction limits.
- **Emotional state.** Safety-conscious; irritated by systems that demand attention
  while driving.
- **Envelope.** EV primary; desktop secondary.
- **Acceptance scenarios.** (a) Accept a call and navigate to a charger with
  ≤ 2 s glances; (b) passenger controls climate without affecting driver view;
  (c) system degrades gracefully when the phone disconnects mid-route.

### P-05 — Priya, 28, software engineer, multi-device, high throughput

- **Routine.** Works across laptop, desktop, phone; uses keyboard heavily; runs
  multiple windows; values density and speed.
- **Constraints.** RSI risk; needs keyboard shortcuts; multi-monitor; dark
  environments.
- **Emotional state.** Impatient with friction; values predictability and
  reversibility.
- **Envelope.** Desktop primary; phone secondary.
- **Acceptance scenarios.** (a) Switch between five apps without a pointer;
  (b) undo a destructive action after 10 steps; (c) use the system at 120 Hz
  without jank.

### P-06 — Captain Mokoena, 50, spacecraft operator

- **Routine.** Monitors systems during long-duration missions; follows procedures;
  handles anomalies; works in gloves, glare, non-rectangular displays.
- **Constraints.** Gloves; high vibration; non-rectangular displays; redundant
  systems; deterministic timing; high workload during emergencies.
- **Emotional state.** Calm under pressure; relies on procedure; distrusts
  surprise.
- **Envelope.** Spaceship primary.
- **Acceptance scenarios.** (a) Follow a 12-step procedure under alarm with
  gloves; (b) identify a failing subsystem from redundant cues; (c) recover from a
  display failure without losing situational awareness.

### P-07 — Fatima, 70, retired, lives alone, limited tech literacy

- **Routine.** Uses TV for news and calls; phone for messages and photos; avoids
  complex settings.
- **Constraints.** Reduced dexterity; unfamiliar vocabulary; fear of breaking
  things; hearing loss (uses captions).
- **Emotional state.** Cautious, easily discouraged by error messages; values
  simplicity and forgiveness.
- **Envelope.** TV primary; phone secondary.
- **Acceptance scenarios.** (a) Make a video call from the TV with the remote
  only; (b) recover from an accidental setting change; (c) read captions without
  strain.

### P-08 — Daniel, 12, neurodivergent, uses assistive tech

- **Routine.** Uses tablet for school and communication; switch access and
  text-to-speech; predictable routines matter.
- **Constraints.** Switch access (two switches); prefers reduced motion; needs
  plain language; overwhelmed by dense screens.
- **Emotional state.** Anxious with unpredictability; calms with structure and
  consistency.
- **Envelope.** Tablet primary.
- **Acceptance scenarios.** (a) Complete a school task with switch access only;
  (b) navigate with reduced motion and no animation; (c) recover from an
  unexpected dialog without losing place.

### P-09 — Nozipho, 40, community health worker, multilingual, field conditions

- **Routine.** Visits patients in rural areas; records data on phone; syncs when
  connectivity allows; works in bright sunlight and dust.
- **Constraints.** Glare; dust; intermittent connectivity; multiple languages
  (isiZulu, English, Afrikaans); shared device among team.
- **Emotional state.** Focused on patients; impatient with tech that fails in the
  field.
- **Envelope.** Phone primary.
- **Acceptance scenarios.** (a) Record a patient note in bright sunlight;
  (b) sync after 6 hours offline; (c) switch language mid-task without losing data.

### P-10 — Alex, 30, remote worker, uses remote browser

- **Routine.** Works from a thin client in a browser; needs the full OS remotely;
  variable latency.
- **Constraints.** Remote latency; no local GPU; must not lose work on disconnect.
- **Emotional state.** Trusts local; skeptical of remote; needs proof of
  reliability.
- **Envelope.** Remote browser primary.
- **Acceptance scenarios.** (a) Work for 2 hours over 200 ms latency;
  (b) reconnect after a drop without data loss; (c) verify that remote is an
  executor, not VNC.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-PERSONA-001` | Every persona has routine, constraints, emotional state, envelope and ≥ 3 acceptance scenarios. |
| `AC-EXP-PERSONA-002` | Every acceptance scenario is testable and falsifiable. |