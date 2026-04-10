# Implementation Plan: Home Screen

**Branch**: `003-home-screen` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the navigation hub that appears after the splash screen. Displays 11 section
boxes in a 2-column grid — each with an emoji icon and a translated label. Tapping
a box navigates to the corresponding content section within the same page. Every
section gets a persistent back/home button so the guest can always return.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 001 (splash + CONTENT object), Feature 002 (design tokens)  
**Storage**: Stateless  
**Testing**: Manual — iOS Safari, Android Chrome, WhatsApp in-app browser  
**Target Platform**: 360 dp and 390 dp phones  
**Constraints**: Single `.html` file; no external deps; grid via CSS Grid; routing via JS show/hide

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | No external icons; SVG line art inline |
| II. Offline-First | ✅ PASS | Pure JS routing; no network calls |
| III. Mobile-First | ✅ PASS | 2-col grid; 44 px tap targets |
| IV. Multilingual | ✅ PASS | Labels keyed via `CONTENT.strings[lang]` |
| V. Version-Based Updates | ✅ PASS | Adding a section = editing one array |

## Project Structure

```text
index.html          ← home screen markup + section skeleton + routing JS
```

No new files. All changes land in `index.html`.

## Implementation Phases

### Phase 1 — Home Screen Grid
- Add `#home` screen div after `#welcome`
- Implement `CONTENT.sections` array (11 entries: icon, labelKey, target)
- CSS Grid 2-col layout using design tokens from spec 002
- Render loop: JS generates section boxes from array
- Show `#home` on splash dismiss; hide `#welcome`

### Phase 2 — Section Routing
- Each content section wrapped in `<div class="screen" id="{target}">`
- JS `navigate(target)` function: hides all screens, shows target
- Back button in every section header → `navigate('home')`
- "Coming soon" fallback for unimplemented sections

### Phase 3 — Multilingual Labels
- Add 11 label keys to `CONTENT.strings.en` (and IT/DE)
- Verify all labels display correctly in EN, IT, and DE; no truncation at 360 dp

## Implementation Notes (Actual vs Planned)

- **Icons**: SVG line art (24px, stroke-based) used — NOT emoji as planned. This aligns
  with the luxury hotel aesthetic of the design system.
- **All sections implemented**: No "coming soon" placeholders — all 11 sections have
  full content in the initial release.
- **Multilingual**: All 11 labels translated to IT and DE (not just placeholder strings).
