# Feature Specification: Adrenaline Attractions Section

**Feature Branch**: `011-adrenaline`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: "Adrenaline section is like Things to Visit." Seed content provided by
owner (3 entries: Lake Maggiore Zipline, Aquadventure Park, Alpyland Mottarone).

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Browses Adrenaline Attractions (Priority: P1)

A guest navigates to the "Adrenaline Attractions" section and sees the owner's
curated list of nearby adventure activities. For each entry they can read the name
and a description, see whether it is the owner's recommendation, visit the official
website, and open the location in Google Maps.

**Why this priority**: This is the core content of the section. Without a working
list the section has no value.

**Independent Test**: Open `index.html`, navigate to "Adrenaline Attractions". At
least one card shows name, description, and links. Works fully offline (card content
needs no network; external links require connectivity, which is expected).

**Acceptance Scenarios**:

1. **Given** the guest navigates to "Adrenaline Attractions", **When** the section
   loads, **Then** a list of attraction cards is displayed, each showing at minimum:
   name and description.
2. **Given** an attraction is marked as recommended, **When** its card is displayed,
   **Then** a distinct star indicator (★) is visible on the card.
3. **Given** an attraction is NOT marked as recommended, **When** its card is
   displayed, **Then** no star indicator appears.
4. **Given** an attraction has a `mapsUrl`, **When** the guest taps "Open in Maps",
   **Then** the device opens Google Maps at the correct location.
5. **Given** an attraction has an `infoUrl` (official website), **When** the guest
   taps the info link, **Then** the browser opens the URL in a new tab.
6. **Given** the device is offline, **When** the guest views the section, **Then**
   all cards render correctly; external links are expected to require connectivity.

---

### User Story 2 - Owner Updates the Attractions List (Priority: P2)

The owner adds, removes, or edits an entry — including toggling the recommended star
or adding a personal note — by modifying only the data array in `CONTENT`. No
structural HTML changes are needed.

**Independent Test**: Add a new entry to `CONTENT.sections.adrenaline` with name,
description, and `infoUrl`. Open the file — the card appears with the info link.

**Acceptance Scenarios**:

1. **Given** a new entry is added to the data array, **When** the page opens,
   **Then** a new card appears with all fields correctly rendered.
2. **Given** `favourite` is toggled to `true`, **When** the page opens,
   **Then** the star appears on that card.
3. **Given** `infoUrl` is set, **When** the page opens,
   **Then** the info link button appears on that card.

---

### Edge Cases

- What if a description is very long (Zipline entry is 400+ characters)? The card
  must expand — no truncation.
- What if the list is empty? A "No recommendations yet" placeholder is shown.
- What if both `mapsUrl` and `infoUrl` are absent? The card renders without buttons.
- What if the screen is very narrow (320 dp)? No horizontal overflow.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display a vertically scrolling list of attraction
  cards, one per entry in the data array.
- **FR-002**: Each entry MUST support these fields:
  - `name` (string, required)
  - `description` (string, required — may be long/multi-paragraph)
  - `favourite` (boolean, required — `true` shows the recommended star)
  - `infoUrl` (string URL, optional — official website or booking page)
  - `it` (string, optional — Italian description)
  - `de` (string, optional — German description)
  There is no `mapsUrl` field — only `infoUrl` is used for external links.
- **FR-003**: Each card MUST display the entry `name` as a title.
- **FR-004**: Each card MUST display the full `description` with no truncation.
  Multi-line text and line breaks MUST be preserved.
- **FR-005**: If `favourite` is `true`, the card MUST display a star badge (★).
  If `false`, no star appears.
- **FR-006**: If `infoUrl` is present, the card MUST show a "Website" (or
  equivalent) button opening the URL in a new tab (`target="_blank" rel="noopener"`).
  If absent, the button MUST NOT appear. There is no "Open in Maps" button.
- **FR-008**: The list MUST be defined as a data array in `CONTENT`
  (key: `CONTENT.sections.adrenaline`). Adding or removing an entry MUST require
  editing only that array.
- **FR-009**: Names and descriptions MUST be translatable — stored per language or
  as language-keyed objects within each entry.
- **FR-010**: The section MUST display a "no recommendations yet" message when the
  list is empty.
- **FR-011**: The section MUST use the visual design system from feature 002 —
  specifically `.card`, `.card-title`, `.card-body`, `.badge`, `.map-btn`, and
  `.ornament-divider`. No new component variants are introduced.
- **FR-012**: The section MUST work fully offline. External links require
  connectivity — this is acceptable and expected.

### Key Entities

- **Attraction Entry**: `{ name, description, favourite: bool, infoUrl?, it?, de? }`
  stored in `CONTENT.sections.adrenaline[]`. No `mapsUrl` field.
- **Recommended Badge**: The ★ indicator shown when `favourite: true`.
- **Website Link**: Optional action button for the official site / booking page
  (`infoUrl`).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All attraction cards render correctly on a 360 dp phone in iOS Safari
  and Android Chrome with no truncation, overflow, or misalignment.
- **SC-002**: Long descriptions (400+ characters, e.g., Zipline) display in full
  with no clipping.
- **SC-003**: The recommended star is present on starred entries and absent on
  non-starred entries — verified by toggling `favourite`.
- **SC-004**: Adding one entry to the data array produces a correctly styled card
  with zero other file changes.
- **SC-005**: "Open in Maps" and "Website" buttons appear only when their
  corresponding URL field is non-empty.
- **SC-006**: The section renders correctly with 1, 3, and 8 entries.

## Assumptions

- The 3 entries from the owner's sample content are the seed data. The owner has
  flagged two entries (Aquadventure Park, Alpyland) as personally unvisited,
  with descriptions sourced from internet reviews. This distinction is captured in
  the description text itself — no special UI treatment is needed.
- `infoUrl` maps to the official website for each attraction (e.g.,
  `https://www.lagomaggiorezipline.it/`).
- Data key `CONTENT.sections.adrenaline` uses a short English key consistent with
  the existing pattern.
- Identical data structure to Things to Visit (spec 010) — the same rendering
  template can serve both sections at implementation time.
- No booking integration is in scope. The `infoUrl` points to an external site
  where the guest can book independently.
- Translation of names and descriptions is out of scope for the initial
  English-only version.
