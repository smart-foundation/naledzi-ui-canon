---
id: WF-SPACIOUS-FRAMES
title: Spacious — Full OS Frames
kind: wireframe
entity: spacious
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-SPACIOUS, UX-PERCEPTION, UX-COGNITION, UX-MOTOR, UX-ACCESSIBILITY, FOUND-EXPERIENCE-INDEX, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX, FOUND-COLOR-INDEX, WF-SPACIOUS-INDEX, WF-SPACIOUS-PRINCIPLES, WF-SPACIOUS-ADAPTATION]
supersedes: []
superseded_by: []
acceptance: [AC-WF-SPACIOUS-020, AC-WF-SPACIOUS-021, AC-WF-SPACIOUS-022, AC-WF-SPACIOUS-023]
---

# Spacious — Full OS Frames

> Every OS frame in spacious density, drawn. State, focus, content, action, transition and
> announcement are stated for every frame. A frame that is not drawn is not specified. A
> frame that says "similar to" is a defect.

**How to read this file.** Frames are grouped by surface. Within a surface, one frame is
drawn per envelope, because spacious density renders differently on a 40 mm watch than on
a 1.5 m TV. Where a surface is genuinely absent on an envelope, the absence is declared
with a reason (`n/a — reason`), not skipped.

**Legend.** `▸` = keyboard/screen-reader focus start. `[▸ label]` = focused control.
`⋯` = overflow. `SHEET` = nested sheet. `E0..E4` = elevation level. Targets are drawn at
spacious size; counts respect the spacious action budget in
`01-principles.md` §4.

---

## Surface 1 — Boot

Boot in spacious density is the compact boot frame with increased spacing and a larger
progress affordance. The boot sequence does not change; only the density of the chrome.

### Frame 1 — Boot, watch (spacious)

```text
┌────────────────────────────┐
│                            │
│                            │
│           Naledzi          │
│                            │
│            ◌  ◌  ◌          │
│                            │
│                            │
└────────────────────────────┘
```

- **State:** `boot.initialising`, density = spacious (carried from last session or
  default).
- **Focus:** none (boot has no interactive element).
- **Content:** wordmark, indeterminate progress. No version, no detail.
- **Action:** none; the system proceeds.
- **Transition:** on ready, go to Frame (Home, watch, spacious).
- **Announce:** "Naledzi, starting."

### Frame 2 — Boot, phone (spacious)

```text
┌──────────────────────────────────────┐
│                                      │
│                                      │
│                                      │
│              Naledzi                 │
│                                      │
│                  ◌  ◌  ◌             │
│                                      │
│                                      │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `boot.initialising`.
- **Focus:** none.
- **Content:** wordmark, progress. Larger outer margin than compact.
- **Action:** none.
- **Transition:** on ready, go to Home.
- **Announce:** "Naledzi, starting."

### Frame 3 — Boot, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│                                                    │
│                                                    │
│                                                    │
│                      Naledzi                       │
│                                                    │
│                          ◌  ◌  ◌                   │
│                                                    │
│                                                    │
│                                                    │
└────────────────────────────────────────────────────┘
```

- **State:** `boot.initialising`.
- **Focus:** none.
- **Content:** wordmark, progress, centred.
- **Action:** none.
- **Transition:** on ready, go to Home.
- **Announce:** "Naledzi, starting."

### Frame 4 — Boot, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│                                                                    │
│                                                                    │
│                            Naledzi                                 │
│                                                                    │
│                                ◌  ◌  ◌                             │
│                                                                    │
│                                                                    │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `boot.initialising`.
- **Focus:** none.
- **Content:** wordmark, progress.
- **Action:** none.
- **Transition:** on ready, go to Home / login.
- **Announce:** "Naledzi, starting."

### Frame 5 — Boot, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│                                                                          │
│                                                                          │
│                              Naledzi                                     │
│                                                                          │
│                                  ◌  ◌  ◌                                 │
│                                                                          │
│                                                                          │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `boot.initialising`.
- **Focus:** none.
- **Content:** 10-foot wordmark, progress; high contrast.
- **Action:** none.
- **Transition:** on ready, go to Home.
- **Announce:** "Naledzi, starting."

### Frame 6 — Boot, EV (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE — speed, warnings]                                 │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│                                                                    │
│                            Naledzi                                 │
│                                                                    │
│                                ◌  ◌  ◌                             │
│                                                                    │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `boot.initialising`.
- **Focus:** none.
- **Content:** wordmark, progress; protected zone untouched.
- **Action:** none.
- **Transition:** on ready, go to Home.
- **Announce:** "Naledzi, starting."
- **Safety:** protected zone is never covered by boot chrome (EV envelope rule).

### Frame 7 — Boot, spaceship (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [REDUNDANT DISPLAY A]                                              │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│                            Naledzi                                 │
│                                                                    │
│                                ◌  ◌  ◌                             │
│                                                                    │
│ [REDUNDANT DISPLAY B]                                              │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `boot.initialising`, deterministic timing.
- **Focus:** none.
- **Content:** wordmark, progress; redundant display status.
- **Action:** none.
- **Transition:** on ready, go to Home.
- **Announce:** "Naledzi, starting."

---

## Surface 2 — Home

Home in spacious density shows fewer items per row, larger touch targets, calmer
grouping and more outer margin. The information architecture is identical to compact:
same regions, same items, same order.

### Frame 8 — Home, watch (spacious)

```text
┌────────────────────────────┐
│ 09:41          ◎ 100%      │
├────────────────────────────┤
│                            │
│        ┌──────────┐        │
│        │  Calendar │        │
│        │  14:00    │        │
│        └──────────┘        │
│                            │
│        ┌──────────┐        │
│        │  Messages │        │
│        │  3 new    │        │
│        └──────────┘        │
│                            │
│           ▸ [ Home ]        │
└────────────────────────────┘
```

- **State:** `home.ready`, density = spacious.
- **Focus:** `Home` crown affordance.
- **Content:** two cards, one primary action. Crown scroll for more.
- **Action:** crown scroll for more cards; tap a card to open.
- **Transition:** on card tap, go to App frame (watch).
- **Announce:** "Home. Calendar, 14:00. Messages, 3 new."

### Frame 9 — Home, phone (spacious)

```text
┌──────────────────────────────────────┐
│ 09:41                       ◎ 100%  │
├──────────────────────────────────────┤
│                                      │
│   ┌────────────────────────────┐     │
│   │  Calendar                  │     │
│   │  Next: 14:00 — Review      │     │
│   └────────────────────────────┘     │
│                                      │
│   ┌────────────────────────────┐     │
│   │  Messages                  │     │
│   │  3 new from 2 people       │     │
│   └────────────────────────────┘     │
│                                      │
│   ┌────────────────────────────┐     │
│   │  Notes                     │     │
│   │  2 edited today            │     │
│   └────────────────────────────┘     │
│                                      │
│   ┌────────────────────────────┐     │
│   │  Files                     │     │
│   │  12 items                  │     │
│   └────────────────────────────┘     │
│                                      │
│   ▸ [ Home ]  [ Search ]  [ More ]   │
└──────────────────────────────────────┘
```

- **State:** `home.ready`, spacious.
- **Focus:** `Home`.
- **Content:** four cards, three bottom actions (within thumb reach).
- **Action:** tap card to open; tap Search to open palette; tap More for the sheet.
- **Transition:** on More, go to Home More sheet.
- **Announce:** "Home. 4 items. Search. More."

### Frame 10 — Home, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│ 09:41                                    ◎ 100%   │
├────────────────────────────────────────────────────┤
│                                                    │
│   ┌──────────────┐   ┌──────────────┐             │
│   │  Calendar     │   │  Messages     │             │
│   │  Next 14:00   │   │  3 new       │             │
│   └──────────────┘   └──────────────┘             │
│                                                    │
│   ┌──────────────┐   ┌──────────────┐             │
│   │  Notes        │   │  Files       │             │
│   │  2 today      │   │  12 items    │             │
│   └──────────────┘   └──────────────┘             │
│                                                    │
│   ┌──────────────┐   ┌──────────────┐             │
│   │  Photos       │   │  Settings    │             │
│   │  48 new       │   │              │             │
│   └──────────────┘   └──────────────┘             │
│                                                    │
│   ▸ [ Home ]  [ Search ]  [ Spaces ]  [ More ]     │
└────────────────────────────────────────────────────┘
```

- **State:** `home.ready`, spacious.
- **Focus:** `Home`.
- **Content:** six cards in two columns; four bottom actions.
- **Action:** tap card; tap More for overflow.
- **Transition:** on More, go to Home More sheet.
- **Announce:** "Home. 6 items."

### Frame 11 — Home, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ 09:41                                               ◎ 100%        │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐   │
│   │  Calendar   │  │  Messages  │  │  Notes     │  │  Files     │   │
│   │  Next 14:00 │  │  3 new     │  │  2 today   │  │  12 items  │   │
│   └────────────┘  └────────────┘  └────────────┘  └────────────┘   │
│                                                                    │
│   ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐   │
│   │  Photos     │  │  Settings  │  │  Browser   │  │  Clock     │   │
│   │  48 new     │  │            │  │            │  │            │   │
│   └────────────┘  └────────────┘  └────────────┘  └────────────┘   │
│                                                                    │
│   ▸ [ Home ]  [ Search ]  [ Spaces ]  [ More ]  [ … ]              │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `home.ready`, spacious.
- **Focus:** `Home`.
- **Content:** eight cards; actions at bottom, overflow in `…`.
- **Action:** tap card; `…` opens the full list.
- **Transition:** on `…`, go to Home all-items sheet.
- **Announce:** "Home. 8 items shown. More available."

### Frame 12 — Home, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│ 09:41                                                            ◎     │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│       ┌──────────────┐   ┌──────────────┐   ┌──────────────┐             │
│       │  Calendar     │   │  Messages     │   │  Notes        │             │
│       │  Next 14:00   │   │  3 new       │   │  2 today     │             │
│       └──────────────┘   └──────────────┘   └──────────────┘             │
│                                                                          │
│       ┌──────────────┐   ┌──────────────┐   ┌──────────────┐             │
│       │  Files        │   │  Photos       │   │  Settings     │             │
│       │  12 items     │   │  48 new      │   │              │             │
│       └──────────────┘   └──────────────┘   └──────────────┘             │
│                                                                          │
│       ▸ [ Home ]     [ Search ]     [ More ]                             │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `home.ready`, spacious, 10-foot.
- **Focus:** `Home` (D-pad).
- **Content:** six large cards; large type; high contrast.
- **Action:** D-pad to move; Enter to open; Back exits.
- **Transition:** on Enter, go to App frame (TV).
- **Announce:** "Home. 6 items. Use arrows to move."

### Frame 13 — Home, EV centre stack (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE — speed 60, battery, warnings]                     │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────────────┐   ┌────────────────────────────┐ │
│   │  Navigation                │   │  Media                     │ │
│   │  Route: Home, 12 min       │   │  Now playing               │ │
│   └────────────────────────────┘   └────────────────────────────┘ │
│                                                                    │
│   ┌────────────────────────────┐   ┌────────────────────────────┐ │
│   │  Climate                   │   │  Phone                     │ │
│   │  21 °C                     │   │  3 missed                  │ │
│   └────────────────────────────┘   └────────────────────────────┘ │
│                                                                    │
│   ▸ [ Home ]  [ Voice ]  [ More ]                                  │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `home.ready`, spacious, EV.
- **Focus:** `Home`.
- **Content:** four cards in the centre stack; protected zone untouched.
- **Action:** tap card; voice control first-class.
- **Transition:** on card tap, go to App frame (EV).
- **Announce:** "Home. 4 items."
- **Safety:** no card covers the protected zone.

### Frame 14 — Home, spaceship primary display (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [DISPLAY A — nominal]  [DISPLAY B — nominal]                       │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────────────┐   ┌────────────────────────────┐ │
│   │  Procedure                 │   │  Telemetry                 │ │
│   │  Step 3 of 12              │   │  O₂ 21.0 %                 │ │
│   └────────────────────────────┘   └────────────────────────────┘ │
│                                                                    │
│   ┌────────────────────────────┐   ┌────────────────────────────┐ │
│   │  Alarms                    │   │  Comms                     │ │
│   │  0 active                  │   │  Channel 4                 │ │
│   └────────────────────────────┘   └────────────────────────────┘ │
│                                                                    │
│   ▸ [ Procedure ]  [ Ack ]  [ More ]                               │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `home.ready`, spacious, spaceship.
- **Focus:** `Procedure`.
- **Content:** four cards; redundant display status; bounded motion only.
- **Action:** follow procedure; Ack acknowledges an alarm.
- **Transition:** on Ack, go to Alarm acknowledge flow.
- **Announce:** "Home. Procedure step 3 of 12. No active alarms."

---

## Surface 3 — App frame

The app frame in spacious density: one primary content region, larger targets, calmer
chrome, fewer visible actions. The app's state machine is unchanged.

### Frame 15 — App frame, watch (spacious)

```text
┌────────────────────────────┐
│ 09:41          ◎ 100%      │
├────────────────────────────┤
│                            │
│   Note                     │
│   ─────                    │
│                            │
│   Buy milk                 │
│   Call Sam                 │
│                            │
│   ▸ [ + ]  [ ⋯ ]           │
└────────────────────────────┘
```

- **State:** `app.ready`, spacious.
- **Focus:** `+`.
- **Content:** title, two list rows, two actions.
- **Action:** tap `+` to add; `⋯` opens the crown menu.
- **Transition:** on `+`, go to Edit sheet.
- **Announce:** "Notes. 2 items. Add."

### Frame 16 — App frame, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Notes                      ⋯      │
├──────────────────────────────────────┤
│                                      │
│   Buy milk                           │
│   ──────────────────────────────     │
│                                      │
│   Call Sam                           │
│   ──────────────────────────────     │
│                                      │
│                                      │
│                                      │
│   ▸ [ + Add ]       [ Edit ]         │
└──────────────────────────────────────┘
```

- **State:** `app.ready`, spacious.
- **Focus:** `+ Add`.
- **Content:** title, two rows with spacing, two actions.
- **Action:** tap `+ Add`; tap `Edit` to enter selection.
- **Transition:** on `+ Add`, go to Edit sheet.
- **Announce:** "Notes. 2 items. Add. Edit."

### Frame 17 — App frame, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│ ‹ Notes                                    ⋯      │
├────────────────────────────────────────────────────┤
│                                                    │
│   ┌────────────────────────┐   ┌────────────────┐  │
│   │  Buy milk              │   │  Preview       │  │
│   │  edited 09:30          │   │                │  │
│   │                        │   │                │  │
│   │  Call Sam              │   │                │  │
│   │  edited yesterday      │   │                │  │
│   └────────────────────────┘   └────────────────┘  │
│                                                    │
│   ▸ [ + Add ]   [ Edit ]   [ Share ]               │
└────────────────────────────────────────────────────┘
```

- **State:** `app.ready`, spacious, two-pane.
- **Focus:** `+ Add`.
- **Content:** list (left), preview (right), three actions.
- **Action:** tap `+ Add`; tap `Share`.
- **Transition:** on `Share`, go to Share sheet.
- **Announce:** "Notes. 2 items. Add. Edit. Share."

### Frame 18 — App frame, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ Notes                                          ─  □  ×            │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌──────────────────────┐   ┌──────────────────────────────┐     │
│   │  Buy milk            │   │                              │     │
│   │  edited 09:30        │   │                              │     │
│   │                      │   │                              │     │
│   │  Call Sam            │   │                              │     │
│   │  edited yesterday    │   │                              │     │
│   └──────────────────────┘   └──────────────────────────────┘     │
│                                                                    │
│   ▸ [ + Add ]   [ Edit ]   [ Share ]   [ … ]                      │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `app.ready`, spacious, multi-window.
- **Focus:** `+ Add`.
- **Content:** list, detail pane, four actions.
- **Action:** tap `…` for overflow.
- **Transition:** on `…`, go to App actions sheet.
- **Announce:** "Notes window. 2 items."

### Frame 19 — App frame, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│ Notes                                                                    │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│       ┌──────────────────────┐                                           │
│       │  Buy milk            │                                           │
│       │  edited 09:30        │                                           │
│       └──────────────────────┘                                           │
│                                                                          │
│       ┌──────────────────────┐                                           │
│       │  Call Sam            │                                           │
│       │  edited yesterday    │                                           │
│       └──────────────────────┘                                           │
│                                                                          │
│       ▸ [ + Add ]     [ Edit ]     [ Back ]                              │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `app.ready`, spacious, 10-foot.
- **Focus:** `+ Add` (D-pad).
- **Content:** two large rows; large type.
- **Action:** D-pad; Enter.
- **Transition:** on `+ Add`, go to Add sheet.
- **Announce:** "Notes. 2 items. Add."

### Frame 20 — App frame, EV (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE — speed, warnings]                                 │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────────────┐                                   │
│   │  Buy milk                  │                                   │
│   │  edited 09:30              │                                   │
│   └────────────────────────────┘                                   │
│                                                                    │
│   ┌────────────────────────────┐                                   │
│   │  Call Sam                  │                                   │
│   │  edited yesterday          │                                   │
│   └────────────────────────────┘                                   │
│                                                                    │
│   ▸ [ + Add ]   [ Voice ]   [ Back ]                               │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `app.ready`, spacious, EV.
- **Focus:** `+ Add`.
- **Content:** two rows; protected zone untouched.
- **Action:** tap; voice.
- **Transition:** on `+ Add`, go to Add sheet.
- **Announce:** "Notes. 2 items."
- **Safety:** no content in protected zone.

### Frame 21 — App frame, spaceship (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [DISPLAY A]  [DISPLAY B]                                           │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────────────┐   ┌────────────────────────────┐  │
│   │  Step 3 of 12              │   │  O₂ 21.0 %   (valid)       │  │
│   │  Verify O₂ reading         │   │  Updated 09:41:02          │  │
│   └────────────────────────────┘   └────────────────────────────┘  │
│                                                                    │
│   ▸ [ Next step ]   [ Ack alarm ]   [ Hold ]                      │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `app.ready`, spacious, spaceship, procedure step.
- **Focus:** `Next step`.
- **Content:** procedure step, telemetry with source and timestamp.
- **Action:** follow procedure; bounded motion only.
- **Transition:** on `Next step`, go to step 4.
- **Announce:** "Procedure step 3 of 12. Verify oxygen reading."

---

## Surface 4 — Settings root

Settings in spacious density: fewer rows visible, larger rows, calmer grouping. Search
remains the primary accelerator.

### Frame 22 — Settings root, watch (spacious)

```text
┌────────────────────────────┐
│ ‹ Settings                 │
├────────────────────────────┤
│                            │
│   ▸ Appearance             │
│                            │
│     Display                │
│                            │
│     Sound                  │
│                            │
│     Notifications          │
│                            │
│     ⋯  more                │
└────────────────────────────┘
```

- **State:** `settings.root`, spacious.
- **Focus:** `Appearance`.
- **Content:** four rows; crown scroll for more.
- **Action:** tap row to open pane; crown scroll.
- **Transition:** on row tap, go to Settings pane.
- **Announce:** "Settings. Appearance."

### Frame 23 — Settings root, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Settings              🔍 Search    │
├──────────────────────────────────────┤
│                                      │
│   ▸ Appearance                       │
│                                      │
│     Display                          │
│                                      │
│     Sound                            │
│                                      │
│     Notifications                    │
│                                      │
│     Privacy                          │
│                                      │
│     Network                          │
│                                      │
│     ⋯  more                          │
└──────────────────────────────────────┘
```

- **State:** `settings.root`, spacious.
- **Focus:** `Appearance`.
- **Content:** six rows; search at top.
- **Action:** tap row; tap Search.
- **Transition:** on Search, go to Palette (settings).
- **Announce:** "Settings. 6 of 18 sections."

### Frame 24 — Settings root, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│ ‹ Settings                          🔍 Search      │
├────────────────────────────────────────────────────┤
│                                                    │
│   ┌────────────────────┐   ┌────────────────────┐  │
│   │ ▸ Appearance        │   │  Privacy           │  │
│   │   Display           │   │  Network           │  │
│   │   Sound             │   │  Bluetooth         │  │
│   │   Notifications     │   │  Power             │  │
│   └────────────────────┘   └────────────────────┘  │
│                                                    │
│   ┌────────────────────┐   ┌────────────────────┐  │
│   │  Storage            │   │  Users             │  │
│   │  Apps               │   │  Accessibility     │  │
│   │  Language           │   │  Date & time       │  │
│   │  Updates            │   │  About             │  │
│   └────────────────────┘   └────────────────────┘  │
└────────────────────────────────────────────────────┘
```

- **State:** `settings.root`, spacious, two-column.
- **Focus:** `Appearance`.
- **Content:** grouped panes, two columns.
- **Action:** tap pane.
- **Transition:** on tap, go to Settings pane.
- **Announce:** "Settings. 16 sections, 2 columns."

### Frame 25 — Settings root, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ Settings                                                🔍 Search  │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────┐   ┌────────────────────────────────────┐  │
│   │ ▸ Appearance        │   │                                    │  │
│   │   Display           │   │   Select a section                 │  │
│   │   Sound             │   │                                    │  │
│   │   Notifications     │   │                                    │  │
│   │   Privacy           │   │                                    │  │
│   │   Network           │   │                                    │  │
│   │   ⋯                 │   │                                    │  │
│   └────────────────────┘   └────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `settings.root`, spacious, master-detail.
- **Focus:** `Appearance`.
- **Content:** section list (left), detail (right, empty until chosen).
- **Action:** tap section.
- **Transition:** on tap, load pane in detail.
- **Announce:** "Settings. Appearance selected."

### Frame 26 — Settings root, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│ Settings                                                                  │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│       ┌──────────────────────┐                                           │
│       │ ▸ Appearance         │                                           │
│       └──────────────────────┘                                           │
│                                                                          │
│       ┌──────────────────────┐                                           │
│       │   Display            │                                           │
│       └──────────────────────┘                                           │
│                                                                          │
│       ┌──────────────────────┐                                           │
│       │   Sound              │                                           │
│       └──────────────────────┘                                           │
│                                                                          │
│       ⋯  more                                                            │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `settings.root`, spacious, 10-foot.
- **Focus:** `Appearance` (D-pad).
- **Content:** large rows, one column.
- **Action:** D-pad; Enter.
- **Transition:** on Enter, go to Settings pane.
- **Announce:** "Settings. Appearance."

### Frame 27 — Settings root, EV (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE]                                                   │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ▸ Display                                                        │
│                                                                    │
│     Sound                                                          │
│                                                                    │
│     Notifications                                                   │
│                                                                    │
│     ⋯  more                                                        │
│                                                                    │
│   ▸ [ Voice ]   [ Back ]                                           │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `settings.root`, spacious, EV.
- **Focus:** `Display`.
- **Content:** rows; voice first-class.
- **Action:** tap; voice.
- **Transition:** on row tap, go to Settings pane.
- **Announce:** "Settings. Display."

### Frame 28 — Settings root, spaceship (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [DISPLAY A]  [DISPLAY B]                                           │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ▸ Display                                                        │
│                                                                    │
│     Sound                                                          │
│                                                                    │
│     Notifications                                                   │
│                                                                    │
│     ⋯  more                                                        │
│                                                                    │
│   ▸ [ Ack ]   [ Back ]                                             │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `settings.root`, spacious, spaceship.
- **Focus:** `Display`.
- **Content:** rows; bounded motion.
- **Action:** tap.
- **Transition:** on row tap, go to Settings pane.
- **Announce:** "Settings. Display."

---

## Surface 5 — Palette (search / command)

Palette in spacious density: larger input, fewer results visible, larger targets. The
palette remains the primary accelerator and is unchanged in behaviour.

### Frame 29 — Palette, watch (spacious)

```text
┌────────────────────────────┐
│ 🔍  type to search         │
├────────────────────────────┤
│                            │
│   ▸ New note               │
│                            │
│     Open Calendar          │
│                            │
│     Settings               │
│                            │
│     ⋯                      │
└────────────────────────────┘
```

- **State:** `palette.open`, spacious.
- **Focus:** search field.
- **Content:** input, 3 results.
- **Action:** type; crown scroll results; tap to run.
- **Transition:** on result tap, run command and close.
- **Announce:** "Search. 3 results."

### Frame 30 — Palette, phone (spacious)

```text
┌──────────────────────────────────────┐
│ 🔍  type to search                   │
├──────────────────────────────────────┤
│                                      │
│   ▸ New note                         │
│                                      │
│     Open Calendar                    │
│                                      │
│     Open Messages                    │
│                                      │
│     Settings                         │
│                                      │
│     ⋯  more                          │
└──────────────────────────────────────┘
```

- **State:** `palette.open`, spacious.
- **Focus:** search field.
- **Content:** input, 4 results.
- **Action:** type; tap result.
- **Transition:** on result tap, run and close.
- **Announce:** "Search. 4 results."

### Frame 31 — Palette, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│ 🔍  type to search                                 │
├────────────────────────────────────────────────────┤
│                                                    │
│   ▸ New note                                       │
│                                                    │
│     Open Calendar                                  │
│                                                    │
│     Open Messages                                  │
│                                                    │
│     Open Files                                     │
│                                                    │
│     Settings                                       │
│                                                    │
│     ⋯  more                                        │
└────────────────────────────────────────────────────┘
```

- **State:** `palette.open`, spacious.
- **Focus:** search field.
- **Content:** input, 5 results.
- **Action:** type; tap result.
- **Transition:** on result tap, run and close.
- **Announce:** "Search. 5 results."

### Frame 32 — Palette, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ 🔍  type to search                                                 │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ▸ New note                                                       │
│                                                                    │
│     Open Calendar                                                  │
│                                                                    │
│     Open Messages                                                  │
│                                                                    │
│     Open Files                                                     │
│                                                                    │
│     Open Settings                                                  │
│                                                                    │
│     ⋯  more                                                        │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `palette.open`, spacious.
- **Focus:** search field.
- **Content:** input, 5 results; keyboard-first.
- **Action:** type; arrow keys; Enter.
- **Transition:** on Enter, run and close.
- **Announce:** "Search. 5 results."

### Frame 33 — Palette, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│ 🔍  type to search                                                       │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│       ▸ New note                                                         │
│                                                                          │
│         Open Calendar                                                    │
│                                                                          │
│         Open Messages                                                    │
│                                                                          │
│         ⋯  more                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `palette.open`, spacious, 10-foot.
- **Focus:** search field.
- **Content:** input, 3 results; large type.
- **Action:** D-pad; on-screen keyboard if no physical keyboard.
- **Transition:** on Enter, run and close.
- **Announce:** "Search. 3 results."

### Frame 34 — Palette, EV (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE]                                                   │
├────────────────────────────────────────────────────────────────────┤
│ 🔍  type or speak                                                  │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ▸ New note                                                       │
│                                                                    │
│     Navigate home                                                  │
│                                                                    │
│     ⋯  more                                                        │
│                                                                    │
│   ▸ [ Voice ]   [ Back ]                                           │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `palette.open`, spacious, EV.
- **Focus:** search field.
- **Content:** input, 2 results; voice first-class.
- **Action:** type or speak.
- **Transition:** on result, run and close.
- **Announce:** "Search. 2 results."
- **Safety:** protected zone untouched.

### Frame 35 — Palette, spaceship (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [DISPLAY A]  [DISPLAY B]                                           │
├────────────────────────────────────────────────────────────────────┤
│ 🔍  type to search                                                 │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ▸ Acknowledge alarm                                              │
│                                                                    │
│     Procedure step 4                                               │
│                                                                    │
│     ⋯  more                                                        │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `palette.open`, spacious, spaceship.
- **Focus:** search field.
- **Content:** input, 2 results; procedure-first.
- **Action:** type; bounded motion.
- **Transition:** on result, run and close.
- **Announce:** "Search. 2 results."

---

## Surface 6 — Notifications

Notifications in spacious density: larger card, fewer actions, calmer grouping, more
spacing. Priority and delivery rules are unchanged.

### Frame 36 — Notification, watch (spacious)

```text
┌────────────────────────────┐
│                            │
│   ┌──────────────────┐     │
│   │  Messages         │     │
│   │  Sam: on my way   │     │
│   │                   │     │
│   │   ▸ [ Reply ]     │     │
│   └──────────────────┘     │
│                            │
└────────────────────────────┘
```

- **State:** `notification.present`, spacious.
- **Focus:** `Reply`.
- **Content:** one notification card, one action.
- **Action:** tap Reply; dismiss by swipe.
- **Transition:** on Reply, go to Reply sheet.
- **Announce:** "New message from Sam: on my way."

### Frame 37 — Notification, phone (spacious)

```text
┌──────────────────────────────────────┐
│                                      │
│   ┌────────────────────────────┐     │
│   │  Messages                   │     │
│   │  Sam: on my way             │     │
│   │                             │     │
│   │   ▸ [ Reply ]   [ Dismiss ] │     │
│   └────────────────────────────┘     │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `notification.present`, spacious.
- **Focus:** `Reply`.
- **Content:** one card, two actions (budget).
- **Action:** tap Reply or Dismiss.
- **Transition:** on Dismiss, remove card.
- **Announce:** "New message from Sam: on my way."

### Frame 38 — Notification, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│                                                    │
│   ┌────────────────────────────┐                   │
│   │  Messages                   │                   │
│   │  Sam: on my way             │                   │
│   │                             │                   │
│   │   ▸ [ Reply ]   [ Dismiss ] [ ⋯ ]             │
│   └────────────────────────────┘                   │
│                                                    │
└────────────────────────────────────────────────────┘
```

- **State:** `notification.present`, spacious.
- **Focus:** `Reply`.
- **Content:** one card, three actions (third in overflow).
- **Action:** tap.
- **Transition:** on `⋯`, go to Notification actions sheet.
- **Announce:** "New message from Sam: on my way."

### Frame 39 — Notification, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│   ┌────────────────────────────┐                                   │
│   │  Messages                   │                                   │
│   │  Sam: on my way             │                                   │
│   │                             │                                   │
│   │   ▸ [ Reply ]   [ Dismiss ] [ ⋯ ]                             │
│   └────────────────────────────┘                                   │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `notification.present`, spacious.
- **Focus:** `Reply`.
- **Content:** one card, three actions.
- **Action:** tap or keyboard.
- **Transition:** on `⋯`, open actions.
- **Announce:** "New message from Sam: on my way."

### Frame 40 — Notification, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│       ┌────────────────────────────┐                                     │
│       │  Messages                   │                                     │
│       │  Sam: on my way             │                                     │
│       │                             │                                     │
│       │   ▸ [ Reply ]   [ Dismiss ]  │                                     │
│       └────────────────────────────┘                                     │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `notification.present`, spacious, 10-foot.
- **Focus:** `Reply`.
- **Content:** one large card, two actions.
- **Action:** D-pad.
- **Transition:** on Dismiss, remove.
- **Announce:** "New message from Sam: on my way."

### Frame 41 — Notification, EV (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE — warnings]                                        │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────────────┐                                   │
│   │  Messages                   │                                   │
│   │  Sam: on my way             │                                   │
│   │                             │                                   │
│   │   ▸ [ Read later ]          │                                   │
│   └────────────────────────────┘                                   │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `notification.present`, spacious, EV.
- **Focus:** `Read later`.
- **Content:** one card, one action (driving-safe).
- **Action:** tap; voice.
- **Transition:** on `Read later`, defer.
- **Announce:** "New message from Sam. Read later."
- **Safety:** no notification covers the protected zone; driving-safe actions only.

### Frame 42 — Notification, spaceship (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [DISPLAY A]  [DISPLAY B]                                           │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌────────────────────────────┐   ┌────────────────────────────┐  │
│   │  Alarm                      │   │  Procedure                 │  │
│   │  O₂ low                     │   │  Step 3 of 12              │  │
│   │                             │   │                            │  │
│   │   ▸ [ Ack ]   [ Silence ]   │   │   ▸ [ Next ]               │  │
│   └────────────────────────────┘   └────────────────────────────┘  │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `notification.present` (alarm), spacious, spaceship.
- **Focus:** `Ack`.
- **Content:** alarm card + procedure card; bounded motion.
- **Action:** Ack or Silence.
- **Transition:** on Ack, acknowledge alarm.
- **Announce:** "Alarm. Oxygen low. Acknowledge."

---

## Surface 7 — Fullscreen

Fullscreen in spacious density: the same fullscreen behaviour as compact, with spacious
spacing inside the immersive surface. System UI rules are unchanged.

### Frame 43 — Fullscreen, watch (spacious)

```text
┌────────────────────────────┐
│                            │
│                            │
│        ●  recording        │
│                            │
│                            │
│                            │
│   ▸ [ Stop ]               │
└────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious.
- **Focus:** `Stop`.
- **Content:** immersive content (recording indicator), one action.
- **Action:** tap Stop to exit.
- **Transition:** on Stop, exit fullscreen.
- **Announce:** "Recording. Stop to exit."

### Frame 44 — Fullscreen, phone (spacious)

```text
┌──────────────────────────────────────┐
│                                      │
│                                      │
│           ●  recording               │
│                                      │
│                                      │
│                                      │
│                                      │
│   ▸ [ Stop ]            [ ⋯ ]        │
└──────────────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious.
- **Focus:** `Stop`.
- **Content:** immersive, two actions.
- **Action:** tap Stop to exit; `⋯` for options.
- **Transition:** on Stop, exit fullscreen.
- **Announce:** "Recording. Stop to exit."

### Frame 45 — Fullscreen, tablet (spacious)

```text
┌────────────────────────────────────────────────────┐
│                                                    │
│                                                    │
│                  ●  recording                     │
│                                                    │
│                                                    │
│                                                    │
│   ▸ [ Stop ]   [ Pause ]   [ ⋯ ]                   │
└────────────────────────────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious.
- **Focus:** `Stop`.
- **Content:** immersive, three actions.
- **Action:** tap.
- **Transition:** on Stop, exit fullscreen.
- **Announce:** "Recording. Stop to exit."

### Frame 46 — Fullscreen, desktop (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│                                                                    │
│                      ●  recording                                  │
│                                                                    │
│                                                                    │
│                                                                    │
│   ▸ [ Stop ]   [ Pause ]   [ Settings ]   [ ⋯ ]                    │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious.
- **Focus:** `Stop`.
- **Content:** immersive, four actions.
- **Action:** tap or keyboard (Esc exits).
- **Transition:** on Esc or Stop, exit fullscreen.
- **Announce:** "Recording. Press Escape to exit."

### Frame 47 — Fullscreen, TV (spacious)

```text
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│                                                                          │
│                        ●  recording                                      │
│                                                                          │
│                                                                          │
│                                                                          │
│       ▸ [ Stop ]     [ Back ]                                            │
└──────────────────────────────────────────────────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious, 10-foot.
- **Focus:** `Stop`.
- **Content:** immersive, large indicator.
- **Action:** D-pad; Back exits.
- **Transition:** on Back, exit fullscreen.
- **Announce:** "Recording. Back to exit."

### Frame 48 — Fullscreen, EV (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [PROTECTED ZONE — speed, warnings]                                 │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│                                                                    │
│                      ●  media                                      │
│                                                                    │
│                                                                    │
│   ▸ [ Pause ]   [ Next ]   [ Back ]                                │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious, EV.
- **Focus:** `Pause`.
- **Content:** immersive media; protected zone untouched.
- **Action:** tap; voice.
- **Transition:** on Back, exit fullscreen.
- **Announce:** "Media playing. Back to exit."
- **Safety:** protected zone never covered.

### Frame 49 — Fullscreen, spaceship (spacious)

```text
┌────────────────────────────────────────────────────────────────────┐
│ [DISPLAY A]  [DISPLAY B]                                           │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│                                                                    │
│                      ●  procedure                                  │
│                                                                    │
│                                                                    │
│   ▸ [ Next ]   [ Ack ]   [ Hold ]                                  │
└────────────────────────────────────────────────────────────────────┘
```

- **State:** `fullscreen.active`, spacious, spaceship.
- **Focus:** `Next`.
- **Content:** immersive procedure; bounded motion.
- **Action:** follow procedure.
- **Transition:** on `Hold`, hold procedure.
- **Announce:** "Procedure. Next to continue."

---

## Surface 8 — Rare cases

Rare cases in spacious density: the same rare cases as compact, with spacious spacing
and calmer hierarchy. Each rare case is drawn for the phone envelope (the most common
single surface); other envelopes follow the same composition rules in
`03-adaptation.md`.

### Frame 50 — Rare case: no network, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Notes                      ⋯      │
├──────────────────────────────────────┤
│                                      │
│   ┌────────────────────────────┐     │
│   │  ⚠  Offline                 │     │
│   │                            │     │
│   │  Your changes are saved    │     │
│   │  on this device. They will │     │
│   │  sync when you are back    │     │
│   │  online.                   │     │
│   │                            │     │
│   │   ▸ [ OK ]                 │     │
│   └────────────────────────────┘     │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `app.offline`, spacious.
- **Focus:** `OK`.
- **Content:** offline banner as a calm card; reassurance.
- **Action:** tap OK to dismiss.
- **Transition:** on OK, return to app ready (offline).
- **Announce:** "Offline. Changes saved on this device. Will sync when online."

### Frame 51 — Rare case: low battery, phone (spacious)

```text
┌──────────────────────────────────────┐
│ 09:41                       🔋 8%   │
├──────────────────────────────────────┤
│                                      │
│   ┌────────────────────────────┐     │
│   │  ⚠  Low battery             │     │
│   │                            │     │
│   │  Spacious density is on    │     │
│   │  to reduce work. Some      │     │
│   │  effects are paused.       │     │
│   │                            │     │
│   │   ▸ [ OK ]   [ Settings ]  │     │
│   └────────────────────────────┘     │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `system.low_battery`, spacious auto-selected.
- **Focus:** `OK`.
- **Content:** low battery card; density rationale stated.
- **Action:** tap OK or Settings.
- **Transition:** on Settings, go to Power settings.
- **Announce:** "Low battery, 8 percent. Spacious density on."

### Frame 52 — Rare case: permission denied, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Camera                     ⋯      │
├──────────────────────────────────────┤
│                                      │
│   ┌────────────────────────────┐     │
│   │  ⊘  Camera access denied    │     │
│   │                            │     │
│   │  The camera is needed to   │     │
│   │  scan a code. You denied   │     │
│   │  access on 20 Oct.         │     │
│   │                            │     │
│   │   ▸ [ Open settings ]      │     │
│   │     [ Use file instead ]   │     │
│   └────────────────────────────┘     │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `app.denied`, spacious.
- **Focus:** `Open settings`.
- **Content:** denial reason, date, two recovery paths.
- **Action:** tap recovery.
- **Transition:** on `Use file instead`, go to file picker.
- **Announce:** "Camera access denied. Two options: open settings, or use a file."

### Frame 53 — Rare case: 200% text, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Notes                      ⋯      │
├──────────────────────────────────────┤
│                                      │
│   Buy milk                           │
│                                      │
│   Call Sam                           │
│                                      │
│   ▸ [ + Add ]                        │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `app.ready`, text size 200%, density auto-degraded to compact (spacing reduced to fit).
- **Focus:** `+ Add`.
- **Content:** rows stacked; one action visible; rest in `⋯`.
- **Action:** tap `+ Add`.
- **Transition:** on `⋯`, open actions sheet.
- **Announce:** "Notes. 2 items. Text size large. Density compact."
- **Note:** spacious spacing yielded to text size (§7 trigger 5); degradation announced.

### Frame 54 — Rare case: reduced motion, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Notes                      ⋯      │
├──────────────────────────────────────┤
│                                      │
│   Buy milk                           │
│                                      │
│   Call Sam                           │
│                                      │
│   ▸ [ + Add ]       [ Edit ]         │
└──────────────────────────────────────┘
```

- **State:** `app.ready`, reduced motion, spacious.
- **Focus:** `+ Add`.
- **Content:** same as Frame 16; no travel on enter/exit; state change is instant.
- **Action:** tap.
- **Transition:** instant, no spring travel.
- **Announce:** "Notes. 2 items."

### Frame 55 — Rare case: RTL, phone (spacious)

```text
┌──────────────────────────────────────┐
│      ⋯                      ‹ ملاحظات │
├──────────────────────────────────────┤
│                                      │
│                           اشترِ حليب │
│                                      │
│                           اتصل بسام │
│                                      │
│         [ تحرير ]       [ + إضافة ] ◂│
└──────────────────────────────────────┘
```

- **State:** `app.ready`, RTL, spacious.
- **Focus:** `+ إضافة` (rightmost, first in RTL focus order).
- **Content:** mirrored layout; spacing identical.
- **Action:** tap.
- **Transition:** on tap, go to Edit sheet (mirrored).
- **Announce:** "ملاحظات. عنصران." (Notes. 2 items.)

### Frame 56 — Rare case: alarm fatigue guard, phone (spacious)

```text
┌──────────────────────────────────────┐
│ ‹ Health                     ⋯      │
├──────────────────────────────────────┤
│                                      │
│   ┌────────────────────────────┐     │
│   │  ⚠  3 reminders suppressed  │     │
│   │                            │     │
│   │  To reduce fatigue, three  │     │
│   │  low-priority reminders    │     │
│   │  were held. Review them    │     │
│   │  now or later.             │     │
│   │                            │     │
│   │   ▸ [ Review ]   [ Later ] │     │
│   └────────────────────────────┘     │
│                                      │
└──────────────────────────────────────┘
```

- **State:** `app.ready`, notification budget exceeded, spacious.
- **Focus:** `Review`.
- **Content:** suppression notice; calm card.
- **Action:** Review or Later.
- **Transition:** on Later, hold until quiet hours end.
- **Announce:** "3 reminders held to reduce fatigue. Review or later."

---

## Surface 9 — Home More sheet (overflow)

Shown when a home surface exceeds its spacious action budget. The sheet is the
overflow destination; it is not a separate information architecture.

### Frame 57 — Home More sheet, phone (spacious)

```text
┌──────────────────────────────────────┐
│ 09:41                       ◎ 100%  │
├──────────────────────────────────────┤
│                                      │
│   ┌────────────────────────────┐     │
│   │  Calendar                  │     │
│   │  Next: 14:00 — Review      │     │
│   └────────────────────────────┘     │
│                                      │
│   ┌────────────────────────────┐     │
│   │  Messages                  │     │
│   │  3 new from 2 people       │     │
│   └────────────────────────────┘     │
│   ┌────────────────────────────┐     │
│   │  SHEET                     │     │
│   │                            │     │
│   │  ▸ Photos                  │     │
│   │    Settings                │     │
│   │    Clock                   │     │
│   │    Browser                 │     │
│   │                            │     │
│   │    [ Close ]               │     │
│   └────────────────────────────┘     │
└──────────────────────────────────────┘
```

- **State:** `home.ready` + `sheet.open (overflow)`, spacious.
- **Focus:** `Photos`.
- **Content:** base dimmed; sheet lists overflow items.
- **Action:** tap item to open; tap Close to dismiss.
- **Transition:** on item tap, open app; on Close, return to Home.
- **Announce:** "More items. Photos. Settings. Clock. Browser."

---

## Acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-020` | Every surface listed (boot, home, app, settings, palette, notifications, fullscreen, rare cases, overflow) has a frame for all seven envelopes, or a declared absence. |
| `AC-WF-SPACIOUS-021` | Every frame has a wireframe, state, focus, content, action, transition and announcement. |
| `AC-WF-SPACIOUS-022` | No frame says "similar to" or omits an envelope. |
| `AC-WF-SPACIOUS-023` | Every rare-case frame names the cause, the recovery and the announcement. |
