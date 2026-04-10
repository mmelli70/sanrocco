# Feature Specification: Beaches Section

**Feature Branch**: `005-beaches`
**Created**: 2026-04-10
**Status**: Draft
**Input**: User description: "beaches section will show a list of my preferred beaches: the data displayed are: name, Google Maps link, a short description (between 500 and 1000 characters), and a star if it's my preferred one"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Browses the Beach List (Priority: P1)

A guest navigates to the Beaches section and sees the owner's curated list of
recommended beaches around Verbania. For each beach they can read the name, a
description, see whether it is the owner's top pick, and open the location
directly in Google Maps.

**Why this priority**: This is the core content of the section. Without a working
list, the section has no value.

**Independent Test**: Open `index.html`, navigate to the Beaches section. At least
one beach card is visible showing name, description, map link, and — for at least
one entry — the "owner's favourite" star badge. Works fully offline (card content
needs no network; map link requires connectivity, which is expected).

**Acceptance Scenarios**:

1. **Given** the guest navigates to the Beaches section, **When** the section loads,
   **Then** a list of beach cards is displayed, each showing name, description, and
   a "Open in Maps" button.
2. **Given** a beach is marked as the owner's favourite, **When** its card is
   displayed, **Then** a distinct star indicator (★) is shown on the card,
   visually distinguishing it from non-favourite entries.
3. **Given** a beach is NOT marked as favourite, **When** its card is displayed,
   **Then** no star indicator appears on that card.
4. **Given** a beach has a `mapsUrl`, **When** the guest taps "Open in Maps",
   **Then** the device opens Google Maps at the correct location in a new tab or
   the maps app.
5. **Given** the device is offline, **When** the guest views the Beaches section,
   **Then** all cards render correctly; only the map link requires connectivity.

---

### User Story 2 - Owner Updates the Beach List (Priority: P2)

The owner adds, removes, edits a beach entry, or toggles its favourite status by
modifying only the data array in `CONTENT`. No structural HTML changes are needed.

**Why this priority**: The list of recommended beaches may change between seasons.
The update must be simple enough for the owner to do without developer help.

**Independent Test**: Add a new beach entry with `favourite: true` to the data
array. Open the file — the new card appears at the end of the list with the star
indicator visible, correctly styled, with no other changes.

**Acceptance Scenarios**:

1. **Given** a new beach is added to the data array with `favourite: true`,
   **When** the page opens, **Then** the card appears with the star indicator.
2. **Given** `favourite` is changed from `true` to `false` on an entry, **When**
   the page opens, **Then** the star indicator is no longer shown on that card.
3. **Given** a description is updated to a longer text (up to 1000 characters),
   **When** the page opens, **Then** the card expands cleanly with no overflow.

---

### Edge Cases

- What if more than one beach is marked as favourite? All of them must show the
  star indicator — there is no limit on the number of favourites.
- What if a description is shorter than 500 characters? The card still renders
  correctly; the 500-character minimum is a content guideline for authors,
  not a technical constraint enforced by the UI.
- What if `mapsUrl` is absent? The "Open in Maps" button must not appear.
- What if the list is empty? A "No recommendations yet" message is shown.
- What if a beach name is very long? It must wrap inside the card without overflow.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Beaches section MUST display a vertically scrolling list of beach
  cards, one per entry in the data array.
- **FR-002**: Each beach entry in the data array MUST support these fields: `name`
  (string), `description` (string, guideline: 500–1000 characters), `mapsUrl`
  (string URL, optional), `favourite` (boolean).
- **FR-003**: Each card MUST display the beach `name` as a title.
- **FR-004**: Each card MUST display the full `description` as body text — no
  truncation; the complete text is always visible.
- **FR-005**: If `favourite` is `true`, the card MUST display a prominent star
  symbol (★) and/or a "Owner's pick" label that clearly distinguishes it from
  non-favourite entries.
- **FR-006**: If `favourite` is `false` or absent, NO star or special indicator
  MUST appear on the card.
- **FR-007**: If `mapsUrl` is present and non-empty, the card MUST show an
  "Open in Maps" button that opens the URL in a new tab / device maps app.
  If absent, the button MUST NOT appear.
- **FR-008**: The beach list MUST be defined as a data array at
  `CONTENT.sections.beaches`, consistent with the content schema convention.
  Adding or removing an entry MUST require editing only that array.
- **FR-009**: The section MUST display a "no recommendations yet" message when
  the beach list is empty.
- **FR-010**: The section MUST use the visual design system from feature 002 —
  specifically `.card`, `.card-title`, `.card-body`, `.badge`, and `.map-btn`.

### Key Entities

- **Beach**: A data record. Fields: `name` (string), `description` (string),
  `mapsUrl` (optional string), `favourite` (boolean, default `false`).
- **Favourite Indicator**: A visual element shown only when `favourite` is `true`.
  Rendered as a ★ symbol and/or a badge label (e.g., "Owner's Pick").

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All beach cards render correctly on a 360 dp phone in iOS Safari and
  Android Chrome — no truncation, overflow, or misalignment.
- **SC-002**: The favourite indicator (★) is visible on favourite cards and absent
  on non-favourite cards — verified by toggling the `favourite` field.
- **SC-003**: Adding one beach entry to the data array produces a correctly styled
  card with zero other file changes — verified by inspection.
- **SC-004**: A description of exactly 1000 characters displays fully within the
  card with no overflow on a 360 dp screen.
- **SC-005**: The "Open in Maps" button appears when `mapsUrl` is set and is absent
  when it is not — verified by toggling the field.

## Assumptions

- Multiple beaches can be marked as favourite simultaneously — the star is an
  "owner's pick" indicator, not a unique ranking.
- The 500–1000 character description length is a content authoring guideline;
  the UI does not enforce minimum or maximum lengths.
- The initial beach list will be populated with the owner's actual recommendations
  (seed content below).
- Translation of beach names and descriptions is out of scope for the initial
  English-only version; the data structure is designed to support it when IT/DE
  are added.
- The beaches section shares the same card visual style as the restaurants section
  (feature 004); no new card variant is introduced beyond the favourite indicator.
- Google Maps URLs follow the same convention as feature 004 (`https://maps.google.com/?q=...`).

## Seed Content

Owner-provided entries for `CONTENT.sections.beaches`. IT/DE translations are the
owner's responsibility. Note: Quartina e Lido has two adjacent beaches — the first
Maps link is used as the primary; both are mentioned in the description.

```js
CONTENT.sections.beaches = [
  {
    name:        "Teatro Maggiore",
    description: "The most convenient beach — just under a 10-minute walk from the house. Sandy and pebble beach with a large grassy area, situated at the Il Maggiore Events Centre. Not particularly large but perfectly sized for a refreshing swim in Lake Maggiore's clear waters. Free access with sun lounger and umbrella rentals, plus an on-site bar.",
    mapsUrl:     "https://maps.app.goo.gl/5iFGesixXWEY6XqM9",
    favourite:   false
  },
  {
    name:        "Spiaggia di Suna",
    description: "A recently renovated public beach with free access to Lake Maggiore. Concrete steps lead to a small pebble beach with disabled access. Modern improvements while maintaining its authentic, uncommercial charm. Perfect for budget-conscious visitors. Note: parking can be challenging during peak season — arrive early.",
    mapsUrl:     "https://maps.app.goo.gl/DUPcYcDEEwEyiaQ26",
    favourite:   false
  },
  {
    name:        "Tre Ponti",
    description: "A newer addition to Verbania's lakefront with fresh facilities and modern amenities. Located 1.6 miles from Verbania centre with several parking spaces nearby. During peak summer season arrive early — limited free parking fills up quickly.",
    mapsUrl:     "https://maps.app.goo.gl/yRziXxgh8PnZQrYG6",
    favourite:   false
  },
  {
    name:        "Canneto (Nature Reserve)",
    description: "A hidden gem within the Special Nature Reserve of the Fondotoce Reed beds, nestled between Fondotoce and Feriolo. Accessible via a short scenic walk through riparian woods of white willow, black and white alders, poplars and elms. From this secluded spot you can admire the Borromean Gulf and the islands. No facilities — bring your own water, snacks and supplies.",
    mapsUrl:     "https://maps.app.goo.gl/PTKs3YCRaHrjfLp18",
    favourite:   false
  },
  {
    name:        "Quartina & Lido (Lake Mergozzo)",
    description: "A stunning and popular beach on the pristine waters of Lake Mergozzo — a small, very clear lake with crystal-clear swimming conditions in a more intimate setting than Lake Maggiore. Gets crowded in peak season. Parking €10/day but spaces fill quickly — arrive before 10:30 AM for the best spot.",
    mapsUrl:     "https://maps.app.goo.gl/6wiNUuzM8xJJZz9h6",
    favourite:   false
  },
  {
    name:        "Cannero Riviera",
    description: "One of my favourite beaches, just 15 minutes from the Swiss border. A wide, well-organised Blue Flag certified beach in a naturally protected bay with crystal-clear water perfect for swimming. Highlight: a floating water platform anchored offshore during summer — ideal for diving and jumping into the lake.",
    mapsUrl:     "https://maps.app.goo.gl/pcbsKW1iPUyjayn29",
    favourite:   true
  }
]
```
