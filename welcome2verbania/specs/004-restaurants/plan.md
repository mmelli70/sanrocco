# Implementation Plan: Restaurants Section

**Branch**: `004-restaurants` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the Restaurants section: a scrollable card list of 12 owner-curated restaurants.
Each card shows name, description, a Maps link, and — for 4 starred entries — a ★ favourite badge.
Owner's top picks: Donna Francesca, Cantina Leonardo, La Pescheria, La Terrazza.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`, `.badge`)  
**Storage**: Stateless  
**Testing**: Manual — all 12 cards render; Maps links open; favourite badges show  
**Constraints**: Single `.html` file; Maps links open externally (native app or browser)

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | No images; text only |
| II. Offline-First | ✅ PASS | Cards render without network; Maps links are OS-level |
| III. Mobile-First | ✅ PASS | Card list; full-width cards on 360 dp |
| IV. Multilingual | ✅ PASS | Section title/labels via strings; descriptions in owner's language |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.restaurants[]` |

## Project Structure

```text
index.html   ← add #restaurants screen + CONTENT.sections.restaurants data (11 entries)
```

## Data Schema

```js
{ name, description, mapsUrl, favourite? }
// favourite: true → shows ★ badge
```

## Seed Data (11 entries)

Dalì, La Casera, Osteria del Castello, L'Alchimista, Gattabuia, Damm'a Traa,
Estremadura, ★ Donna Francesca, ★ Cantina Leonardo, L'Imbarcadero (Isola Pescatori),
★ La Pescheria (Isola Pescatori)

## Implementation Phases

### Phase 1 — Section Markup & Render Loop
- Add `<div class="screen" id="restaurants">` with back-nav header
- JS render loop over `CONTENT.sections.restaurants[]`
- `.card` component per entry: name, description, Maps button
- ★ favourite badge on `favourite: true` entries (top of card or name row)

### Phase 2 — Favourite Badge Component
- Favourite badge: distinct colour (amber/gold from design tokens)

### Phase 3 — Validation
- All 12 cards render correctly at 360 dp ✅
- 4 starred entries show favourite badge ✅
- Long descriptions don't overflow cards ✅

## Implementation Notes (Actual vs Planned)

- **No rating/price fields**: These were removed — only `name`, `description`, `mapsUrl`,
  and `favourite` fields exist in the data model.
- **12 restaurants**: La Terrazza was added as the 12th entry during build.
- **Multilingual**: Each restaurant entry has `it` and `de` description fields for
  Italian and German translations.
