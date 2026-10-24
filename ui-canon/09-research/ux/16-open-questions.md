---
id: UX-OPEN-QUESTIONS
title: Open Questions — Unresolved, Owner, Deadline
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-OPEN-001]
---

# Open Questions

> Unresolved questions in the UX research subtree. Each has an owner and a deadline.
> A question without an owner or a deadline is a defect.

## 1. Open questions

| ID | Question | Why it matters | Owner | Deadline | Blocking |
|---|---|---|---|---|---|
| `UX-OQ-01` | Is the four-chunk working-memory ceiling (Cowan) the right number for safety envelopes under high workload, or should it be lower? | EV/spaceship displays must not exceed capacity. | Safety + UX Research Lead | Before EV envelope canon | `06-envelopes/ev/`, `spaceship/` |
| `UX-OQ-02` | What is the right notification budget per person per day, and is it per-device or per-person? | Determines notification delivery policy. | UX + Shell Lead | Before `04-shell/notifications/` canon | `04-shell/notifications/` |
| `UX-OQ-03` | Does spacious mode switch automatically under declared high workload, or is it user-only? | Affects stress rule and user trust. | UX + Safety Lead | Before safety envelope canon | `07-wireframes/modes/spacious/` |
| `UX-OQ-04` | Which WCAG level (AA vs AAA) is realistic on watch and IoT envelopes? | Target sizes and contrast on tiny displays. | Accessibility + Envelope Leads | Before envelope canon | `06-envelopes/watch/`, `iot/` |
| `UX-OQ-05` | How is motion-sensitivity declared and propagated across devices (per-user, per-device)? | Reduced-motion default must follow the person. | Accessibility + Ecosystem Lead | Before pairing canon | `02-architecture/ecosystem/` |
| `UX-OQ-06` | What is the evidence base for the spaced/compact density split being optimal rather than merely pragmatic? | Risk of a two-tier being too coarse. | UX Research Lead | Before framework adaptivity canon | `03-framework/adaptivity/` |
| `UX-OQ-07` | Are the cited safety standards (FAA, NASA, MIL-STD, NHTSA, SAE, ARINC) sufficient for spacecraft UI, or is a dedicated standard needed? | Gaps in spacecraft-specific guidance. | Safety Lead + Legal | Before spaceship envelope canon | `06-envelopes/spaceship/` |
| `UX-OQ-08` | How does inclusive recruitment scale to the number of studies the corpus implies? | Cost and capacity. | UX Research Lead | Before first summative study | `08-process/` |
| `UX-OQ-09` | Is the timelessness scorecard's 16 threshold validated, or is it a convention? | Admission decisions depend on it. | Canon Editor | Before any primitive canonisation | `00-canon/01-timelessness-test.md` |
| `UX-OQ-10` | Does the spacious stress rule (force spacious under high workload) conflict with expert preference for compact? | Expert vs safety tension. | Safety + UX Lead | Before EV envelope canon | `06-envelopes/ev/` |

## 2. Contested claims (recorded, not resolved)

- The transfer of cognitive-load theory from instructional to UI contexts is interpretation.
- The four-chunk limit is for unchunked, unfamiliar material; expert chunking varies.
- Hofstede's dimensions are national averages; individual variation is large.
- Timelessness is a hypothesis about the future and cannot be proved.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-UX-OPEN-001` | Every open question has an owner and a deadline; contested claims are recorded. |