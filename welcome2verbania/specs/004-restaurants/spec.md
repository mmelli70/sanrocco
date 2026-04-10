# Feature Specification: Restaurants Section

**Feature Branch**: `004-restaurants`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: User description: "the section restaurants will show a list of my preferred restaurants. For each restaurant must be shown: name, a link to google maps, a small description"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Browses the Restaurant List (Priority: P1)

A guest navigates to the Restaurants section and sees the owner's curated list of
recommended restaurants. For each entry they can read the name, a short description,
and open the location directly in Google Maps.

**Why this priority**: This is the core content of the section. Without a working
list, the section has no value.

**Independent Test**: Open `index.html`, navigate to the Restaurants section. At
least one restaurant card is visible showing name, description, and a map link.
The map link opens correctly when tapped. Works fully
offline (the map link opens a browser but the card itself needs no network).

**Acceptance Scenarios**:

1. **Given** the guest navigates to the Restaurants section, **When** the section
   loads, **Then** a list of restaurant cards is displayed, each showing name,
   description, and a "Open in Maps" button.
2. **Given** a restaurant card is displayed, **When** the guest taps "Open in Maps",
   **Then** the device opens Google Maps (or the default maps app) at the correct
   location — in a new tab or the maps app directly.
3. **Given** the device has no internet connection, **When** the guest views the
   Restaurants section, **Then** all restaurant cards render correctly; only the
   maps link requires connectivity (which is expected and acceptable).

---

### User Story 2 - Owner Updates the Restaurant List (Priority: P2)

The owner adds, removes, or edits a restaurant entry by modifying only the data
array in `CONTENT` inside `index.html`. No structural HTML changes are needed.

**Why this priority**: Restaurant recommendations change seasonally. The update
process must be simple enough for the owner to do without developer help.

**Independent Test**: Add a new restaurant entry to the `CONTENT.sections.restaurants`
array with all required fields. Open the file — the new card appears correctly
styled at the end of the list with no other changes.

**Acceptance Scenarios**:

1. **Given** a new restaurant object is added to the data array, **When** the page
   opens, **Then** a new card appears with all fields correctly rendered.
2. **Given** a restaurant entry is removed from the data array, **When** the page
   opens, **Then** the card is gone and the remaining cards are correctly spaced.
3. **Given** a description is changed to a longer text, **When** the page opens,
   **Then** the card expands to fit the text with no overflow or truncation.

---

### Edge Cases

- What if a restaurant description is very long? The card must expand; text must
  not be truncated or overflow the card boundary.
- What if the restaurant list is empty? The section hero still shows; a brief
  "No recommendations yet" message is shown instead of a blank body.
- What if a Google Maps URL is missing or empty? The "Open in Maps" button must
  not appear for that entry rather than showing a broken link.
- What if the list grows to 20+ restaurants? The section must scroll vertically
  and all cards remain correctly rendered.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The Restaurants section MUST display a vertically scrolling list of
  restaurant cards, one per restaurant entry in the data array.
- **FR-002**: Each restaurant entry in the data array MUST support these fields:
  `name` (string), `description` (string), `mapsUrl` (string URL, optional),
  `favourite` (boolean, optional — `true` shows an owner's pick badge, default `false`),
  `it` (string, optional — Italian description), `de` (string, optional — German description).
  There is no `rating` or `price` field.
- **FR-003**: Each card MUST display the restaurant `name` as a title.
- **FR-004**: Each card MUST display the `description` as body text with no
  truncation — full text always visible.
- **FR-007**: If `mapsUrl` is present and non-empty, the card MUST show an
  "Open in Maps" button that opens the URL. If absent, the button MUST NOT appear.
- **FR-007b**: If `favourite` is `true`, the card MUST display an owner's pick
  badge (★ or equivalent), consistent with the badge style used in beaches and
  supermarkets (feature 002 `.badge` component). If `false` or absent, no badge.
- **FR-008**: The maps button MUST open the URL in a new tab / the device maps
  app (`target="_blank"`).
- **FR-009**: The restaurant list MUST be defined as a data array in `CONTENT`
  (consistent with the content schema from feature 001). Adding or removing an
  entry MUST require editing only that array.
- **FR-010**: Restaurant names and descriptions MUST be translatable — they are
  stored as plain strings per language in `CONTENT.strings[lang]`, or as
  language-keyed objects within each restaurant entry.
- **FR-011**: The section MUST display a "no recommendations yet" message when
  the restaurant list is empty, rather than a blank body.
- **FR-012**: The section MUST use the visual design system defined in feature 002
  — specifically `.card`, `.card-title`, `.card-body`, `.card-label`, `.map-btn`,
  and `.ornament-divider` classes.

### Key Entities

- **Restaurant**: A data record in the restaurant list array. Fields: `name`
  (string), `description` (string), `mapsUrl` (optional string), `favourite`
  (optional boolean), `it` (optional string — Italian description), `de` (optional
  string — German description). No `rating` or `price` fields.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All restaurant cards render correctly on a 360 dp phone in iOS Safari
  and Android Chrome with no truncation, overflow, or misalignment.
- **SC-002**: Adding one restaurant entry to the data array produces a correctly
  styled card with zero other file changes — verified by inspection.
- **SC-004**: The "Open in Maps" button is present when `mapsUrl` is set and absent
  when it is not — verified by toggling the field in the data array.
- **SC-005**: The section renders correctly with 1, 5, and 10 restaurant entries —
  no layout breaks at any count.

## Assumptions

- Restaurant data is owner-curated and static per version — there is no search,
  filtering, or sorting UI in this spec.
- The initial restaurant list replaces the demo.html placeholder data with the
  owner's actual recommendations (seed content below).
- Google Maps URLs are standard short links. Deep-link handling (opening the native
  Maps app on iOS/Android) is left to the OS.
- Translation of restaurant names and descriptions is out of scope for the initial
  English-only version; the fields are designed to support it when IT/DE are added.
- Section categories (e.g., "Fine Dining", "Traditional") as seen in `demo.html`
  are not required by this spec — a flat list is sufficient. Categories may be
  added in a future spec as a section divider using `.ornament-divider`.
- The restaurants section card uses the same `.card` component from the design
  system (feature 002); no new card variant is introduced.

## Seed Content

Owner-provided entries for `CONTENT.sections.restaurants`. IT/DE translations are the owner's responsibility.

```js
CONTENT.sections.restaurants = [
  {
    name:        "Dalì",
    description: "Located in the old embarcadero — perfect for breakfast, aperitivo, or pizza. Main dishes are quite good but I prefer other restaurants for a full meal.",
    mapsUrl:     "https://g.co/kgs/MsXgfzD"
  },
  {
    name:        "La Casera",
    description: "⭐ MY PREFERRED CHOICE FOR CHEESE & AFFETTATI. Super foodie spot. High quality, a little pricey but nothing terrible. Exceptional cheese, affettati, and wine selection. You must try it for an aperitivo!",
    mapsUrl:     "https://g.co/kgs/K4gpVGi"
  },
  {
    name:        "Osteria del Castello",
    description: "Located in Piazza Castello with a lovely pergola — perfect for dining outside when it's warm. An historical osteria with good food and a great wine selection. Reserve in advance!",
    mapsUrl:     "https://g.co/kgs/YBBz5QV"
  },
  {
    name:        "L'Alchimista",
    description: "Excellent pizzeria specialising in 'pizza contemporanea' — characterised by a large, airy cornicione. Very, very good pizza.",
    mapsUrl:     "https://g.co/kgs/k7R4zea"
  },
  {
    name:        "Gattabuia",
    description: "⭐ MY PREFERRED CHOICE FOR PIZZA (evenings). A unique community canteen promoting the professional integration of people with justice-related issues. Lunch: fixed price €10.50 for primo, secondo e contorno — cheap and perfect for a quick meal in Pallanza. Evenings: the best pizza in Verbania at very affordable prices. You MUST book well in advance — always fully booked. I recommend a table outside as the inner room can be noisy.",
    mapsUrl:     "https://g.co/kgs/wRwwzoX"
  },
  {
    name:        "Damm'a Traa",
    description: "In Suna, loved by a younger crowd. Generous portions of delicious local cuisine at great prices. Guests love dining outdoors with lake views — 'excellent food in a beautiful setting with abundant portions.'",
    mapsUrl:     "https://g.co/kgs/hCBG59e"
  },
  {
    name:        "Estremadura",
    description: "Perfect for cocktails and gin tonics. Very popular with young people. Drinks are not cheap, but the cocktail list is spectacular.",
    mapsUrl:     "https://g.co/kgs/b5xugtA"
  },
  {
    name:        "Donna Francesca",
    description: "⭐ MY PREFERRED CHOICE FOR OVERALL RESTAURANT. In Cossogno (the road is a little tricky but worth it). A cozy, rustic osteria with hearty homemade Italian cuisine made with local, seasonal ingredients. Every dish on the menu is usually excellent, prices are very reasonable, and the quality/price ratio is outstanding. Request a table outside — book in advance, especially at weekends.",
    mapsUrl:     "https://g.co/kgs/cYiBsFk",
    favourite:   true
  },
  {
    name:        "Cantina Leonardo (Mergozzo)",
    description: "⭐ MY PREFERRED CHOICE FOR LOCATION. On the lakeshore in Mergozzo with a stunning view of Lake Mergozzo. Good pizzas, good food overall — but the view is superb, especially at sunset. Prices are surprisingly reasonable for such a spectacular setting. Highly recommended.",
    mapsUrl:     "https://g.co/kgs/aqLci7Y",
    favourite:   true
  },
  {
    name:        "L'Imbarcadero (Isola Pescatori)",
    description: "On Isola Pescatori (Isola Superiore) — reachable by public ferry from Verbania Intra. Very good food, reasonable prices, nice lake views. Slightly better food than its neighbour La Pescheria. Book in advance.",
    mapsUrl:     null,
    favourite:   false
  },
  {
    name:        "La Pescheria (Isola Pescatori)",
    description: "On Isola Pescatori (Isola Superiore). Very good food, reasonable prices. The better location of the two island restaurants — dining under the pergola 'al fresco' is a wonderful experience. My usual choice when visiting the island.",
    mapsUrl:     "https://maps.app.goo.gl/mW5Knm882zSTd33NA",
    favourite:   true
  },
  {
    name:        "La Terrazza",
    description: "One of the best locations on the lake. Outstanding pizza, very good food overall, very reasonable prices. Highly recommended.",
    mapsUrl:     "https://maps.app.goo.gl/LNbFp2L1VceG2uC78",
    favourite:   true
  }
]
```

> ⭐ = owner's personal top pick for that category. Ratings are subjective.
> Island restaurants (L'Imbarcadero, La Pescheria) have no direct Maps link —
> guests reach them by ferry; see the Things to Visit section (Borromean Islands).
