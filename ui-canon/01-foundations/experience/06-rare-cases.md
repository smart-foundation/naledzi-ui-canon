---
id: FOUND-EXPERIENCE-RARE
title: Rare Cases — Low Battery, No Network, Full Disk, Denied Permissions, Thermal, Corrupted Data, Conflict, Multiple Users, Guest/Kiosk, Update Mid-Work, Hardware Failure, RTL, 200% Text, Reduced Motion, Motion Sickness, Alarm Fatigue, Glove Use, Glare, Vibration
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX, FOUND-EXPERIENCE-ERROR]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-RARE-001, AC-EXP-RARE-002, AC-EXP-RARE-003]
---

# Rare Cases

> Rare cases are designed, not left to the crash. Each case states how the person
> feels and what the system does.

## 1. Principle

A rare case is any state that is not the happy path but is reachable. The system
MUST specify the behaviour, the message and the recovery for each. "It won't happen"
is not a specification. Honesty over polish (`LAW-011`): degraded states are shown
as degraded.

## 2. Rare cases

### RC-01 — Low battery

- **How the person feels.** Anxious about losing work; wants to know how much time
  remains.
- **What the system does.** Shows battery level and estimated time in the status
  rail; offers a low-power mode that reduces brightness, motion and background
  work; preserves work; warns before critical. No sudden shutdown without warning
  where avoidable.

### RC-02 — No network

- **How the person feels.** Frustrated if work is blocked; calm if offline is normal.
- **What the system does.** Offline is a normal state (`LAW-017`): local-first; apps
  that can work offline do; sync status is shown honestly ("offline, will sync");
  no fake data; no spinning forever.

### RC-03 — Full disk

- **How the person feels.** Alarmed; wants to know what to delete and whether work
  is safe.
- **What the system does.** Writes fail honestly with cause and recovery; offers
  storage management; preserves in-flight work in a recovery buffer; never silently
  drops data.

### RC-04 — Denied permissions

- **How the person feels.** Confused about why a feature is unavailable.
- **What the system does.** Shows the denied state with the reason and a path to
  request the permission; the feature is visibly unavailable, not silently broken.

### RC-05 — Thermal throttling

- **How the person feels.** Unaware usually; annoyed if performance drops silently.
- **What the system does.** Reduces frame rate and background work honestly if
  needed; surfaces a "running warm" indicator only if performance is affected; no
  fake smoothness.

### RC-06 — Corrupted data

- **How the person feels.** Alarmed; wants to know if work is recoverable.
- **What the system does.** Detects corruption on read; offers recovery from backup
  or last good version; never shows corrupted content as if valid; names the file.

### RC-07 — Conflict (sync)

- **How the person feels.** Confused; wants to choose.
- **What the system does.** Shows both versions; offers merge or keep-both; never
  silently overwrites; conflict is a visible state.

### RC-08 — Multiple users

- **How the person feels.** Needs privacy between users.
- **What the system does.** Fast user switching; each user's data and session
  isolated; lock screen between users; no leakage of notifications or clipboard.

### RC-09 — Guest / kiosk

- **How the person feels.** Needs a clean, safe, temporary session.
- **What the system does.** Guest session with no access to owner data; data wiped
  on exit; kiosk mode locks to one app; clear exit path.

### RC-10 — Update mid-work

- **How the person feels.** Anxious about losing work or being interrupted.
- **What the system does.** Updates are scheduled, not forced; in-flight work is
  preserved across restart; the person is told what will happen and when; can defer.

### RC-11 — Hardware failure

- **How the person feels.** Alarmed; wants to know what still works.
- **What the system does.** Fails honestly; shows what is unavailable; offers
  recovery; critical functions (safety) have redundancy on safety envelopes.

### RC-12 — RTL

- **How the person feels.** Excluded if layout is broken.
- **What the system does.** Full RTL layout via the bidirectional algorithm; mirrored
  reading order; physical light/shadow/sound not mirrored; tested golden flow.

### RC-13 — 200% text

- **How the person feels.** Excluded if text is clipped.
- **What the system does.** Layouts re-flow; no clipping; tested on all reference
  screens.

### RC-14 — Reduced motion

- **How the person feels.** Sick or disoriented if motion is forced.
- **What the system does.** Travel removed; state change preserved via instant
  transition or announcement; mandatory setting.

### RC-15 — Motion sickness

- **How the person feels.** Nauseated by large-field motion or lag.
- **What the system does.** Reduced-motion default available; no large-field
  animation; low latency; user can disable motion entirely.

### RC-16 — Alarm fatigue

- **How the person feels.** Numb to alarms; misses real ones.
- **What the system does.** Alarms are prioritised and accurate; non-actionable
  alarms are suppressed; budgets enforced.

### RC-17 — Glove use

- **How the person feels.** Frustrated by small targets.
- **What the system does.** Larger targets and spacing on safety envelopes; touch
  thresholds adjusted; alternative inputs (voice, hardware) available.

### RC-18 — Glare

- **How the person feels.** Unable to read the screen.
- **What the system does.** High-contrast, glare-safe palette on EV/outdoor
  envelopes; brightness adapts; content remains legible.

### RC-19 — Vibration

- **How the person feels.** Unable to read or touch accurately.
- **What the system does.** Stabilised display; larger targets; voice input;
  redundancy on safety envelopes.

## 3. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-RARE-001` | Every rare case above has a specified behaviour and recovery. |
| `AC-EXP-RARE-002` | RTL and 200% text pass the golden flow. |
| `AC-EXP-RARE-003` | Reduced motion removes travel while preserving state change. |