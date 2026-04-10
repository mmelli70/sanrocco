# Tasks: Home Screen

**Input**: `specs/003-home-screen/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 001 (CONTENT object, setLanguage, DOMContentLoaded), spec 002 (design tokens, `.section-grid`, `.section-box`, `.section-header`, `.back-btn`)

---

## Phase 1: CONTENT Sections Array

**Purpose**: Define the 11-entry navigation data in the CONTENT object.

- [ ] T003-01 In `index.html` `<script>` block, extend the `CONTENT` object with a `nav` array of 11 entries in order. Each entry: `{ icon, labelKey, target }`:
  ```js
  { icon: "📞", labelKey: "nav_contacts",     target: "contacts" },
  { icon: "🗺️", labelKey: "nav_howToReach",   target: "how-to-reach" },
  { icon: "📋", labelKey: "nav_houseRules",   target: "house-rules" },
  { icon: "🚨", labelKey: "nav_emergency",    target: "emergency" },
  { icon: "🛒", labelKey: "nav_supermarkets", target: "supermarkets" },
  { icon: "🍽️", labelKey: "nav_restaurants",  target: "restaurants" },
  { icon: "🍦", labelKey: "nav_gelaterie",    target: "gelaterie" },
  { icon: "🏖️", labelKey: "nav_beaches",      target: "beaches" },
  { icon: "🏛️", labelKey: "nav_thingsToVisit",target: "things-to-visit" },
  { icon: "⚡", labelKey: "nav_adrenaline",   target: "adrenaline" },
  { icon: "⛵", labelKey: "nav_boatRental",   target: "boat-rental" }
  ```
- [ ] T003-02 Add 11 label keys to `CONTENT.strings.en` (and empty string placeholders to `it` and `de`):
  `nav_contacts`, `nav_howToReach`, `nav_houseRules`, `nav_emergency`, `nav_supermarkets`, `nav_restaurants`, `nav_gelaterie`, `nav_beaches`, `nav_thingsToVisit`, `nav_adrenaline`, `nav_boatRental`

**Checkpoint**: `CONTENT.nav` is defined; `CONTENT.strings.en` has all 11 label keys.

---

## Phase 2: Home Screen Markup & Render

**Purpose**: Build the navigation grid shown after splash dismissal.

- [ ] T003-03 Add `<div class="screen" id="home" hidden>` to `index.html` body after `#welcome`. Inside: a `<header>` with the guide title and a `<main class="section-grid" id="nav-grid">` (empty — populated by JS)
- [ ] T003-04 In `index.html` `<script>` block, write `renderHomeScreen()`: iterate `CONTENT.nav`, for each entry create a `<button class="section-box" data-target="{target}">` containing a `<span class="icon">` and a `<span class="label" data-i18n="{labelKey}">` — append to `#nav-grid`; call on `DOMContentLoaded`
- [ ] T003-05 Wire splash-dismiss to show home screen: on tap of the splash screen (or a "Enter" button — see spec 001), call `navigate('home')`

**Checkpoint**: After splash, the 11-box grid is visible. No broken layout at 360 dp.

---

## Phase 3: Section Routing

**Purpose**: Navigate between home and any section without page reload.

- [ ] T003-06 In `index.html` `<script>` block, implement `navigate(target)`:
  - Hide all `.screen` elements (`hidden = true`)
  - Show the screen with `id === target` (`hidden = false`)
  - Scroll to top (`window.scrollTo(0, 0)`)
  - Update `document.title` if section has a title key
- [ ] T003-07 Add click listener on `#nav-grid` (event delegation): on tap of `.section-box`, call `navigate(button.dataset.target)`
- [ ] T003-08 Add "coming soon" fallback: if `navigate(target)` is called and no screen with that id exists, show a `#coming-soon` screen with a back button and a translatable message from `CONTENT.strings[lang].comingSoon`; add `nav_comingSoon` to string keys

**Checkpoint**: Tapping each box navigates correctly (or shows coming soon). Back button always returns to `#home`.

---

## Phase 4: Back Navigation (FR-010)

**Purpose**: Every section has a persistent sticky header with a back/home button.

- [ ] T003-09 Write `createSectionHeader(titleKey)` JS helper: returns a `<header class="section-header">` containing a `<button class="back-btn">← </button>` with click → `navigate('home')`, and a `<h2 data-i18n="{titleKey}">` for the section title
- [ ] T003-10 Ensure `.section-header` is `position: sticky; top: 0; z-index: 10` (from spec 002 T002-07) — verify it stays visible while scrolling a long section

**Checkpoint**: Scroll to bottom of any section — the header with back button is always visible. Tapping it returns to `#home`.

---

## Phase 5: Validation

- [ ] T003-11 Verify 2-col grid with 11 entries on 360 dp and 390 dp — no horizontal overflow, no truncated labels ✅
- [ ] T003-12 Add one extra entry to `CONTENT.nav`, reload — new box appears without any HTML change; remove it again ✅
- [ ] T003-13 Verify fully offline (airplane mode): all 11 boxes render, navigation works ✅
- [ ] T003-14 Verify `setLanguage()` updates all 11 nav labels when language changes ✅

---

## Dependencies

- T003-01 and T003-02 can run in parallel
- T003-03 → T003-04 → T003-05 (markup before render before wiring)
- T003-06 must complete before T003-07 and T003-08
- T003-09 → T003-10 (helper before verification)
- Phase 5 depends on Phases 1–4 complete
