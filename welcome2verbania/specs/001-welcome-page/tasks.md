# Tasks: Welcome Page

**Input**: Design documents from `specs/001-welcome-page/`
**Prerequisites**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, contracts/ ✅

**Organization**: Tasks grouped by user story for independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no shared dependencies)
- **[Story]**: Which user story this task belongs to (US1, US2)
- Exact file paths included in every description

---

## Phase 1: Setup (Project Structure)

**Purpose**: Create all files and folders before any implementation begins.

- [ ] T001 Create project file structure: `index.html` (empty skeleton), `src/content/en.js` (empty), `assets/` directory with a `.gitkeep` placeholder, `build.sh` (empty)
- [ ] T002 Populate `src/content/en.js` with English content strings per `specs/001-welcome-page/contracts/content-schema.md` — include the full `CONTENT` object with `languages`, `defaultLanguage`, and `strings.en`

**Checkpoint**: All files exist; `src/content/en.js` exports a valid `CONTENT` object.

---

## Phase 2: Foundational (HTML + JS Scaffold)

**Purpose**: Core structure that both user stories depend on. MUST be complete before Phase 3 or 4.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [ ] T003 Write the HTML skeleton in `index.html`: `<!DOCTYPE html>`, `<html lang="en">`, `<head>` with `<meta charset>`, `<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">`, inline `<style>` block (empty), inline `<script>` block (empty)
- [ ] T004 [P] Add CSS foundation to `index.html` `<style>` block: `* { box-sizing: border-box; margin: 0; padding: 0; }`, `html, body { height: 100%; }`, `.screen { min-height: 100dvh; min-height: 100vh; padding: env(safe-area-inset-top) env(safe-area-inset-right) env(safe-area-inset-bottom) env(safe-area-inset-left); }`
- [ ] T005 Embed the `CONTENT` object in `index.html` `<script>` block by inlining the content of `src/content/en.js`, then implement `setLanguage(code)` function that: (1) updates all `[data-i18n]` DOM elements with the matching string, (2) sets `document.documentElement.lang`, (3) marks the active flag button
- [ ] T006 Add language auto-detection on `DOMContentLoaded` in `index.html` `<script>` block: read `navigator.language`, find a matching `code` in `CONTENT.languages` where `active === true`, fall back to `CONTENT.defaultLanguage`, call `setLanguage(detectedCode)`

**Checkpoint**: Opening `index.html` in a browser shows a blank page with no console errors and language detection runs silently.

---

## Phase 3: User Story 1 — Guest Opens the Guide (Priority: P1) 🎯 MVP

**Goal**: Full-viewport welcome screen — background image, overlay, and text stack visible without scrolling on a 360 dp phone.

**Independent Test**: Open `index.html` from the file system with airplane mode on. The background image (or fallback colour), "San Rocco", "Bed & Breakfast Guest Guide", and "Verbania - Italy" must all be visible without scrolling on a 360 × 640 dp screen.

- [ ] T007 [US1] Add background layer to `index.html`: a `<div class="bg">` inside `.screen` styled with `background-image: url('data:image/jpeg;base64,PLACEHOLDER')`, `background-size: cover`, `background-position: center`, `position: absolute; inset: 0`, and fallback `background-color: #2c3e50`
- [ ] T008 [P] [US1] Add the dark overlay to `index.html`: a `<div class="overlay">` inside `.screen` with `position: absolute; inset: 0; background: rgba(0,0,0,0.35)` layered above `.bg`
- [ ] T009 [P] [US1] Add the text stack HTML to `index.html`: a `<div class="content">` containing `<h1 data-i18n="propertyName">`, `<p data-i18n="subtitle">`, `<p data-i18n="location">`, and an empty `<div class="lang-selector">` placeholder; positioned above overlay via `position: relative; z-index: 1`
- [ ] T010 [US1] Style the text stack in `index.html` `<style>` block: `.content` centered vertically and horizontally (flexbox column), white `color: #fff`, `h1` large (clamp 2rem–3rem), subtitle and location smaller (1rem–1.2rem), `text-shadow: 0 1px 4px rgba(0,0,0,0.6)` on all text
- [ ] T011 [US1] Verify layout in at minimum two real environments: open `index.html` from the filesystem in iOS Safari (or BrowserStack) and Android Chrome; confirm all three text lines visible without scrolling at 360 dp width

**Checkpoint**: User Story 1 is fully functional. Guest sees welcome screen with no internet.

---

## Phase 4: User Story 2 — Guest Selects Language (Priority: P2)

**Goal**: Flag selector below the text stack; English active and tappable; IT and DE visible but disabled.

**Independent Test**: Tap 🇬🇧 flag — guide remains in English (no reload). IT and DE flags are visible, appear dimmed, and do not respond to taps.

- [ ] T012 [US2] Populate `.lang-selector` in `index.html` `<script>` block via `renderLanguageSelector()`: for each entry in `CONTENT.languages`, create a `<button>` with `data-lang-code`, emoji text, `aria-label` from `label` field; set `disabled` and `opacity: 0.4` when `active === false`; call this function inside `DOMContentLoaded` before `setLanguage`
- [ ] T013 [P] [US2] Style `.lang-selector` and its buttons in `index.html` `<style>` block: flex row, `gap: 1rem`, flag buttons `font-size: 2rem`, `background: none; border: none; cursor: pointer; padding: 0.25rem`, `min-width: 44px; min-height: 44px` (touch target), active state shown with `border-bottom: 2px solid #fff`
- [ ] T014 [US2] Wire flag tap in `index.html` `<script>` block: add click listener on `.lang-selector` (event delegation); on tap of an enabled button, call `setLanguage(button.dataset.langCode)`; `setLanguage` must also update the active border on the tapped flag and remove it from others
- [ ] T015 [US2] Verify language selector in iOS Safari and Android Chrome: 🇬🇧 tappable and shows active border; 🇮🇹 and 🇩🇪 dimmed and non-interactive; no page reload on flag tap

**Checkpoint**: User Stories 1 and 2 both work independently.

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Accessibility, versioning, image tooling, and final distribution test.

- [ ] T016 [P] Add `const VERSION = "1.0.0"` constant to `index.html` `<script>` block and display it in a small footer `<span>` inside `.content` (e.g., `v1.0.0` in `font-size: 0.7rem; opacity: 0.6`)
- [ ] T017 [P] Audit accessibility in `index.html`: add `aria-label="Select language"` to `.lang-selector`, confirm `<h1>` is the only H1, verify colour contrast of white text over `rgba(0,0,0,0.35)` overlay meets WCAG AA (≥ 4.5:1)
- [ ] T018 Write `build.sh` at repo root: accept optional argument `IMAGE=assets/home.jpeg`; base64-encode the image with `base64 -i "$IMAGE" | tr -d '\n'`; replace the `PLACEHOLDER` token inside `index.html`'s `.bg` background-image URL with the encoded string; print success message and new file size
- [ ] T019 Run the full test checklist from `specs/001-welcome-page/quickstart.md`: airplane mode open, iOS Safari, Android Chrome, WhatsApp in-app browser, Gmail in-app browser — confirm all checklist items pass before marking feature done

**Checkpoint**: `index.html` is distributable, accessible, versioned, and passes all cross-platform tests.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: No dependencies — start immediately
- **Phase 2 (Foundational)**: Depends on Phase 1 — BLOCKS Phases 3 and 4
- **Phase 3 (US1)**: Depends on Phase 2 — can start as soon as Foundational is done
- **Phase 4 (US2)**: Depends on Phase 2 — can start in parallel with Phase 3
- **Phase 5 (Polish)**: Depends on Phases 3 and 4 being complete

### User Story Dependencies

- **US1** and **US2** are independent of each other once Phase 2 is done
- US2 builds on the `.lang-selector` placeholder introduced in T009 (US1), so T009 must complete before T012

### Within Each Phase

- Tasks marked [P] within a phase can be worked in parallel
- T007 (background), T008 (overlay), T009 (text stack) can be done in parallel once T003–T006 are done

---

## Parallel Example: Phase 3 (US1)

```text
After T003–T006 complete:

Parallel batch A:
  Task T007: Add background layer div + CSS
  Task T008: Add dark overlay div + CSS
  Task T009: Add text stack HTML + positioning

Sequential:
  Task T010: Style text stack (depends on T009 existing)
  Task T011: Cross-platform verification (depends on T007–T010)
```

---

## Implementation Strategy

### MVP (User Story 1 Only)

1. Phase 1: Setup
2. Phase 2: Foundational scaffold
3. Phase 3: US1 — welcome screen
4. **STOP AND TEST**: Open file from phone in airplane mode
5. Distribute to first guest if validated

### Full Feature

1. Add Phase 4 (US2) on top of MVP
2. Add Phase 5 (Polish) before final distribution

### Single-developer order

T001 → T002 → T003 → T004 → T005 → T006 → T007 → T008 → T009 → T010 → T011 → T012 → T013 → T014 → T015 → T016 → T017 → T018 → T019
