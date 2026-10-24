---
id: FOUND-MOTION-ENVELOPES-08
title: Motion Envelopes
kind: foundation
entity: motion
status: review
normative: true
version: 0.1.0
owner: Foundations Lead
depends: [FOUND-MOTION-INDEX, FOUND-MOTION-SPRINGS-01, FOUND-MOTION-TOKENS-06, FOUND-MOTION-SAFETY-05, LAW-008, LAW-016]
supersedes: []
superseded_by: []
acceptance: [AC-FOUND-MOTION-080, AC-FOUND-MOTION-081, AC-FOUND-MOTION-082]
---

# Motion Envelopes

> Motion is one model, but its budget, its available springs and its settle bounds are
> envelope properties. A watch cannot afford what a desktop can; a spacecraft cannot risk
> what a phone can.

---

## 1. Common rules

- **FOUND-MOTION-330.** Every envelope MUST declare its available spring set (from
  `06-tokens.md` §3), its ω cap, its settle bounds and its degradation behaviour.
- **FOUND-MOTION-331.** An envelope MUST NOT use a spring outside its available set.
- **FOUND-MOTION-332.** An envelope that overrides a token value MUST declare the
  override here and in its own envelope file.

---

## 2. Per-envelope behaviour

### 2.1 Watch

- **Available springs:** ENTER, EXIT, MOVE, SETTLE, REDUCED.
- **ω cap:** 24 rad/s. Springs settle quickly; the small screen means travel is short.
- **Settle:** within 200 ms for ENTER/EXIT, 100 ms for MOVE.
- **Stagger:** at most 3 items; delay 30 ms.
- **Scroll:** no momentum; snap to item.
- **Parallax:** none (no pointer, no useful tilt on a wrist).
- **Reduced motion:** ENTER/EXIT reduce to opacity (80 ms) or instant.
- **Degradation:** disable parallax (already none) → shorten springs → instant.
- **Idle:** zero motion work; the always-on display commits only on change.

### 2.2 Phone

- **Available springs:** all.
- **ω cap:** none (token defaults).
- **Settle:** token defaults.
- **Stagger:** up to 8 items; delay 40 ms.
- **Scroll:** momentum with `SPRING-SCROLL`; snap to page on flick.
- **Parallax:** device-motion parallax on E2-E3, few pixels, filtered.
- **Reduced motion:** per `04-reduced-motion.md` §3.
- **Degradation:** reduce motion → shorten springs → disable parallax → instant.

### 2.3 Tablet

- **Available springs:** all.
- **ω cap:** none.
- **Settle:** token defaults; slightly larger travel allowed (larger screen).
- **Stagger:** up to 12 items; delay 40 ms.
- **Scroll:** momentum; snap to page.
- **Parallax:** pointer parallax (with pointer) and device-motion parallax.
- **Reduced motion:** per `04-reduced-motion.md` §3.
- **Degradation:** as phone.

### 2.4 Desktop

- **Available springs:** all.
- **ω cap:** none; precise, high-throughput input allows stiffer springs (MOVE at 28).
- **Settle:** token defaults; travel may be larger (multi-monitor).
- **Stagger:** up to 20 items; delay 30 ms.
- **Scroll:** momentum; smooth scrolling is expected.
- **Parallax:** pointer parallax on E2-E3.
- **Reduced motion:** per `04-reduced-motion.md` §3; also honours OS setting.
- **Degradation:** as phone, but parallax is disabled first because pointer parallax is
  the highest-cost effect on large surfaces.

### 2.5 TV

- **Available springs:** ENTER, EXIT, MOVE, REDUCED.
- **ω cap:** 20 rad/s (remote input is coarse; fast motion is disorienting at distance).
- **Settle:** 300 ms for ENTER, 200 ms for MOVE.
- **Stagger:** delay 60 ms (TV is slower to read).
- **Scroll:** no momentum; item-by-item.
- **Parallax:** none.
- **Focus:** focus-led; the focus ring does not spring.
- **Reduced motion:** ENTER/EXIT reduce to opacity or instant.
- **Degradation:** shorten springs → instant.

### 2.6 EV

- **Available springs:** SAFETY, REDUCED only.
- **ω cap:** 12 rad/s (ζ ≥ 1.2).
- **Settle:** within 400 ms.
- **Stagger:** forbidden.
- **Scroll:** instant or `SPRING-REDUCED`.
- **Parallax:** forbidden.
- **Critical indicators:** never animate through occlusion; value ticks only.
- **Reduced motion:** safety motion unchanged; non-safety motion removed.
- **Degradation:** instant for all non-safety; safety motion unchanged.

### 2.7 Spaceship

- **Available springs:** SAFETY, REDUCED only.
- **ω cap:** 12 rad/s (ζ ≥ 1.2); deterministic timing.
- **Settle:** within 400 ms; deterministic across redundant channels.
- **Stagger:** forbidden.
- **Scroll:** instant.
- **Parallax:** forbidden.
- **Critical indicators:** never animate through occlusion.
- **Reduced motion:** safety motion unchanged.
- **Degradation:** instant; redundancy must agree.

### 2.8 IoT

- **Available springs:** REDUCED only.
- **ω cap:** 60 rad/s (near-instant).
- **Settle:** within 100 ms.
- **Stagger:** forbidden.
- **Scroll:** not applicable (tiny or headless).
- **Parallax:** forbidden.
- **Motion:** discouraged; instant preferred.
- **Degradation:** instant.

### 2.9 Spatial

- **Available springs:** SPATIAL, ENTER, EXIT, REDUCED.
- **ω cap:** 6 rad/s for world-locked content; 18 rad/s for chrome.
- **Settle:** 500–800 ms for world-locked; 200 ms for chrome.
- **Stagger:** up to 6 items; delay 50 ms.
- **Scroll:** not applicable; gaze/head navigation.
- **Parallax:** real stereoscopic depth; comfort-bounded.
- **Comfort:** acceleration, field of view and duration limits per accessibility vestibular
  rules; fixed-reference mode required.
- **Reduced motion:** fixed-reference mode (disables world-locked motion).
- **Degradation:** disable world-locked motion → shorten springs → fixed reference.

### 2.10 Remote browser

- **Available springs:** REDUCED, ENTER, EXIT.
- **ω cap:** 18 rad/s (jitter-tolerant; slower to absorb latency).
- **Settle:** 300 ms for ENTER/EXIT.
- **Stagger:** up to 6 items; delay 50 ms.
- **Scroll:** momentum discouraged; prefer instant.
- **Parallax:** none.
- **Reduced motion:** per `04-reduced-motion.md` §3.
- **Degradation:** instant on latency spike; never drop frames silently.

---

## 3. Envelope overrides

An envelope that overrides a token value MUST list it here and in its own envelope file.

| Envelope | Override | Value | Reason |
|---|---|---|---|
| Watch | `TOK-MOTION-SPRING-ENTER` ω | 20 | Small screen, short travel |
| Watch | `TOK-MOTION-STAGGER-DELAY` | 30 ms | Faster reading on small screen |
| TV | `TOK-MOTION-SPRING-ENTER` ω | 14 | Remote, distant viewing |
| TV | `TOK-MOTION-STAGGER-DELAY` | 60 ms | Slower reading at distance |
| Spatial | `TOK-MOTION-SPRING-SPATIAL` ω | 6 | Vestibular comfort |
| Remote browser | `TOK-MOTION-SPRING-ENTER` ω | 18 | Jitter tolerance |

---

## Acceptance

| ID | Test |
|---|---|
| `AC-FOUND-MOTION-080` | Every envelope uses only its declared available spring set; a conformance script reports zero violations. |
| `AC-FOUND-MOTION-081` | Every envelope override is declared here and in its envelope file. |
| `AC-FOUND-MOTION-082` | Run the reference flows on each envelope; motion stays within the declared caps and degradation behaves as specified. |