---
id: WF-SPACIOUS-PRINCIPLES
title: Spacious — Principles
kind: wireframe
entity: spacious
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-COGNITION, UX-ATTENTION, UX-ACCESSIBILITY, UX-SPACIOUS, FOUND-EXPERIENCE-INDEX, FOUND-DEPTH-INDEX, FOUND-MOTION-INDEX, FOUND-COLOR-INDEX, WF-SPACIOUS-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-WF-SPACIOUS-010, AC-WF-SPACIOUS-011, AC-WF-SPACIOUS-012]
---

# Spacious — Principles

> Spacious is a density mode. It is what you get when you ask the screen to show fewer,
> larger, calmer things. It is not a theme, not a skin and not a separate product. The
> screen in spacious density answers the same question as the screen in compact density;
> it just answers it with more room.

---

## 1. The three changes, in priority order

Spacious changes exactly three things, and in this order. A designer who changes a fourth
thing is designing a different screen.

1. **Spacing increases.** Outer margins, inner padding, gaps between regions and gaps
   between items all grow by the spacious spacing token set. The content area shrinks in
   proportion; content is re-flowed to fit, never truncated.
2. **Visible action count decreases.** Secondary actions leave the primary surface and
   move into a sheet, a crown menu, a "more" control or the command palette. The primary
   action stays, becomes larger and more isolated. The number of visible actions on any
   surface MUST NOT exceed the spacious action budget (§4).
3. **Hierarchy calms.** Elevation noise is reduced: fewer surfaces are raised, fewer
   borders are drawn, fewer dividers appear. Depth is still truthful (LAW-007); it is
   simply used less. The calmest surface that still communicates the hierarchy is the
   correct one.

If a designer changes colour, type scale, motion grammar, depth semantics, the state
machine, the command IDs or the wording, they are not designing spacious density. They
are designing a theme, and themes are not admitted (LAW-001, LAW-007, LAW-013).

---

## 2. Why spacious exists: the evidence

Spacious is not an aesthetic preference. It is a response to four well-documented human
limits, and each one is cited.

### 2.1 Cognitive load and chunking

Working memory holds roughly four chunks of unrelated information at once
(Miller, 1956; Cowan, 2001). Cognitive load theory shows that extraneous load — load
caused by the presentation, not the task — directly reduces the capacity available for
the task (Sweller, 1988). A dense screen is a load generator: every visible control,
every divider, every badge competes for the same four slots. Spacious reduces extraneous
load by reducing what is visible, so the four slots are spent on the task.

- **UX-SPACIOUS-01.** Spacious MUST reduce the number of simultaneously visible
  unrelated items to four or fewer where the task permits. Where the task genuinely
  requires more, the excess MUST be grouped into chunks of four or fewer and separated
  by space, not by lines.

### 2.2 Motor accuracy and target size

Fitts's law (Fitts, 1954) states that movement time grows with the index of difficulty,
which is a function of distance and target width. Smaller targets are slower and more
error-prone. WCAG 2.2 Success Criterion 2.5.8 (Target Size Minimum) requires a target
size of at least 24 × 24 CSS pixels at AA and 44 × 44 at AAA (W3C, 2023). Under
stress, fatigue, vibration, glare and one-handed use, the effective target size the
person can hit reliably is larger than the static minimum. Spacious uses larger targets
and larger gaps between them, so a mis-tap costs less.

- **UX-SPACIOUS-02.** Spacious MUST use targets of at least 44 × 44 CSS pixels for
  primary actions and at least 32 × 32 for secondary actions, with a gap of at least
  8 CSS pixels between adjacent targets. These are floors; envelopes with gloves, glare
  or vibration (EV, spaceship) MUST exceed them per their envelope spec.

### 2.3 Attention and interruption cost

Attention is finite and owned by the person (LAW-020). Interruption research shows that
resuming a task after an interruption costs time and increases error rates, and that
the cost grows with the number of items on screen that must be re-scanned (Endsley,
1995; Cvach, 2012 on alarm fatigue). A calmer surface is a faster surface to return
to. Spacious reduces the re-scan set.

- **UX-SPACIOUS-03.** Spacious MUST reduce the re-scan set on return from an
  interruption: the primary content and the primary action MUST be the two largest
  elements on the surface, and MUST be locatable without reading.

### 2.4 Stress, workload and dignity

Stress narrows attention and raises cognitive load (Kahneman, 2011). Under stress the
person does not want more options; they want fewer, clearer ones, and they want the
system to stop competing for attention (Weiser & Brown, 1997, calm technology). A
system that gets louder under stress is a system that fails its user. Spacious gets
simpler.

- **UX-SPACIOUS-04.** Under a declared stress or workload state (safety envelope,
  alarm, fatigue, low battery, denied permission), spacious MUST be the default and
  compact MUST NOT be forced. The person MAY still choose compact, but the system MUST
  NOT choose it for them.

### 2.5 Accessibility and low vision

WCAG 2.2 (W3C, 2023) and ISO 9241-11 (ISO, 2018) treat spacing and target size as
usability, not decoration. Larger spacing improves readability for users with low
vision, dyslexia and presbyopia, and reduces the mis-tap rate for users with motor
impairment. Spacious is therefore an accessibility feature as much as a comfort
feature, and it MUST be available to every user on every envelope.

- **UX-SPACIOUS-05.** Spacious MUST be available as an accessibility adaptation, not
  only as a preference. A user who needs it MUST be able to set it once and have it
  persist across sessions, devices and envelopes (subject to envelope capability).

---

## 3. What spacious never changes

This list is normative and exhaustive. If a change is not on this list, it is not
spacious.

Spacious MUST NOT change:

1. **The human need** the screen serves.
2. **The domain model** and the data.
3. **The state machine** and the state names.
4. **The command IDs** and the action grammar.
5. **The wording** of labels, errors, confirmations and announcements (translated, not
   rewritten).
6. **The accessibility semantics**: roles, names, states, actions, focus order,
   announcements.
7. **The colour roles** and their values. Colour is unchanged.
8. **The depth semantics**: elevation levels, light model, occlusion truth. Depth is
   used less, never redefined.
9. **The motion grammar**: springs, settle, interruptibility, reduced-motion
   alternative. Motion is unchanged.
10. **The acceptance criteria**. A screen that passes in compact passes in spacious,
    and vice versa, for behaviour.
11. **The capability and security model.** Density is not a capability.
12. **The safety rules** of EV and spaceship envelopes. Safety wins.

Spacious MAY change, and only these:

1. Spacing tokens (margins, padding, gaps).
2. The number of visible actions (by moving secondary actions to a sheet, menu or
   palette).
3. The number of raised surfaces and dividers (calmer hierarchy).
4. Target sizes (larger, within the floors in §2.2).
5. The number of columns in a grid (fewer columns, larger cells).
6. The density of a list (fewer items visible, larger rows).
7. The amount of secondary content shown inline (less; the rest is one tap away).

---

## 4. The spacious action budget

The visible action budget is the maximum number of primary-and-secondary actions that
may appear on a surface at once in spacious density. It is a ceiling, not a target.

| Surface | Spacious budget | Compact budget (for reference) |
|---|---|---|
| Watch home | 1 primary | 1 primary + crown menu |
| Phone home | 4 | 6 |
| Tablet home | 6 | 9 |
| Desktop home / window | 8 | 12 |
| TV home | 5 | 7 |
| EV centre stack | 4 (zone-limited) | 6 |
| Spaceship primary display | 3 (procedure-first) | 5 |
| App frame (any envelope) | 3 primary + sheet | 5 primary + sheet |
| Settings root | 6 rows visible | 9 rows visible |
| Palette | 8 results visible | 12 results visible |
| Notification | 2 actions | 3 actions |

Rules:

- **WF-SPACIOUS-009.** A surface that exceeds its spacious budget MUST move the excess
  to a sheet, a menu, the command palette, or a peer surface. It MUST NOT shrink the
  targets below the floors in §2.2.
- **WF-SPACIOUS-010.** The primary action is never counted as "excess". It is always
  visible, always largest, always first in focus order.
- **WF-SPACIOUS-011.** An action that is moved out of the primary surface in spacious
  density MUST be reachable in one additional step, and that step MUST be documented in
  the flow.

---

## 5. Calm hierarchy

Depth is semantic (LAW-007). Spacious uses less of it, not different rules.

- **WF-SPACIOUS-012.** In spacious density, a surface SHOULD use the lowest elevation
  that still communicates its role. A card that is raised in compact MAY be flat with
  tonal separation in spacious, provided the hierarchy remains readable when shadows
  are removed (FOUND-DEPTH test 1).
- **WF-SPACIOUS-013.** Dividers between items MUST be replaced by spacing where the
  grouping is clear from position and spacing alone. A divider is added back only when
  a test shows the grouping is ambiguous without it.
- **WF-SPACIOUS-014.** Badges, counts, secondary labels and metadata MUST be hidden or
  collapsed when they are not needed for the current task. They MUST remain available
  on focus or on demand.
- **WF-SPACIOUS-015.** Borders MUST NOT be used to create separation that spacing
  already creates. A border that carries no meaning is decoration (LAW-007).

The calm hierarchy test: remove all shadows, borders and dividers. Is the hierarchy
still readable from position, spacing, scale and contrast? If yes, the spacious frame is
calm enough. If no, spacing is doing too little work and must be increased before
borders are added back.

---

## 6. Spacing and targets (tokens, not numbers)

Spacious does not name pixel values. It names tokens, minted by `03-framework/tokens/`
from this foundation. The tokens are:

| Token family | Spacious behaviour |
|---|---|
| `TOK-SPACE-OUTER-*` | Outer margin grows by the spacious step. |
| `TOK-SPACE-INNER-*` | Inner padding grows by the spacious step. |
| `TOK-SPACE-GAP-*` | Item and region gaps grow by the spacious step. |
| `TOK-TARGET-*` | Minimum target sizes grow to the spacious floors (§2.2). |
| `TOK-DEPTH-ELEVATION-*` | Same levels; usage is reduced, not redefined. |
| `TOK-MOTION-*` | Unchanged. Motion is unchanged. |
| `TOK-COLOR-*` | Unchanged. Colour is unchanged. |
| `TOK-TYPE-*` | Unchanged base scale; the person may combine spacious with a larger type preference, and the two compose. |

The spacious step is a multiplier applied to the base spacing token. It is declared in
the token file, not here. This file declares the rule: spacious spacing is always
larger than compact spacing for the same token, and the ratio is constant across
envelopes.

---

## 7. Degradation: spacious → compact

Spacious is not always possible. When it is not, the system degrades to compact by
rule, never by opinion, and the degradation is announced.

Degradation triggers (any one is sufficient):

1. **Space.** The available content area is below the spacious minimum for the surface
   (declared per surface in `03-adaptation.md`).
2. **Input.** The primary input is a five-button remote with no pointer and the
   surface requires more than the remote can reach without paging (TV, EV cluster).
3. **Workload.** A safety or high-workload state is declared and the envelope requires
   compact density for legibility (spaceship primary display during an alarm).
4. **Content.** The content cannot be re-flowed into the spacious layout without
   truncation or paging that exceeds the declared paging budget.
5. **Text.** The person's text-size preference is at or above 200% and spacious
   spacing would push primary content off screen.
6. **Performance.** The surface cannot meet its frame budget in spacious density on
   the target envelope (declared per envelope).

Degradation rules:

- **WF-SPACIOUS-016.** Degradation MUST be automatic when a trigger fires, and MUST
  be reversible when the trigger clears.
- **WF-SPACIOUS-017.** Degradation MUST be announced. The person MUST be told, in the
  surface's own language, that density changed and why, unless the change is a
  safety-required change on a safety envelope, in which case the change is recorded in
  the still and announced to assistive tech but not as a modal.
- **WF-SPACIOUS-018.** Degradation MUST NOT drop content. Content that does not fit in
  compact is re-flowed, collapsed, paged or moved to a peer, per the adaptation ladder
  in `05-apps/_standard/04-envelope-adaptation.md`.
- **WF-SPACIOUS-019.** A person's explicit density choice MUST override automatic
  degradation except where a safety rule forbids spacious (EV protected zone, spaceship
  alarm). In that case the safety rule wins and the override is recorded.

---

## 8. Spacious and the other modes

Spacious composes with, and does not replace, the other adaptation modes:

- **Reduced motion.** Spacious does not add motion. Reduced motion removes travel; the
  density is unchanged.
- **High contrast.** Spacious spacing and high-contrast colour are independent and
  compose.
- **Large text (200%).** Spacious may degrade to compact if text size forces it
  (§7, trigger 5). The person's text size always wins over density.
- **RTL.** Spacious spacing mirrors; the rules are identical.
- **One-handed / glove use.** Spacious is often the right density here, but the
  envelope's input rules take precedence.

---

## 9. The spacious test

Every spacious frame is tested four ways:

1. **Derivation.** Can the spacious frame be produced from the compact frame by the
   three changes in §1 and the rules in §3–§7? If a step cannot be named, the frame is
   a fork.
2. **Content.** Is every piece of content from the compact frame present in the
   spacious frame, possibly re-flowed, collapsed, paged or moved to a peer? If any is
   missing, the frame fails.
3. **Calm.** Remove shadows, borders and dividers. Is the hierarchy still readable?
   If not, spacing is insufficient.
4. **Floor.** Do all targets meet the spacious floors, and does the frame meet the
   accessibility floor? If not, the frame fails regardless of how calm it looks.

A frame that fails any test is not spacious. It is either compact or a defect.

---

## 10. Sources and limits

| Principle | Source | Limit |
|---|---|---|
| Working memory ~4 chunks | Miller, G. A. (1956). "The magical number seven, plus or minus two." *Psychological Review*, 63(2), 81-97. https://doi.org/10.1037/h0043158 ; Cowan, N. (2001). "The magical number 4 in short-term memory." *Behavioral and Brain Sciences*, 24(1), 87-114. https://doi.org/10.1017/S0140525X01003922 | The exact number varies by chunk type and by person; treat as an order of magnitude. Access date 23 October 2026. |
| Cognitive load theory | Sweller, J. (1988). "Cognitive load during problem solving." *Cognitive Science*, 12(2), 257-285. https://doi.org/10.1207/s15516709cog1202_4 | Most evidence is from instructional settings; UI evidence is thinner but consistent. Access date 23 October 2026. |
| Fitts's law | Fitts, P. M. (1954). "The information capacity of the human motor system." *Journal of Experimental Psychology*, 47(6), 381-391. https://doi.org/10.1037/h0055392 | Describes aimed movement; does not cover steering tasks (Accot & Zhai, 1997) or gesture. Access date 23 October 2026. |
| Target size floors | W3C (2023). *WCAG 2.2*, SC 2.5.8. https://www.w3.org/TR/WCAG22/ | 24 px is a floor, not a recommendation; stress raises the effective floor. Access date 23 October 2026. |
| Calm technology | Weiser, M. and Brown, J. S. (1997). "The coming age of calm technology." In *Beyond Calculation*, 75-85. Springer. https://doi.org/10.1007/978-1-4612-0685-9_6 | A design stance, not a measured law; evidence is qualitative. Access date 23 October 2026. |
| Stress and attention narrowing | Kahneman, D. (2011). *Thinking, Fast and Slow*. Farrar, Straus and Giroux. | General cognitive psychology; UI-specific replication is limited. Access date 23 October 2026. |
| Situation awareness and interruption cost | Endsley, M. R. (1995). "Toward a theory of situation awareness in dynamic systems." *Human Factors*, 37(1), 32-64. https://doi.org/10.1518/001872095779049543 | Aviation-derived; transfer to consumer UI is supported but not one-to-one. Access date 23 October 2026. |
| Accessibility and spacing | W3C (2023). *WCAG 2.2*. https://www.w3.org/TR/WCAG22/ ; ISO (2018). *ISO 9241-11*. https://www.iso.org/standard/63500.html | Standards are consensus minima, not optima. Access date 23 October 2026. |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-WF-SPACIOUS-010` | Every spacious frame derives from its compact frame by the three changes in §1 and the rules in §3–§7. |
| `AC-WF-SPACIOUS-011` | No spacious frame changes colour, depth semantics, motion grammar, state machine, command IDs or wording. |
| `AC-WF-SPACIOUS-012` | Every spacious target meets the floors in §2.2 and every frame meets the accessibility floor. |