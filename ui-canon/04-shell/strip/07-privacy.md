---
id: SHELL-STRIP-PRIVACY
title: Strip Privacy
kind: shell
entity: strip
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-STRIP-INDEX, CANON-LAWS, CANON-DECISIONS]
supersedes: []
superseded_by: []
acceptance: [AC-SHELL-STRIP-070, AC-SHELL-STRIP-071]
---

# Strip Privacy

> Thumbnails are an observation capability. Sensitive apps blank or omit themselves. Screen
> capture is explicit. The user can see and revoke every grant (`LAW-020`).

---

## 1. Observation capability

- The strip holds an observation capability to read a surface's still for thumbnailing.
- The capability is granted per app, per user, per device.
- Revoking it blanks the card (placeholder with identity + "content hidden").
- Default: apps that declare sensitivity are denied by default; non-sensitive apps are
  granted by default but revocable.

---

## 2. Sensitive apps

- An app declares `sensitive: true` (banking, health, private browsing, etc.).
- Sensitive apps show a placeholder card by default.
- The user may grant observation per app; the grant is visible and revocable in settings.
- A sensitive app never shows a thumbnail without an explicit grant.

---

## 3. Blanking

- Even with observation granted, an app may blank its thumbnail in certain states (e.g.,
  a password field is focused, a private document is open).
- Blanking is declared by the app in its commit (a `blank_thumbnail` flag).
- A blanked card shows a placeholder, never a stale thumbnail.

---

## 4. Screen capture

- Screen capture (recording, screenshots) is a separate capability, explicitly granted.
- The strip's thumbnails are not screen capture; they are derived stills under observation.
- When screen capture is active, a visible indicator appears (`status-rail/`).
- An app may declare `capture_blocked` to prevent its content from being captured; the
  system honours it and shows a placeholder in captures.

---

## 5. Cross-device

- Observation grants are per-device by default; syncing them is an explicit user choice.
- A remote display's thumbnail access requires a grant.

---

## 6. Acceptance

| ID | Test |
|---|---|
| `AC-SHELL-STRIP-070` | Sensitive apps show placeholder by default. |
| `AC-SHELL-STRIP-071` | Revoking observation blanks the card immediately. |
| `AC-SHELL-STRIP-072` | Blanking flag in a commit blanks the thumbnail. |
| `AC-SHELL-STRIP-073` | Capture-blocked apps show a placeholder in captures. |
| `AC-SHELL-STRIP-074` | Every observation grant is visible and revocable in settings. |