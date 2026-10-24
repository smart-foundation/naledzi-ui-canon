---
id: PORTFOLIO-NEEDS
title: Human Needs That Predate Computing
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, CANON-TIMELESSNESS, CANON-LAWS, UX-RESEARCH-INDEX, UX-TIMELESSNESS]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-008, AC-UX-TIMELESSNESS-001]
---

# Human Needs That Predate Computing

> An app is not a legacy category with a new skin. It is a response to a need that existed
> before computers. If the need only exists because the interface exists, the thing is a
> workaround, not a primitive.

---

## 1. The distinction: need, job, solution, app

Four layers, four owners. Conflating them is how legacy app lists get inherited.

| Layer | Question | Example | Owner in this corpus |
|---|---|---|---|
| **Need** | What does a human lack or seek, independent of any tool? | "I need to remember." | `01-needs-not-apps.md` |
| **Job** | What progress does the person try to make, in a situation, with success criteria? | "When I meet someone new, I want to capture their name and context so I can recall it later." | `02-job-domains.md` |
| **Solution** | What mechanism satisfies the job, with what trade-offs? | A searchable, syncable, private store of contacts with notes. | app standard + envelopes |
| **App** | A capability-scoped, stateful view of the domain, in the shared grammar. | The people/contacts surface. | `05-apps/<name>/` |

**Rules.**

- `PORTFOLIO-NEED-001`. A candidate app MUST name a need that predates computing in one
  sentence. If the sentence contains "app", "screen", "icon", "dock", "tab" or a vendor
  name, it is a solution masquerading as a need and is rejected.
- `PORTFOLIO-NEED-002`. A need is not a feature. "I need to sort files by date" is a
  feature; "I need to find what I stored" is a need.
- `PORTFOLIO-NEED-003`. Jobs are stated in the Christensen form: *When [situation], I want
  to [action], so I can [outcome].* The situation and the outcome are the unit of analysis,
  not the person's demographics (Christensen, Dillon, Hall & Duncan, 2016).
- `PORTFOLIO-NEED-004`. A job domain (see `02-job-domains.md`) groups jobs by the need they
  serve and the context they share. It is not an app and does not imply one app.

---

## 2. The needs that predate computing

These twelve are the set. They are not a taxonomy of apps; they are a taxonomy of human
life. Every candidate in `04-candidate-portfolio.md` traces to at least one. The list is
deliberately short: a need that cannot be stated in one sentence is not a need.

| # | Need | What it means | Older than computing? |
|---|---|---|---|
| N1 | **Communicate** | Move meaning between people across distance and time. | Yes — speech, writing, signal fires, post. |
| N2 | **Remember** | Keep facts, experiences and commitments available later. | Yes — memory, knots, ledgers, libraries. |
| N3 | **Create** | Make something that did not exist: text, image, sound, object, plan. | Yes — craft, art, writing. |
| N4 | **Compute** | Derive a quantity, relation or prediction from inputs. | Yes — counting, abacus, slide rule, ledger. |
| N5 | **Navigate** | Know where I am, where things are, and how to get there. | Yes — landmarks, maps, stars, dead reckoning. |
| N6 | **Care** | Sustain the body and the people I am responsible for: health, food, shelter, safety. | Yes — medicine, husbandry, parenting. |
| N7 | **Learn** | Acquire skill and understanding, and teach it. | Yes — apprenticeship, school, conversation. |
| N8 | **Transact** | Exchange value, agree terms, settle. | Yes — barter, money, contract. |
| N9 | **Control environment** | Change the state of the world around me: light, heat, sound, motion, access. | Yes — fire, switches, locks, thermostats. |
| N10 | **Observe** | Notice what is happening now or over time, in the world or in the system. | Yes — watching, measuring, logging. |
| N11 | **Rest** | Recover attention and energy; be still without demand. | Yes — sleep, pause, contemplation. |
| N12 | **Coordinate** | Align people, tasks and time so joint work happens. | Yes — calendars, rosters, command. |

**Evidence.**

- Maslow, A. H. (1943). "A theory of human motivation." *Psychological Review*, 50(4),
  pp. 370–396. URL: https://doi.org/10.1037/h0054346 — accessed 23 October 2026.
  Finding: human motivation is organised around needs that predate any tool, from
  physiological survival to self-actualisation. Implication: Naledzi's need list is
  organised around what a person is trying to become, not around what a device can do.
- Max-Neef, M. A. (1991). *Human Scale Development: Conception, Application and Further
  Reflections.* Apex Press. URL:
  https://web.archive.org/web/20130319153338/http://www.max-neef.cl/download/Max-neef_Human_Scale_development.pdf
  — accessed 23 October 2026. Finding: needs are finite, few and constant across
  cultures; what changes is the satisfier. Implication: the need list is short and stable;
  apps are satisfiers and may change, the needs do not.
- Nussbaum, M. C. (2011). *Creating Capabilities: The Human Development Approach.*
  Harvard University Press. URL: https://www.hup.harvard.edu/books/9780674072350 —
  accessed 23 October 2026. Finding: a life worthy of dignity requires a set of central
  capabilities (bodily health, senses and imagination, practical reason, affiliation,
  control over one's environment, play). Implication: N9 (control environment), N6 (care)
  and N11 (rest/play) are not luxuries; they are capabilities the system must not take
  away.
- Alderfer, C. P. (1969). "An empirical test of a new theory of human needs."
  *Organizational Behavior and Human Performance*, 4(2), pp. 142–175.
  URL: https://doi.org/10.1016/0030-5073(69)90004-X — accessed 23 October 2026.
  Finding: needs operate in parallel (existence, relatedness, growth), not only as a
  strict hierarchy. Implication: Naledzi does not gate "higher" needs behind "lower" ones;
  rest and play are available even when a task is open.
- Norman, D. A. (2013). *The Design of Everyday Things* (revised). Basic Books.
  URL: https://www.worldcat.org/title/design-of-everyday-things/oclc/851388459 —
  accessed 23 October 2026. Finding: people act on mental models of need, not on
  system models. Implication: an app that names its internal model instead of the
  person's need fails the first-contact test.
- Cooper, A. (1999). *The Inmates Are Running the Asylum.* Sams.
  URL: https://www.worldcat.org/title/inmates-are-running-the-asylum/oclc/41024079 —
  accessed 23 October 2026. Finding: software is designed by engineers for engineers;
  goal-directed design starts from user goals. Implication: Naledzi derives apps from
  goals, not from engineering components.

**Limits.** Maslow's hierarchy is contested and culturally specific; Max-Neef's list is
one of several; Nussbaum's capabilities are philosophical, not empirical. Naledzi uses
them as a *checklist of human breadth*, not as a proof. The twelve needs are a design
hypothesis until tested against real users (`GAP-RES-01`).

---

## 3. Activity theory: need → activity → action → operation

Activity theory (Leont'ev, 1978; Engeström, 1987) gives the mechanism that turns a need
into a job. It is the reason an app is not a need and a need is not an app.

| Level | Driven by | Example (remembering) |
|---|---|---|
| **Need** | Motive | "I need to remember." |
| **Activity** | Object / motive | "Keeping my commitments." |
| **Action** | Conscious goal | "Capture this person's name and context." |
| **Operation** | Conditions / tools | "Type into a field, attach a photo, set a reminder." |

**Rules.**

- `PORTFOLIO-NEED-005`. An app owns **actions and operations**, not needs and not
  activities. The need and the activity belong to the person; the app is the tool.
- `PORTFOLIO-NEED-006`. When the conditions change (input, display, envelope), the
  operation changes and the action may change, but the need and the activity do not. If
  they do, the app was modelled on the tool, not on the person.
- `PORTFOLIO-NEED-007`. An app that can only be described at the operation level ("tap
  the blue button") has no timeless model and is rejected.

**Evidence.**

- Leont'ev, A. N. (1978). *Activity, Consciousness, and Personality.* Prentice-Hall.
  URL: https://www.worldcat.org/title/activity-consciousness-and-personality/oclc/3844408
  — accessed 23 October 2026. Finding: activity is object-oriented and motive-driven;
  actions are goal-directed; operations are condition-driven and routinised. Implication:
  Naledzi specifies at the action level and lets operations vary by envelope.
- Engeström, Y. (1987). *Learning by Expanding: An Activity-Theoretical Approach to
  Developmental Research.* Orienta-Konsultit. URL:
  https://www.amazon.com/Learning-Expanding-Activity-Theoretical-Approach-Developmental/dp/1107074428
  — accessed 23 October 2026. Finding: an activity system includes subject, object,
  tools, community, rules and division of labour; change in any element restructures the
  whole. Implication: an app is one tool inside a person's activity system; it must not
  assume it is the whole system or the only tool.
- Kuutti, K. (1996). "Activity theory as a potential framework for
  human-computer interaction research." In *Context and Consciousness*, B. A. Nardi (ed.),
  MIT Press, pp. 17–44. URL:
  https://mitpress.mit.edu/9780262140593/context-and-consciousness/ — accessed 23 October
  2026. Finding: activity theory resists reducing the user to a task performer;
  the unit of analysis is the activity, not the click. Implication: Naledzi's job
  statements are situated (situation + outcome), not decontextualised task lists.

---

## 4. Jobs to be done: situation, not persona

Jobs-to-be-done (Christensen & Raynor, 2003; Christensen et al., 2016; Ulwick, 2016)
replaces the question "who is the user?" with "what progress is the user trying to make,
in this situation, with what success criteria?"

**Rules.**

- `PORTFOLIO-NEED-008`. A job statement MUST name the situation (trigger), the action and
  the outcome. Demographics are not a situation.
- `PORTFOLIO-NEED-009`. A job has functional, emotional and social dimensions. An app that
  serves only the functional dimension and ignores the emotional or social one is
  incomplete; see `01-foundations/experience/`.
- `PORTFOLIO-NEED-010`. Competing solutions to the same job include non-software ones. If
  a paper notebook satisfies the job better in a given context, the app must earn its place
  on capability, not on existence.
- `PORTFOLIO-NEED-011`. A job that is only performed because the current tool makes it
  necessary (e.g., "organise my files into folders") is a tool-induced job and is
  rejected or folded into a deeper job.

**Evidence.**

- Christensen, C. M. and Raynor, M. E. (2003). *The Innovator's Solution: Creating and
  Sustaining Successful Growth.* Harvard Business School Press.
  URL: https://search.worldcat.org/title/innovators-solution/oclc/52047969 — accessed
  23 October 2026. Finding: customers hire products to do a job; the job, not the
  customer segment, is the unit of analysis. Implication: Naledzi groups apps by job, not
  by user type.
- Christensen, C. M., Hall, T., Dillon, K. and Duncan, D. S. (2016). *Competing Against
  Luck: The Story of Innovation and Customer Choice.* HarperBusiness.
  URL: https://search.worldcat.org/title/Competing-Against-Luck-:-The-Story-of-Innovation-and-Customer-Choice/oclc/957652628
  — accessed 23 October 2026. Finding: a job has functional, emotional and social
  dimensions; the circumstances of the struggle matter more than the customer's
  attributes. Implication: every candidate states all three dimensions or declares which
  are not served and why.
- Ulwick, A. W. (2016). *Jobs to Be Done: Theory to Practice.* Idea Bite Press.
  URL: https://www.amazon.com/Jobs-be-Done-Theory-Practice/dp/0990576744 — accessed
  23 October 2026. Finding: jobs decompose into desired outcomes with metrics; a product
  wins by satisfying more outcomes better. Implication: admission scores include
  capability honesty and data ownership, not only task completion.
- Kano, N., Seraku, N., Takahashi, F. and Tsuji, S. (1984). "Attractive quality and
  must-be quality." *Journal of the Japanese Society for Quality Control*, 14(2),
  pp. 39–48. URL: https://www.worldcat.org/title/journal-of-the-japanese-society-for-quality-control/oclc/2240813
  — accessed 23 October 2026. Finding: quality attributes split into must-be, one-dimensional
  and attractive; delight decays into must-be over time. Implication: a feature that is
  attractive today becomes a must-be tomorrow; the admission test scores decade
  independence to resist this.

---

## 5. Why "need" is not "solution"

The most common error in deriving a portfolio is to take a familiar app and rename it.
The test that catches this is the **decade swap** and the **input swap**
(`CANON-TIMELESSNESS` §3.1–3.3).

| Legacy app name | Assumed need | Actual deeper need | Verdict |
|---|---|---|---|
| File manager | "I need folders." | "I need to find what I stored." | Fold: search + files as one job domain. |
| Browser | "I need tabs." | "I need to read and navigate information." | Fold: reading + navigation; no chrome mandate. |
| Settings | "I need a settings tree." | "I need to change what the system does, safely." | Survives as a control surface, re-derived. |
| App store | "I need a grid of apps." | "I need to get capability I do not have." | Fold: capability discovery, not a grid. |
| Home screen | "I need icons." | "I need to resume or start what matters." | Fold into strip + launcher job. |
| Dock | "I need a permanent bar." | "I need to switch and resume." | Transformed into the strip. |
| Widget dashboard | "I need glanceable tiles." | "I need to observe without opening." | Fold into observe job + status rail. |
| Notification centre | "I need a separate place." | "I need to know what interrupted me." | Fold into notification delivery + attention. |

**Rule.** `PORTFOLIO-NEED-012`. A candidate whose stated need disappears when the
current tool is removed is a tool-induced candidate and is rejected or folded. The
rejection is recorded in `05-rejections.md` with its score.

---

## 6. The envelope is part of the need

A need is not complete until it names the situations in which it is felt. A person
remembers things on a watch (glance, 5 s), on a phone (walking, one hand), on a desktop
(hours), in a car (driver, safety) and in space (gloves, glare). The same need, different
operations. The envelope map (`06-envelope-map.md`) is therefore not a deployment matrix
added after the fact; it is part of the need statement.

**Rule.** `PORTFOLIO-NEED-013`. Every need statement in §2 MUST be tested against the
envelope set in `06-envelope-map.md`. A need that cannot be served on any envelope is
either out of scope or mis-stated.

---

## 7. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-NEEDS-001` | Every candidate in `04-candidate-portfolio.md` traces to at least one need in §2. |
| `AC-PORTFOLIO-NEEDS-002` | No need statement contains an app, screen, icon, dock, tab or vendor name. |
| `AC-PORTFOLIO-NEEDS-003` | Every job statement follows the Christensen form with situation, action and outcome. |
| `AC-PORTFOLIO-NEEDS-004` | Every need is tested against the envelope set. |
| `AC-PORTFOLIO-NEEDS-005` | A stranger can derive the need list from the citations in §2 alone. |