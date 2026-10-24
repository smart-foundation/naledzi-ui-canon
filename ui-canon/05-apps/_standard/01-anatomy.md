---
id: APP-ANATOMY
title: App Anatomy
kind: app
entity: _standard
status: canon
normative: true
version: 0.1.0
owner: Apps Guild
depends: [APP-STANDARD, LAW-007, LAW-010]
acceptance: [AC-APP-STANDARD-006]
---

# App Anatomy

> An app is a composition of regions, not a pile of screens. The regions are the same
> everywhere; the domain fills them.

---

## 1. The canonical frame

```
┌──────────────────────────────────────────────────────────────────────┐
│ IDENTITY        title · context · sync/status        actions  ⋯     │  raised / base
├──────────────────────────────────────────────────────────────────────┤
│ NAVIGATION      back · section set · breadcrumb · spaces             │  base
├───────────────┬──────────────────────────────────────────────────────┤
│ CONTEXT       │ CONTENT                                              │
│ (optional)    │                                                      │
│ list / tree   │ the task                                             │
│ inspector     │                                                      │
│               │                                                      │
├───────────────┴──────────────────────────────────────────────────────┤
│ ACTIONS         primary · secondary · destructive                    │  raised
├──────────────────────────────────────────────────────────────────────┤
│ STATUS          selection · progress · local warnings                │  base
└──────────────────────────────────────────────────────────────────────┘
```

Overlays (`floating`, `overlay`) sit above this frame and are never part of it. The system
rail and the strip are drawn by the system, outside the app's frame.

---

## 2. Regions

### 2.1 Identity

**Job.** Answer "what is this and where am I?" in one glance.

**Contents.** App name or icon, the current object or context, a sync or connection state
if relevant, and the overflow action.

**Rules.**

- The identity region is always the top-most region of the app frame.
- It may collapse to a single line on phone and watch.
- It never duplicates the system status rail. If the fact is global (time, battery,
  network), it belongs to the rail, not the app.
- It never shows a version number, a build hash or a marketing tagline in the product
  surface. Those belong in Settings → About.
- It never grows into a second toolbar. If actions multiply, they go to the action region
  or the palette.

**Failure.** If the context cannot be loaded, the identity region still shows the app and
the object's last known name, marked stale. It never shows a blank title.

---

### 2.2 Navigation

**Job.** Answer "how do I go back, and what peers can I move between?"

**Contents.** Back, a Section Set, a breadcrumb, a space switcher, or nothing.

**Rules.**

- Back is always the same gesture and the same key on a given envelope.
- A Section Set is the primitive; a tab bar is one rendering.
- Navigation never hides the primary content permanently. On a watch it may be a single
  crown-scroll affordance; on a TV it is a focusable row.
- Deep links land on a complete state, never on a loading shell with no context.
- The navigation region may be absent when there is nowhere to go. It is not replaced by a
  decorative title bar.

---

### 2.3 Content

**Job.** The task.

**Rules.**

- Content is the hero. It receives the largest area and the highest contrast.
- Content is never fully covered by chrome. Overlays may cover it temporarily, but the
  content remains the base layer.
- Empty, loading, error and denied states occupy the content region. They are not modals.
- Content scales with the envelope. It does not simply shrink; the layout recomposes (see
  [`04-envelope-adaptation.md`](04-envelope-adaptation.md)).
- Content has a declared scroll model: none, vertical, horizontal, two-axis, or paged. It
  is never "whatever the framework does".
- A virtualized list has a declared item height, a focus model and an end state.
- A canvas has a declared coordinate space, zoom range and reset.

---

### 2.4 Context

**Job.** Secondary information that helps the content without competing with it.

**Contents.** List/detail peer, tree, inspector, filters, related items, metadata.

**Rules.**

- The context region is optional.
- It is `raised` relative to content, never floating.
- On phone and watch it becomes a sheet or a separate frame, not a squeezed column.
- It never steals focus on open unless the user opened it deliberately.
- It collapses before content does when space is tight.
- It has a declared minimum width and a declared collapse order.

---

### 2.5 Actions

**Job.** What the user can do here.

**Contents.** One primary action, a small set of secondary actions, and an overflow.

**Rules.**

- Exactly one primary action per frame, or none if the content is directly manipulable.
- The primary action is a verb and names the outcome ("Save changes", not "OK").
- Destructive actions are never primary. They are separated, styled by role, and require
  confirmation or undo.
- Actions that are unavailable are shown disabled with a reason, or hidden with a
  discoverable explanation. They are never silently absent.
- Every action is also a command in the palette, with a stable ID.
- The action region collapses to an overflow menu before it wraps.
- On watch, the action region becomes one primary button or a crown-activated menu.
- On TV and remote, actions are focusable and reachable with the directional pad.

---

### 2.6 Status

**Job.** Local truth: selection, progress, sync, warnings, counts.

**Rules.**

- Status is local. Global facts belong to the system rail.
- Status never lies. Unknown is `NOT REPORTED` or an explicit "checking" state.
- Progress has a determinate and indeterminate form, and a cancel path if the operation is
  cancellable.
- A warning names the consequence and the recovery.
- Status is announced to assistive tech when it changes meaningfully, not on every tick.

---

## 3. Layers and elevation

| Layer | Elevation | Behaviour |
|---|---|---|
| Content | `base` | scrolls, receives direct manipulation |
| Navigation / identity | `base` or `raised` | stays, collapses, never floats |
| Context panel | `raised` | attached, resizable, collapsible |
| Card / drag ghost | `floating` | temporary, follows pointer/finger, casts shadow |
| Sheet | `overlay` | transient task, dismissible, traps focus |
| Dialog | `overlay` | blocking decision, rare, explicit |
| Palette | `overlay` | universal command surface |
| System rail / strip | `system` | never app-owned |

**Rules.**

- An app never draws at `system`.
- An app never uses a higher elevation than the job requires.
- A floating layer has a visible edge, a shadow and a dismissal path.
- An overlay dims what is behind it, but does not make it unreadable if the overlay is
  non-modal.
- Elevation animates with a spring when it changes
  ([`../../01-foundations/motion/`](../../01-foundations/motion/README.md)).

---

## 4. Persistent, transient and system

| Kind | Lifespan | Examples |
|---|---|---|
| **Persistent** | Until the user leaves the app | identity, navigation, content, context |
| **Transient** | Until the task ends | sheet, dialog, palette, card, toast |
| **System** | Owned by the OS | status rail, strip, lock, notifications |

A transient layer never becomes persistent by accident. A system layer is never styled to
look like an app layer.

---

## 5. Density

| Density | Spacing | Type | Secondary actions | Use |
|---|---|---|---|---|
| `compact` | 4/8/12 | smaller rhythm | in overflow | data-dense desktop, watch lists |
| `comfortable` | 8/16/24 | default | visible | phone, tablet, desktop |
| `spacious` | 12/24/40 | larger rhythm | visible, fewer | media, focus modes, accessibility |

Rules:

- Density changes spacing, type rhythm and action visibility. It never changes the
  information architecture.
- A dense screen must still meet target-size and contrast rules.
- A spacious screen must still expose every action (in overflow if necessary).
- Density is per window, not per app globally, and can be changed without restart.

---

## 6. The "one primary intent" rule

Every frame has one primary intent. It is the thing the user most likely came to do.

- If the frame is a list, the primary intent is selection or opening, not a toolbar action.
- If the frame is an editor, the primary intent is editing, not saving.
- If the frame is a player, the primary intent is play/pause, not settings.
- If the frame is a form, the primary intent is submit, and it is the only primary action.

If two intents compete, the frame is doing too much. Split it.

---

## 7. What an app never draws

- The system status rail, the strip, the lock screen or the notification centre.
- A second title bar that duplicates the identity region.
- A permanent hamburger menu that hides all navigation on a wide screen.
- A floating action button that duplicates a visible primary action.
- A modal loading spinner.
- A fake skeleton that never resolves.
- A "close" button on a full-screen app that has no window to close.
- A theme switcher inside the app; theme belongs to Settings.
- A version number or build hash in the product surface.

---

## 8. The anatomy test

A frame passes the anatomy test when:

1. A stranger can point to the identity, navigation, content, actions and status within
   five seconds.
2. Removing any region does not make the frame ambiguous.
3. The primary intent is obvious without reading every label.
4. The elevation of every layer matches its job.
5. The frame survives a 40 mm watch and a 1.5 m TV without a different information
   architecture.
6. Every region has a declared behaviour when empty, loading, errored or denied.
