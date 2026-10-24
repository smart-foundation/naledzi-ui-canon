---
id: UX-CULTURE-LANGUAGE
title: Culture and Language — Cultural Models, RTL, Script Shaping, Numerals, Icon Meaning, Translation, Dignity
kind: research
entity: ux-research
status: canon
normative: true
version: 0.1.0
owner: UX, Timelessness, Spacious Design and Usability Research Lead
depends: [CANON-LAWS, CANON-TIMELESSNESS, UX-RESEARCH-INDEX]
supersedes: []
superseded_by: []
acceptance: [AC-UX-CULTURE-001, AC-UX-CULTURE-002, AC-UX-CULTURE-003]
---

# Culture and Language

> No single culture is the default. Dignity is not optional. Localisation is
> structural, not a translation pass.

## 1. Principle

Culture shapes what an icon means, what a colour signifies, how information is
ordered, and what counts as respectful. Language shapes layout (RTL, vertical
scripts, numerals, dates). Translation is not a string swap; it changes length,
direction and sometimes meaning. A design that assumes one culture is a design that
excludes. Dignity — the absence of shame, blame and surveillance — is the
cross-cultural constant.

## 2. Evidence

### 2.1 Cultural models

- **Hofstede, G. (2001).** *Culture's Consequences: Comparing Values, Behaviors,
  Institutions and Organizations Across Nations* (2nd ed.). Sage. (URL:
  https://www.worldcat.org/title/cultures-consequences/oclc/45091449 ; accessed
  23 October 2026.) Finding: cultures differ on power distance, individualism,
  masculinity, uncertainty avoidance, long-term orientation and indulgence. Limit:
  the model is criticised for stereotyping and for using national averages.
  Implication: Naledzi does not assume a single cultural default; it exposes
  defaults as settings; dignity (respect, no blame) is the cross-cultural constant.

- **Nisbett, R. E. (2003).** *The Geography of Thought: How Asians and Westerners
  Think Differently... and Why.* Free Press. (URL:
  https://www.worldcat.org/title/geography-of-thought/oclc/50603883 ; accessed
  23 October 2026.) Finding: analytic (object-focused) vs holistic (context-focused)
  cognition varies by culture. Limit: the dichotomy is overstated; within-culture
  variation is large. Implication: Naledzi supports both dense, object-focused
  layouts and sparse, context-focused ones via density modes; never assume one.

### 2.2 RTL and script shaping

- **W3C (2023).** *Internationalization (i18n) Activity.* (URL:
  https://www.w3.org/International/ ; accessed 23 October 2026.) Finding: the web
  internationalisation guidelines cover character encoding, text direction,
  language tags and locale data. Implication: Naledzi follows W3C i18n for text
  direction, locale data and language tagging.

- **Unicode Consortium (2024).** *Unicode Standard, Version 16.0.* (URL:
  https://www.unicode.org/versions/Unicode16.0.0/ ; accessed 23 October 2026.)
  Finding: defines scripts, bidirectional algorithm, normalisation and collation.
  Implication: Naledzi uses the Unicode bidirectional algorithm for RTL/LTR
  mixing; no ad-hoc direction handling.

- **CLDR (2024).** *Unicode Common Locale Data Repository.* (URL:
  https://cldr.unicode.org/ ; accessed 23 October 2026.) Finding: locale data for
  dates, times, numbers, currencies, plurals and collation. Implication: Naledzi
  uses CLDR for all locale formatting; no hand-rolled date/number formatting.

### 2.3 Numerals and dates

- **CLDR (2024).** (as above.) Finding: numeral systems, date formats and plural
  rules vary by locale. Implication: Naledzi respects the locale's numeral system
  (Arabic-Indic, Devanagari, etc.) and date format; the user can override.

### 2.4 Icon meaning

- **McDougall, S. J. P., Curry, M. B. and de Bruijn, O. (1999).** "Measuring
  symbol and icon characteristics: norms for concreteness, complexity, meaningfulness,
  familiarity, and semantic distance for 239 symbols." *Behavior Research Methods,
  Instruments, & Computers*, 31(3), pp. 487–519. (URL:
  https://doi.org/10.3758/BF03200730 ; accessed 23 October 2026.) Finding: icon
  comprehension depends on concreteness, familiarity and semantic distance; abstract
  icons are poorly understood. Implication: Naledzi uses Solar icons (concrete,
  semantic) and Naledzi glyphs for OS concepts; icons are always accompanied by a
  text label on first contact; icon-only controls require a tooltip/label.

- **Isherwood, S. J., McDougall, S. J. P. and Curry, M. B. (2007).** "Icon
  identification in context: the changing role of icon characteristics with user
  experience." *Human Factors*, 49(3), pp. 465–476. (URL:
  https://doi.org/10.1518/001872007X200102 ; accessed 23 October 2026.) Finding:
  context and experience change icon comprehension; novices need labels. Implication:
  labels are mandatory on first contact; icon-only is an expert affordance.

### 2.5 Translation and length

- **W3C (2023).** *i18n: Internationalization.* (as above.) Finding: translated
  text is often 30–100% longer; layouts must accommodate. Implication: Naledzi
  layouts are flexible; no fixed-width text containers; 200% text is a tested case
  (`01-foundations/experience/06-rare-cases.md`).

### 2.6 Dignity

- **Sen, A. (1999).** *Development as Freedom.* Oxford University Press. (URL:
  https://www.worldcat.org/title/development-as-freedom/oclc/40982271 ; accessed
  23 October 2026.) Finding: freedom and dignity are the ends of development, not
  side effects. Implication: Naledzi treats dignity as a requirement, not a polish:
  no shame in errors, no surveillance, no dark patterns.

## 3. What this predicts for Naledzi

1. **No single culture is the default.** Defaults are settings.
2. **RTL is structural.** Bidirectional algorithm; mirrored layout where
   appropriate; physical light/shadow/sound are not mirrored.
3. **Scripts are shaped correctly.** Unicode + CLDR; no ad-hoc shaping.
4. **Numerals and dates follow CLDR.** User override allowed.
5. **Icons are concrete and labelled on first contact.**
6. **Translation changes length and direction.** Flexible layouts; 200% text tested.
7. **Dignity is cross-cultural.** No blame, no shame, no surveillance.

## 4. Limits and contested claims

- Hofstede's dimensions are national averages; individual variation is large. Use as
  a reminder of difference, not a classification of users.
- Icon research is lab-based; comprehension varies by domain and experience.

## 5. Where implemented (IDs)

- `UX-LAW-10`.
- `LAW-019`, `LAW-020`.
- `01-foundations/experience/07-culture-language.md`.
- `01-foundations/typography/` — scripts and localisation.
- `03-framework/adaptivity/` — RTL and density.

## 6. Acceptance implications

- `AC-UX-CULTURE-001`: RTL layout passes the full golden flow without clipping.
- `AC-UX-CULTURE-002`: 200% text passes without clipping on all reference screens.
- `AC-UX-CULTURE-003`: Every icon-only control has a text label on first contact.

## Acceptance

| ID | Test |
|---|---|
| `AC-UX-CULTURE-001` | RTL golden flow passes. |
| `AC-UX-CULTURE-002` | 200% text passes. |
| `AC-UX-CULTURE-003` | Icon-only controls labelled on first contact. |
---<|end|><|start|>write to=assistant<|channel|>analysis<|message|>Created file successfully: naledzi/docs/ui-canon/09-research/ux/10-culture-language.md