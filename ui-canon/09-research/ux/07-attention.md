---
id: UX-ATTENTION
title: Attention — Interruption Cost, Notification Fatigue, Resumption, Signal Detection, Alarm Fatigue
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, UX-COGNITION, UX-EMOTION]
supersedes: []
superseded_by: []
acceptance: [AC-UX-ATTENTION-001, AC-UX-ATTENTION-002, AC-UX-ATTENTION-003]
---

# Attention

> Attention is finite and owned by the person. Interruptions cost. Notifications
> fatigue. Alarms cry wolf. Resumption must be designed.

## 1. Principle

Attention is the scarce resource of the interface. Every interruption has a cost in
time and in error. Notifications that are not actionable are noise. Repeated false
alarms erode response to real ones. Resumption after an interruption must restore
context, not restart the task. The system MUST budget attention and never spend it on
its own behalf.

## 2. Evidence

### 2.1 Interruption cost

- **Mark, G., Gudith, D. and Klocke, U. (2008).** "The cost of interrupted work:
  more speed and stress." *Proceedings of CHI '08*, pp. 107–110. (URL:
  https://doi.org/10.1145/1357054.1357072 ; accessed 23 October 2026.) Finding:
  interrupted work is resumed faster but with more stress and more errors; the cost
  is paid in quality, not just time. Implication: Naledzi interrupts only when the
  value exceeds the cost; non-urgent notifications are queued.

- **Bailey, B. P. and Konstan, J. A. (2006).** "On the need for attention-aware
  systems: measuring effects of interruption on task performance, error rate, and
  affective state." *Computers in Human Behavior*, 22(4), pp. 685–708. (URL:
  https://doi.org/10.1016/j.chb.2005.12.009 ; accessed 23 October 2026.) Finding:
  interruption timing and modality determine cost; breakpoints reduce cost.
  Implication: Naledzi delivers notifications at task breakpoints where possible;
  urgent safety overrides are the exception.

### 2.2 Notification fatigue

- **Iqbal, S. T. and Bailey, B. P. (2010).** "Oasis: a framework for linking
  notification delivery to the perceptual structure of goal-directed tasks."
  *ACM Transactions on Computer-Human Interaction*, 17(4), art. 15. (URL:
  https://doi.org/10.1145/1879831.1879833 ; accessed 23 October 2026.) Finding:
  notifications delivered at subtask boundaries are less disruptive. Implication:
  Naledzi's notification delivery policy prefers breakpoints; the framework exposes
  task structure to the delivery policy.

- **Pielot, M., Church, K. and de Oliveira, R. (2014).** "An in-situ study of
  mobile phone notifications." *Proceedings of MobileHCI '14*, pp. 233–242. (URL:
  https://doi.org/10.1145/2628363.2628364 ; accessed 23 October 2026.) Finding:
  people receive dozens of notifications a day and ignore most; response depends on
  content and sender. Implication: notification budgets are mandatory; batching and
  summarisation are the default.

### 2.3 Resumption

- **Trafton, J. G. and Monk, C. A. (2007).** "Task interruptions." *Reviews of
  Human Factors and Ergonomics*, 3(1), pp. 111–126. (URL:
  https://doi.org/10.1518/155723408X299852 ; accessed 23 October 2026.) Finding:
  resumption lag is reduced by leaving the task in a visible, recoverable state.
  Implication: Naledzi preserves the task state and the cursor/focus on
  interruption; resumption restores it.

- **Altmann, E. M. and Trafton, J. G. (2002).** "Memory for goals: an
  activation-based model." *Cognitive Science*, 26(1), pp. 39–83. (URL:
  https://doi.org/10.1207/s15516709cog2601_2 ; accessed 23 October 2026.)
  Finding: goals decay during interruption; external cues aid recovery. Implication:
  Naledzi shows a resumption cue (what was I doing?) after a long interruption.

### 2.4 Signal detection and alarm fatigue

- **Endsley, M. R. (1995).** "Toward a theory of situation awareness in dynamic
  systems." *Human Factors*, 37(1), pp. 32–64. (URL:
  https://doi.org/10.1518/001872095779049543 ; accessed 23 October 2026.)
  Finding: situation awareness is perception, comprehension, projection; information
  must be perceived to be understood. Implication: a signal that is not perceived
  (too small, too fast, occluded) is not a signal.

- **Cvach, M. (2012).** "Monitor alarm fatigue: an integrative review." *Biomedical
  Instrumentation & Technology*, 46(4), pp. 268–277. (URL:
  https://doi.org/10.2345/0899-8205-46.4.268 ; accessed 23 October 2026.)
  Finding: 85–99% of clinical alarms are false or non-actionable; alarm fatigue
  causes real alarms to be missed. Implication: Naledzi suppresses non-actionable
  alarms; every alarm must be actionable; repeated false alarms are a defect, not
  a nuisance.

- **Sorkin, R. D. (1988).** "Why are people turning off our alarms?" *The Journal of
  the Acoustical Society of America*, 84(3), pp. 1107–1108. (URL:
  https://doi.org/10.1121/1.396756 ; accessed 23 October 2026.) Finding: alarms that
  cry wolf are disabled by users; the only cure is accuracy. Implication: Naledzi
  never emits an alarm it cannot justify; a disabled alarm is a design failure.

### 2.5 Attention budget

- **LAW-020 (canon).** Notifications and motion respect attention as a finite
  resource. Implication: notification budgets, quiet hours, and a single, honest
  priority scheme.

## 3. What this predicts for Naledzi

1. **Attention budget is mandatory.** Per-person, per-device, per-day limits.
2. **Interruptions are queued unless urgent.** Safety overrides are the exception.
3. **Breakpoint delivery preferred.** Subtask boundaries.
4. **Resumption restores context.** State, focus, cursor, cue.
5. **Alarms are actionable and accurate.** No cry-wolf.
6. **Quiet hours are mandatory.** With safety override.

## 4. Limits and contested claims

- Interruption-cost figures are from office work; transfer to mobile and safety
  contexts is interpretation.
- Alarm-fatigue research is clinical; the OS is not a medical device, but the
  principle (false alarms erode response) transfers.

## 5. Where implemented (IDs)

- `UX-LAW-07`.
- `LAW-020`.
- `04-shell/notifications/` — delivery, priority, history.
- `01-foundations/experience/08-attention-notifications.md`.

## 6. Acceptance implications

- `AC-UX-ATTENTION-001`: Non-urgent notifications are queued, not interrupting, in
  the reference flow.
- `AC-UX-ATTENTION-002`: Resumption restores state, focus and cursor after
  interruption.
- `AC-UX-ATTENTION-003`: No non-actionable alarm is emitted in the safety
  reference flow.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-ATTENTION-001` | Non-urgent notifications queued. |
| `AC-UX-ATTENTION-002` | Resumption restores context. |
| `AC-UX-ATTENTION-003` | No non-actionable alarms. |