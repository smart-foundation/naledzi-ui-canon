---
id: PORTFOLIO-BOUNDARIES
title: Shell and System Boundaries — What Is Not an App
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-REJECTIONS, CANON-LAWS, APP-STANDARD, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-BOUNDARIES-001, AC-PORTFOLIO-BOUNDARIES-002, AC-PORTFOLIO-BOUNDARIES-003]
---

# Shell and System Boundaries — What Is Not an App

> An app is a capability-scoped, stateful view of a domain (`APP-STANDARD` §1). Anything
> that is OS-owned, universal, or has no domain of its own is not an app, even if a
> legacy OS ships it as one. This file is the boundary. If a surface is listed here, it
> is specified under `04-shell/` or `02-architecture/`, not under `05-apps/`.

---

## 1. The test

A surface is **not an app** when any of the following is true:

1. It is the single owner of a fact that other surfaces depend on (`LAW-001`): output,
   stills, focus, session, capability grants.
2. It is universal across all apps on an envelope: status rail, strip, palette, gestures.
3. It has no domain of its own; it is a view of system state, not of user data.
4. It is mandatory for the OS to function; killing it breaks the screen, not a task.
5. It is a lifecycle surface (boot, lock, update, recovery) owned by the session, not
   by a domain.

A surface that passes none of these is an app candidate and goes through the admission
test.

---

## 2. The boundary list

### B-01 — Lock screen

- **Kind.** system surface.
- **Owner.** Session / identity service.
- **Job.** Protect the device and its data; establish who is using it.
- **Why not an app.** It is the gate to every app; it owns session state. An app cannot
  draw at `system` elevation.
- **Envelope notes.** Watch/phone/tablet/desktop/TV/EV/spatial: present. IoT: physical
  presence / commissioning state instead. Spaceship: procedure-gated.

### B-02 — Command palette / search

- **Kind.** system surface (foundation).
- **Owner.** Framework palette + shell.
- **Job.** Name what you want; universal command surface. Score 20 on the timelessness
  test (`CANON-TIMELESSNESS` §4.3).
- **Why not an app.** It is a foundation, not a domain. Every app exposes its commands
  to it. It is OS-owned and universal.
- **Envelope notes.** Present on all envelopes that have text input; on watch it is a
  crown-scroll list; on TV it is a focusable row.

### B-03 — Strip (switcher + launcher)

- **Kind.** system surface.
- **Owner.** Shell.
- **Job.** Switch, resume, launch. Transformed dock (score 9 → transform).
- **Why not an app.** It is the transformed dock; OS-owned; summon-only; no permanent
  chrome (`LAW-010`).
- **Envelope notes.** Present where multi-app or multi-state switching exists; on watch
  it is a single summonable reel.

### B-04 — Status rail

- **Kind.** system surface.
- **Owner.** Shell.
- **Job.** Global facts: time, battery, network, safety indicators.
- **Why not an app.** Global facts belong to the rail, not to any app (`APP-ANATOMY`
  §2.1). Adaptive; collapses per envelope.
- **Envelope notes.** Present on all envelopes; content varies (safety indicators on EV/
  spaceship are protected and never animate through occlusion).

### B-05 — Notifications (delivery and attention)

- **Kind.** system surface.
- **Owner.** Shell notifications + attention manager.
- **Job.** Deliver what interrupted; manage attention budget; quiet hours.
- **Why not an app.** Attention is an OS resource (`LAW-020`). There is no
  "notification centre app"; history is a view within the system surface.
- **Envelope notes.** Present on all envelopes; on IoT it is an ambient indicator or
  peer-only.

### B-06 — Settings (the app) vs settings (the tree)

- **Kind.** The `settings` app is admitted (`04-candidate-portfolio.md` #24). The
  *vendor settings tree* is rejected (`05-rejections.md` R-03).
- **Boundary.** The app owns the editor and observer of declared system facts. It does
  not own any fact; it writes through contracts. The tree is derived from changeable
  facts, not inherited.

### B-07 — Permission prompts

- **Kind.** system surface.
- **Owner.** Capability manager.
- **Job.** Grant, deny, review and revoke capabilities.
- **Why not an app.** Capability grants are OS-owned and must be consistent across
  apps. A prompt is a system overlay at `system` elevation.
- **Envelope notes.** Present on all envelopes; on watch it is a glanceable confirm;
  on EV/spaceship it is safety-gated.

### B-08 — Onboarding

- **Kind.** shell surface + cross-app flow.
- **Owner.** Shell lifecycle.
- **Job.** First success without a manual (`RES-LEA-012`).
- **Why not an app.** First-run is a shell lifecycle surface, not a domain. It
  composes apps and shell surfaces.
- **Envelope notes.** Present on all envelopes; on IoT it is commissioning.

### B-09 — Updates and recovery

- **Kind.** system surface.
- **Owner.** Lifecycle service.
- **Job.** Keep the system working; get back to a known state.
- **Why not an app.** Lifecycle, not a domain. Recovery is an OS responsibility.
- **Envelope notes.** Present on all envelopes; on spaceship it is procedure-gated.

### B-10 — Home / idle

- **Kind.** shell surface.
- **Owner.** Shell.
- **Job.** Resume or start what matters; rest.
- **Why not an app.** The resume/start job is served by the strip + launcher. There is
  no "home screen app"; idle is a shell state (`LAW-004`).
- **Envelope notes.** Present on all envelopes; on watch it is the glance surface.

### B-11 — Quick settings / control centre

- **Kind.** system surface (or a view of the `settings` app).
- **Owner.** Shell + settings.
- **Job.** Change the most common settings without opening Settings.
- **Why not an app.** It is a summonable overlay over system facts; it writes through
  the settings contracts. It may be a view of the `settings` app, not a separate app.

### B-12 — Multi-window / spaces

- **Kind.** shell surface.
- **Owner.** Shell policy (optional app).
- **Job.** Arrange workspaces.
- **Why not an app.** Placement and arbitration are policy, which is optional
  (`LAW-006`). The shell owns the stills; policy owns the arrangement.

### B-13 — Fullscreen behaviour

- **Kind.** declared behaviour of an app or surface, not a surface itself.
- **Owner.** The app declares; the shell enforces.
- **Why not an app.** Fullscreen is a declared behaviour, not a hidden mode
  (`PROC-MASTER-BRIEF` §2). It specifies what happens to the status rail, strip,
  notifications, gestures, focus, multi-window and safety zones.

---

## 3. The app vs shell test (worked)

| Surface | App? | Reason |
|---|---|---|
| Calculator | Yes | Domain (compute) with state and buffer. |
| Status rail | No | Global facts; OS-owned. |
| Settings app | Yes | Domain (configuration) with state. |
| Settings tree | No | Rejected form; folded into the app. |
| Notifications app | No | Attention is an OS resource. |
| Strip | No | Transformed dock; OS-owned. |
| Palette | No | Foundation; universal. |
| Lock | No | Session; OS-owned. |
| Onboarding | No | Shell lifecycle. |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-BOUNDARIES-001` | Every shell surface named in the master brief appears in §2. |
| `AC-PORTFOLIO-BOUNDARIES-002` | No surface listed here is specified as an app under `05-apps/`. |
| `AC-PORTFOLIO-BOUNDARIES-003` | Every app candidate passes the app test in §1 (none of the five conditions). |