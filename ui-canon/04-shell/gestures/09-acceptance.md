---
id: SHELL-GESTURES-ACCEPTANCE
title: Gestures — Acceptance
kind: shell
entity: gestures
status: canon
normative: true
version: 0.1.0
owner: Shell Guild
depends: [SHELL-GESTURES-INDEX]
acceptance: [AC-SHELL-GESTURES-000]
---

# Gestures — Acceptance

---

## 1. Golden flows

### Flow A — Back and home

1. User swipes left edge → back.
2. User swipes bottom short → home.
3. Reduced motion: same result, no travel.

### Flow B — Capture lease expiry

1. User starts a drag; pointer leaves surface.
2. Lease holds input.
3. User releases; lease expires; drop completes.
4. Crash during drag: lease expires; no stuck pointer.

## 2. Acceptance table

| ID | Requirement | Evidence |
|---|---|---|
| `AC-SHELL-GESTURES-000` | All files exist; no stubs | Tree audit |
| `AC-SHELL-GESTURES-001` | Every reserved gesture has non-gesture path | Flow A |
| `AC-SHELL-GESTURES-002` | Capture leases expire correctly | Flow B |
| `AC-SHELL-GESTURES-003` | Conflicts resolve per table | Conflict tests |