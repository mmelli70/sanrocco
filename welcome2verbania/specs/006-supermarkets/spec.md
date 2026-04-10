# Feature Specification: Supermarkets Section

**Feature Branch**: `006-supermarkets`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: User description: "for the section supermarket, it will be shown a list of shops, using the same layout as beaches. Name, Google Maps link, description and a star if preferred"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Finds a Nearby Shop (Priority: P1)

A guest navigates to the Supermarkets section and sees the owner's curated list of
nearby shops. For each entry they can read the name, a short description, see whether
it is the owner's preferred pick, and open its location in Google Maps.

**Why this priority**: This is the core content of the section. Guests need practical
shopping information; without a working list the section has no value.

**Independent Test**: Open `index.html`, navigate to the Supermarkets section. At
least one shop card is visible showing name, description, and map link. At least one
entry shows the preferred-star indicator. Works fully offline.

**Acceptance Scenarios**:

1. **Given** the guest navigates to the Supermarkets section, **When** the section
   loads, **Then** a list of shop cards is displayed, each showing name, description,
   and — where applicable — a preferred indicator and a map button.
2. **Given** a shop is marked as preferred, **When** its card is displayed, **Then**
   a star (★) or "Owner's Pick" badge is clearly visible on the card.
3. **Given** a shop is NOT marked as preferred, **When** its card is displayed,
   **Then** no star or badge appears.
4. **Given** a shop has a `mapsUrl`, **When** the guest taps "Open in Maps", **Then**
   the device opens Google Maps at the correct location in a new tab or the maps app.
5. **Given** the device is offline, **When** the guest views the section, **Then**
   all cards render correctly; only the map link requires connectivity.

---

### User Story 2 - Owner Updates the Shop List (Priority: P2)

The owner adds, removes, edits a shop entry, or toggles its preferred status by
modifying only the data array in `CONTENT`. No structural HTML changes are needed.

**Why this priority**: Shops open, close, and change. Updates must be simple enough
for the owner to handle without developer help.

**Independent Test**: Add a new shop entry with `favourite: true` to the data array.
Open the file — the new card appears correctly styled with the star indicator, with
no other changes required.

**Acceptance Scenarios**:

1. **Given** a new shop is added to the data array, **When** the page opens, **Then**
   a correctly styled card appears with all provided fields rendered.
2. **Given** `favourite` is toggled from `true` to `false`, **When** the page opens,
   **Then** the star indicator is no longer shown on that card.
3. **Given** a description is updated, **When** the page opens, **Then** the card
   expands cleanly with no overflow or truncation.

---

### Edge Cases

- What if more than one shop is marked as preferred? All show the star — no limit.
- What if `mapsUrl` is absent? The "Open in Maps" button must not appear.
- What if the list is empty? A "No recommendations yet" message is shown.
- What if a shop name is very long? It wraps inside the card without overflow.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Supermarkets section MUST display a vertically scrolling list of
  shop cards, one per entry in the data array.
- **FR-002**: Each shop entry MUST support: `name` (string), `description` (string),
  `mapsUrl` (optional string), `favourite` (boolean).
- **FR-003**: Each card MUST display the shop `name` as a title.
- **FR-004**: Each card MUST display the full `description` as body text with no
  truncation.
- **FR-005**: If `favourite` is `true`, the card MUST display a ★ symbol and/or an
  "Owner's Pick" badge, visually consistent with the same indicator used in the
  Beaches section (feature 005).
- **FR-006**: If `favourite` is `false` or absent, no star or badge MUST appear.
- **FR-007**: If `mapsUrl` is present and non-empty, the card MUST show an
  "Open in Maps" button opening the URL in a new tab / device maps app.
  If absent, the button MUST NOT appear.
- **FR-008**: The shop list MUST be defined as a data array at
  `CONTENT.sections.supermarkets`. Adding
  or removing an entry MUST require editing only that array.
- **FR-009**: The section MUST display a "no recommendations yet" message when the
  list is empty.
- **FR-010**: The section MUST use the visual design system from feature 002 —
  the same component classes used in the Beaches section (feature 005).

### Key Entities

- **Shop**: A data record. Fields: `name` (string), `description` (string),
  `mapsUrl` (optional string), `favourite` (boolean, default `false`),
  `it` (optional string — Italian description), `de` (optional string — German description).
- **Favourite Indicator**: A ★ symbol and/or badge shown only when `favourite: true`.
  Visually identical to the indicator used in the Beaches section.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All shop cards render correctly on a 360 dp phone in iOS Safari and
  Android Chrome — no truncation, overflow, or misalignment.
- **SC-002**: The favourite indicator is present on preferred cards and absent on
  non-preferred cards — verified by toggling `favourite`.
- **SC-003**: Adding one shop entry produces a correctly styled card with zero other
  file changes — verified by inspection.
- **SC-004**: The "Open in Maps" button appears when `mapsUrl` is set and is absent
  when it is not.
- **SC-005**: The section renders correctly with 1, 5, and 10 entries — no layout
  breaks.

## Assumptions

- The layout and card style are identical to the Beaches section (feature 005).
  No new visual components are introduced — this section reuses the same pattern.
- Multiple shops can be marked as preferred simultaneously.
- The initial shop list will be populated by the owner at content-entry time;
  no seed data is specified in this spec.
- "Supermarkets" is used as the section name but in practice the list may include
  any type of shop (grocery, bakery, market). The data structure does not restrict
  shop type.
- Translation is implemented for IT and DE — each shop entry has `it` and `de`
  description fields alongside the English `description`.

## Seed Content

Owner-provided entries for `CONTENT.sections.supermarkets`. IT/DE translations are
the owner's responsibility.

```js
CONTENT.sections.supermarkets = [
  {
    name:        "Esselunga",
    description: "I recommend registering for their fidelity card at the entrance desk — many discounted items are only available with the 'Fidaty Card'. Good quality fresh produce and vegetables. Meat and fish are fine. My favourite place for the weekly grocery shop.",
    mapsUrl:     "https://g.co/kgs/nFqzzXW",
    favourite:   true
  },
  {
    name:        "Tigros",
    description: "Easily reachable on a quick walk. I suggest registering for their fidelity card too 😊. Smaller than Esselunga but a good choice — solid prices and interesting promotions.",
    mapsUrl:     "https://g.co/kgs/74WugM6",
    favourite:   false
  },
  {
    name:        "Colombo — Fruit & Vegetables",
    description: "BEST PLACE TO BUY FRUITS. A bit hidden — it's the local supplier of fruits and vegetables for restaurants in the area. Slightly more expensive than Esselunga, but the quality is considerably higher. Fruits are juicy, great variety. Absolutely the best place to buy fresh produce.",
    mapsUrl:     "https://g.co/kgs/Lv4oodn",
    favourite:   true
  },
  {
    name:        "Cusio Formaggi — Saturday Market Only",
    description: "BEST PLACE TO BUY CHEESE — open Saturday morning only.\n\nEvery Saturday there is a street market in Intra with many sellers. 'Cusio Formaggi' is the one I strongly recommend: comparable quality to 'La Casera' at 40% less. They let you taste before you buy — ask the owners, they are very kind.\n\nMy recommended cheeses:\n• Erborinato stagionato sotto vinacce (blue cheese aged under grape pomace — my absolute favourite!)\n• Toma del Mottarone or Toma della Valsesia (semi-hard, tasty)\n• Monte 27 (hard, similar to parmesan)\n• Castelmagno unbranded (less expensive than DOP, but very good)\n• Gorgonzola: two types — creamy and stronger\n• Burrata: mozzarella filled with stracciatella — do NOT eat straight from the fridge, you will miss so much flavour!\n• Guanciale: essential for real carbonara and amatriciana — buy the whole sealed package, very reasonable price.",
    mapsUrl:     "https://maps.app.goo.gl/qfxzwD8Xhu4danhe9",
    favourite:   true
  }
]
```
