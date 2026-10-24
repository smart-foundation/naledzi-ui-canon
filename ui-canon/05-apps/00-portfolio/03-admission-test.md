---
id: PORTFOLIO-ADMISSION
title: App Admission Test
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-NEEDS, PORTFOLIO-JOBS, CANON-TIMELESSNESS, CANON-LAWS, APP-STANDARD, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-ADMISSION-001, AC-PORTFOLIO-ADMISSION-002, AC-PORTFOLIO-ADMISSION-003, AC-PORTFOLIO-ADMISSION-004]
---

# App Admission Test

> No app is admitted because a legacy OS ships one. Admission is scored, not felt. A
> candidate passes only if it serves a need older than computing, survives change of
> input, display and envelope, declares its capabilities honestly, keeps data local and
> owned, earns trust, is accessible, carries no legacy chrome, works offline and can be
> reproduced by a stranger.

---

## 1. The two questions (before scoring)

Answer both in one sentence. If either is weak, stop and do not score.

- **Q1 — The human question.** What need does this serve that existed before computers?
  (One of N1–N12, or a sub-need stated in the same form.) If the need only exists
  because the interface exists ("users need a home screen to launch apps"), it is a
  workaround, not a primitive.
- **Q2 — The change question.** What happens to this when input, display and form factor
  change? If the answer is "it breaks and we add a special case per device", it is not
  timeless. If the answer is "the same model, a different executor", it is.

---

## 2. The scorecard

Each criterion scored **0, 1 or 2**. Maximum **20**.

| # | Criterion | 0 | 1 | 2 |
|---|---|---|---|---|
| 1 | **Human need** | Exists only because of the interface | Useful but shallow; need is tool-induced | Serves a need older than computing (N1–N12) |
| 2 | **Job survival** | Job disappears when the tool is removed | Job survives but is reworded per tool | Job is stated in Christensen form and survives any tool |
| 3 | **Envelope reach** | Needs a device-specific fork | Works on two envelopes; declared exceptions on others | Same behaviour on ≥3 envelopes; layout adapts by rule |
| 4 | **Capability honesty** | Capability needs undeclared or assumed | Declared but no denied-state behaviour | Required/optional/refused declared; honest when denied |
| 5 | **Data ownership** | Keeps a shadow copy of another owner's fact; cloud-required | Local-first with sync; ownership ambiguous | Local-first; user owns data; no shadow authority (`LAW-001`, `LAW-020`) |
| 6 | **Trust** | Dark patterns, hidden defaults, no reversibility | Partial reversibility; some honest absence | Reversible or confirmable; honest absence; grants revocable |
| 7 | **Accessibility** | Visual/pointer only | Partial alternative path | Full path: keyboard, screen reader, switch, voice, reduced motion |
| 8 | **No legacy chrome** | Permanent chrome with no timeless job | Chrome is summonable on some envelopes | No permanent chrome; everything summoned or earned (`LAW-010`) |
| 9 | **No network dependency** | Core task requires network | Core task works offline with degraded sync | Core task works offline; remote is a peer (`LAW-017`) |
| 10 | **Reproducibility** | Spec incomplete; stranger cannot implement | Spec complete for happy path only | Full standard: model, behaviour, flows, states, a11y, perf, ACs, stranger test |

**Admission.**

- **Canon (proposed):** score ≥ 16, and no 0 on criteria 1–4.
- **Review:** score 12–15. Kept as a layer or folded into another app; not admitted as a
  standalone app.
- **Reject:** score < 12, or any 0 on 1–4.

A score of 20 is rare and not required. A score of 18 with a declared weakness is better
than a dishonest 20 (`CANON-TIMELESSNESS` §2).

---

## 3. The tests behind the score

### 3.1 The input swap

Describe the core task with a pointer. Then touch. Then keyboard only. Then a TV remote
(five buttons). Then voice. Then gaze or neural input. If any path requires a different
*model* (not a different binding), score ≤ 1 on criterion 3. If any path is impossible,
score 0.

### 3.2 The display swap

Describe it at 40 mm (watch), 150 mm (phone), 300 mm (tablet), 600 mm (laptop), 1.5 m
(TV), across a car cabin, and on a non-rectangular or spatial display. If it needs a
different information architecture per size, it is not adaptive — score ≤ 1 on criterion 3.

### 3.3 The decade swap

Remove the current fashion, framework and screen technology. Does the app still make
sense? If it only works because "that is how apps look now", score 0 on criterion 1.

### 3.4 The first-contact test

Show it to someone who has never seen the OS. Can they discover the primary action in
under five seconds without a tooltip, coach mark or manual? If not, score ≤ 1 on
criterion 6 (trust/learnability) and criterion 7.

### 3.5 The idle test

Leave it alone for an hour. Measure CPU, GPU, wakeups, messages and battery. If it
costs anything, score ≤ 1 on criterion 9 (no network) is not enough — also check
`08-performance.md`. Idle silence is `LAW-004`.

### 3.6 The failure test

Deny a capability, kill a service, disconnect the network, fill the disk, remove the
output. Does the app explain itself and recover? If it lies or freezes, score 0 on
criterion 4 (capability honesty).

### 3.7 The stranger test

Hand the directory to a competent team that has never spoken to you. Can they implement
it without asking a question? If not, the *specification* is not reproducible,
regardless of the idea. Fix the spec before scoring again (criterion 10).

### 3.8 The offline test

Disconnect the network. Does the core task complete? Reconnect. Does state reconcile
without corruption? (`LAW-017`.)

---

## 4. The kill rule

A candidate is **killed** (rejected, not admitted, not transformed) when any of the
following is true:

1. Score < 12.
2. Any 0 on criteria 1–4.
3. The candidate is a tool-induced job (`PORTFOLIO-NEED-011`): the need disappears when
   the current tool is removed.
4. The candidate requires a network for its core task (`LAW-017`).
5. The candidate keeps a shadow copy of a fact owned by another service (`LAW-001`).
6. The candidate draws permanent chrome with no timeless job (`LAW-010`).
7. The candidate cannot state its human need in one sentence predating computing.

A killed candidate is recorded in `05-rejections.md` with its score and the reason. It is
not deleted; the reason is part of the design (`PROC-APPEND-ONLY`).

---

## 5. The transform rule

A score of 12–15 does not mean "delete". It means **keep the need, replace the form.**
Write down all five:

1. the need the thing serves;
2. the assumptions that failed;
3. the primitive that survives the assumptions;
4. the per-envelope renderings of that primitive;
5. the evidence that the new form is better.

If you cannot do all five, the thing is rejected, not transformed
(`CANON-TIMELESSNESS` §5).

For apps, a transform usually means: the job survives but the *app* does not; the job is
folded into another app's domain, or into a shell surface, or into a cross-app flow.

---

## 6. Worked example — the calculator (compute domain)

The calculator is the reproducibility exemplar. Its score is recorded here as the
reference for how a small app is scored.

| Criterion | Score | Why |
|---|---|---|
| 1 Human need | 2 | Computing a quantity predates computers (abacus, slide rule). |
| 2 Job survival | 2 | "When I need a number, I want to get it" survives any tool. |
| 3 Envelope reach | 2 | Watch, phone, tablet, desktop, TV, spatial; same model, different input. |
| 4 Capability honesty | 2 | No capabilities needed beyond local compute; refused list explicit. |
| 5 Data ownership | 2 | History is local; no shadow copy. |
| 6 Trust | 2 | Determinate; no network; honest absence on overflow. |
| 7 Accessibility | 2 | Full keyboard, screen reader, switch path. |
| 8 No legacy chrome | 2 | No permanent chrome; opens on demand. |
| 9 No network dependency | 2 | Works offline entirely. |
| 10 Reproducibility | 2 | Full standard; stranger test passed. |
| **Total** | **20** | **Canon (proposed).** |

The calculator is admitted as the exemplar. It is not a mandate that every device ships a
calculator; its envelope status is `contextual` on TV and `absent` on IoT, recorded in
`06-envelope-map.md`.

---

## 7. Worked example — the dock (rejected)

| Criterion | Score | Why |
|---|---|---|
| 1 Human need | 1 | Switching and launching are real, but the dock conflates them. |
| 2 Job survival | 1 | The job survives; the form does not. |
| 3 Envelope reach | 0 | Assumes a wide, permanent strip. |
| 4 Capability honesty | 1 | Undeclared on small envelopes. |
| 5 Data ownership | 2 | n/a — no data. |
| 6 Trust | 1 | Usually silent on failure. |
| 7 Accessibility | 1 | Usually reachable, often poorly labelled. |
| 8 No legacy chrome | 0 | Permanent chrome with no timeless job. |
| 9 No network dependency | 2 | n/a. |
| 10 Reproducibility | 1 | Inherited, not specified. |
| **Total** | **9** | **Reject. Transform into the strip.** |

Outcome: the need (switch, resume, launch) is kept; the form becomes the summon-only strip
(`04-shell/strip/`).

---

## 8. Scoring protocol

1. Score before writing the app directory. An app whose score is not recorded is not
   ready (`LAW-012`).
2. Score with evidence, not opinion. Each cell cites a reason in one clause.
3. A score of 1 requires a stated weakness; a 0 requires a stated cause.
4. Re-score only when the candidate changes materially (new envelope, new capability,
   new failure cost). Record the change in `09-open-questions.md` or the app changelog.
5. The Portfolio Architect's scores are `review` until Gate 1 freezes them.

---

## 9. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-ADMISSION-001` | Every candidate in `04-candidate-portfolio.md` has a scored row in this format. |
| `AC-PORTFOLIO-ADMISSION-002` | No candidate is admitted with a 0 on criteria 1–4. |
| `AC-PORTFOLIO-ADMISSION-003` | Every rejected candidate has a recorded score and reason in `05-rejections.md`. |
| `AC-PORTFOLIO-ADMISSION-004` | A second scorer can reproduce the score within ±1 from the candidate description. |