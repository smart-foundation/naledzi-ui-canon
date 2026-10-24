---
id: PORTFOLIO-NAMING
title: Naming
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-ADMISSION, CANON-LAWS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-NAMING-001, AC-PORTFOLIO-NAMING-002, AC-PORTFOLIO-NAMING-003]
---

# Naming

> A name is a handle for a job, not a brand. It must be job-first, free of legacy baggage
> and vendor mimicry, localisable, and backed by a stable ID that never changes.

---

## 1. Principles

- `PORTFOLIO-NAME-001`. **Job-first.** The name states what the person does or gets,
  not what the tool is. "Notes" names the job (capturing notes). "Finder" names the tool.
- `PORTFOLIO-NAME-002`. **No legacy baggage.** A name that implies a legacy form
  ("file manager", "browser", "dock") is rejected unless the legacy form itself was
  admitted. The form was not admitted; the job was. Rename to the job.
- `PORTFOLIO-NAME-003`. **No vendor mimicry.** Names MUST NOT imitate a vendor's app
  name, icon or phrasing (Apple "Files", Google "Keep", Microsoft "Edge"). Naledzi is one
  vocabulary.
- `PORTFOLIO-NAME-004`. **Localisable.** The name MUST be translatable without breaking
  the concept. A name that is a pun, a brand or an untranslatable idiom is rejected.
  The stable ID is the anchor; the displayed name is a localised string.
- `PORTFOLIO-NAME-005`. **Stable ID.** The directory/ID name is ASCII, kebab-case, and
  never changes once minted. Display names may change; IDs do not (`DOC-SYSTEM` §5).
- `PORTFOLIO-NAME-006`. **Short.** One or two words. If a name needs a subtitle to be
  understood, the name is wrong.
- `PORTFOLIO-NAME-007`. **Honest.** The name MUST NOT over-promise. "Studio" implies
  creation; if the surface only plays, it is not a studio.
- `PORTFOLIO-NAME-008`. **No version numbers, no "pro", no "lite".** Variants are
  envelopes and capability, not product tiers.

---

## 2. Name → ID → display name

| Layer | Form | Example |
|---|---|---|
| Stable ID | `APP-<NAME>` (uppercase, ASCII) | `APP-NOTES` |
| Directory | kebab-case | `notes/` |
| Display name (en-GB) | Localised string | "Notes" |
| Display name (other locale) | Translated | "Notas" |
| Command ID | `cmd.<app>.<verb>` | `cmd.notes.create` |

The stable ID is the contract; the display name is presentation. A rename of the display
name is a content change, not an ID change.

---

## 3. Working names in the candidate portfolio

The working names in `04-candidate-portfolio.md` are provisional. The following are flagged
for renaming review at Gate 1:

| Working name | Concern | Proposed direction |
|---|---|---|
| `browser` | Legacy baggage; implies chrome-and-tabs. | Keep only if re-derived as "Read" or "Navigate"; else rename. |
| `files` | Legacy baggage; implies folder tree. | Keep if search-first; consider "Keep" (job: keep what I stored). |
| `store` | Vendor-ish; implies a shop. | Consider "Get" or "Capabilities". |
| `home-control` | Compound; awkward. | Consider "Home" or "Environment". |
| `people` | Generic; may collide. | Consider "Contacts" (job-first enough) or "Circle". |
| `tasks` | May fold into `calendar`. | Decide at Gate 1. |
| `converter` | May fold into `calculator`. | Decide at Gate 1. |
| `studio` | Over-promises if scoped to media only. | Scope explicitly: "Media studio". |
| `agent-console` | Developer jargon. | Consider "Agents" or "Assistance". |

**Rule.** `PORTFOLIO-NAME-009`. A rename after Gate 1 requires an ADR and a supersession
entry; the old name is marked `superseded_by`, not deleted.

---

## 4. Localisation rules

- `PORTFOLIO-NAME-010`. Display names are stored as message keys, not literals
  (`RES-CUL-009`).
- `PORTFOLIO-NAME-011`. Names MUST NOT assume a single script or direction; the layout
  reserves space for the longest expected translation (German, Finnish) plus 30%.
- `PORTFOLIO-NAME-012`. Icons carry a semantic name, never a file path; the label is
  the safety net when the icon does not translate (`RES-CUL-008`).
- `PORTFOLIO-NAME-013`. A name that cannot be translated without losing meaning is
  rejected or given a descriptive localised phrase plus a stable icon.

---

## 5. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-NAMING-001` | Every admitted app has a stable ID, a directory name and a display name. |
| `AC-PORTFOLIO-NAMING-002` | No admitted name imitates a vendor's app name. |
| `AC-PORTFOLIO-NAMING-003` | Every display name has a message key and a translation path. |