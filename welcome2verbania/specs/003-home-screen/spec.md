# Feature Specification: Home Screen

**Feature Branch**: `003-home-screen`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: User description: "after the splash page, a new page will show with buttons with icons and text for the main sections of the document — How to reach us, House rules, Supermarkets, Restaurants, Gelaterie, Beaches, Things to visit, Adrenaline attractions, Boat rental. Every icon and text is in a box and two boxes are shown per row. The list can be expanded in the future and must be easily updated."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Navigates to a Section (Priority: P1)

After dismissing the splash screen, the guest sees a grid of labelled section buttons.
They tap one and are taken to that section's content page.

**Why this priority**: This is the main navigation of the entire guide. Without it,
guests cannot reach any content.

**Independent Test**: Open `index.html`, dismiss the splash screen. The home screen
displays with all 9 section buttons arranged in a 2-column grid. Tapping any button
navigates to the correct section (or shows a placeholder if the section is not yet
implemented). Works fully offline.

**Acceptance Scenarios**:

1. **Given** the splash screen has been dismissed, **When** the home screen appears,
   **Then** all defined sections are visible as boxes arranged in 2 columns, each
   showing an icon and a text label, without scrolling on a 360 dp phone.
2. **Given** the home screen is displayed, **When** the guest taps a section box,
   **Then** the corresponding section content is shown immediately with no page reload.
3. **Given** the device is offline, **When** the guest taps any section box,
   **Then** navigation works identically to the online case.
4. **Given** the guide is viewed on both a 360 dp Android and a 390 dp iPhone,
   **Then** the 2-column grid fits without horizontal scroll and box text is not truncated.

---

### User Story 2 - Content Author Adds or Removes a Section (Priority: P2)

A content author adds a new section entry (e.g., "Pharmacies") or removes one from
the home screen grid by editing a single list in `index.html`. No structural HTML
changes are needed — only the data list.

**Why this priority**: The spec explicitly requires the list to be easily expandable.
If adding a section requires touching multiple places in the HTML, the design is fragile.

**Independent Test**: Add a new entry `{ icon: "💊", label: "Pharmacies", target: "pharmacies" }`
to the sections list in the `CONTENT` object. Open the file — the new box appears in
the grid automatically, correctly styled, without any other change.

**Acceptance Scenarios**:

1. **Given** a new section entry is added to `CONTENT.sections`, **When** the page
   opens, **Then** the new box appears in the grid in the correct position with the
   correct icon and label.
2. **Given** one section entry is removed from `CONTENT.sections`, **When** the page
   opens, **Then** the grid reflows correctly — no empty gaps, no broken layout.
3. **Given** the sections list has an odd number of items, **When** the page opens,
   **Then** the last box either spans the full row or is left-aligned — no layout
   breakage.

---

### Edge Cases

- What if a section label is very long (e.g., "Adrenaline Attractions")? Text must
  wrap within the box without overflowing or being cut off.
- What if the total number of sections grows to 12 or more? The grid must scroll
  vertically and all boxes remain correctly sized.
- What if a section has not been implemented yet? The box must still appear; tapping
  it shows a clear "coming soon" message rather than breaking navigation.
- What if the guest is deep inside a section's content? The back/home button must
  always be reachable — either fixed/sticky at the top or always within one scroll
  to the top of the section.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The home screen MUST appear automatically after the splash screen is
  dismissed, with no additional user action required.
- **FR-002**: The home screen MUST display all defined sections as boxes arranged in
  a **2-column grid**.
- **FR-003**: Each box MUST contain one SVG line art icon (24px, stroke-based) and one
  text label, vertically stacked and centred.
- **FR-004**: The section list MUST be defined as a data array in the `CONTENT`
  object (alongside language strings) so that adding or removing a section requires
  editing only that array — no structural HTML changes.
- **FR-005**: Each section entry in the data array MUST have at minimum: an `icon`
  (SVG line art string), a `label` key (looked up from language strings), and a `target`
  identifier used to show the correct content section.
- **FR-006**: Tapping a box MUST navigate to the corresponding content section within
  the same page (no reload, no new tab).
- **FR-007**: If a target section has no content yet, tapping its box MUST display
  a "coming soon" placeholder rather than an error or blank screen.
- **FR-008**: The initial section list MUST include exactly these 11 entries in order:
  Contacts, How to Reach Us, House Rules, Emergency, Supermarkets, Restaurants,
  Gelaterie, Beaches, Things to Visit, Adrenaline Attractions, Boat Rental.
- **FR-009**: Section labels MUST be translatable — each label key resolves through
  the active language in `CONTENT.strings`, consistent with the multilingual contract
  established in feature 001.
- **FR-010**: Every content section MUST display a persistent back/home button
  (e.g., a header bar with a "← Home" control) that navigates the guest back to the
  home screen grid without a page reload. This back affordance MUST be visible
  without scrolling when a section first opens.
- **FR-011**: The home screen MUST be fully functional offline with no network requests.

### Key Entities

- **Section Entry**: A record in the `CONTENT.sections` array. Fields: `icon` (emoji),
  `labelKey` (string key into `CONTENT.strings[lang]`), `target` (section identifier).
- **Home Screen**: The view displayed after the splash screen, containing the section grid.
- **Section Grid**: A 2-column layout of Section Boxes.
- **Section Box**: A tappable card showing one icon and one translated label.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All 11 section boxes are visible on first display of the home screen on
  a 360 × 640 dp phone (or scroll to show all) — verified on iOS Safari and Android Chrome.
- **SC-002**: Adding one entry to `CONTENT.sections` produces a correctly styled new
  box with zero other file changes — verified by inspection.
- **SC-003**: Tapping any box navigates to its section (or "coming soon") in under
  100 ms perceived time, with no page reload — verified manually.
- **SC-004**: The 2-column grid remains correct with 8, 9, 10, and 11 entries (odd
  and even counts) — no broken layouts.
- **SC-005**: All section labels display correctly in English — verified after
  language detection runs on page load.

## Assumptions

- The home screen replaces the role of the navigation bar seen in `demo.html` as the
  primary way to enter sections. The demo's horizontal scrollable nav bar may coexist
  inside sections but is not the entry point.
- Section boxes use SVG line art icons (24px, stroke-based, consistent with the design
  system in feature 002). Emoji icons were considered but replaced during implementation.
- The 11 initial sections listed in FR-008 are all fully implemented with content
  (not "coming soon" placeholders). All sections were built as part of the initial release.
- The home screen is distinct from the splash/welcome screen (feature 001): the splash
  is a full-screen cover; the home screen is the navigation hub shown after entering.
- Label translation keys for the 9 sections will be added to `CONTENT.strings` for
  each active language as part of this feature.
- Grid layout uses CSS Grid or Flexbox — no JavaScript layout calculation.
