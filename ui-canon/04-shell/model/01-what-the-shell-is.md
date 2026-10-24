---
id: SHELL-MODEL-WHAT
title: What the Shell Is and Is Not
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, ARCH-PRESENT-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-010, AC-SHELL-MODEL-011]
---

# What the Shell Is and Is Not

> The shell is the OS behaviour layer. It is not a compositor. It is not a window manager in
> the legacy sense. It does not own truth, pixels, or the screen. It owns **behaviour**: how a
> person moves between surfaces, how the OS speaks, and how the system stays honest.

---

## 1. What the shell is

The shell is the set of components, surfaces and rules that let a person:

1. **See what exists** — the strip (live stills), the status rail (facts), notifications
   (time-sensitive facts).
2. **Move between what exists** — gestures, shortcuts, spaces, the palette host, focus.
3. **Be spoken to by the OS** — notifications, lock screen, lifecycle, safety warnings.
4. **Control the OS** — lock, session, update, recovery, settings entry points.
5. **Compose their context** — spaces, multi-window, fullscreen.

It is the behaviour that survives any app being closed. It is the layer that makes the OS
feel like one system rather than a pile of windows.

The shell is **two things**, not one:

- **Mandatory system surfaces** that commit like any producer, at `system` elevation:
  status rail, strip host, lock screen, notification surface, palette host, on-screen
  keyboard host, permission prompt host. These exist on every envelope that needs them, in a
  form the envelope earns.
- **Optional policy** that advises placement, stacking, focus and arbitration. Present on
  desktop, phone, tablet, TV, EV, spaceship, spatial, remote browser. Absent on watch
  (minimal or none) and IoT (none). Absence is normal and declared (`LAW-006`,
  `LAW-011`).

---

## 2. What the shell is NOT

### 2.1 Not a compositor

A compositor owns outputs, arbitrates clients, and produces pixels. Naledzi's presentation
authority owns the truth; the executor produces pixels. The shell is neither. The shell is a
*producer* of system surfaces and an *advisor* (policy) of placement. It never scans out,
never allocates display buffers for clients, and never owns a DRM/KMS device.

Consequence: the shell can be replaced without changing the presentation contract. A new
shell policy speaks the same `plan` shape. The executor does not know it is a shell.

### 2.2 Not a window manager in the legacy sense

A legacy window manager (X11 WM, Wayland compositor-as-WM) owns window geometry, borders,
title bars, stacking, and the "active window" global. Naledzi has none of these as
permanent concepts:

- There is no "window" as a chrome-bearing object. There are **surfaces** with a declared
  placement hint and a declared elevation. Borders and title bars are not system chrome;
  they are app or component decisions.
- Stacking is a *plan* produced by optional policy, not a mutable scene graph owned by a
  single process.
- There is no global "active window". Focus is owned by the authority and named in the
  still (`model/04-focus.md`).
- Workspaces are **spaces** with named contexts and transitions, not virtual desktops that
  swap a set of windows (`spaces/`).

### 2.3 Not the presentation authority

The authority is mandatory and small and owns truth. The shell never says "the current
still is N." It commits system surfaces; the authority numbers them. Killing the shell
policy does not invalidate a still (`AC-ARCH-PRESENT-001`).

### 2.4 Not the app

The shell does not own domain state. It does not draw app content. It does not decide what
an app's primary action is. It provides the frame in which apps live and the system
surfaces that surround them.

### 2.5 Not a launcher in the legacy sense

There is no app grid as a permanent home. Apps are reached through the strip (live stills),
the palette (commands), and gestures. A launcher exists only where an envelope earns it
(e.g., TV home, watch app list) and is a surface, not a permanent bar (`LAW-010`).

---

## 3. The shell's invariants

1. **The shell never owns truth.** It produces inputs and plans; the authority numbers.
2. **The shell's system surfaces are commits.** They carry buffer, damage, present intent,
   fence, and optional semantics, like any producer (`ARCH-PRESENT-COMMIT`).
3. **The shell's policy is optional and replaceable.** Absence is normal; a default policy
   applies (`ARCH-PRESENT-POLICY` §6).
4. **The shell never draws app content.** It draws at `system` elevation only.
5. **The shell never blocks the system.** A shell crash leaves the authority, the stills and
   the executor intact; a new shell policy adopts the truth.
6. **The shell is honest.** Unknown state is `NOT REPORTED`; denied capability is visible;
   no fake aliveness (`LAW-011`).
7. **The shell is silent when idle.** Hidden strip costs zero; status rail updates on
   change; no heartbeat (`LAW-004`).

---

## 4. The shell's surfaces and their elevation

Every shell surface lives at `system` elevation (the highest). It is never occluded by app
content. Safety-critical indicators (EV speed, spaceship alarms) are additionally
protected: they never animate through an occluding path and have protected zones
(`ADR-0017`).

| Surface | Elevation | Always on? | Earned by |
|---|---|---|---|
| Status rail | system | adaptive (collapses) | every envelope that needs facts |
| Strip host | system | summoned | envelopes with switching |
| Notification surface | system | transient | all envelopes |
| Lock screen | system | when locked | all envelopes with lock |
| Palette host | system (overlay) | summoned | all envelopes |
| Permission prompt host | system (overlay) | transient | all envelopes |
| On-screen keyboard host | system (overlay) | when editing | touch envelopes |
| Safety indicators | system (protected) | always where needed | EV, spaceship |

---

## 5. What the shell reads and writes

**Reads:** numbered stills (for thumbnails, status facts), capability grants, session
identity, power/network/time facts, app command registries (for palette), app stills
(observation capability).

**Writes (commits):** system surfaces at `system` elevation; plans (policy); focus
candidate; capture-lease grants/revoke; space transitions; lock/unlock; session
start/end.

**Never writes:** app domain state, app buffers, the truth (still numbers), rendering
pixels.

---

## 6. Per-envelope form

The shell is one system, but its form is earned per envelope. The rule: a surface exists on
an envelope only if a person needs it there, and in the form the envelope's input, display
and safety allow. "Similar to phone" is a defect; each envelope is specified in its own
cells (`SHELL-INDEX` §3).

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-010` | A definition of the shell exists that distinguishes it from compositor, WM, authority and app, and is referenced by every other shell file. |
| `AC-SHELL-MODEL-011` | Killing the shell policy leaves stills intact; killing the authority fails honestly. |
| `AC-SHELL-MODEL-012` | No app draws at `system` elevation; the renderer rejects it. |
| `AC-SHELL-MODEL-013` | Every shell surface is a commit with buffer, damage, fence and present intent. |

---

## 8. References

- Wayland protocol and compositor model. https://wayland.freedesktop.org/docs/html/ — accessed 23 October 2026.
- ARINC 661, cockpit display system. https://www.arinc.com/ — accessed 23 October 2026.
- Norman, D. A. *The Design of Everyday Things*. Basic Books, 2013. ISBN 978-0465050659.
- Nielsen, J. *10 Usability Heuristics*. https://www.nngroup.com/articles/ten-usability-heuristics/ — accessed 23 October 2026.