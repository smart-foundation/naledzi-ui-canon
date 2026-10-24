---
id: FOUND-EXPERIENCE-ONBOARDING
title: Onboarding — First-Run, Progressive Disclosure, No Forced Tour, Learn-by-Doing, Accessibility Onboarding, Device Pairing
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-LEARNING, FOUND-EXPERIENCE-FELT]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-ONBOARD-001, AC-EXP-ONBOARD-002, AC-EXP-ONBOARD-003]
---

# Onboarding

> First-run, progressive disclosure, no forced tour, learn-by-doing, accessibility
> onboarding, device pairing.

## 1. Principle

Onboarding is learn-by-doing. The person's first task is a real task, not a tour. There
is no forced tour, no coach marks that block, no "welcome to your new OS" modal that
must be dismissed. Progressive disclosure reveals complexity as it is needed. Accessibility
onboarding lets the person set up their assistive tech on first run. Device pairing is
designed as a first-class flow, not an afterthought.

## 2. First-run

1. **Boot → lock.** The device boots to the lock screen. No setup wizard blocks the
   first view unless identity is required.
2. **Identity.** If a user account exists, unlock; else, create one inline. No separate
   "setup app".
3. **First home.** The home screen appears with one clear primary action (the palette
   or the first admitted app). No empty-state essay.
4. **First task.** The person's first action is a real, useful task (send a message,
   open a note, set the time). Success is visible.
5. **No tour.** No coach marks, no tooltip chains, no "next/next/done". If a feature
   needs a tour, the feature is not discoverable and is a defect.

## 3. Progressive disclosure

- The default view is the simple one.
- Advanced controls live in Settings or behind an explicit "more".
- The primary action is never hidden.
- Disclosure is triggered by the person's action, never by time or by a wizard.

## 4. Learn-by-doing

- Every action produces visible or announced feedback (`06-learning.md`).
- Errors are recoverable and blameless.
- The person can explore without fear of breaking things (reversibility).
- Shortcuts are accelerators, never the only path.

## 5. Accessibility onboarding

- On first run, the system offers (does not force) assistive-tech setup: screen reader,
  switch access, text size, reduced motion, colour-vision mode, voice.
- The offer is a single, dismissible sheet, not a wizard.
- Settings for all of these remain available later.
- The default is the system's best guess from the device, overridable.

## 6. Device pairing

- Pairing is a first-class flow: discover, confirm, grant capabilities, done.
- Pairing is initiated from the palette or Settings, never hidden.
- Capabilities granted during pairing are revocable later.
- Pairing works offline (local discovery) and online.
- A failed pairing explains the cause and the recovery; it does not hang.

## 7. What is intentionally absent

- A forced tour.
- A "welcome" modal that must be dismissed.
- A separate setup app.
- A multi-step wizard without a skip path.

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-ONBOARD-001` | First-run completes without a forced tour or wizard. |
| `AC-EXP-ONBOARD-002` | First success happens without a manual or hint. |
| `AC-EXP-ONBOARD-003` | Device pairing completes end-to-end including failure and recovery. |