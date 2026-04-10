# Implementation Plan: Design System

**Branch**: `002-design-system` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/002-design-system/spec.md`

## Summary

Define and implement the visual design system for the San Rocco guest guide: colour
tokens, typography (two embedded typefaces, offline-safe), reusable component CSS
classes, and a font-embedding build step. All styles live in a single `<style>` block
in `index.html`. Google Fonts is replaced by WOFF2 files embedded as base64 data URIs.

## Technical Context

**Language/Version**: CSS3 (custom properties, `clamp()`, `@font-face`), Vanilla JS (none for design system itself)
**Primary Dependencies**: None at runtime — fonts embedded at build time via `build.sh`
**Storage**: N/A — stateless by constitution
**Testing**: Visual inspection on iOS Safari, Android Chrome; CSS contrast checker for WCAG AA
**Target Platform**: iOS 15+ Safari, Android 9+ Chrome, WhatsApp/Gmail in-app browsers
**Project Type**: Single-file static HTML document — CSS-only design system
**Performance Goals**: Total embedded font payload ≤ 150 KB (subset Latin); full render ≤ 2 s offline
**Constraints**: Zero external URLs in `<style>` or `<link>`; all `@font-face src` must be `data:` URIs
**Scale/Scope**: 8 font variants (5 Cormorant Garamond + 3 Jost), 8 colour tokens, ~12 component classes

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | Fonts embedded as base64 WOFF2; no external `@import` or `<link>` |
| II. Offline-First | ✅ PASS | All assets inlined; no network calls for fonts or styles |
| III. Mobile-First | ✅ PASS | Typography uses `clamp()` + `rem`; touch targets ≥ 44 px |
| IV. Multilingual | ✅ PASS | Design system is language-neutral; font subset covers Latin + IT/DE diacritics |
| V. Version-Based Updates | ✅ PASS | Design changes trigger a version bump; `build.sh` re-embeds fonts |

**⚠️ Key conflict resolved**: `demo.html` uses `@import url('https://fonts.googleapis.com/...')`.
This violates principles I and II. Resolution: download WOFF2 files, subset to Latin Extended,
embed as `@font-face { src: url('data:font/woff2;base64,...') }`.

**Post-design re-check**: ✅ All principles maintained through Phase 1 design.

## Project Structure

### Documentation (this feature)

```text
specs/002-design-system/
├── plan.md              ← this file
├── research.md          ← Phase 0
├── data-model.md        ← Phase 1
├── quickstart.md        ← Phase 1
├── contracts/
│   ├── design-tokens.md        ← Phase 1
│   └── component-classes.md    ← Phase 1
└── tasks.md             ← created by /speckit.tasks
```

### Source Code (repository root)

```text
assets/
└── fonts/
    ├── cormorant-garamond-300.woff2
    ├── cormorant-garamond-300-italic.woff2
    ├── cormorant-garamond-400.woff2
    ├── cormorant-garamond-400-italic.woff2
    ├── cormorant-garamond-600.woff2
    ├── jost-300.woff2
    ├── jost-400.woff2
    └── jost-500.woff2

download-fonts.sh # curl-based: fetches WOFF2 files from Google Fonts CDN (one-time, build-time)
build.sh          # Extended with --fonts flag: base64-encodes assets/fonts/* → injects into index.html
index.html        # <style> block holds all tokens + component CSS + @font-face rules
```

**Structure Decision**: Single-project. Font WOFF2 files are kept in `assets/fonts/` as
source files. `build.sh` base64-encodes them and injects `@font-face` rules into `index.html`.
The CSS design system (tokens + components) is hand-edited directly in `index.html`.
