# Feature Specification: Gelaterie Section

**Feature Branch**: `009-gelaterie`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: "Gelaterie is like restaurants — same structure."
**Reference spec**: `specs/004-restaurants/spec.md`

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Browses the Gelaterie List (Priority: P1)

A guest navigates to the Gelaterie section and sees the owner's curated list of
recommended gelato shops. For each entry they can read the name, a short
description, and open the location directly in Google Maps.

**Why this priority**: This is the core content of the section. Without a working
list, the section has no value.

**Independent Test**: Open `index.html`, navigate to the Gelaterie section. At
least one gelateria card is visible showing name, description, and a map link.
The map link opens correctly when tapped. Works fully
offline (the map link opens a browser but the card itself needs no network).

**Acceptance Scenarios**:

1. **Given** the guest navigates to the Gelaterie section, **When** the section
   loads, **Then** a list of gelateria cards is displayed, each showing name,
   description, and a "Open in Maps" button.
2. **Given** a gelateria card is displayed, **When** the guest taps "Open in Maps",
   **Then** the device opens Google Maps (or the default maps app) at the correct
   location — in a new tab or the maps app directly.
3. **Given** the device has no internet connection, **When** the guest views the
   Gelaterie section, **Then** all cards render correctly; only the maps link
   requires connectivity (which is expected and acceptable).

---

### User Story 2 - Owner Updates the Gelaterie List (Priority: P2)

The owner adds, removes, or edits a gelateria entry by modifying only the data
array in `CONTENT` inside `index.html`. No structural HTML changes are needed.

**Why this priority**: Gelato shop recommendations change seasonally. The update
process must be simple enough for the owner to do without developer help.

**Independent Test**: Add a new gelateria entry to the `CONTENT.sections.gelaterie`
array with all required fields. Open the file — the new card appears correctly
styled at the end of the list with no other changes.

**Acceptance Scenarios**:

1. **Given** a new gelateria object is added to the data array, **When** the page
   opens, **Then** a new card appears with all fields correctly rendered.
2. **Given** a gelateria entry is removed from the data array, **When** the page
   opens, **Then** the card is gone and the remaining cards are correctly spaced.
3. **Given** a description is changed to a longer text, **When** the page opens,
   **Then** the card expands to fit the text with no overflow or truncation.

---

### Edge Cases

- What if a gelateria description is very long? The card must expand; text must
  not be truncated or overflow the card boundary.
- What if the gelaterie list is empty? The section hero still shows; a brief
  "No recommendations yet" message is shown instead of a blank body.
- What if a Google Maps URL is missing or empty? The "Open in Maps" button must
  not appear for that entry rather than showing a broken link.
- What if the list grows to 20+ entries? The section must scroll vertically
  and all cards remain correctly rendered.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Gelaterie section MUST display a vertically scrolling list of
  gelateria cards, one per entry in the data array.
- **FR-002**: Each gelateria entry in the data array MUST support these fields:
  `name` (string), `description` (string), `mapsUrl` (string URL, optional),
  `favourite` (boolean, optional — `true` shows an owner's pick badge, default `false`),
  `it` (string, optional — Italian description), `de` (string, optional — German description).
  There is no `rating` or `price` field.
- **FR-003**: Each card MUST display the gelateria `name` as a title.
- **FR-004**: Each card MUST display the `description` as body text with no
  truncation — full text always visible.
- **FR-007**: If `mapsUrl` is present and non-empty, the card MUST show an
  "Open in Maps" button that opens the URL. If absent, the button MUST NOT appear.
- **FR-008**: The maps button MUST open the URL in a new tab / the device maps
  app (`target="_blank"`).
- **FR-009**: The gelaterie list MUST be defined as a data array in `CONTENT`
  (consistent with the content schema from feature 001). Adding or removing an
  entry MUST require editing only that array.
- **FR-010**: Gelateria names and descriptions MUST be translatable — stored as
  plain strings per language in `CONTENT.strings[lang]`, or as language-keyed
  objects within each entry.
- **FR-011**: The section MUST display a "no recommendations yet" message when
  the list is empty, rather than a blank body.
- **FR-012**: The section MUST use the visual design system defined in feature 002
  — specifically `.card`, `.card-title`, `.card-body`, `.card-label`, `.map-btn`,
  and `.ornament-divider` classes.

### Key Entities

- **Gelateria**: A data record in the gelaterie list array. Fields: `name`
  (string), `description` (string), `mapsUrl` (optional string), `favourite`
  (optional boolean), `it` (optional string — Italian description), `de` (optional
  string — German description). No `rating` or `price` fields.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All gelateria cards render correctly on a 360 dp phone in iOS Safari
  and Android Chrome with no truncation, overflow, or misalignment.
- **SC-002**: Adding one entry to the data array produces a correctly styled card
  with zero other file changes — verified by inspection.
- **SC-004**: The "Open in Maps" button is present when `mapsUrl` is set and absent
  when it is not — verified by toggling the field in the data array.
- **SC-005**: The section renders correctly with 1, 5, and 10 entries —
  no layout breaks at any count.

## Assumptions

- Gelateria data is owner-curated and static per version — there is no search,
  filtering, or sorting UI in this spec.
- The data key is `CONTENT.sections.gelaterie` (Italian plural, matching the section
  name used in the home screen grid — feature 003).
- Google Maps URLs are standard `https://maps.google.com/?q=...` links. Deep-link
  handling (opening the native Maps app on iOS/Android) is left to the OS.
- Translation of names and descriptions is implemented for IT and DE — each gelateria
  entry has `it` and `de` description fields alongside the English `description`.
- The gelaterie section card uses the same `.card` component from the design
  system (feature 002) as the restaurants section — no new card variant is introduced.
- The identical data structure to restaurants means the same rendering logic can
  be reused at implementation time (a shared "rated list" template).

## Seed Content

Owner-provided entries for `CONTENT.sections.gelaterie`. IT/DE translations are the owner's responsibility.

```js
CONTENT.sections.gelaterie = [
  {
    name:        "Gelato d'Altri Tempi",
    description: "Best gelateria in Verbania. The portions could be a little bigger… but the quality is very good. Highlights: pistacchio, nocciola, marron glacé and all cream flavours.",
    mapsUrl:     "https://maps.app.goo.gl/5ebF1SE2WgoPop9y9"
  },
  {
    name:        "Gelatomania",
    description: "Second best in Verbania. You must try the Tiramisù flavour.",
    mapsUrl:     "https://maps.app.goo.gl/9pGWiMNAo2TMamyj6"
  },
  {
    name:        "K2 (Pallanza)",
    description: "Very good gelateria covering both cream and fruit flavours. The best gelato in Pallanza.",
    mapsUrl:     "https://maps.app.goo.gl/1XdBDSuKwYC3sjvX7"
  },
  {
    name:        "Gelateria Aurora (Candoglia, near Mergozzo)",
    description: "BEST GELATERIA — worth a detour! A little outside Mergozzo, in Candoglia. Best gelato especially for fruit flavours: Macedonia, mango, and lamponi are my favourites. Large portions, very fair price. Try the large cups served at the tables — a client put it perfectly: \"The ice cream cups are giant, good and at a very fair price.\"",
    mapsUrl:     "https://g.co/kgs/p6wfSfF",
    favourite:   true
  }
]
```
