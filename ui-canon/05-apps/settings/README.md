---
id: APP-SETTINGS
title: Settings
kind: app
entity: settings
status: review
normative: true
version: 0.1.0
owner: Settings and System Control Guild
depends: [APP-STANDARD, APP-ANATOMY, APP-STATE-MACHINE, APP-FLOW-SPEC, APP-A11Y, CANON-LAWS]
children: [01-purpose.md, 02-model.md, 03-behaviour.md, 04-anatomy.md, 05-layout.md, 06-input.md, 07-accessibility.md, 08-performance.md, 09-capabilities.md, 10-failure.md, 11-acceptance.md, 12-open-questions.md, 13-changelog.md, panes/, flows/, research/]
acceptance: [AC-SETTINGS-001, AC-SETTINGS-002, AC-SETTINGS-003]
---

# Settings

> Settings is where a person changes what the system does, sees what the system is doing,
> and gets back to a known state. It is the visible face of every contract that carries a
> user choice.

**Status: review.** The directory is authored to the completeness contract. It has not
passed the two-reviewer gate in [`08-process/05-review-gates.md`](../../08-process/05-review-gates.md),
so it MUST NOT be marked `canon` yet. The content, not the status, is the deliverable.

---

## 1. Definition

Settings is a **capability-scoped editor and observer of declared system facts**. It owns no
fact that another service owns. It composes a derived view of the settings each owning
service exposes, and it writes changes back through that service's contract.

It is an app in the sense of [`APP-STANDARD`](../_standard/README.md): a stateful view of a
domain, presented through the shared grammar. The domain is **configuration and control**,
not "a list of toggles".

One-sentence purpose: *let a person understand what their device is doing, change it safely,
and undo the change.*

---

## 2. What Settings is

| It is | Because |
|---|---|
| An **editor** of values whose owners are services | `LAW-001`: one fact, one owner. Settings is never the second owner. |
| An **observer** of live state | A person needs to see battery, storage, network and permission truth, not a copy that drifts. |
| A **search surface** over every setting, including settings the person cannot name | Findability, not tree memorisation. |
| A **permission and privacy surface** | Grants are visible, scoped, reviewable, revocable. |
| A **recovery surface** | Reset, rollback, repair and restore are first-class, not buried. |
| An **envelope-aware** app | A watch has no display resolution pane; a spaceship has no wallpaper pane. |

## 3. What Settings is not

| It is not | Because |
|---|---|
| The owner of theme, display, network, power or identity state | Each has a contract owner. Settings calls it. |
| A vendor settings tree reproduced from a legacy OS | `PROC-MASTER-BRIEF` §3.1: panes are derived from what the person can change. |
| A preference dump for every implementation detail | A control exists only if a person can form an intention about it. |
| A hidden admin console | Developer and operations controls are declared, gated and audited. |
| A second notification centre, file manager or app store | Cross-links go to the owning surface. |
| A place where destructive actions are one tap from a scroll | Destructive actions are separated, confirmed and reversible where possible (`LAW-015`). |
| A modal blocker during setup | The person can leave and return; nothing is lost. |

---

## 4. The pane registry

Panes are the navigation unit. A pane is a directory with the seven files defined in
[`panes/README.md`](panes/README.md). The registry is **derived from the capability surface
of the envelope plus the person's changeable facts**, not from a legacy tree.

| # | Pane | Slug | User question | Envelopes |
|---|---|---|---|---|
| 1 | Root and search | [`root-and-search`](panes/root-and-search/README.md) | Where do I start, and how do I find a setting? | all |
| 2 | Appearance | [`appearance`](panes/appearance/README.md) | How does the system look and feel? | phone, tablet, desktop, tv, ev, spatial, remote |
| 3 | Display | [`display`](panes/display/README.md) | How is this screen driven? | phone, tablet, desktop, tv, ev, spatial |
| 4 | Sound | [`sound`](panes/sound/README.md) | What do I hear, and what hears me? | all except iot-headless |
| 5 | Notifications | [`notifications`](panes/notifications/README.md) | What is allowed to interrupt me? | all |
| 6 | Privacy and security | [`privacy-and-security`](panes/privacy-and-security/README.md) | Who can see, hear, record and know what? | all |
| 7 | Network | [`network`](panes/network/README.md) | How is this device connected? | phone, tablet, desktop, tv, ev, spaceship, iot, spatial, remote |
| 8 | Bluetooth and devices | [`bluetooth-and-devices`](panes/bluetooth-and-devices/README.md) | What is paired, and what can it do? | phone, tablet, desktop, tv, ev, iot, spatial |
| 9 | Power and battery | [`power-and-battery`](panes/power-and-battery/README.md) | How long will it last, and what is it spending? | phone, tablet, desktop, watch, ev, iot, spatial, remote |
| 10 | Storage | [`storage`](panes/storage/README.md) | What is using space, and what can I remove? | phone, tablet, desktop, ev, spaceship, iot, spatial |
| 11 | Users and accounts | [`users-and-accounts`](panes/users-and-accounts/README.md) | Who can use this device, and as whom? | phone, tablet, desktop, tv, ev, spaceship, spatial |
| 12 | Apps | [`apps`](panes/apps/README.md) | What is installed, what may it do, and what is default? | phone, tablet, desktop, tv, ev, spatial |
| 13 | Accessibility | [`accessibility`](panes/accessibility/README.md) | How does the system adapt to my body and cognition? | all |
| 14 | Language and region | [`language-and-region`](panes/language-and-region/README.md) | What language, script, format and unit does it use? | all |
| 15 | Date and time | [`date-and-time`](panes/date-and-time/README.md) | What time is it, and how is it shown? | all |
| 16 | Keyboard | [`keyboard`](panes/keyboard/README.md) | What do the keys do, and how do I type my script? | desktop, tablet, ev, spaceship, remote |
| 17 | Pointer, touch and trackpad | [`pointer-touch-and-trackpad`](panes/pointer-touch-and-trackpad/README.md) | How does pointing behave? | desktop, tablet, phone, ev, spaceship |
| 18 | Displays and projection | [`displays-and-projection`](panes/displays-and-projection/README.md) | Where else can this screen go? | phone, tablet, desktop, tv, ev, spaceship, spatial |
| 19 | Updates | [`updates`](panes/updates/README.md) | What version am I on, and what comes next? | all |
| 20 | About | [`about`](panes/about/README.md) | What is this device, legally and materially? | all |
| 21 | Developer | [`developer`](panes/developer/README.md) | What is it doing, and how do I inspect it? | desktop, tablet, phone, ev, spaceship, iot, remote |
| 22 | Recovery and reset | [`recovery-and-reset`](panes/recovery-and-reset/README.md) | How do I get back to a working state? | all |
| 23 | Device pairing and continuity | [`device-pairing-and-continuity`](panes/device-pairing-and-continuity/README.md) | Which devices are mine, and what may they share? | all |
| 24 | Vehicle | [`vehicle`](panes/vehicle/README.md) | What is the vehicle doing? | ev only |
| 25 | Operations | [`operations`](panes/operations/README.md) | What is the ship doing, and what procedure applies? | spaceship only |
| 26 | IoT | [`iot`](panes/iot/README.md) | What is this device sensing and switching? | iot only |
| 27 | Spatial | [`spatial`](panes/spatial/README.md) | Where is my play space, and how comfortable is it? | spatial only |
| 28 | Remote access | [`remote-access`](panes/remote-access/README.md) | Who can drive this machine from elsewhere? | all |
| 29 | Backup and sync | [`backup-and-sync`](panes/backup-and-sync/README.md) | What is copied, where, and how do I get it back? | all |
| 30 | Default apps and protocols | [`default-apps-and-protocols`](panes/default-apps-and-protocols/README.md) | What opens this, and by what job? | phone, tablet, desktop, tv, ev, spatial |
| 31 | Telemetry and feedback | [`telemetry-and-feedback`](panes/telemetry-and-feedback/README.md) | What leaves the device, and can I see it? | all |

A pane that is absent on an envelope is declared absent in that pane's README and in
[`05-layout.md`](05-layout.md). It is never rendered disabled with no reason.

---

## 5. The directory tree

```text
settings/
├── README.md                      this manifest
├── 01-purpose.md                  the human need
├── 02-model.md                    settings model: scope, ownership, defaults, locks
├── 03-behaviour.md                search, change, apply, revert, sync, conflicts
├── 04-anatomy.md                  regions, layers, navigation, detail pane
├── 05-layout.md                   every envelope, density, text scaling, RTL
├── 06-input.md                    pointer, touch, keyboard, remote, voice, crown
├── 07-accessibility.md            semantics, focus, announcements, cognition
├── 08-performance.md              search, large trees, idle, memory
├── 09-capabilities.md             what Settings may read and change
├── 10-failure.md                  locked, denied, unsupported, corrupt, partial
├── 11-acceptance.md               ACs, golden flows, traceability
├── 12-open-questions.md           unresolved, owner, deadline
├── 13-changelog.md                history
├── panes/
│   ├── README.md                  the pane contract and index
│   ├── _schema.md                 the seven-file pane template
│   └── <31 pane directories>
├── flows/
│   ├── README.md                  flow index
│   └── 14 flow files, every frame drawn
└── research/
    └── 00-sources.md              evidence base with full citations
```

Absences: none. Every file listed exists.

---

## 6. Relationship to the system

```text
┌──────────────────────────────────────────────────────────────────┐
│ Settings (this app)                                              │
│  derived index · editor · preview · history view · recovery       │
│  writes through contracts       reads through contracts          │
└───────────────┬──────────────────────────────┬───────────────────┘
                │                              │
   ┌────────────▼───────────┐      ┌───────────▼──────────────────┐
   │ owning services        │      │ Settings store                │
   │ theme, display, audio, │      │ user/device preference values │
   │ network, power, user,  │      │ versioned, scoped, audited    │
   │ update, notification,  │      │ (not the owner of hardware or │
   │ access, device, ...    │      │  identity facts)              │
   └────────────────────────┘      └───────────────────────────────┘
```

The Settings **store** holds preference facts whose declared owner is the store itself:
per-user, per-device and per-app preference values, with version and provenance. It does
**not** mirror live hardware state. A battery percentage, a link speed or a monitor mode is
read from its owner at the moment of display and is labelled stale when the owner cannot
answer.

Contract citations:

- `protocol/schemas/settings.capnp:27-109` — the `Settings` interface: get/set, watch,
  bulk, per-app overrides, roaming profile, version, history, dependency, templates,
  encrypted values.
- `protocol/schemas/settings.capnp:160-179` — `SettingScope` and `ManagedPolicy`.
- `protocol/schemas/settings.capnp:236-266` — dependency and template structures.
- `uspace/servers/settings/src/main.rs:57-95` — the deployed service seeds only
  `system.hostname`; no persistence path exists in this service today.
- `uspace/servers/settings/src/store.rs:122-140` — fixed capacity: 8 domains, 8 keys per
  domain, 24 history entries, 4 templates, 8 dependencies, 8 overrides, 4 profiles.
- `services.toml` (`[services.settings]`, order 27) — settings-service is deployed.

The gap between the contract's ambition and the deployed store's capacity is recorded in
[`12-open-questions.md`](12-open-questions.md) as `OQ-SETTINGS-001` and `OQ-SETTINGS-002`.
It is not hidden by the UI design: the UI is specified for the contract, and the store must
grow to meet it.

---

## 7. Envelope scope

| Envelope | Settings exists | Composition | Notes |
|---|---|---|---|
| watch | yes | single-column list, crown scroll, one control per screen | no display/pointer panes |
| phone | yes | root list → pane stack; search at root | full |
| tablet | yes | rail + list + detail; search persistent | full |
| desktop | yes | rail + list + detail; multi-window allowed | full |
| tv | yes | focus rows, d-pad, 10-foot type | no keyboard-layout pane; pointer pane absent |
| ev | yes, speed-gated | driver: safety subset; parked/passenger: full | vehicle pane; NHTSA 2/12 rule |
| spaceship | yes, procedure-gated | operations pane, deterministic, no decorative motion | vehicle pane absent; ops pane required |
| iot | yes, thin | status + network + power + automation; often remote-rendered | no appearance/display panes |
| spatial | yes | floating panel, hand/eye focus, comfort | guardians, play space |
| remote browser | yes | executor-rendered; local-first semantics | no local hardware panes; scope shown |

An envelope that cannot render Settings at all (a headless IoT node with no surface) exposes
the same model through the remote-access pane and the CLI contract. Absence of a screen is
not absence of the setting; it changes the presentation.

---

## 8. How to read this directory

1. Start with [`01-purpose.md`](01-purpose.md) for the human need and non-goals.
2. Read [`02-model.md`](02-model.md) before any pane: scope, ownership, timing and locks are
   defined there and referenced everywhere else.
3. Read [`03-behaviour.md`](03-behaviour.md) for the change pipeline and search algorithm.
4. Use [`panes/`](panes/README.md) for the controls, defaults and failure of one area.
5. Use [`flows/`](flows/README.md) for every frame of the fourteen required journeys.
6. Use [`research/00-sources.md`](research/00-sources.md) for the evidence behind claims
   about human behaviour.

---

## 9. Status and evidence

| Claim | Evidence |
|---|---|
| Every pane has the seven required files | tree audit, [`panes/README.md`](panes/README.md) |
| Every control has default, range, scope, timing and reset | [`panes/_schema.md`](panes/_schema.md), `AC-SETTINGS-010` |
| Every flow has every frame | [`flows/README.md`](flows/README.md), `AC-SETTINGS-020` |
| Every setting is searchable by more than its label | [`03-behaviour.md`](03-behaviour.md) §4, `AC-SETTINGS-006` |
| No legacy app list is hardcoded | [`panes/apps/README.md`](panes/apps/README.md), portfolio dependency |
| Settings never owns another service's fact | [`02-model.md`](02-model.md) §2, `AC-SETTINGS-004` |

Acceptance summary: [`11-acceptance.md`](11-acceptance.md).
Open questions: [`12-open-questions.md`](12-open-questions.md).
