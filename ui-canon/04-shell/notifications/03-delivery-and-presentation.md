---
id: SHELL-NOTIF-DELIVERY
title: Notifications — Delivery and Presentation
kind: shell
entity: notifications
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-NOTIF-PRIORITY, SHELL-NOTIF-MODEL, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX]
acceptance: [AC-SHELL-NOTIF-030]
---

# Notifications — Delivery and Presentation

---

## 1. Delivery forms

| Form | When | Interrupts? |
|---|---|---|
| Banner | top/bottom edge transient card | yes if priority allows |
| Badge | count on app card / status rail | no |
| Sound | audio cue | yes if priority allows |
| Haptic | tactile cue | yes if priority allows |
| Lock-screen entry | shown on lock screen | no new interruption |
| History entry | always recorded | no |

## 2. Presentation rules

- **SHELL-NOTIF-031.** A banner MUST appear at `floating` elevation, never occlude a
  safety indicator, and auto-dismiss after a declared timeout (default 5 s) unless it
  requires action.
- **SHELL-NOTIF-032.** Banners MUST be coalesced when several arrive together: show the
  highest priority, with a count of the rest, expandable.
- **SHELL-NOTIF-033.** A banner MUST be dismissible by swipe/click/Escape and MUST NOT
  reappear unless the fact changes.
- **SHELL-NOTIF-034.** Sound and haptic MUST respect the device's sound/haptic settings
  and quiet hours; `critical` may override quiet hours for safety only.
- **SHELL-NOTIF-035.** On TV, banners are readable at 3 m and dismissible with Back.
- **SHELL-NOTIF-036.** On EV, banners never occlude protected zones; non-safety
  banners are suppressed while driving.
- **SHELL-NOTIF-037.** On spaceship, banners are replaced by procedure-list entries;
  no pop-up interrupts a procedure.
- **SHELL-NOTIF-038.** Grouped notifications from the same origin collapse into one
  banner with a count; expanding shows the list.

## 3. Motion

Banner enter/exit uses a named spring (`FOUND-MOTION`), settle-and-stop, with a
reduced-motion alternative (instant appear/disappear, state change announced).

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-NOTIF-030` | Banner never occludes a safety indicator. |
| `AC-SHELL-NOTIF-031` | Banners coalesce and do not reappear after dismiss. |
| `AC-SHELL-NOTIF-032` | Sound/haptic respect quiet hours except critical safety. |
| `AC-SHELL-NOTIF-033` | Reduced motion removes travel. |