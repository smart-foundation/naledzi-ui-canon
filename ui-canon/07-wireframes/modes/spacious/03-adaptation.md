---
id: WF-SPACIOUS-ADAPTATION
title: Spacious — Adaptation
kind: wireframe
entity: spacious
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-SPACIOUS, FOUND-EXPERIENCE-INDEX, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX, APP-ENVELOPE-ADAPTATION, WF-SPACIOUS-INDEX, WF-SPACIOUS-PRINCIPLES]
supersedes: []
superseded_by: []
acceptance: [AC-WF-SPACIOUS-030, AC-WF-SPACIOUS-031, AC-WF-SPACIOUS-032, AC-WF-SPACIOUS-033]
---

# Spacious — Adaptation

> How spacious density travels across envelopes, and how it yields to compact when it
> must. No content is lost in either direction. The adaptation is reversible and
> announced.

---

## 1. The adaptation ladder (density variant)

Density adaptation follows the same ladder as envelope adaptation
(`05-apps/_standard/04-envelope-adaptation.md` §1), applied to density rather than to
envelope:

1. **Re-flow.** Keep the same content and regions; increase spacing and reduce columns.
2. **Collapse.** Move secondary content and secondary actions into a sheet, popover or
   section. The primary content stays.
3. **Page.** Split a long list or grid into pages with explicit navigation, when
   re-flow and collapse are not enough.
4. **Peer.** Move secondary content to a companion surface (phone ↔ watch, desktop ↔
   phone) when the primary surface cannot hold it at spacious spacing.
5. **Declare.** If a feature genuinely cannot exist at spacious density on an envelope,
   declare the envelope exception with a reason and a degraded alternative. An
   exception without an alternative is a scope cut.

Never adapt by shrinking text below legibility, hiding a primary action, or silently
removing a feature. These are defects, not adaptations.

---

## 2. Per-envelope adaptation

### 2.1 Watch

- Spacious is the **default** density on watch. The screen is small; calmness is the
  point.
- One primary region. Secondary content is a vertical card reached by crown scroll.
- One primary action; the rest live in the crown menu.
- Spacious → compact is triggered only by a declared workload or alarm state, and the
  change is announced to assistive tech.
- No content is moved to a peer; the watch has no peer by default, but may hand off to
  the phone on request.

### 2.2 Phone

- Spacious is selectable and is the default under stress, fatigue, low battery and
  one-handed use (declared by system rules).
- One content column. Context becomes a bottom sheet.
- Actions in the bottom action region within thumb reach; maximum 3 visible in
  spacious (§ 01-principles §4).
- Keyboard-aware layout; content is never behind the keyboard.
- Spacious → compact triggers: available content area below the spacious minimum
  (§3), text size ≥ 200%, or performance budget miss.

### 2.3 Tablet

- Spacious uses two columns where compact uses three, and larger rows.
- List/detail becomes list-over-detail (detail in a sheet) when space is tight.
- Pointer and keyboard remain first-class; targets grow but do not change behaviour.
- Spacious → compact triggers: split-view multitasking reduces the app's width below
  the spacious minimum.

### 2.4 Desktop

- Spacious uses fewer columns and larger cards; multi-window is preserved.
- The strip and status rail are system-owned and are unaffected by app density.
- Hover remains an enhancement, never the only path.
- Spacious → compact triggers: the window is resized below the spacious minimum, or
  the person enables compact explicitly.

### 2.5 TV

- Spacious is the **default** density on TV. 10-foot layouts need calmness.
- Three large cards per row instead of four or five. Large type, high contrast.
- D-pad is primary; pointer optional.
- Spacious → compact is rare and is triggered only by a content-heavy screen that
  cannot be paged within the paging budget. The change is announced.

### 2.6 EV

- Spacious is the **default** density in the centre stack. Touch targets are larger,
  glare and vibration are assumed.
- Protected zones are never covered, in either density.
- Spacious → compact is triggered by a driving-state change that requires more
  information density (navigation re-route, warning), and the change is announced to
  the driver only when safe (no modal while moving).
- Voice and physical controls remain first-class in both densities.

### 2.7 Spaceship

- Spacious is **not** the default during an alarm or high-workload state. Compact
  density is required for procedure-first legibility.
- Spacious is permitted during low-workload monitoring and is the default there.
- Bounded motion and deterministic timing apply in both densities.
- Spacious → compact is triggered by any alarm, any procedure step, or any
  high-workload declaration. The change is recorded in the still and announced to
  assistive tech; it is not a modal.

---

## 3. Spacious minimums (per surface)

The spacious minimum is the smallest content area in which a surface may run in
spacious density. Below it, the surface degrades to compact. Values are expressed as
token references; the concrete pixel values live in `03-framework/tokens/`.

| Surface | Watch | Phone | Tablet | Desktop | TV | EV | Spaceship |
|---|---|---|---|---|---|---|---|
| Home | 36 mm | 320 px | 600 px | 800 px | 1280 px | zone | display |
| App frame | 36 mm | 320 px | 600 px | 720 px | 1280 px | zone | display |
| Settings root | n/a (crown) | 320 px | 600 px | 720 px | 1280 px | zone | display |
| Palette | 36 mm | 320 px | 600 px | 720 px | 1280 px | zone | display |
| Notification | 36 mm | 320 px | 600 px | 720 px | 1280 px | zone | display |
| Fullscreen | 36 mm | 320 px | 600 px | 720 px | 1280 px | zone | display |

`zone` means the envelope's declared content zone (EV centre stack region). `display`
means the envelope's declared primary display area (spaceship). `n/a (crown)` means
the surface is reached by crown scroll, not by a width threshold.

---

## 4. Overflow rules (no content loss)

When spacious spacing does not fit the content, overflow is handled in this order. The
order is normative; skipping a step is a defect.

1. **Re-flow.** Change the arrangement (fewer columns, stacked rows).
2. **Collapse.** Move secondary content or secondary actions into a sheet, popover or
   section. The primary content stays visible.
3. **Page.** Split into pages with explicit navigation and a visible page indicator.
   Paging is announced.
4. **Peer.** Move secondary content to a companion surface, preserving content and
   selection.
5. **Declare.** Record an envelope exception with a reason and an alternative.

Rules:

- **WF-SPACIOUS-030.** Overflow MUST NOT drop content. Every piece of content from
  the compact frame MUST be reachable in the spacious frame, possibly re-flowed,
  collapsed, paged or moved to a peer.
- **WF-SPACIOUS-031.** Overflow MUST NOT hide a primary action. A primary action
  that does not fit is the trigger for degradation to compact, not for hiding.
- **WF-SPACIOUS-032.** Overflow MUST be visible to the person: a `⋯`, a page
  indicator, a sheet handle or a peer indicator. Silent overflow is a defect.
- **WF-SPACIOUS-033.** Overflow MUST be reversible: the person can return to the
  full content in one step.

---

## 5. Density selection

Density is chosen by the following precedence, highest first:

1. Safety rule (EV protected zone, spaceship alarm) — forces compact.
2. Person's explicit choice — spacious or compact, persisted across sessions and
   envelopes where the envelope supports it.
3. Envelope default (watch and TV spacious; spaceship low-workload spacious).
4. System rule (stress, fatigue, low battery, one-handed, glare, vibration) —
   selects spacious.
5. Available space (degradation triggers in §3 and §6).

A higher-precedence rule always wins. A lower-precedence rule is re-evaluated when
the higher one clears.

---

## 6. Degradation triggers (full list)

Any one of these triggers degradation from spacious to compact:

1. **Space.** Available content area below the spacious minimum for the surface and
   envelope (§3).
2. **Input.** Primary input is a five-button remote with no pointer and the surface
   requires more than the remote can reach without paging.
3. **Workload.** A safety or high-workload state is declared and the envelope
   requires compact density for legibility.
4. **Content.** The content cannot be re-flowed into the spacious layout without
   truncation or paging beyond the paging budget.
5. **Text.** The person's text-size preference is at or above 200% and spacious
   spacing would push primary content off screen.
6. **Performance.** The surface cannot meet its frame budget in spacious density on
   the target envelope.

Degradation behaviour:

- **WF-SPACIOUS-034.** Degradation MUST be automatic when a trigger fires and MUST
  be reversible when the trigger clears.
- **WF-SPACIOUS-035.** Degradation MUST be announced, in the surface's own
  language, with the reason, unless the change is safety-required on a safety
  envelope, in which case it is recorded in the still and announced to assistive
  tech but is not a modal.
- **WF-SPACIOUS-036.** Degradation MUST NOT drop content. Content that does not fit
  in compact is re-flowed, collapsed, paged or moved to a peer.
- **WF-SPACIOUS-037.** A person's explicit density choice MUST override automatic
  degradation except where a safety rule forbids spacious. In that case the safety
  rule wins and the override is recorded.

---

## 7. Cross-envelope continuity

When a person moves a surface from one envelope to another (handoff, remote output,
continue-on-another-device), density is re-evaluated on the destination envelope:

- The person's explicit choice travels with the surface.
- The destination envelope's default and safety rules apply.
- If the destination cannot honour the choice, it degrades by the rules in §6 and
  announces the change.
- Content, selection and scroll position are preserved across the density change.

---

## 8. Acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-030` | Every envelope has a declared spacious default and a declared degradation trigger set. |
| `AC-WF-SPACIOUS-031` | No spacious → compact degradation drops content; verified by content checklist per surface. |
| `AC-WF-SPACIOUS-032` | Every overflow is visible and reversible. |
| `AC-WF-SPACIOUS-033` | Density selection precedence is implemented and tested for conflicts. |