# Implementation Plan: Beaches Section

**Branch**: `005-beaches` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)

## Summary

Build the Beaches section: a scrollable card list of 6 owner-curated beaches around
Verbania and Lake Mergozzo. Each card shows name, description, a Maps link, and —
for the owner's top pick — a ★ favourite badge. Cannero Riviera is starred.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`, `.badge`)  
**Storage**: Stateless  
**Testing**: Manual — all 6 cards render; Maps links open; starred entry shows badge

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Text only; no images |
| II. Offline-First | ✅ PASS | Static content; Maps links are OS-level |
| III. Mobile-First | ✅ PASS | Full-width cards on 360 dp |
| IV. Multilingual | ✅ PASS | Section title via strings; descriptions owner-supplied |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.beaches[]` |

## Project Structure

```text
index.html   ← add #beaches screen + CONTENT.sections.beaches data (6 entries)
```

## Data Schema

```js
{ name, description, mapsUrl, favourite? }
// favourite: true → ★ badge
```

## Seed Data (6 entries)

Teatro Maggiore, Spiaggia di Suna, Tre Ponti, Canneto, Quartina e Lido (Mergozzo),
★ Cannero Riviera

## Implementation Phases

### Phase 1 — Section Markup & Render Loop
- Add `<div class="screen" id="beaches">` with back-nav header
- JS render loop over `CONTENT.sections.beaches[]`
- `.card` per entry: name, description, Maps button
- ★ favourite badge on `favourite: true` entries

### Phase 2 — Validation
- All 6 cards render at 360 dp ✅
- Cannero Riviera shows ★ badge ✅
- Maps links open correctly ✅
- Long descriptions (up to ~1000 chars) don't overflow ✅
