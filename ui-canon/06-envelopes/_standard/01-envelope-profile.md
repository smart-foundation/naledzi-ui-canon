---
id: ENV-STANDARD-PROFILE
title: The Envelope Profile
kind: envelope
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Envelope and Device UX Guild
depends: [ENV-STANDARD-README, CANON-LAWS, APP-ENVELOPE-ADAPTATION]
acceptance: [AC-ENV-STANDARD-006, AC-ENV-STANDARD-010]
---

# The Envelope Profile

> Before a single region is placed, the envelope must state fourteen facts. Layout derived
> from a screen size is a guess. Layout derived from a profile is a design.

---

## 1. Why a profile, not a breakpoint

Two devices can share a width and differ in every fact that matters: one is held in a hand
in glare, the other is bolted to a wall in a quiet room. A breakpoint sees `1024 px` twice.
A profile sees a hand-held, glare-exposed, vibration-exposed, S3 device and a stationary,
ambient, S2 device. The compositions must differ.

The profile is also the unit of **agreement between peers**. When a phone hands a session to
a car, the car does not describe itself as "a big phone". It publishes its profile; the
phone adapts the content and the interaction to the declared facts.

**Normative.** The profile MUST be declared by the platform, not inferred by an app from
viewport dimensions. An app MAY read the profile; it MUST NOT guess it (`LAW-019`).

---

## 2. The fourteen fields

Each field has an ID, a type and a required value. `NOT REPORTED` is a valid value with a
human-readable reason (`LAW-011`); a default is not.

### EP-01 — Physical situation

Where the device is and what is happening around it. One of:
`wrist`, `hand-held`, `lap-or-table`, `desk`, `living-room`, `vehicle-cabin`,
`flight-deck`, `fixed-environment`, `room-scale`, `remote-host`.

The value determines reach, viewing distance, occlusion risk and whether the user can stop.

### EP-02 — Posture and attention

The dominant human posture and attention budget:

| Value | Meaning | Consequence |
|---|---|---|
| `glance` | seconds, interrupted, one hand | one primary action per frame; no multi-step forms |
| `transient` | tens of seconds, standing or walking | one task, resumable, large targets |
| `focused` | minutes, seated, both hands free | full flows, keyboard acceleration |
| `lean-back` | minutes to hours, low effort | large type, focus-driven, minimal text entry |
| `operational` | minutes to hours, divided attention, high consequence | procedures, checklists, alarms, cross-check |
| `ambient` | no sustained attention | state visible at a distance; no interaction assumed |

### EP-03 — Social and privacy context

Who else can see the display, hear audio, or observe input:

- `private` — one person, shoulder-surfing possible;
- `shared-viewing` — several people see the same surface by design;
- `shared-cabin` — driver and passengers see different zones;
- `multi-crew` — several operators with different roles and authorities;
- `public-ambient` — anyone nearby sees the surface;
- `remote-observed` — a host or observer may see the session.

Privacy context determines default notification detail, redaction, passenger privacy and
whether personal content may appear on a shared surface (`LAW-020`).

### EP-04 — Display set

A list, not a single size:

| Sub-field | Values |
|---|---|
| Count | 1, 2, 3, or `n` with declared roles |
| Geometry | rectangular, rounded, ultra-wide, portrait, circular, non-rectangular, curved |
| Distance | near (0.2–0.5 m), arm (0.5–0.9 m), room (2–4 m), flight (0.5–0.8 m) |
| Density | compact, comfortable, spacious |
| Head-coupled | yes/no (spatial) |
| Occlusion | none, partial (steering wheel, helmet), variable |

When there is more than one display, each MUST have a declared **role** (primary,
secondary, cluster, HUD, passenger, redundancy, ambient) and a declared failure behaviour.

### EP-05 — Input set

Every input the device actually has, with exactly one primary and at least one fallback:

`touch`, `multi-touch`, `stylus`, `pointer`, `keyboard`, `hardware-keys`, `d-pad`,
`rotary-crown`, `scroll-wheel`, `voice`, `gaze`, `pinch`, `hand-tracking`, `physical-button`,
`procedure-key`, `remote-input`, `none`.

The profile MUST state which inputs work with gloves, which work without looking, and which
work one-handed. An input that exists but cannot complete a flow is not a primary input.

### EP-06 — Non-visual output

`speaker`, `headphones`, `bone-conduction`, `haptic-actuator`, `haptic-array`,
`audible-alarm`, `visual-alarm`, `none`. Each has a volume/strength range and a silence
policy. On S3/S4, an alarm MUST have at least two independent channels (for example visual
plus audible) unless a declared exception exists.

### EP-07 — Power and thermal

- Power source: battery (declared capacity class), mains, vehicle bus, spacecraft bus.
- Expected continuous session: minutes, hours, days.
- Thermal envelope: passive, fan, liquid, vacuum (radiative only).
- Declared power states: `active`, `idle`, `sleep`, `deep-sleep`, `safe-mode`, `off`.
- A device MAY refuse a task to protect power; it MUST say so (`ENV-STANDARD-PERF-06`).

### EP-08 — Network and connectivity

- Local-only capable: yes/no.
- Peer links: personal-area, local-network, vehicle-bus, crew-bus, internet, intermittent.
- Expected disconnection duration: seconds, minutes, hours, indefinite.
- Reconnection model: reconcile, never blind replay (`LAW-017`).

`Offline` is a normal declared state on every envelope. It is not an error colour.

### EP-09 — Session and identity

One of:

| Model | Description |
|---|---|
| `personal-continuous` | one person, device unlocked while worn/held |
| `personal-locked` | explicit unlock per session |
| `shared-account` | several people, per-user profiles |
| `role-authorised` | operator signs in with a role and authority scope |
| `kiosk` | fixed task, no personal identity |
| `headless` | no interactive identity; commissioned to an owner |
| `attached` | identity delegated by a paired host, revocable |

The session model determines lock, switching, notification privacy and what "sign out"
means. A headless device still has an owner and a revocation path.

### EP-10 — Safety class

`S0` informational · `S1` personal · `S2` environmental · `S3` vehicle · `S4` flight.
Defined fully in [`08-safety-and-criticality.md`](08-safety-and-criticality.md). The class
sets protected zones, alarm rules, determinism and the failure posture.

### EP-11 — Criticality and timing

- Hard real-time deadlines: none, soft (human-perceptible), firm (missed deadline degrades),
  hard (missed deadline is a hazard).
- Declared timing tolerance for safety feedback: e.g. `≤ 50 ms`, `≤ 100 ms`.
- Whether animation is allowed during a safety state: yes (bounded) / no.

### EP-12 — Environment

Each of glare, vibration, temperature, noise, moisture, gloves, helmet, acceleration is
declared `none`, `low`, `moderate`, `high`, with a consequence. Example: `vibration: high`
forces ≥ 44 px targets and forbids precision drag; `glare: high` forces a contrast floor
above WCAG minimum and forbids low-contrast status text.

### EP-13 — Failure tolerance and recovery budget

- Acceptable interruption: none, < 1 s, < 5 s, < 30 s.
- Recovery target: automatic, one action, procedure, service.
- Data-loss tolerance: none, last committed still, last checkpoint, declared.
- Whether the device can be rebooted while the task is live: yes/no.

### EP-14 — Adaptation posture

For each region (identity, navigation, content, context, actions, status), declare
`present`, `collapsible`, `absent`, or `peer`. This is the envelope's row in the region
matrix, made explicit, with a trigger and return path for every `collapsible` and a
preservation statement for every `peer`.

---

## 3. The ten profiles at a glance

| Field | Watch | Phone | Tablet | Desktop | TV | EV | Ship | IoT | Spatial | Remote |
|---|---|---|---|---|---|---|---|---|---|---|
| EP-01 | wrist | hand-held | lap/table | desk | living-room | vehicle-cabin | flight-deck | fixed | room-scale | remote-host |
| EP-02 | glance | transient | focused | focused | lean-back | operational | operational | ambient | transient/focused | focused |
| EP-03 | private | private | private/shared | private | shared-viewing | shared-cabin | multi-crew | public-ambient | private/room | remote-observed |
| EP-04 count | 1 | 1–2 | 1–2 | 1–3 | 1 | 3–6 | 3–6 | 0–1 | 2 (stereo) | 1 |
| EP-04 distance | near | near | arm | arm | room | arm | flight | variable | near/room | variable |
| EP-05 primary | touch+crown | touch | touch | keyboard+pointer | d-pad | touch+physical | physical+procedure | button | gaze+pinch | pointer+keyboard |
| EP-06 | haptic+speaker | haptic+speaker | speaker | speaker | speaker | speaker+haptic | audible+visual | buzzer/LED | speaker+haptic | host audio |
| EP-07 | battery days | battery day | battery day | mains | mains | vehicle bus | ship bus | mains/battery | battery hours | host |
| EP-08 | peer link | all | all | all | local+net | vehicle+net | crew-bus | local+net | local+net | internet |
| EP-09 | personal-continuous | personal-locked | personal/shared | shared-account | shared-account | role-authorised | role-authorised | headless | personal-locked | attached |
| EP-10 | S1 | S1 | S1 | S1 | S1 | S3 | S4 | S2 | S2 | S2 |
| EP-11 | soft | soft | soft | soft | soft | firm/hard | hard | soft | soft | soft |
| EP-12 | glare/motion | motion/glare | low | none | distance | glare/vibration | glare/vibration/gloves | none | motion | none |
| EP-13 | automatic | one action | one action | automatic | one action | procedure | procedure | automatic | one action | reconnect |

A cell is a **summary**, not the profile. Each envelope's `01-constraints.md` carries the
full declaration with ranges and consequences.

---

## 4. Profile-driven decisions

The profile MUST change composition in these ways:

| Profile fact | Forced decision |
|---|---|
| `glance` attention | one primary action per frame; no nested sheets deeper than one |
| `shared-viewing` | notification bodies redacted by default; no personal calendar detail |
| `shared-cabin` | driver zone and passenger zone declared; passenger content never enters driver zone |
| `multi-crew` | per-role authority; no silent mode change; cross-check prompts |
| `high glare` | contrast floor raised; no thin light text; no colour-only status |
| `high vibration` | minimum target 44 px; no precision drag; commit on release, not on move |
| `gloves` | physical controls preferred; capacitive targets ≥ 17.5 mm where used |
| `hard real-time` | no unbounded animation; fixed frame cadence; deterministic alarm ordering |
| `remote-observed` | observation indicator always visible; revocation one action away |
| `intermittent network` | local-first; queue with declared ceiling; no spinner that implies progress |

---

## 5. Envelope changes at runtime

An envelope MAY change while a session is live. Examples: a tablet gains a keyboard; a
phone projects to a car; a desktop display is unplugged; a spacecraft loses a display unit;
a spatial headset switches to passthrough.

**Rules.**

1. The platform MUST publish a new profile before the composition changes.
2. The app MUST preserve content, selection and scroll anchor across the change.
3. Focus MUST be restored to the nearest equivalent control, not to the first control.
4. If an input disappears, its in-flight gesture MUST be cancelled, not committed.
5. If a display disappears, its windows MUST move to a declared fallback display or to a
   recoverable state; they MUST NOT be silently destroyed.
6. If the safety class rises (for example a parked car begins moving), the higher class
   applies immediately and the composition MUST enter its driving mode in the same still.
7. A profile change MUST NOT fabricate a value that the new device cannot provide. It shows
   `NOT REPORTED` with the reason.

```text
Frame — Profile change: tablet docked
┌──────────────────────────────────────────────────────────────┐
│ TABLET · profile v12                                        │
├──────────────────────────────────────────────────────────────┤
│ CONTENT (unchanged, selection preserved)                     │
│                                                              │
│  ▸ Draft — paragraph 14 of 31                                │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│ INPUT  touch+pointer → keyboard+pointer+touch                │
│ STATUS docked · charging · keyboard connected                │
└──────────────────────────────────────────────────────────────┘
Focus: returns to the caret in paragraph 14, not to the editor root.
```

---

## 6. Profile honesty

The profile is a factual claim about hardware and context. It MUST NOT be cosmetic.

- A device MUST NOT claim an input it cannot deliver to the focused surface.
- A device MUST NOT claim `local-only capable: yes` if a core flow requires the network.
- A device MUST NOT claim `hard real-time` if its alarm path can be pre-empted by an app.
- A device MUST NOT hide a degraded sensor behind a plausible value (`LAW-011`).
- When a fact is unknown, the field is `NOT REPORTED` and the dependent surface degrades
  visibly.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-ENV-STANDARD-006` | Every envelope declares all fourteen fields with values or `NOT REPORTED` plus reason. |
| `AC-ENV-STANDARD-010` | Changing the profile at runtime preserves content, selection and focus equivalent, and applies a raised safety class in the same still. |
| `AC-ENV-STANDARD-011` | No app infers an envelope from viewport size alone. |
| `AC-ENV-STANDARD-012` | Every multi-display profile declares a role and a failure behaviour per display. |

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| 0.1.0 | 2026-10-22 | Initial fourteen-field profile and ten-envelope matrix. |
