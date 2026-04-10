# Implementation Plan: Things to Visit Section

**Branch**: `010-things-to-visit` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the "Things to Visit" section: a card list of 11 owner-curated attractions
near Verbania. Same base layout as Beaches, with two additions: an optional
`infoUrl` for external links (website/schedule), and an optional ★ favourite badge.
All 11 entries have Maps links; several have info URLs.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`, `.badge`)  
**Storage**: Stateless  
**Testing**: Manual — all 11 cards render; Maps + infoUrl links open; 360 dp no overflow

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Text only; no images |
| II. Offline-First | ✅ PASS | Cards render offline; external links use OS |
| III. Mobile-First | ✅ PASS | Full-width cards; long descriptions wrap cleanly |
| IV. Multilingual | ✅ PASS | Section title via strings |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.thingsToVisit[]` |

## Project Structure

```text
index.html   ← add #things-to-visit screen + CONTENT.sections.thingsToVisit (11 entries)
```

## Data Schema

```js
{ name, description, mapsUrl, favourite?, infoUrl? }
// infoUrl: optional — renders as "More info" button alongside Maps button
```

## Seed Data (11 entries)

Borromean Islands, Villa Taranto, Stresa, Sacro Monte di Ghiffa, Baveno,
Cannero Riviera, Mergozzo, Orta San Giulio, Valle Vigezzo, Valle Formazza,
Valle Verzasca

## Implementation Phases

### Phase 1 — Section Markup & Render Loop
- Add `<div class="screen" id="things-to-visit">` with back-nav header
- JS render loop over `CONTENT.sections.thingsToVisit[]`
- `.card` per entry: name, description, Maps button, optional "More info" button
- ★ favourite badge on starred entries

### Phase 2 — Validation
- All 11 cards render at 360 dp ✅
- `infoUrl` entries show second action button ✅
- Long descriptions render without overflow ✅
- Maps links open ✅

## Implementation Notes (Actual vs Planned)

- **No mapsUrl field**: Removed — only `infoUrl` is used for external links where applicable.
- **Multilingual**: Each entry has `it` and `de` description fields for Italian and German
  translations.
