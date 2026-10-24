---
id: FOUND-EXPERIENCE-JOURNEY
title: Emotional Journey — First Contact, First Success, Daily Use, Error, Recovery, Long-Term Trust
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, FOUND-EXPERIENCE-FELT, FOUND-EXPERIENCE-PERSONAS]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-JOURNEY-001, AC-EXP-JOURNEY-002, AC-EXP-JOURNEY-003]
---

# Emotional Journey

> The emotional curve from first contact to long-term trust, per envelope. Designed,
> not left to chance.

## 1. The journey stages

1. **First contact.** The person sees the system for the first time. Emotion: curiosity
   or anxiety. Goal: discover the primary action in < 5 s; no overwhelm.
2. **First success.** The person completes a task. Emotion: relief, then confidence.
   Goal: success without a manual, a tour or a hint.
3. **Daily use.** The person uses the system routinely. Emotion: calm, capability.
   Goal: low friction, low cognitive load, flow.
4. **Error.** Something goes wrong. Emotion: frustration, anxiety. Goal: no blame;
   clear cause and recovery.
5. **Recovery.** The person recovers. Emotion: relief, restored trust. Goal: recovery
   is faster than the error.
6. **Long-term trust.** The person relies on the system for years. Emotion: trust,
   ownership. Goal: consistency, honesty, reversibility.

## 2. Emotional curve per envelope

### 2.1 Phone

- First contact: curiosity (lock screen → home, one clear action).
- First success: confidence (first message sent in < 60 s).
- Daily use: calm, capability (spacious-ish, clear hierarchy).
- Error: frustration, then relief (clear message, undo).
- Recovery: restored trust.
- Long-term: trust, ownership.

### 2.2 Desktop

- First contact: competence (familiar grammar, dense but legible).
- First success: confidence (first document saved).
- Daily use: flow, capability (compact, keyboard-first).
- Error: frustration, then relief.
- Recovery: restored trust.
- Long-term: trust, ownership, expertise.

### 2.3 Watch

- First contact: delight at simplicity (glanceable).
- First success: confidence (first notification handled).
- Daily use: calm, unhurried (minimal chrome).
- Error: rare; recovery is immediate (undo).
- Long-term: trust (reliable, quiet).

### 2.4 TV

- First contact: ease (remote, large targets).
- First success: confidence (first app launched).
- Daily use: calm, leisure.
- Error: mild frustration; recovery via remote.
- Long-term: trust (shared, family).

### 2.5 EV

- First contact: safety (clear, bounded, no surprise).
- First success: confidence (first drive task completed safely).
- Daily use: calm, alert (safety-aware, not anxious).
- Error: alert, then relief (clear, actionable).
- Recovery: restored safety.
- Long-term: trust (safety-critical reliability).

### 2.6 Spaceship

- First contact: competence (procedure-first, redundant).
- First success: confidence (first procedure completed).
- Daily use: alert, calm (high workload, bounded).
- Error: alert, then relief (redundant cues, procedure).
- Recovery: restored awareness.
- Long-term: trust (deterministic, reliable).

## 3. What breaks the journey

- A first contact that overwhelms → anxiety, abandonment.
- A first success that requires a manual → incompetence, abandonment.
- An error that blames → shame, distrust.
- A recovery that loses work → anger, distrust.
- A long-term inconsistency → confusion, distrust.

Each of these is a defect with an AC in `10-acceptance.md`.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-JOURNEY-001` | First-contact test: primary action in < 5 s on every envelope. |
| `AC-EXP-JOURNEY-002` | First success without manual/tour on every envelope. |
| `AC-EXP-JOURNEY-003` | Error → recovery → restored trust completes without data loss. |