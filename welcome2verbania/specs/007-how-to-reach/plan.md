# Implementation Plan: How to Reach Us

**Branch**: `007-how-to-reach` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)

## Summary

Build the "How to Reach Us" section with three sub-sections:
1. **ZTL Warning** — high-visibility `.warning-box` with embedded ZTL sign image (`assets/ztl-sign.png`), access hours, and explanation of the camera system.
2. **Reach the House** — prose directions + 3 sequential photos (`assets/door1.jpg`, `assets/door2.jpg`, `assets/door3.jpg`) guiding guests from Piazza San Rocco to the apartment door.
3. **Parking** — card list of 2 nearby parking options with Maps links.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (routing + back nav), Feature 002 (`.warning-box`, `.card`)  
**Build Tool**: `build.sh` injects base64 data URIs for ZTL sign and 3 door photos  
**Testing**: Manual — ZTL image renders; door photos display in sequence; Maps links open  
**Constraints**: Images must be base64-inlined; ZTL sign is 412×724 px RGBA PNG (may need optimisation)

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | All images base64-inlined via `build.sh` |
| II. Offline-First | ✅ PASS | No external image URLs at runtime |
| III. Mobile-First | ✅ PASS | Photos full-width; warning box above the fold |
| IV. Multilingual | ✅ PASS | All text in `CONTENT.strings[lang]` |
| V. Version-Based Updates | ✅ PASS | Parking list in `CONTENT.sections.parking[]` |

## Project Structure

```text
assets/
├── ztl-sign.png      ← ZTL road sign image (412×724 RGBA PNG, ~464 KB)
├── door1.jpg         ← Arrival photo 1 (gate)
├── door2.jpg         ← Arrival photo 2 (walkway)
└── door3.jpg         ← Arrival photo 3 (stairs/door)

index.html            ← #how-to-reach screen; tokens {{ZTL_SIGN}}, {{DOOR_PHOTO_1/2/3}}
build.sh              ← injects base64 for above assets
```

## Build Tokens

| Token | Source file |
|-------|------------|
| `{{ZTL_SIGN}}` | `assets/ztl-sign.png` |
| `{{DOOR_PHOTO_1}}` | `assets/door1.jpg` |
| `{{DOOR_PHOTO_2}}` | `assets/door2.jpg` |
| `{{DOOR_PHOTO_3}}` | `assets/door3.jpg` |

## ZTL Access Hours

Free passage: **08:00–12:30** and **14:30–20:00**

## Implementation Phases

### Phase 1 — ZTL Sub-Section
- Add `<div class="screen" id="how-to-reach">` with back-nav header
- `.warning-box` with ZTL explanation text, access hours, camera note
- `<img>` with `src="{{ZTL_SIGN}}"` for the road sign

### Phase 2 — Reach the House Sub-Section
- Prose directions text from `CONTENT.strings[lang].reachTheHouse`
- 3 `<img>` elements with tokens `{{DOOR_PHOTO_1/2/3}}`, full-width, sequential

### Phase 3 — Parking Sub-Section
- Render loop over `CONTENT.sections.parking[]`
- Each card: name, description, "Open in Maps" button
- Seed: Via Brigata Cesare Battisti (free) + Largo degli Invalidi del Lavoro (pay)

### Phase 4 — build.sh Extension
- Extend `build.sh` to inject ZTL sign and 3 door photos
- Consider optimising ztl-sign.png (WebP or resize) to reduce file size
- Verify total HTML file size stays manageable after all base64 injections
