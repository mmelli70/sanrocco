# Implementation Plan: Emergency Section

**Branch**: `014-emergency` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the Emergency section with high-visibility cards for Italian emergency numbers
(112, 118, 113, 115), the nearest hospital (Ospedale Castelli DEA), and two
pharmacies (Farmacia San Giorgio, Farmacia Nava). Every number is one-tap-to-call.
Uses the `.emergency-card` component from spec 002 for unmistakable visual urgency.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.emergency-card`)  
**Storage**: Stateless  
**Testing**: Manual — verify `tel:` links open dialler; Maps links open Google Maps  
**Constraints**: Single `.html` file; 112 MUST be first and most prominent

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | All data embedded |
| II. Offline-First | ✅ PASS | `tel:` works without signal (OS-level) |
| III. Mobile-First | ✅ PASS | Large tap targets; `.emergency-card` high contrast |
| IV. Multilingual | ✅ PASS | Names/descriptions via `CONTENT.strings[lang]` |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.emergency[]` array |

## Project Structure

```text
index.html   ← add #emergency screen + CONTENT.sections.emergency data
```

## Seed Data (summary)

| # | Name | Number |
|---|------|--------|
| 1 | 112 — Single Emergency | 112 |
| 2 | 118 — Ambulance | 118 |
| 3 | 113 — Police | 113 |
| 4 | 115 — Fire Brigade | 115 |
| 5 | Ospedale Castelli DEA | 0323 541111 |
| 6 | Farmacia San Giorgio | 0323 401355 |
| 7 | Farmacia Nava | 0323 519181 |

## Implementation Phases

### Phase 1 — Section Markup & Cards
- Add `<div class="screen" id="emergency">` with back-nav header
- Render loop over `CONTENT.sections.emergency[]`
- 112 entry uses largest `.emergency-card--primary` variant
- Other entries use standard `.emergency-card`
- Each card: name, description, tappable `tel:` number, optional address + Maps link

### Phase 2 — Intro Text
- `CONTENT.strings[lang].emergencyIntro` block above the cards
- Explains how 112 works in Italy, multilingual

### Phase 3 — Validation
- 112 is first and visually most prominent on 360 dp ✅
- All 7 numbers open dialler correctly ✅
- Hospital and pharmacy Maps links open Google Maps ✅
- Airplane mode: all cards readable, no broken elements ✅

## Implementation Notes (Actual vs Planned)

- **7 entries**: 112, 118, 113, 115, Ospedale Castelli DEA, Farmacia Nava, Farmacia San Giorgio.
- **Fully multilingual**: Each entry has `name_it`, `name_de`, `it`, `de` fields for complete
  Italian and German translations — critical for safety information.
- **Pharmacies**: Full address, phone, and opening hours included for each pharmacy.
