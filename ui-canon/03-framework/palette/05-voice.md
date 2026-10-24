---
id: FW-PALETTE-VOICE
title: Voice
kind: framework
entity: palette
status: canon
normative: true
version: 0.1.0
owner: Framework Guild
depends: [FW-PALETTE-INDEX, FW-README, CANON-LAWS, APP-STANDARD]
acceptance: [AC-FW-PALETTE-005]
---

# Voice

---

## 1. Same commands

Voice invokes the same command registry, with the same IDs, availability and capability
checks. There is no second "voice command" set.

## 2. Recognition

- Speech is transcribed to text, then matched against command titles/keywords using the
  same matcher as typing.
- Low-confidence matches require confirmation before dispatch.
- Ambiguous matches present a short list for selection.

## 3. Confirmation

- Destructive commands always confirm, visually and audibly, before dispatch.
- Commands with side effects on shared data confirm when the cost of reversal is high.
- Confirmation uses the standard confirmation prompt component.

## 4. Transcript

- The recognised transcript is shown in the palette input field so the person can correct it.
- Corrections re-run matching.

## 5. Accessibility

- Voice is an input modality, not a separate accessibility mode.
- Screen-reader users can invoke voice and receive the transcript as an announcement.
