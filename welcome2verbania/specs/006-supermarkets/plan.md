# Implementation Plan: Supermarkets Section

**Branch**: `006-supermarkets` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)

## Summary

Build the Supermarkets section: a card list of 4 owner-curated shops.
Same layout as Beaches. Each card shows name, description, Maps link, and optional
★ favourite badge. Cusio Formaggi is Saturday-only — this must be clearly noted.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.card`, `.badge`)  
**Storage**: Stateless  
**Testing**: Manual — 4 cards render; Saturday-only note visible; Maps links open

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Text only |
| II. Offline-First | ✅ PASS | Static content |
| III. Mobile-First | ✅ PASS | Full-width cards on 360 dp |
| IV. Multilingual | ✅ PASS | Section title via strings |
| V. Version-Based Updates | ✅ PASS | Entries in `CONTENT.sections.supermarkets[]` |

## Project Structure

```text
index.html   ← add #supermarkets screen + CONTENT.sections.supermarkets data (4 entries)
```

## Data Schema

```js
{ name, description, mapsUrl, favourite?, note? }
// note: optional short highlight (e.g. "Only on Saturday mornings")
```

## Seed Data (4 entries)

Esselunga, Tigros, Colombo (fruits specialist), Cusio Formaggi (★ Saturday market only)

## Implementation Phases

### Phase 1 — Section Markup & Render Loop
- Add `<div class="screen" id="supermarkets">` with back-nav header
- Reuse same card render pattern as Beaches (share render function if possible)
- `note` field renders as a small highlighted tag on the card

### Phase 2 — Validation
- All 4 cards render at 360 dp ✅
- Cusio Formaggi Saturday-only note prominent ✅
- Maps links open ✅
