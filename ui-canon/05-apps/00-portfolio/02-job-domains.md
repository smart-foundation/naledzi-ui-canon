---
id: PORTFOLIO-JOBS
title: Job Domains
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-NEEDS, CANON-TIMELESSNESS, CANON-LAWS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-JOBS-001, AC-PORTFOLIO-JOBS-002, AC-PORTFOLIO-JOBS-003]
---

# Job Domains

> A job domain is not an app. It is a cluster of jobs that share a need, a context and a
> failure cost. One domain may yield zero, one or several apps depending on envelope and
> capability. The domain is the unit of derivation; the app is the unit of specification.

---

## 1. What a job domain is

A job domain is defined by five fields. All five must be stated; a domain with a blank
field is not derived, it is asserted.

| Field | Question |
|---|---|
| **Verb cluster** | What do people do, in imperative verbs? |
| **Need** | Which of the twelve needs (N1–N12) does it serve? |
| **Contexts** | In what situations, with what constraints, with whom? |
| **Envelopes** | On which devices is the job felt? |
| **Failure cost** | What happens when it goes wrong: annoyance, loss, injury, death? |

**Rules.**

- `PORTFOLIO-JOB-001`. A domain MUST be stated without naming an app, a vendor, a file
  format or a screen. "Manage PDFs" is not a domain; "keep and find what I stored" is.
- `PORTFOLIO-JOB-002`. A domain MUST have at least one job statement in Christensen form
  (situation, action, outcome) and at least one failure cost.
- `PORTFOLIO-JOB-003`. Domains are not mutually exclusive. A person can be in two domains
  at once (reading a message while navigating). The strip and the palette exist for this.
- `PORTFOLIO-JOB-004`. A domain that only exists on one envelope is still a domain, but
  its admission score for envelope independence (timelessness criterion 4) is reduced and
  must be declared.
- `PORTFOLIO-JOB-005`. Failure cost determines safety class interaction. A job whose
  failure can injure (navigation in a vehicle, medication timing) MUST be specified to the
  safety envelope's rules even when it runs on a phone.

---

## 2. The job domains

### JD-01 — Communicate (need N1)

- **Verb cluster:** send, receive, reply, call, meet, share, announce, listen.
- **Need:** N1 Communicate.
- **Contexts:** one-to-one and one-to-many; synchronous and asynchronous; near (same
  room) and far (across time zones); trusted (family) and untrusted (stranger); private
  and public.
- **Envelopes:** watch, phone, tablet, desktop, TV, EV (passenger), spatial, remote.
- **Primary input:** text, voice, gesture, pointer; on TV and EV, voice-first.
- **Failure cost:** missed message (annoyance to harm); misdirected message (privacy
  breach, LAW-020); interruption during safety task (harm).
- **Jobs (sample, not exhaustive):**
  - *When I think of something to tell a person, I want to send it without deciding
    which channel, so I can keep the conversation moving.*
  - *When a message arrives, I want to know whether it needs me now, so I can protect
    my attention.*
  - *When I am with someone in person, I want the device to step back, so I am not rude.*
- **Capability needs:** messaging transport, contacts, presence (declared, not detected),
  notification delivery, voice capture, camera/microphone with revocable grants.
- **Envelope notes:** on watch, communicate is glance-and-reply (canned, voice, emoji);
  on spaceship, communication is procedure-gated and may be delayed by light-time.

### JD-02 — Remember (need N2)

- **Verb cluster:** capture, store, find, recall, organise, forget, restore.
- **Need:** N2 Remember.
- **Contexts:** quick capture (walking), deliberate capture (desk), recall under pressure
  (meeting, cockpit), recall after years, shared memory (team), private memory.
- **Envelopes:** all, including IoT (ambient capture) and spaceship (procedure memory).
- **Primary input:** text, voice, photo, scan, structured form.
- **Failure cost:** lost commitment (annoyance to legal/financial harm); corrupted
  record (trust loss); false recall (harm in medical/flight context).
- **Jobs:**
  - *When I meet someone, I want to capture their name and context, so I can recall it
    later without searching my memory.*
  - *When I need a fact I stored, I want to find it by what I remember about it, not
    by where I filed it.*
  - *When I no longer need something, I want to forget it deliberately, so my future
    search is not polluted.*
- **Capability needs:** local-first storage, search, sync, encryption, capability-scoped
  sharing, retention policy.

### JD-03 — Create (need N3)

- **Verb cluster:** write, draw, record, compose, edit, arrange, publish, iterate.
- **Need:** N3 Create.
- **Contexts:** quick note (phone, walking), long-form writing (desktop), media capture
  (camera), composition (music, video), collaborative creation, creation under stress
  (field notes).
- **Envelopes:** phone, tablet, desktop, spatial; watch (voice note only); TV (viewing
  and light annotation); EV (passenger, parked).
- **Primary input:** keyboard, touch, pointer, stylus, voice, camera, microphone.
- **Failure cost:** lost work (trust loss); corrupted file (data loss); accidental
  publish (reputation/privacy harm).
- **Jobs:**
  - *When an idea arrives, I want to capture it in under five seconds, so it is not
    lost to interruption.*
  - *When I refine a piece of work, I want the tool to stay out of the way, so my
    attention stays on the work.*
  - *When I finish, I want to publish or share it with one clear action, so I do not
    hesitate.*
- **Capability needs:** buffer ownership, damage declaration, undo, versioning, export,
  sharing, media capture with revocable grants.

### JD-04 — Compute (need N4)

- **Verb cluster:** calculate, convert, estimate, compare, simulate, derive.
- **Need:** N4 Compute.
- **Contexts:** quick arithmetic (checkout, tip), unit conversion (cooking, travel),
  comparison (prices, specs), engineering calculation (desk), scientific (tablet/stylus).
- **Envelopes:** watch, phone, tablet, desktop, TV (rare), EV (passenger), spatial.
- **Primary input:** keypad, keyboard, voice, pointer.
- **Failure cost:** wrong number (financial/medical harm); silent error (trust loss).
- **Jobs:**
  - *When I need a number, I want to get it without opening a heavy tool, so I can
    decide now.*
  - *When I compute, I want to see how I got there, so I can check my reasoning.*
- **Capability needs:** local computation, history, copy to clipboard (capability-gated),
  no network dependency (LAW-017).
- **Note:** the calculator is the reproducibility exemplar for this domain. It is not the
  only compute surface; conversion, comparison and estimation are separate apps or
  features of the same domain depending on the admission test.

### JD-05 — Navigate space and information (need N5)

- **Verb cluster:** locate, route, orient, explore, search, browse, find.
- **Need:** N5 Navigate.
- **Contexts:** physical navigation (walking, driving, flying), information navigation
  (finding a document, a setting, a person), spatial navigation (room-scale, spatial
  envelope).
- **Envelopes:** all, including EV (driver, safety-gated) and spaceship (procedure
  navigation) and spatial.
- **Primary input:** map, search, voice, pointer, d-pad, gaze.
- **Failure cost:** wrong route (delay to danger); lost information (annoyance); in
  vehicle/space, wrong navigation is a safety event.
- **Jobs:**
  - *When I need to get somewhere, I want the route that fits my constraints (time,
    safety, fuel), not just the shortest.*
  - *When I search for something I stored, I want results by relevance to my memory of
    it, not by filename.*
  - *When I am driving, I want navigation that does not ask me to look, so I keep my
    eyes on the road.*
- **Capability needs:** location (revocable), maps (offline-capable), search, voice,
  protected zones on safety envelopes.

### JD-06 — Care (need N6)

- **Verb cluster:** monitor, remind, track, measure, treat, rest, recover.
- **Need:** N6 Care.
- **Contexts:** personal health (sleep, activity, medication), care for others
  (children, elders, patients), environmental care (plants, home), device health
  (battery, storage, thermal).
- **Envelopes:** watch, phone, tablet, desktop, EV (driver alertness), spaceship
  (crew health), IoT (ambient), spatial.
- **Primary input:** sensors, manual entry, voice, reminders.
- **Failure cost:** missed medication (harm); false alarm (alarm fatigue, trust loss);
  missed deterioration (harm).
- **Jobs:**
  - *When my body or my charge needs attention, I want to know early and calmly, so I
    can act without panic.*
  - *When I care for someone, I want to see their state without spying, so trust is
    preserved.*
- **Capability needs:** sensors (revocable), health data (local-first, encrypted),
  notifications with budgets, quiet hours, observation rights.

### JD-07 — Learn (need N7)

- **Verb cluster:** study, practise, teach, explain, quiz, discover, reference.
- **Need:** N7 Learn.
- **Contexts:** self-directed learning, classroom, on-the-job, just-in-time reference
  (a procedure in a cockpit), child learning, expert refresher.
- **Envelopes:** phone, tablet, desktop, TV (shared), spatial, EV (parked/passenger),
  spaceship (training).
- **Primary input:** text, media, voice, gesture, quiz.
- **Failure cost:** misunderstood procedure (harm in safety context); wasted time;
  disengagement.
- **Jobs:**
  - *When I need to do something I have not done before, I want guidance at the moment
    of action, so I do not have to memorise it first.*
  - *When I am an expert, I want the system to get out of my way, so I am not slowed
    by beginner scaffolding.*
- **Capability needs:** content delivery, offline access, progress (local), accessibility
  (cognitive, motor), no surveillance of learning.

### JD-08 — Transact (need N8)

- **Verb cluster:** buy, sell, pay, agree, sign, settle, refund, account.
- **Need:** N8 Transact.
- **Contexts:** personal purchase, subscription management, peer-to-peer exchange,
  business invoicing, shared household budget, high-stakes (property, medical).
- **Envelopes:** phone, tablet, desktop, TV (viewing, confirm on phone), EV (parked),
  spatial.
- **Primary input:** secure entry, biometric, pointer, keyboard.
- **Failure cost:** financial loss; fraud; privacy breach; irreversible commitment.
- **Jobs:**
  - *When I decide to buy, I want to complete it with confidence and a record, so I
    can prove what happened.*
  - *When I review my spending, I want to see what I agreed to, so I am not surprised.*
- **Capability needs:** secure input, payment capability (revocable, scoped), audit
  trail, receipts, offline queueing, no silent retries.

### JD-09 — Control environment (need N9)

- **Verb cluster:** switch, adjust, lock, unlock, open, close, set, automate.
- **Need:** N9 Control environment.
- **Contexts:** home (lights, climate, locks), device (settings), vehicle (climate,
  seats, windows), spacecraft (life support, power), workplace (access, HVAC).
- **Envelopes:** all, including IoT (the device itself), EV, spaceship.
- **Primary input:** switch, slider, voice, automation rules, physical button.
- **Failure cost:** uncomfortable (annoyance); unsafe (temperature, lockout, fire);
  in vehicle/space, control failure is a safety event.
- **Jobs:**
  - *When the room is wrong, I want to fix it in one action, so I can get back to what
    I was doing.*
  - *When I am not present, I want the environment to behave as I set it, so I do not
    have to manage it constantly.*
  - *When automation acts, I want to see what it did and undo it, so I stay in charge.*
- **Capability needs:** device control contracts, automation rules (local), override,
  audit log, safety interlocks on S3/S4 envelopes.

### JD-10 — Observe (need N10)

- **Verb cluster:** watch, measure, log, monitor, glance, compare, track.
- **Need:** N10 Observe.
- **Contexts:** glanceable status (watch), dashboard (desktop), ambient (IoT), safety
  monitoring (EV, spaceship), media consumption (TV), environmental (weather).
- **Envelopes:** all.
- **Primary input:** glance, scroll, filter, voice query.
- **Failure cost:** missed change (annoyance to harm); false signal (alarm fatigue);
  surveillance (privacy harm, LAW-020).
- **Jobs:**
  - *When I want to know the state of something, I want to see it without opening an
    app, so my attention is not stolen.*
  - *When a value changes, I want to be told only if it matters, so I am not
    conditioned to ignore signals.*
- **Capability needs:** sensor/telemetry contracts, sampling rates, glance surfaces,
  notification budgets, observation rights.

### JD-11 — Rest (need N11)

- **Verb cluster:** pause, sleep, focus, quiet, recover, play, idle.
- **Need:** N11 Rest.
- **Contexts:** sleep, focus mode, do-not-disturb, leisure (media, games), recovery
  after error, low-stimulation mode (vestibular, stress).
- **Envelopes:** all, including watch (sleep tracking) and spatial (comfort).
- **Primary input:** minimal; often none (idle is the point).
- **Failure cost:** broken rest (health); inability to disengage (attention tax);
  motion sickness (harm).
- **Jobs:**
  - *When I need to focus or recover, I want the system to become quiet, so my
    attention can return to me.*
  - *When I play, I want immersion without losing the ability to stop, so I stay in
    control.*
- **Capability needs:** quiet hours, notification budgets, reduced motion, focus modes,
  idle silence (LAW-004).

### JD-12 — Coordinate (need N12)

- **Verb cluster:** schedule, assign, track, hand off, meet, remind, sync.
- **Need:** N12 Coordinate.
- **Contexts:** personal planning (calendar), team coordination, household, shift
  work, mission operations (spaceship), multi-device continuity.
- **Envelopes:** phone, tablet, desktop, TV (shared view), EV (passenger), spaceship,
  spatial.
- **Primary input:** calendar, task list, voice, shared view.
- **Failure cost:** missed appointment (annoyance to harm); conflicting commitments
  (trust loss); in mission context, coordination failure is a safety event.
- **Jobs:**
  - *When I plan my time, I want to see conflicts before they happen, so I am not
    embarrassed or unsafe.*
  - *When work moves between devices, I want to resume where I left off, so I do not
    repeat myself.*
- **Capability needs:** time, calendar, sync, handoff, multi-device continuity, shared
  state via roles (not names).

---

## 3. Domain-to-need traceability

| Domain | Need | Candidate apps (see 04) |
|---|---|---|
| JD-01 Communicate | N1 | messages, mail, calls, contacts |
| JD-02 Remember | N2 | notes, files, people/contacts, archive |
| JD-03 Create | N3 | notes, camera, studio (audio/video), editor |
| JD-04 Compute | N4 | calculator, converter, terminal (compute) |
| JD-05 Navigate | N5 | maps, browser (reading), search, files |
| JD-06 Care | N6 | health, medication, home control, device health |
| JD-07 Learn | N7 | reference, study, onboarding/help |
| JD-08 Transact | N8 | payments, wallet, receipts |
| JD-09 Control environment | N9 | settings, home control, vehicle, operations |
| JD-10 Observe | N10 | clock, weather, status, dashboard, media |
| JD-11 Rest | N11 | media, focus, idle, sleep |
| JD-12 Coordinate | N12 | calendar, tasks, handoff, continuity |

A candidate that cannot be placed in this table is not derived and is rejected.

---

## 4. Envelope reach of domains

Every domain is felt on at least three envelopes or it is a feature, not a domain. The
domains that are watch-present (JD-01, 02, 04, 06, 09, 10, 11) are the ones that make a
watch worth wearing. The domains that are spaceship-present are the ones that make a
spacecraft operable. See `06-envelope-map.md`.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-JOBS-001` | Every domain has all five fields (verb cluster, need, contexts, envelopes, failure cost). |
| `AC-PORTFOLIO-JOBS-002` | Every domain has at least one Christensen-form job statement. |
| `AC-PORTFOLIO-JOBS-003` | Every candidate in `04-candidate-portfolio.md` maps to at least one domain. |
| `AC-PORTFOLIO-JOBS-004` | No domain names an app, vendor, file format or screen. |
| `AC-PORTFOLIO-JOBS-005` | Every domain with injury-level failure cost is cross-referenced to the safety envelopes. |