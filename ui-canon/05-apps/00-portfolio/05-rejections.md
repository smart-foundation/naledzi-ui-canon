---
id: PORTFOLIO-REJECTIONS
title: Rejected and Folded Legacy Categories
kind: app
entity: 00-portfolio
status: review
normative: true
version: 0.1.0
owner: Apps Guild
depends: [PORTFOLIO-INDEX, PORTFOLIO-NEEDS, PORTFOLIO-JOBS, PORTFOLIO-ADMISSION, CANON-TIMELESSNESS, CANON-LAWS]
supersedes: []
superseded_by: []
acceptance: [AC-PORTFOLIO-REJECTIONS-001, AC-PORTFOLIO-REJECTIONS-002, AC-PORTFOLIO-REJECTIONS-003]
---

# Rejected and Folded Legacy Categories

> Legacy categories are not admitted because a legacy OS ships them. Some fail the
> admission test outright; some survive as jobs that must be re-composed into different
> surfaces. The rejection is recorded because the reason is part of the design.

---

## 1. The rule

- `PORTFOLIO-REJ-001`. A legacy category is never admitted as an app on name alone.
- `PORTFOLIO-REJ-002`. A legacy category that fails the admission test is recorded here
  with its score and the reason.
- `PORTFOLIO-REJ-003`. A legacy category whose job survives is **folded** or
  **transformed**, not deleted. The job is re-derived as a primitive, a shell surface, a
  cross-app flow or a feature of an admitted app.
- `PORTFOLIO-REJ-004`. A folded category may return only with new evidence and a new
  scored entry. A rejection that keeps returning without new evidence is a process defect
  (`CANON-TIMELESSNESS` §6).

---

## 2. Legacy categories

### R-01 — File manager as a folder-tree app

- **Legacy form.** A permanent tree of folders and files; the user navigates by path.
- **Assumed need.** "I need folders." (tool-induced, `PORTFOLIO-NEED-011`.)
- **Actual need.** N2 Remember, N5 Navigate: "I need to find what I stored."
- **Admission score.** 10 (human need 1, job survival 1, envelope reach 1, capability
  honesty 1, data ownership 2, trust 1, accessibility 1, no legacy chrome 0, no network 2,
  reproducibility 1). Zero on criterion 8 (permanent chrome, folder tree).
- **Verdict.** Rejected as a form. The job survives and is folded into `files` (JD-02,
  JD-05): search-first, memory-based retrieval, path as an attribute not the navigation.
- **What survives.** File access, metadata, sharing, sync, capability-scoped permissions.
- **What is removed.** The folder tree as the primary navigation; the permanent sidebar
  of drives; the "cut/copy/paste files" mental model as the only way.
- **Evidence.** Norman (2013): conceptual models survive; implementations do not.
  Landauer & Nachbar (1985): breadth beats depth in menu trees. Cowan (2001): working
  memory holds ~4 chunks; deep path navigation exceeds it.

### R-02 — Browser as a chrome-and-tabs app

- **Legacy form.** A window with an address bar, back/forward, and a row of tabs; tabs are
  the primitive.
- **Assumed need.** "I need tabs." (tool-induced.)
- **Actual need.** N5 Navigate: "I need to read and navigate information."
- **Admission score.** 12 (human need 2, job survival 2, envelope reach 2, capability
  honesty 1, data ownership 1, trust 1, accessibility 2, no legacy chrome 1, no network 1,
  reproducibility 1). Review band.
- **Verdict.** Transformed. The job survives; the form does not. Tabs become one rendering
  of a **Section Set** (`APP-STANDARD` §3.1, `CANON-TIMELESSNESS` worked example 4.2).
  Chrome becomes summonable, not permanent (`LAW-010`). The candidate `browser` is admitted
  provisionally with a declared weakness on no-legacy-chrome.
- **What survives.** Reading, following links, history, bookmarks as saved navigation,
  offline reading of cached pages.
- **What is removed.** Tab-as-primitive mandate; permanent address bar; inability to
  dismiss chrome; tracking without consent.
- **Evidence.** Tabs score 15 on the timelessness test (review): keep the need, not the
  chrome. Section Set renders as rail, segmented control, crown-scroll or list.

### R-03 — Settings as a vendor settings tree

- **Legacy form.** A nested tree of categories copied from a vendor's control panel.
- **Assumed need.** "I need a settings tree."
- **Actual need.** N9 Control environment: "I need to change what the system does, safely,
  and get back to a known state."
- **Admission score.** 6 if shipped as a tree (human need 1, job survival 1, envelope
  reach 0, capability honesty 0, data ownership 1, trust 1, accessibility 1, no legacy
  chrome 0, no network 2, reproducibility 0).
- **Verdict.** Rejected as a form. The job survives and is re-derived as the `settings`
  app: panes are derived from changeable facts and envelope capability, not from a vendor
  tree (`settings/README.md` §4, `PROC-MASTER-BRIEF` §3.1).
- **What survives.** Every changeable fact, with default, range, scope, timing, reset,
  search keywords, accessibility.
- **What is removed.** The vendor tree; panes with no user intention; implementation-detail
  toggles; the "advanced" junk drawer.
- **Evidence.** `PROC-MASTER-BRIEF` §3.1: settings panes are derived from what the person
  can actually change. Settings README: 31 panes, each answering a user question.

### R-04 — App store as a grid of apps

- **Legacy form.** A grid of icons with ratings and "Get" buttons.
- **Assumed need.** "I need a grid of apps."
- **Actual need.** N8 Transact, N5 Navigate: "I need to get a capability I do not have."
- **Admission score.** 8 (human need 1, job survival 1, envelope reach 1, capability
  honesty 1, data ownership 1, trust 1, accessibility 1, no legacy chrome 0, no network 0,
  reproducibility 1). Zero on criteria 8 and 9.
- **Verdict.** Transformed into `store`: capability discovery, not a grid. Admission is
  provisional (score 16) with declared weaknesses.
- **What survives.** Catalogue, install, update, review, capability disclosure.
- **What is removed.** The grid as the only view; self-installing; hidden permissions;
  dark patterns.
- **Evidence.** Christensen et al. (2016): the circumstance, not the customer, is the
  unit; a grid serves the vendor, not the circumstance.

### R-05 — Home screen as an icon grid

- **Legacy form.** A grid of app icons; the "desktop" of a phone.
- **Assumed need.** "I need icons to launch apps."
- **Actual need.** N10 Observe, N12 Coordinate: "I need to resume or start what matters."
- **Admission score.** 9 (human need 1, job survival 1, envelope reach 0, capability
  honesty 1, data ownership 2, trust 1, accessibility 1, no legacy chrome 0, no network 2,
  reproducibility 1). Zero on criteria 3 and 8.
- **Verdict.** Folded. The resume/start job is served by the strip (summon-only, live
  stills) and a launcher surface. No permanent icon grid (`LAW-010`).
- **What survives.** Launching, resuming, organising by use.
- **What is removed.** Permanent icon grid; "home" as a place you must visit; widget
  sprawl.
- **Evidence.** Dock worked example (`CANON-TIMELESSNESS` §4.1): score 9, reject as
  foundation, transform into the strip.

### R-06 — Dock

- **Legacy form.** A permanent bar of app icons at an edge.
- **Assumed need.** "I need a permanent bar to switch apps."
- **Actual need.** N10/N12: "I need to switch and resume."
- **Admission score.** 9 (see `03-admission-test.md` §7).
- **Verdict.** Rejected as a form. Transformed into the **strip**: summon-only, live
  stills, depth cards, no permanent chrome (`04-shell/strip/`).
- **What survives.** Switching, resuming, launching.
- **What is removed.** Permanence, icon memorisation, bottom-edge competition.

### R-07 — Widget dashboard

- **Legacy form.** A separate screen of glanceable tiles.
- **Assumed need.** "I need glanceable tiles."
- **Actual need.** N10 Observe: "I need to observe without opening an app."
- **Admission score.** 11 (human need 2, job survival 2, envelope reach 1, capability
  honesty 1, data ownership 2, trust 1, accessibility 1, no legacy chrome 1, no network 1,
  reproducibility 1).
- **Verdict.** Folded. Glance surfaces are not a separate app; they are the observe job
  expressed through the status rail, the strip's live stills and app-provided glance
  contracts. No widget dashboard app.
- **What survives.** Glanceable information, at-a-glance status.
- **What is removed.** A separate dashboard surface; tile chrome; the "widget" as a
  primitive.

### R-08 — Notification centre as a separate place

- **Legacy form.** A panel you open to see all notifications.
- **Assumed need.** "I need a separate place for notifications."
- **Actual need.** N1/N10/N7: "I need to know what interrupted me, and control it."
- **Admission score.** 10 (human need 1, job survival 1, envelope reach 1, capability
  honesty 1, data ownership 2, trust 1, accessibility 1, no legacy chrome 0, no network 2,
  reproducibility 1). Zero on criterion 8.
- **Verdict.** Folded. Notification delivery and attention management are system
  surfaces (`04-shell/notifications/`). There is no "notification centre app"; history is
  a view within the system surface, not a place.
- **What survives.** Delivery, priority, history, quiet hours, budgets.
- **What is removed.** The separate place; the badge count as the only signal.

---

## 3. Jobs that survive and must be re-composed

Some legacy categories fail as *forms* but their jobs are real and must be re-composed
into admitted surfaces. This table is the bridge between rejection and admission.

| Surviving job | Re-composed into | Why not an app |
|---|---|---|
| Switch and resume | Strip (system surface) | OS-owned navigation; no app owns output. |
| Launch what matters | Strip + launcher | Summon-only; no permanent chrome. |
| Find what I stored | `files` app | Memory-based search, not path tree. |
| Read and navigate info | `browser` app | Section Set, not tabs; summonable chrome. |
| Change what the system does | `settings` app | Panes from changeable facts. |
| Get a capability I lack | `store` app | Capability discovery, not a grid. |
| Observe without opening | Status rail + glance contracts | OS-owned glance surfaces. |
| Know what interrupted me | Notifications (system) | Delivery + attention, not a place. |
| Wake and rest | `clock` app + focus modes | Time + rest as one job domain. |

---

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-PORTFOLIO-REJECTIONS-001` | Every rejected category has a score and a reason. |
| `AC-PORTFOLIO-REJECTIONS-002` | Every surviving job is mapped to an admitted surface or shell surface. |
| `AC-PORTFOLIO-REJECTIONS-003` | No rejected category is implemented as an app without a new scored entry. |