# Feature Specification: Design System

**Feature Branch**: `002-design-system`
**Created**: 2026-04-10
**Status**: Draft
**Input**: User description: "the style of the page should be elegant and minimal — follow the style of the demo.html file"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Perceives a Luxury, Cohesive Experience (Priority: P1)

A guest opens the guide on their phone and immediately feels they are reading a premium
boutique B&B document — not a generic HTML page. The visual language is consistent across
every section: colours, spacing, typography and component shapes all feel intentional and
unified.

**Why this priority**: Visual identity is the foundation every other section is built on.
Without a defined design system, each section will look inconsistent.

**Independent Test**: Open `index.html` on a phone. Without internet, the typography,
colour palette and spacing are correct and consistent on the splash screen, header,
navigation and at least one content section.

**Acceptance Scenarios**:

1. **Given** the file is opened with no internet, **When** the splash screen appears,
   **Then** the typography is serif for the property name, sans-serif for supporting
   text, and the colour palette uses only the defined design tokens — with no
   missing fonts or fallback boxes.
2. **Given** two different sections are displayed, **When** the guest navigates between
   them, **Then** the cards, dividers, labels and body text look identical in style.
3. **Given** the guide is opened on a 360 dp Android screen and a 390 dp iPhone,
   **Then** font sizes, spacing and touch targets look correct and proportional on both.

---

### User Story 2 - Content Author Updates Text Without Breaking the Style (Priority: P2)

A content author edits a card title or body text in `index.html`. The result still looks
correct — no overflow, no broken alignment, no style regression.

**Why this priority**: The design system must be resilient to content changes, not
fragile. Styles should be structural, not dependent on exact string lengths.

**Independent Test**: Change the text of a card title to something 3× longer than the
original. Open the file — the card expands gracefully without any text being cut off
or components overlapping.

**Acceptance Scenarios**:

1. **Given** a card title is changed to a long string, **When** the page is opened,
   **Then** the card height expands to fit and no text is truncated.
2. **Given** a content author removes one item from a list section, **When** the page
   is opened, **Then** the remaining items are evenly spaced and the section footer
   remains correctly positioned.

---

### Edge Cases

- What if a section has no items? The section hero still displays; body shows an
  empty state message rather than collapsing awkwardly.
- What if system fonts render with different metrics on Android vs iOS? Font-size and
  line-height values must be tested on both to confirm no layout breaks.
- What if a future section introduces a new component not covered by the design system?
  New components must extend the existing token set; they must not introduce new colour
  values or font sizes outside the scale.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The guide MUST use only two typeface roles: a **serif** (for headlines,
  property name, large numbers) and a **sans-serif** (for body, labels, navigation).
- **FR-002**: Both typefaces MUST be embedded directly in `index.html` as base64-encoded
  WOFF2 data URIs — no `@import` from Google Fonts or any external URL.
- **FR-003**: The colour palette MUST be defined as CSS custom properties (`--token-name`)
  in `:root` and used exclusively throughout — no hardcoded hex values outside `:root`.
- **FR-004**: The colour palette MUST consist of: one **cream** background, one **warm
  white** surface, one **charcoal** dark, one **stone** mid-grey, one **gold** accent,
  one **gold-light** secondary accent, one **border** colour, one **accent background**.
- **FR-005**: The design system MUST define reusable component classes: `.card`,
  `.section-hero`, `.nav-item`, `.ornament-divider`, `.badge`, `.rule-item`,
  `.wifi-box` / `.info-box`, `.warning-box`, `.emergency-card`, `.map-btn`.
  `.warning-box` is a high-visibility variant of `.info-box` (amber/gold border +
  background tint) used for safety-critical notices (ZTL warning, dishwasher caution).
- **FR-006**: All font sizes MUST use `clamp()` or `rem` units — no `px` font sizes —
  to respect the user's OS accessibility text size setting.
- **FR-007**: Touch targets (buttons, nav items, flag buttons) MUST be at least
  44 × 44 CSS pixels per Apple/Google accessibility guidelines.
- **FR-008**: The serif and sans-serif fonts chosen MUST visually match the style of
  `demo.html` (Cormorant Garamond + Jost aesthetic): thin weight headlines, wide
  letter-spacing on uppercase labels, elegant and restrained.
- **FR-009**: The design system MUST work fully offline with no visible difference
  compared to an online rendering (i.e., fonts MUST NOT fall back to system fonts
  when offline).
- **FR-010**: The CSS MUST be contained entirely within a single `<style>` block in
  `index.html` — no external `.css` file references.

### Key Entities

- **Design Token**: A CSS custom property in `:root` representing a named colour,
  spacing value, or radius. All components reference tokens, never raw values.
- **Component Class**: A reusable CSS class defining the visual structure of a UI
  element. Component classes use tokens only.
- **Typeface Role**: One of two font-family assignments (serif / sans-serif). Each
  role has one embedded font at a defined set of weights.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Opening `index.html` with no internet connection shows identical
  typography to an online rendering — verified on iOS Safari and Android Chrome.
- **SC-002**: Every visible hex colour value in `index.html` (outside `:root`) matches
  a defined design token — zero hardcoded hex values in component CSS.
- **SC-003**: All interactive elements (nav items, flag buttons, map buttons) have a
  tap target of at least 44 × 44 CSS pixels — verified with browser dev tools.
- **SC-004**: Font rendering on a 360 dp Android device and a 390 dp iPhone shows
  no clipped text, no overflow and no layout breaks across all defined components.
- **SC-005**: A content author changing a card title to 2× its original length
  produces no visual breakage — card expands cleanly.

## Assumptions

- The reference style is `demo.html` in the project root, which uses Cormorant Garamond
  (serif) and Jost (sans-serif) loaded from Google Fonts. The implementation MUST
  replicate this aesthetic using the same or equivalent fonts embedded as WOFF2 data URIs.
- Font subsetting (limiting to the characters needed for Latin + basic punctuation) is
  acceptable to reduce file size — full Unicode coverage is not required.
- The colour palette tokens are derived directly from `demo.html`:
  `--cream #F7F3EE`, `--warm-white #FDFAF6`, `--charcoal #2C2C2C`, `--stone #8C8478`,
  `--gold #B8996A`, `--gold-light #D4B896`, `--border #E2D9CF`, `--accent-bg #F0EAE1`.
- The design system spec does NOT include motion/animation decisions (splash screen
  entrance animation) — those belong to the splash/welcome screen feature spec.
- The `demo.html` file uses Google Fonts which violates the Self-Contained and
  Offline-First constitution principles. The implementation MUST resolve this conflict
  by embedding fonts — the visual result is the reference, not the technique.
