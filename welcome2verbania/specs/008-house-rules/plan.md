# Implementation Plan: House Rules

**Branch**: `008-house-rules` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Status**: COMPLETE

## Summary

Build the House Rules section with 8 clearly named sub-sections: Check-In/Out,
Smoking, City Tax, WiFi, Kitchen (dishwasher caution), Jacuzzi, Air Conditioning,
and Waste. Uses `.info-box` for informational content and `.warning-box` for
the dishwasher and jacuzzi cautions. All text is owner-supplied and translatable.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.info-box`, `.warning-box`)  
**Storage**: Stateless  
**Testing**: Manual — all 8 sub-sections readable at 360 dp; warning boxes visually distinct  
**Constraints**: Single `.html` file; WiFi credentials embedded in content strings

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Pure text content; no external deps |
| II. Offline-First | ✅ PASS | Static content only |
| III. Mobile-First | ✅ PASS | Sub-sections stack vertically; readable at 360 dp |
| IV. Multilingual | ✅ PASS | All rule text in `CONTENT.strings[lang]` |
| V. Version-Based Updates | ✅ PASS | Edit one string key to update a rule |

## Project Structure

```text
index.html   ← add #house-rules screen with 8 sub-section blocks
```

## Sub-Sections & Components

| # | Title | Component |
|---|-------|-----------|
| 1 | Check-In / Check-Out | `.info-box` |
| 2 | Smoking | `.info-box` |
| 3 | City Tax | `.info-box` |
| 4 | WiFi | `.info-box` (credentials highlighted) |
| 5 | Kitchen — Dishwasher | `.warning-box` (caution) |
| 6 | Jacuzzi | `.warning-box` (caution) |
| 7 | Air Conditioning | `.info-box` |
| 8 | Waste Disposal | `.info-box` (placeholder until May) |

## Implementation Phases

### Phase 1 — Section Markup
- Add `<div class="screen" id="house-rules">` with back-nav header
- 8 sub-section `<h3>` headings + content blocks
- `.warning-box` for Kitchen and Jacuzzi sections
- WiFi credentials in a visually distinct code/highlight block

### Phase 2 — Data & Strings
- Add all 8 sub-section text blocks to `CONTENT.strings.en`
- IT/DE placeholder keys created for future translation

### Phase 3 — Validation
- All 8 sub-sections visible and readable at 360 dp ✅
- Warning boxes visually different from info boxes ✅
- WiFi SSID and password readable at a glance ✅

## Implementation Notes (Actual vs Planned)

- **8 sub-sections implemented**: checkin, smoking, city tax, wifi, dishwasher (kitchen),
  aircon, waste, jacuzzi — all complete and translated.
- **Waste schedule**: Mon–Sat day-by-day waste disposal schedule in all 3 languages.
- **All text in strings.en/it/de**: Fully translated to Italian and German.
