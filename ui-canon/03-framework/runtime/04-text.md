---
id: FW-RUNTIME-TEXT
title: "Text: shaping, bidi, fallback, IME, selection, accessibility, variable fonts"
kind: framework
entity: runtime
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-RUNTIME-MIRUI, FOUND-TYPOGRAPHY-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-FW-TEXT-001]
---

# Text

> Text is a first-class runtime concern: shaping, bidi, fallback, IME, selection and
> accessibility all ride the same data. There is no "just draw a string" path.

---

## 1. Shaping

- MirUI text widget supports wrap, align, vertical align, overflow, max lines, line height,
  letter/word spacing, direction, language, shaping policy, font features
  (`src/ui/widgets/text.rs:155`–`167` `ParagraphStyle`).
- FW-TEXT-001. Shaping MUST respect the declared language and script; shaping policy
  `Auto`/`Required`/`Simple` maps to the foundation's typography rules.
- FW-TEXT-002. Variable fonts are preferred where licensed; axes (weight, width, optical
  size) resolve through tokens, not hardcoded values.
- FW-TEXT-003. Ligatures and contextual alternates follow the language tag; they MUST NOT
  break copy/paste or search (the underlying codepoint sequence is preserved).

## 2. Bidi

- `TextDirection::{Auto, LeftToRight, RightToLeft}` (`src/ui/widgets/text.rs:51`).
- FW-TEXT-004. `Auto` resolves via the Unicode bidi algorithm on the content; explicit
  direction overrides for UI labels with known direction.
- FW-TEXT-005. Mixed-direction text (e.g. an Arabic sentence with an English file name)
  MUST render with correct reordering and MUST keep the selection logical.

## 3. Fallback

- FW-TEXT-006. A missing glyph falls back through the declared font chain; the final
  fallback is a visible replacement (tofu) with a recorded reason, never a silent blank.
- FW-TEXT-007. Font families are named by role in tokens until licensed families land
  (FW-Q-001).
- FW-TEXT-008. Emoji and symbol fonts are separate fallbacks and MUST NOT displace text
  metrics.

## 4. IME

- FW-TEXT-009. Composition state (preedit) is rendered distinctly (underline) and is
  announced to assistive tech as "composing".
- FW-TEXT-010. Commit and cancel of composition are explicit; a partial composition is never
  silently committed on focus loss — it is cancelled with a reason.
- FW-TEXT-011. IME works on every envelope that has text input, including TV (remote text
  entry) and EV (driver-safe entry constraints).

## 5. Selection

- FW-TEXT-012. Selection is logical (codepoint ranges), not visual (rects); visual rects are
  derived.
- FW-TEXT-013. Selection supports: char, word, line, all; keyboard (shift+arrow) and
  pointer (drag, double/triple click).
- FW-TEXT-014. Copy/cut/paste use the system clipboard capability; permission is explicit.
- FW-TEXT-015. Password/secure fields disable selection and copy of the value; the reveal
  affordance is a separate control.

## 6. Accessibility

- FW-TEXT-016. The accessibility tree receives the text content, not the rendered glyphs.
- FW-TEXT-017. Heading/paragraph/list semantics are declared by the component, not inferred
  from styling.
- FW-TEXT-018. Text scaling to 200% MUST NOT clip or lose content (FW-LAYOUT-013).

## 7. Numerals

- Tabular numerals for columns; proportional for prose. Numeral system (Arabic-Indic etc.)
  follows locale. FW-TEXT-019. A number's value is preserved across locale formatting.

## 8. Performance

- FW-TEXT-020. Shaping results are cached per (string, font, scale, width) and invalidated
  on change; cache size is budgeted.
- FW-TEXT-021. Long documents virtualise: only visible paragraphs are shaped.

## Acceptance

| ID | Test |
|---|---|
| `AC-FW-TEXT-001` | Mixed LTR/RTL/emoji text renders, selects, copies and is announced correctly at 100% and 200% scale. |
| `AC-FW-TEXT-002` | IME composition, commit and cancel work on phone and TV. |
| `AC-FW-TEXT-003` | Missing glyph fallback is visible and recorded. |