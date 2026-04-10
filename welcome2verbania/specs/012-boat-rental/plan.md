# Implementation Plan: Boat Rental Section

**Branch**: `012-boat-rental` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the Boat Rental section as a rich document — not a card list. Contains a
guest attribution header (Philipp), 6 operator entries with contact details/fleet/pricing/reviews,
and a "General Tips" section at the bottom. Structure is closer to House Rules
than to Restaurants — prose + structured data blocks rather than uniform cards.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`, `.info-box`)  
**Storage**: Stateless  
**Testing**: Manual — all 6 operators render; phone/website links work; Tips section visible

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Text only; no images |
| II. Offline-First | ✅ PASS | Static content; `tel:` links use OS |
| III. Mobile-First | ✅ PASS | Document-style layout; full-width at 360 dp |
| IV. Multilingual | ✅ PASS | Section title + attribution via strings; content owner-supplied |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.boatRental[]` |

## Project Structure

```text
index.html   ← add #boat-rental screen + CONTENT.sections.boatRental data (6 entries)
```

## Data Schema

```js
{
  name, website?, location?, notTested?,
  contact?: { person?, phone?, mobile?, whatsapp?, email? },
  fleet?: string[],          // bullet list of boats with prices
  notes?: string[],          // bullet list of important notes
  review?: string            // free-form review paragraph
}
```

## Seed Data (6 operators)

1. Lago Charter (Feriolo) — Holger Brozio, +49 151 65 63 46 83
2. Rent Boat Lago Maggiore (Verbania/Pallanza)
3. Cantiere di Ghiffa — Michele, +39 346 373 5367
4. Marina di Pallanza — not tested
5. Rent Boat Cannobio — not tested
6. Feriolo Sporting Club — professional water sports

Plus: General Tips sub-section (Fuel Costs, Water Sports, Booking Advice)

## Implementation Phases

### Phase 1 — Section Structure
- Add `<div class="screen" id="boat-rental">` with back-nav header
- Guest attribution banner: "Written by a guest — thank you Philipp!"
- JS render loop over `CONTENT.sections.boatRental[]`

### Phase 2 — Operator Cards
- Each operator: `.card` with name, optional "not tested" badge
- Contact block: tappable `tel:` for phone/mobile, `wa.me` for WhatsApp, website link
- Fleet: bullet list rendered from `fleet[]` array
- Notes: bullet list rendered from `notes[]` array
- Review: italic paragraph from `review` string

### Phase 3 — General Tips
- Static sub-section at bottom of screen
- 3 sub-heads: Fuel Costs, Water Sports, Booking Advice
- Content from `CONTENT.strings[lang].boatRentalTips`

### Phase 4 — Validation
- All 6 operators render at 360 dp ✅
- "Not tested" badge on Marina di Pallanza and Rent Boat Cannobio ✅
- Phone/WhatsApp links open on device ✅
- General Tips section visible after operators ✅

## Implementation Notes (Actual vs Planned)

- **Multilingual**: Each operator entry has `it` and `de` fields for description and review
  translations. Italian and German translations fully implemented.
