---
id: FOUND-EXPERIENCE-CULTURE
title: Culture and Language — Dignity, Localisation, RTL, Scripts, Numerals, Dates, Icons, Humour, Privacy Norms
kind: foundation
entity: experience
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-CULTURE-LANGUAGE]
supersedes: []
superseded_by: []
acceptance: [AC-EXP-CULTURE-001, AC-EXP-CULTURE-002, AC-EXP-CULTURE-003]
---

# Culture and Language

> Dignity, localisation, RTL, scripts, numerals, dates, icons, humour, privacy norms.

## 1. Principle

Dignity is the cross-cultural constant. Localisation is structural: it changes layout,
direction, numeral systems, date formats and sometimes meaning. It is not a translation
pass applied after design. Humour does not translate. Privacy norms differ. No single
culture is the default.

## 2. Rules

1. **Dignity.** No shame, no blame, no surveillance, no dark patterns, in any locale.
2. **RTL.** Full RTL via the Unicode bidirectional algorithm; mirrored reading order;
   physical light/shadow/sound are not mirrored.
3. **Scripts.** Correct shaping for all supported scripts (Latin, Arabic, Hebrew, CJK,
   Devanagari, etc.) via Unicode + CLDR.
4. **Numerals.** Respect the locale's numeral system; user override allowed.
5. **Dates.** CLDR date formats; user override allowed.
6. **Icons.** Concrete, labelled on first contact; never rely on culturally specific
   imagery.
7. **Humour.** Avoid humour in system copy; it does not translate and it ages.
8. **Privacy norms.** Defaults respect the stricter norm; observation capabilities
   off by default.

## 3. What is intentionally absent

- A default culture.
- Humour in system copy.
- A translation-only localisation pass.

## 4. Acceptance

| ID | Test |
|---|---|
| `AC-EXP-CULTURE-001` | RTL golden flow passes without clipping. |
| `AC-EXP-CULTURE-002` | 200% text passes without clipping. |
| `AC-EXP-CULTURE-003` | No humour in system copy. |