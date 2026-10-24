---
id: SHELL-MODEL-SURFACES
title: Surfaces — Windows, Surfaces, Stills and Cards
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, ARCH-PRESENT-INDEX, FOUND-DEPTH-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-030, AC-SHELL-MODEL-031]
---

# Surfaces

> A surface is a producer's declared, committed, numbered rectangle of truth. It is not a
> legacy window. It has no chrome by default, no title bar by inheritance, and no global
> identity beyond its surface ID and the still that contains it.

---

## 1. The four things people confuse

| Term | Meaning | Owner | Lifetime |
|---|---|---|---|
| **Surface** | A committed, numbered rectangle: pixels + hit map + accessibility + input ownership + buffer lifetime | The producer (app or shell) | Until closed or revoked |
| **Window** | A legacy chrome-bearing object with title bar, borders, min/max/close. **Not a Naledzi primitive.** | n/a | n/a — we do not have windows |
| **Still** | The atomic, versioned truth of an entire output: all surfaces, their order, focus, input ownership | Presentation authority | Until next commit |
| **Card** | A surface's live representation in the strip: a thumbnail still + title + state + badges | Strip (derived) | Commit-driven; frozen when app is not visible |

A surface is what an app or the shell *is*. A still is what the *output* is. A card is what
the *strip* shows. None of these is a window.

---

## 2. Surface anatomy

A surface declares, in its commit:

| Field | Meaning |
|---|---|
| `surface_id` | Stable ID for this surface's lifetime |
| `producer` | The producer (app or shell service) that owns it |
| `buffer` | Capability handle to the buffer (`LAW-002`) |
| `damage` | Declared dirty rects (`LAW-003`) |
| `present_intent` | When the producer wants it visible (`ARCH-PRESENT-PRESENT-INTENT`) |
| `fence` | Synchronisation fence |
| `placement_hint` | Declared placement intent: fullscreen, split, float, pip, tiling, spatial anchor |
| `elevation_request` | Requested elevation; authority clamps to legal levels; apps may not request `system` |
| `semantics` | Optional accessibility/semantic payload |
| `observation` | Whether it may be thumbnailed/captured (`LAW-020`) |

The authority validates the commit and assigns the still number. The surface does not choose
its still number.

---

## 3. Surface kinds

| Kind | Producer | Elevation | Notes |
|---|---|---|---|
| App surface | app | base/raised/floating/overlay (app-chosen, never system) | The app's content |
| System surface | shell | system | Status rail, strip host, lock, notification surface, palette host |
| Overlay surface | app or shell | overlay | Dialog, sheet, palette; owns focus when modal |
| Floating surface | app | floating | Popover, drag ghost, tooltip |
| Safety surface | shell (EV/spaceship) | system (protected) | Speed, range, alarms; never occluded |

An app may not create a `system`-elevation surface. The renderer and authority reject it
(`AC-SHELL-MODEL-012`).

---

## 4. Placement hints

A surface declares its intent; policy decides geometry. Hints:

| Hint | Meaning |
|---|---|
| `fullscreen` | Fill the output (subject to fullscreen behaviour: `fullscreen/`) |
| `maximised` | Fill the work area, leaving system surfaces |
| `split` | Share the work area with peers (ratio declared) |
| `tile` | Be placed in a tiling grid |
| `float` | Free position, optionally snapped |
| `pip` | Picture-in-picture: small, always-on-top (non-safety) |
| `spatial` | Anchored in 3D space (spatial envelope) |
| `background` | Behind other surfaces, non-interactive |

Hints are *intent*, not geometry. Two surfaces with `split` and ratios 1:1 and 1:2 produce
a plan; the policy decides the actual rects. The authority validates that the plan does not
violate safety zones.

---

## 5. Surface lifecycle

```text
   created ──► committed (first still) ──► visible ──► occluded ──► closed
                  │                          │            │
                  │                          │            └── still shows last frame
                  │                          └── input ownership may transfer
                  └── rejected ──► (named rejection, not a silent drop)
```

- A surface is not visible until its first commit is numbered into a still.
- A surface may be occluded (behind another) and still committed; its buffer lives until
  released (`ARCH-PRESENT-BUFFER-LIFETIME`).
- Closing releases the buffer and removes the surface from subsequent stills; the last
  still in which it appeared remains addressable for forensics.
- A crashed producer does not leave a stuck surface; the authority revokes its capabilities
  and removes it on the next policy pass (`LAW-015`).

---

## 6. Surface identity and reuse

A surface ID is stable for the surface's lifetime and is not reused. Reusing an ID would
make stills ambiguous and forensics impossible. A new surface (even for the same app in a
new window) gets a new ID.

---

## 7. Cards (strip representations)

A card is not a surface; it is the strip's view of a surface. It carries:

- a thumbnail (a still of the surface, commit-driven, not polled),
- title (from the surface's semantics),
- state (running, paused, loading, error, offline),
- badges (notifications, progress, attention),
- privacy flag (blanked or omitted if the app declares sensitivity).

Cards are derived. The strip holds an observation capability; revoking it blanks the card.
See `strip/`.

---

## 8. What the shell must never do with surfaces

1. Never keep a parallel copy of app content (`LAW-001`).
2. Never assume a surface exists because an app "should" have one (`LAW-011`).
3. Never draw chrome around a surface that the app did not declare.
4. Never reuse a surface ID.
5. Never let an app surface reach `system` elevation.

---

## 9. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-030` | A surface commit carries buffer, damage, present intent, fence, placement hint and elevation request; missing fields are named rejections. |
| `AC-SHELL-MODEL-031` | An app requesting `system` elevation is rejected with a named reason. |
| `AC-SHELL-MODEL-032` | Surface IDs are unique for the session; reuse is detected. |
| `AC-SHELL-MODEL-033` | A crashed producer's surface is removed on the next policy pass; no stuck pointer. |
| `AC-SHELL-MODEL-034` | Cards are commit-driven; a hidden strip costs zero messages. |