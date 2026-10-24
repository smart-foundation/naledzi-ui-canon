---
id: SHELL-MODEL-FOCUS
title: Focus — Ownership, Rings, Restoration and Cross-Device
kind: shell
entity: model
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-MODEL-INDEX, ARCH-PRESENT-INDEX, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-MODEL-040, AC-SHELL-MODEL-041]
---

# Focus

> Focus is owned by the presentation authority and named in the still. It is not a global
> variable, not a per-app guess, and not a pointer position. The shell's job is to decide
> *which surface* should receive focus when several are eligible, and to restore it when
> the context changes.

---

## 1. What focus is

Focus is **input ownership made visible**. The still names:

- the focused surface,
- the focused element within it (if any),
- the focus ring geometry,
- the input ownership (keyboard, pointer, remote, voice).

Focus and input ownership are committed together in the same still (`LAW-005`). There is no
moment when the ring points at one thing and keystrokes go to another.

---

## 2. Ownership

| Component | Owns |
|---|---|
| Presentation authority | The fact of focus: which surface, which element, in which still |
| Shell policy | The *candidate* when several surfaces are eligible (advisory) |
| App | Focus within its own surface (order, traversal, restoration) |
| Accessibility | The derived announcement of focus changes |

The shell policy may propose a focus candidate; the authority validates and commits. An app
may not move focus to another surface; it moves focus within its own surface and requests
a surface focus change through the contracted surface API.

---

## 3. Focus rings

A focus ring is a visual affordance at `raised` or `floating` elevation above the focused
element, with:

- a declared colour from the token system (not a hardcoded value),
- a declared thickness that survives 200% text and high contrast,
- a motion that explains the move (a spring, bounded, reduced-motion-aware),
- a non-visual equivalent (announcement, haptic where available).

Rules:

1. Focus is **always visible** on envelopes that use directional input (TV, EV, spatial,
   keyboard). On pointer-first envelopes, the ring appears on keyboard navigation and
   persists until pointer use.
2. Focus never disappears without a replacement. Losing focus without a new owner is a
   defect (`AC-APP-INPUT-005`).
3. Focus ring colour is never the only carrier of focus; shape and position also encode it
   (`FOUND-DEPTH-002`).
4. Reduced motion removes travel but keeps the state change.

---

## 4. Restoration

Focus must be restorable:

1. **Within a surface:** when a transient layer (sheet, dialog, palette) closes, focus
   returns to the element that opened it. If that element is gone, focus moves to the
   nearest declared fallback, never to an arbitrary element.
2. **Across surfaces:** when a surface is closed or occluded, focus moves to the next
   eligible surface in the policy's order; if none, to the system (strip host).
3. **Across spaces:** when switching spaces, focus is saved per space and restored on
   return. A space with no saved focus focuses its default entry point.
4. **After a crash or restart:** focus is restored to the last committed focus in the
   restored still, or to a declared default if the focused element no longer exists.
5. **Cross-device:** when a session moves to another device (handoff), focus is
   transferred as part of the session state; the receiving device restores it or declares
   a default. See `spaces/05-cross-device.md` and `notifications/07-cross-device.md`.

Restoration is a property of the still, not of app memory. An app that tracks focus in its
own state duplicates the authority and violates `LAW-001`.

---

## 5. Cross-device focus

When a session continues on another device:

- The focused surface and element are part of the session snapshot.
- The receiving device applies them if the surface and element exist there; otherwise it
  focuses a declared default and announces the change.
- Focus never silently jumps to a different task on the receiving device.
- If the receiving device cannot host the surface (e.g., watch cannot host a desktop
  editor), the surface is not shown and focus lands on a declared fallback with an
  announcement.

---

## 6. Focus and modality

- A modal layer (dialog, permission prompt, lock) traps focus within itself until
  resolved. Trapping is declared, not implicit.
- A non-modal layer (popover, sheet that is dismissible, palette) does not trap focus;
  focus may leave it, and it dismisses on outside action.
- Fullscreen non-modal apps do not trap focus (`fullscreen/04-focus-and-input.md`).
- The strip, when summoned, moves focus into the reel; releasing it restores focus to the
  previous surface.

---

## 7. Focus and accessibility

- Every focus change is announced to assistive tech in the same still.
- Focus order is specified per flow (`05-apps/_standard/06-accessibility.md`).
- A screen reader user can complete every flow without a pointer.
- Focus is never lost on any input path (`AC-APP-INPUT-005`).

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-MODEL-040` | Focus is named in the still; pixels and hit map agree with it in every frame. |
| `AC-SHELL-MODEL-041` | Transient layer close restores focus to the opener or a declared fallback. |
| `AC-SHELL-MODEL-042` | Space switch saves and restores focus per space. |
| `AC-SHELL-MODEL-043` | Crash/restart restores focus to the last committed focus or a declared default. |
| `AC-SHELL-MODEL-044` | Cross-device handoff transfers focus or declares a fallback with announcement. |
| `AC-SHELL-MODEL-045` | Non-modal fullscreen does not trap focus. |