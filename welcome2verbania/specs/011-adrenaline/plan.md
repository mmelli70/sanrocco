# Implementation Plan: Adrenaline Attractions Section

**Branch**: `011-adrenaline` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the "Adrenaline Attractions" section: a card list of 3 adventure activities
near Verbania. Same structure as Things to Visit (spec 010) — name, description,
Maps link, optional `infoUrl`, optional ★ favourite badge.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`), Feature 010 (shared render pattern)  
**Storage**: Stateless  
**Testing**: Manual — 3 cards render; links open; 360 dp no overflow

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Text only |
| II. Offline-First | ✅ PASS | Static content |
| III. Mobile-First | ✅ PASS | Full-width cards on 360 dp |
| IV. Multilingual | ✅ PASS | Section title via strings |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.adrenaline[]` |

## Project Structure

```text
index.html   ← add #adrenaline screen + CONTENT.sections.adrenaline data (3 entries)
```

## Data Schema

```js
{ name, description, mapsUrl, favourite?, infoUrl? }
// Same schema as thingsToVisit
```

## Seed Data (3 entries)

Lake Maggiore Zipline, Acquadventure Park, Alpyland Mottarone

## Implementation Phases

### Phase 1 — Section Markup & Render Loop
- Add `<div class="screen" id="adrenaline">` with back-nav header
- Reuse card render function from Things to Visit (spec 010)
- Same `.card` + infoUrl + favourite badge pattern

### Phase 2 — Validation
- All 3 cards render at 360 dp ✅
- infoUrl entries show "More info" button ✅
- Maps links open ✅

## Implementation Notes (Actual vs Planned)

- **No mapsUrl field**: Removed — only `infoUrl` is used for external links.
- **Multilingual**: Each entry has `it` and `de` description fields for Italian and German
  translations.
