# Implementation Plan: Gelaterie Section

**Branch**: `009-gelaterie` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)

## Summary

Build the Gelaterie section — same structure as Restaurants (spec 004).
Card list of 4 owner-curated gelato shops, each with name, description,
Maps link, and optional ★ favourite badge.
Gelateria Aurora (Mergozzo/Candoglia) is starred.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`), Feature 004 (shared favourite badge render function)  
**Storage**: Stateless  
**Testing**: Manual — 4 cards render; Maps links open

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Text only |
| II. Offline-First | ✅ PASS | Static content |
| III. Mobile-First | ✅ PASS | Full-width cards on 360 dp |
| IV. Multilingual | ✅ PASS | Section title via strings |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.gelaterie[]` |

## Project Structure

```text
index.html   ← add #gelaterie screen + CONTENT.sections.gelaterie data (4 entries)
```

## Data Schema

```js
{ name, description, mapsUrl, favourite? }
// Same schema as restaurants
```

## Seed Data (4 entries)

Gelato d'Altri Tempi, Gelatomania, K2 (Pallanza), ★ Gelateria Aurora (Mergozzo/Candoglia)

## Implementation Phases

### Phase 1 — Section Markup & Render Loop
- Add `<div class="screen" id="gelaterie">` with back-nav header
- Reuse `renderFavouriteBadge()` from spec 004 (Restaurants)
- Same `.card` + favourite badge pattern

### Phase 2 — Validation
- All 4 cards render at 360 dp ✅
- Gelateria Aurora shows ★ badge ✅
- Maps links open ✅
