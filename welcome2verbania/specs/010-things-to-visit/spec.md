# Feature Specification: Things to Visit Section

**Feature Branch**: `010-things-to-visit`
**Created**: 2026-04-10
**Status**: Draft
**Input**: "Things to Visit — same approach as beaches: name, description, star if
recommended." Seed content provided by owner (11 entries: Borromean Islands, Villa
Taranto, Stresa, Sacro Monte di Ghiffa, Baveno, Cannero Riviera, Mergozzo, Orta San
Giulio, Valle Vigezzo, Valle Formazza, Valle Verzasca).

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Browses Places to Visit (Priority: P1)

A guest navigates to the "Things to Visit" section and sees the owner's curated list
of recommended places near Verbania. For each entry they can read the name and a rich
description, see whether it is the owner's recommendation, open the location in Google
Maps, and — where available — tap a link for more information (e.g., an official
website, a schedule page).

**Why this priority**: This is the core content of the section. Without a working
list the section has no value. The descriptions are deliberately rich and informative
— guests use them to decide where to go.

**Independent Test**: Open `index.html`, navigate to "Things to Visit". At least one
card shows name, description, map link, and recommended star. Works fully offline.

**Acceptance Scenarios**:

1. **Given** the guest navigates to "Things to Visit", **When** the section loads,
   **Then** a list of place cards is displayed, each showing at minimum: name and
   description.
2. **Given** a place is marked as recommended, **When** its card is displayed,
   **Then** a distinct star indicator (★) is visible on the card.
3. **Given** a place is NOT marked as recommended, **When** its card is displayed,
   **Then** no star indicator appears.
4. **Given** a place has a `mapsUrl`, **When** the guest taps "Open in Maps",
   **Then** the device opens Google Maps at the correct location.
5. **Given** a place has an `infoUrl` (e.g., a schedule or official website),
   **When** the guest taps the info link, **Then** the browser opens the URL in
   a new tab.
6. **Given** the device is offline, **When** the guest views the section, **Then**
   all cards render correctly; external links are expected to require connectivity.

---

### User Story 2 - Guest Reads a Rich Description (Priority: P1)

Some entries have long, multi-paragraph descriptions (e.g., Borromean Islands,
Valle Formazza waterfall schedule). The guest can read the full text without it being
truncated or cut off, even on a small phone screen.

**Why this priority**: The value of this section is in the descriptions — hiding or
clipping them defeats the purpose.

**Independent Test**: Open the Valle Formazza entry. The full description including
the 2025 waterfall schedule is visible by scrolling within (or past) the card. No
text is cut off.

**Acceptance Scenarios**:

1. **Given** a description is very long (500+ characters), **When** the card is
   displayed, **Then** the full description is readable — either fully expanded or
   with a clear "read more" expansion — with no text truncation.
2. **Given** the guest reads a description containing a schedule table (Valle
   Formazza), **When** they view the card, **Then** the schedule is legible and
   correctly formatted on a 360 dp screen.
3. **Given** the guest reads a description with an embedded warning (Valle Verzasca
   Swiss vignette note), **When** they view the card, **Then** the warning is
   visible within the description text.

---

### User Story 3 - Owner Updates the Places List (Priority: P2)

The owner adds, removes, edits an entry, or toggles its recommended status by
modifying only the data array in `CONTENT`. No structural HTML changes are needed.

**Independent Test**: Add a new entry to `CONTENT.sections.thingsToVisit` with
name, description, and `favourite: true`. Open the file — the new card appears with
the star and full description.

**Acceptance Scenarios**:

1. **Given** a new entry is added to the data array, **When** the page opens,
   **Then** a new card appears with all fields correctly rendered.
2. **Given** `favourite` is toggled from `false` to `true`, **When** the page opens,
   **Then** the star appears on that card.
3. **Given** `infoUrl` is added to an existing entry, **When** the page opens,
   **Then** the info link button appears on that card.

---

### Edge Cases

- What if a description contains a multi-line schedule (Valle Formazza)? The text
  must render legibly — line breaks preserved, no text run together.
- What if the list is empty? The section hero still shows; a "No recommendations yet"
  message is shown instead of a blank body.
- What if both `mapsUrl` and `infoUrl` are absent? The card renders without any link
  buttons — no broken layout.
- What if the screen is very narrow (320 dp)? Cards, text, and buttons must not
  overflow horizontally.
- What if the list grows to 15+ entries? The section scrolls vertically with no
  layout breakage.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display a vertically scrolling list of place cards,
  one per entry in the data array.
- **FR-002**: Each entry in the data array MUST support these fields:
  - `name` (string, required)
  - `description` (string, required — may be long/multi-paragraph)
  - `favourite` (boolean, required — `true` shows the recommended star)
  - `mapsUrl` (string URL, optional)
  - `infoUrl` (string URL, optional — for external schedules, official sites, etc.)
- **FR-003**: Each card MUST display the entry `name` as a title.
- **FR-004**: Each card MUST display the full `description` as body text with no
  truncation. Multi-line text and line breaks MUST be preserved in rendering.
- **FR-005**: If `favourite` is `true`, the card MUST display a visible star badge
  (★) signalling the owner's recommendation. If `false`, no star appears.
- **FR-006**: If `mapsUrl` is present and non-empty, the card MUST show an
  "Open in Maps" button that opens the URL in a new tab / maps app. If absent,
  the button MUST NOT appear.
- **FR-007**: If `infoUrl` is present and non-empty, the card MUST show an
  "More Info" (or equivalent) button that opens the URL in a new tab
  (`target="_blank" rel="noopener"`). If absent, the button MUST NOT appear.
- **FR-008**: The places list MUST be defined as a data array in `CONTENT`
  (key: `CONTENT.sections.thingsToVisit`). Adding or removing an entry MUST require
  editing only that array.
- **FR-009**: Entry names and descriptions MUST be translatable — stored as plain
  strings per language in `CONTENT.strings[lang]`, or as language-keyed objects
  within each entry.
- **FR-010**: The section MUST display a "no recommendations yet" message when the
  list is empty, rather than a blank body.
- **FR-011**: The section MUST use the visual design system defined in feature 002 —
  specifically `.card`, `.card-title`, `.card-body`, `.badge`, `.map-btn`, and
  `.ornament-divider` classes. No new component variants are introduced.
- **FR-012**: The section MUST work fully offline. No assets may depend on a network
  request. External links (`mapsUrl`, `infoUrl`) are expected to require connectivity
  — this is acceptable.

### Key Entities

- **Place Entry**: A record in the things-to-visit data array. Fields: `name`
  (string), `description` (string), `favourite` (boolean), `mapsUrl` (optional
  string), `infoUrl` (optional string).
- **Recommended Badge**: The ★ indicator shown on cards where `favourite: true`.
- **Info Link**: Optional secondary action button linking to an external URL
  (schedule, official site, etc.).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All place cards render correctly on a 360 dp phone in iOS Safari and
  Android Chrome with no truncation, overflow, or misalignment.
- **SC-002**: Cards with long descriptions (500+ characters) display the full text
  with no clipping — verified with the Valle Formazza entry.
- **SC-003**: The recommended star is present on starred entries and absent on
  non-starred entries — verified by toggling the `favourite` field.
- **SC-004**: Adding one entry to the data array produces a correctly styled card
  with zero other file changes.
- **SC-005**: The "Open in Maps" and "More Info" buttons appear only when the
  corresponding URL field is non-empty — verified by toggling each field.
- **SC-006**: The section renders correctly with 1, 5, and 11 entries.

## Assumptions

- Descriptions are owner-written prose, possibly very long (the sample content
  includes entries of 400–600 characters). No maximum length is enforced — the card
  expands to fit.
- The 11 entries from the owner's sample content are the seed data for this section.
  Translation of descriptions to IT and DE is the owner's responsibility.
- The `infoUrl` field covers the need for the Valle Formazza waterfall schedule link
  and any similar external reference. The schedule text itself is part of the
  `description` field — the URL is a supplementary "source" link.
- The Valle Verzasca Swiss vignette warning is part of the description text — no
  special visual treatment (e.g., warning box) is required for individual entry
  notes; a plain text note within the description is sufficient.
- The data key `CONTENT.sections.thingsToVisit` uses camelCase to match the
  existing pattern (cf. `CONTENT.sections.parking` in feature 007).
- No filtering, sorting, or category grouping UI is in scope for this spec.
  If categories are desired in the future (e.g., "Nature", "Culture", "Day Trips")
  a new spec revision is required.
- The `.badge` component from feature 002 is used for the recommended star — same
  pattern as the beaches section (feature 005).
