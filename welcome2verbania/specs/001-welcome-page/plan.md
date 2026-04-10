# Implementation Plan: Welcome Page

**Branch**: `001-welcome-page` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/001-welcome-page/spec.md`

## Summary

Build the full-viewport welcome screen for the San Rocco B&B guest guide. The
deliverable is a section of a single self-contained HTML file showing a background
image, the property name, subtitle, location, and a language-flag selector. All
assets are inlined; the file works with zero network access.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JavaScript (ES6+) — no transpilation  
**Primary Dependencies**: None (zero external runtime dependencies by constitution)  
**Storage**: N/A — stateless by constitution  
**Testing**: Manual browser testing (iOS Safari, Android Chrome, WhatsApp/Gmail in-app browser)  
**Target Platform**: iOS 15+ Safari, Android 9+ Chrome, WhatsApp in-app browser, Gmail in-app browser  
**Project Type**: Single-file static HTML document  
**Performance Goals**: Full render in < 2 s on a mid-range smartphone with airplane mode on  
**Constraints**: Single `.html` file; all images encoded as base64 data URIs; no `<link>` or `<script src>` pointing outside the file  
**Scale/Scope**: 1 deliverable file, 1 screen (welcome/cover), 1 active language (EN); architecture supports 3 languages (IT, EN, DE)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Single HTML; image inlined as base64; no CDN or external refs |
| II. Offline-First | ✅ PASS | No network calls at any point |
| III. Mobile-First | ✅ PASS | Designed for 360 dp viewport; touch targets; tested on iOS + Android |
| IV. Multilingual | ✅ PASS | EN active; content strings keyed by language; IT/DE placeholders in selector |
| V. Version-Based Updates | ✅ PASS | File rebuilt on each content change; version visible in document |

**Post-design re-check**: ✅ All principles maintained through Phase 1 design.

## Project Structure

### Documentation (this feature)

```text
specs/001-welcome-page/
├── plan.md          ← this file
├── research.md      ← Phase 0
├── data-model.md    ← Phase 1
├── quickstart.md    ← Phase 1
├── contracts/
│   └── content-schema.md   ← Phase 1
└── tasks.md         ← created by /speckit.tasks
```

### Source Code (repository root)

```text
assets/
└── background.jpg        # Source image (NOT committed if large; owner-supplied)

src/
└── content/
    └── en.js             # English content strings (single source of truth for text)

index.html                # Final deliverable (hand-editable or build-generated)
build.sh                  # Optional: re-encodes images and assembles index.html
```

**Structure Decision**: Single-project, single-file output. `src/content/en.js` holds
all user-visible strings so content authors never touch HTML structure. `build.sh`
re-encodes the background image to base64 and injects it into `index.html`. For
updates without a build step, base64 strings can be replaced directly in the HTML.
