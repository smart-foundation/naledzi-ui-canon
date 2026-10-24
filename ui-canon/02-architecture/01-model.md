---
id: ARCH-MODEL-01
title: The Architectural Model
kind: architecture
entity: 02-architecture
status: review
normative: true
version: 0.1.0
owner: Architecture Editor
depends: [CANON-LAWS, CANON-GLOSSARY, ARCH-README]
supersedes: []
superseded_by: []
acceptance: [AC-ARCH-MODEL-001, AC-ARCH-MODEL-002, AC-ARCH-MODEL-003]
---

# The Architectural Model

> A visible fact is not a stream of pictures. It is a numbered, validated, atomic
> statement about what the user can see and touch at one instant. Everything in this
> subtree is derived from that sentence.

---

## 1. The unit: the numbered still

A **still** is the atomic unit of presentation. It is one versioned fact containing:

| Component | What it declares | Where the contract carries it |
|---|---|---|
| Pixels | the exact buffer(s), format, transform, and damage that compose the image | `compositor.capnp:529-541`; `framebuffer.capnp:48-88` |
| Hit map | the input targets and their geometry at that instant | declared by surfaces and roles, not by pixels; `surface.capnp:323-336` |
| Accessibility snapshot | the semantic tree the user can observe | `surface.capnp:4` imports `accessibility.capnp`; semantic nodes are owned by that schema |
| Input ownership | which session owns pointer/keyboard/touch, and which surface has focus | authority-owned; see `presentation/06-input-ownership.md` |
| Buffer lifetimes | which buffer is being read, by whom, until which fence | `compositor.capnp:572-577`, `surface.capnp:168-171` |
| Still number | a monotonic number scoped to the presentation authority | authority-owned; no schema field exists — see gap G-01 |

A still is **immutable once numbered**. A later still may supersede it; nothing may
retroactively change still *n*. The user's observation is always of one still, never of a
mixture of two. Tearing is a failure of this rule, not a cosmetic defect.

```
                 still 41                         still 42
   ┌──────────────────────────────┐   ┌──────────────────────────────┐
   │ pixels: buffer A, fence f41  │   │ pixels: buffer B, fence f42  │
   │ hit map: H41                 │   │ hit map: H42                 │
   │ a11y: snapshot S41           │   │ a11y: snapshot S42           │
   │ input owner: session 7       │   │ input owner: session 7       │
   │ buffers pinned until f41     │   │ buffers pinned until f42     │
   └──────────────────────────────┘   └──────────────────────────────┘
              immutable                        immutable
```

**MUST.** Every presentation MUST be numbered by exactly one authority.

**MUST NOT.** A presentation authority MUST NOT expose a still number that can be
observed before the still is fully valid (pixels ready, hit map complete, accessibility
snapshot coherent).

**MAY.** An executor MAY display an incomplete still only as an explicit placeholder
declared in the still, and the authority MUST record it as degraded.

---

## 2. Three roles, one truth

The model separates three roles because they have different failure modes and different
owners. Conflating them is the original architectural error this corpus corrects.

### 2.1 Presentation authority (mandatory)

The authority owns **truth**:

- it validates a commit against schema, capability, and declared state;
- it assigns the still number;
- it owns the mapping from still number to the facts that were true;
- it owns input ownership and focus owner for that still;
- it decides acceptance, rejection, or degraded acceptance, and records why;
- it never rasterizes, never allocates a scanout buffer, never talks to a GPU.

Authority is not a process requirement. It is a role that MUST exist exactly once per
presentation domain. A presentation domain may be one device, one seat, or one remote
surface. Two authorities for one still is a defect (LAW-001).

### 2.2 Policy (optional)

Policy owns **choice**, not truth:

- which surface is above which;
- how surfaces are laid out under a placement hint;
- which surface receives focus when several are eligible;
- how conflicting gestures or shortcuts arbitrate.

Policy MUST produce a **plan**: a total order of surface IDs plus geometry plus focus
candidate, expressed in contract terms. A policy that cannot be resolved (absent,
crashed, timed out) MUST cause the authority to apply the deterministic default policy
in `presentation/04-policy.md`, not to stop presenting. Policy never writes pixels.

### 2.3 Executor (replaceable)

The executor owns **realization**:

- scanout engine and planes;
- GPU command submission;
- CPU composition;
- remote encode/transport;
- headless sink.

The executor receives a plan and a set of buffer handles, and MUST either realize the
still exactly as declared or reject with a typed reason. It MUST NOT silently change
format, colour, scale, order, or timing. If it cannot realize a still, it reports
`AtomicRejection` semantics (`framebuffer.capnp:248-266`) or the path-specific
equivalent; it does not approximate without declaring degradation.

```
        commit (declaration)
               │
               ▼
     ┌───────────────────┐   reject / accept-degraded
     │ AUTHORITY         │──────────────────────────► session
     │ validate + number │
     └─────────┬─────────┘
               │ valid still + plan request
               ▼
     ┌───────────────────┐   plan (total order, geometry, focus)
     │ POLICY (optional) │──────────┐
     └───────────────────┘          │
                                    ▼
                          ┌───────────────────┐
                          │ EXECUTOR          │
                          │ realize or reject │
                          └─────────┬─────────┘
                                    │ present(fence)
                                    ▼
                               numbered still
```

---

## 3. The commit is the only door

Content enters the visible world through a commit. There is no side door: an app cannot
write a scanout buffer directly, cannot mutate a presented buffer, and cannot ask an
executor to display something the authority has not numbered.

The contract's commit carries:

| Field | Type | Line | Architectural meaning |
|---|---|---|---|
| `surfaceId` | `T.SurfaceId` | `compositor.capnp:530` | which surface this still replaces |
| `frameId` | `UInt64` | `compositor.capnp:531` | producer's frame identity, for ack and pacing |
| `bufferIndex` | `UInt8` | `compositor.capnp:532` | which buffer of the surface's set |
| `format` | `T.PixelFormat` | `compositor.capnp:533` | declared format; must match the buffer |
| `damageOption` | `DamageOption` | `compositor.capnp:534` | declared damage or explicit omission |
| `present` | `PresentIntent` | `compositor.capnp:535` | when the producer wants it shown |
| `fence` | `SyncFence` | `compositor.capnp:536` | when the buffer is safe to read |
| `transform` | `T.BufferTransform` | `compositor.capnp:537` | declared orientation |

A commit that omits any mandatory declaration is invalid. A commit that declares a
buffer the session does not own is invalid. A commit whose fence is already failed is
invalid. Validation is mandatory and its result is recorded in the still history.

**MUST NOT.** The authority MUST NOT infer a declaration. In particular it MUST NOT
diff a buffer to discover damage, MUST NOT guess a colour space from pixel values, and
MUST NOT assume a refresh rate when the display validity flag is false
(`display.capnp:267-376`).

---

## 4. Facts, not pictures

The architecture distinguishes four kinds of fact. Every file in this subtree says which
kind it is asserting.

| Kind | Example | Owner | May be cached? |
|---|---|---|---|
| Identity | session ID, surface ID, device ID | issuing service | derived only |
| Declaration | damage rects, present intent, colour space, role | the producer | no; a cache is a second owner |
| Decision | accept/reject, still number, focus owner | authority | history only |
| Observation | measured latency, dropped frames, actual refresh | executor/telemetry | yes, with timestamp and validity |

Caching an identity is allowed if the cache is invalidated by the owner's event. Caching
a declaration is forbidden: a cached damage rect is a stale claim about pixels.
Caching a decision is allowed only as history, never as current truth. Caching an
observation is allowed only with its measurement time and validity, exactly as
`display.capnp:267-376` requires for hardware facts.

---

## 5. The four invariants

These hold on every path, in every envelope, at every scale. A path that cannot satisfy
one of them is not an architecture path; it is an experiment and MUST NOT ship.

### INV-1 — Single writer per still

For any still number *n* and any surface *s*, at most one commit may define *s* in *n*.
The authority serializes commits per surface. Concurrent producers on one surface are a
contract violation, not a merge problem.

### INV-2 — Read-only after present

Once a buffer is included in a numbered still, its producing session MUST NOT write to
it until the authority has released it. Release is expressed by the found fence and the
buffer's return to the producer. The contract's `SyncFence` (`compositor.capnp:572-577`)
and `T.FenceHandle` (`surface.capnp:168-171`, `types.capnp:979`) are the only valid
release signals; a timeout is a failure, not a release.

### INV-3 — No truth in the executor

An executor MAY know that it drew 1920×1080. It MUST NOT be the authority for the fact
that the user saw 1920×1080. That fact belongs to the still record. A remote executor
that reports "delivered" does not thereby make the still delivered; the authority
decides what "delivered" means for that path and records the evidence.

### INV-4 — Absence is a value

A missing panel, missing EDID, unknown refresh, unknown device role, or absent policy is
a declared absence with a validity flag, never a zero or a default. The schema already
models this for displays (`display.capnp:267-376`); the architecture generalizes it:
**if a fact has no producer, the still says so and the UI renders absence honestly.**

---

## 6. Scale without a second model

The same model serves a watch and a spacecraft because the roles do not change, only
their placement:

| Envelope | Authority | Policy | Executor |
|---|---|---|---|
| Watch | on-device | on-device, minimal | on-device scanout/CPU |
| Phone | on-device | on-device | GPU + scanout |
| Desktop | on-device | on-device or session service | GPU + multiple scanouts |
| TV | on-device | on-device | scanout, limited GPU |
| Car | on-device (safety domain) | on-device, deterministic | scanout + GPU, isolated |
| Spacecraft | on-device, redundant | deterministic, frozen | scanout, no remote dependency |
| IoT | on-device or headless | usually absent | CPU or remote |
| Spatial | on-device | spatial policy | GPU + compositor per eye |
| Remote browser | remote authority | remote policy | local raster + remote encode |
| Headless | on-device authority, no panel | optional | sink only |

The envelope files in `ecosystem/envelopes/` instantiate this table with budgets,
failure behaviour, and acceptance. They do not redefine the roles.

---

## 7. What the model forbids

- A second scene graph maintained "for performance".
- An executor that reorders surfaces because it thinks it knows better.
- A policy that rejects a valid commit.
- An authority that renders to decide what was committed.
- A "damage tracker" that reads the buffer.
- A remote path that reports success before the authority has a still record.
- A device that presents without a still number because "it is only a preview".

Each prohibition has an acceptance check in `08-acceptance.md` or the branch
acceptance file. A prohibition without a check is a wish; this corpus does not ship
wishes.
