# Feature Specification: How to Reach Us

**Feature Branch**: `007-how-to-reach`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: User description: "this section will show a text with the description to reach the apartment, and a box highly visible where is explained that the house is in a ZTL area and the image of the road signs"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Reads the Arrival Directions (Priority: P1)

A guest who is about to arrive reads the directions section and understands how to
reach the apartment. They see a clear prose description of the route and, prominently,
a warning that the property is inside a ZTL (Zona a Traffico Limitato — restricted
traffic zone) so they can take the necessary precautions before driving in.

**Why this priority**: Getting the ZTL warning wrong can result in a fine for the
guest. This is the most safety-critical piece of information in the guide. It must
be impossible to miss.

**Independent Test**: Open `index.html`, navigate to the "How to Reach Us" section.
The directions text is readable. The ZTL warning box is immediately visible without
scrolling (or clearly stands out when scrolling past it) and shows both the warning
text and the road sign image. Works fully offline.

**Acceptance Scenarios**:

1. **Given** the guest opens the "How to Reach Us" section, **When** the section
   loads, **Then** the arrival directions text is visible and fully readable.
2. **Given** the section is displayed, **When** the guest scans the page, **Then**
   the ZTL warning box is visually distinct — clearly more prominent than the
   surrounding text — with a colour, border, or background that signals importance.
3. **Given** the ZTL warning box is displayed, **When** the guest reads it, **Then**
   the warning text explains that the property is in a ZTL zone and what the guest
   must do (e.g., register their plate or avoid driving in).
4. **Given** the ZTL warning box is displayed, **When** the guest looks at it,
   **Then** the Italian road sign image for ZTL is visible and clearly rendered
   (not a broken image, not blurred).
5. **Given** the device is offline, **When** the guest views the section, **Then**
   the road sign image renders correctly (it is embedded in the file, not loaded
   from a URL).

---

### User Story 2b - Guest Enters the Property (Priority: P1)

Once the guest has parked and is on foot in Piazza San Rocco, they need step-by-step
guidance to find the correct gate, ring the bell, and reach the apartment on the
second floor. A short "Reach the House" sub-section with descriptive text and three
photos guides them through the last few metres of the journey.

**Why this priority**: A guest who cannot find the entrance, the bell, or the correct
staircase is stranded — this is the most operationally critical moment of the arrival.
Clear visual guidance (photos of gate, walkway, stairs) eliminates confusion.

**Independent Test**: Open `index.html`, navigate to "How to Reach Us". Scroll to
the "Reach the House" sub-section. The description text is readable. Three photos
are visible and render correctly in offline mode.

**Acceptance Scenarios**:

1. **Given** the guest has arrived at Piazza San Rocco, **When** they open this
   sub-section, **Then** a description explains: the gate at number 2, the bell
   labelled MELLI, WhatsApp contact option, late-arrival key safe, walkway to
   second floor, and the note not to close the gate at the stairs.
2. **Given** the sub-section is displayed, **When** the guest scrolls through it,
   **Then** three photos are visible in sequence (e.g., gate exterior, walkway,
   staircase/floor) helping them match their surroundings to the guide.
3. **Given** the device is offline, **When** the photos are displayed, **Then** all
   three render correctly — they are embedded in the file, not loaded from a URL.
4. **Given** the screen is very narrow (320 dp), **When** the photos are displayed,
   **Then** no horizontal overflow occurs; each photo fills its container cleanly.

---

### User Story 3 - Guest Finds a Parking Spot Nearby (Priority: P1)

A guest arriving by car needs to park. They scroll to the Parking sub-section and
see a list of nearby parking areas with a name, a brief description, a photo of the
location, and a link to open it in Google Maps.

**Why this priority**: Finding parking is part of the arrival experience and directly
reduces guest stress. Without this information guests may drive around or miss
convenient options.

**Independent Test**: Open `index.html`, navigate to "How to Reach Us". Scroll to
the Parking sub-section. At least one parking card is visible with name, description,
photo, and a working "Open in Maps" link. Works fully offline (photo is embedded).

**Acceptance Scenarios**:

1. **Given** the guest opens the "How to Reach Us" section, **When** they scroll to
   the parking area, **Then** a sub-section labelled "Parking" (or equivalent in the
   active language) is visible.
2. **Given** the parking sub-section is visible, **When** the guest reads a parking
   card, **Then** it shows: a name, a description, and — optionally — a photo.
3. **Given** a parking card has a Google Maps link, **When** the guest taps it,
   **Then** the device opens Google Maps (or the browser) to the correct location.
4. **Given** the device is offline, **When** the guest views the parking cards,
   **Then** any embedded photos render correctly. Cards without photos show a
   graceful placeholder.
5. **Given** a parking card has no photo yet, **When** the card is displayed,
   **Then** the card layout does not break — the photo area is omitted or replaced
   by a neutral placeholder.

---

### User Story 4 - Owner Manages the Parking List (Priority: P2)

The owner can add, remove, or reorder parking entries by editing the
`CONTENT.sections.parking` array. Adding a photo requires running `build.sh` to
embed the image as base64.

**Independent Test**: Add a new parking entry to `CONTENT.sections.parking` with
a name and description but no photo. Open the file — the new card is shown correctly
without a photo.

**Acceptance Scenarios**:

1. **Given** a new parking entry is added to `CONTENT.sections.parking`, **When**
   the page opens, **Then** the new card appears in the list.
2. **Given** a parking entry has a `photoToken` that has not been injected, **When**
   the page opens, **Then** the card renders without a broken image.
3. **Given** the owner runs `build.sh --parking-photos`, **When** the page opens,
   **Then** the embedded photo appears in the correct parking card.

---

### User Story 2 - Owner Updates the Directions or ZTL Warning (Priority: P2)

The owner updates the directions text or the ZTL warning copy by editing the
`CONTENT` object. The road sign image can be replaced by updating the embedded
asset in `index.html` (via `build.sh`).

**Why this priority**: Directions may change if access routes are modified, or the
ZTL rules change. Updates must be straightforward.

**Independent Test**: Change the directions text in `CONTENT.strings.en`. Open the
file — the new text is shown with no layout breakage.

**Acceptance Scenarios**:

1. **Given** the directions text is updated in `CONTENT`, **When** the page opens,
   **Then** the new text is displayed correctly.
2. **Given** the ZTL warning copy is updated in `CONTENT`, **When** the page opens,
   **Then** the updated warning is shown in the warning box.
3. **Given** the road sign image is replaced via `build.sh`, **When** the page
   opens, **Then** the new image is shown inside the warning box.

---

### Edge Cases

- What if the directions text is very long (multiple paragraphs)? The content area
  must scroll vertically; no text is cut off.
- What if the road sign image has not been embedded yet (placeholder)? A visible
  placeholder box is shown rather than a broken image icon.
- What if the guest's screen is very narrow (320 dp)? The ZTL box, road sign image,
  "Reach the House" photos, and parking cards must not overflow horizontally.
- What if one or more "Reach the House" photos have not been injected yet? Each
  uninjected photo slot shows a neutral placeholder — no broken image icons.
- What if a parking entry has no photo? The card must render without the photo block
  — no broken image icon, no empty space that breaks the layout.
- What if a parking entry has no Google Maps link? The map button is simply not
  rendered for that card.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display a directions text block describing how to
  reach the property. The text is stored in `CONTENT.strings[lang]` and is
  translatable.
- **FR-002**: The section MUST display a ZTL warning box that is visually
  prominent — differentiated from body text by a distinct background colour,
  border, or icon that signals a warning or important notice.
- **FR-003**: The ZTL warning box MUST contain a text explanation of the ZTL
  restriction and its implications for the guest. The text is stored in
  `CONTENT.strings[lang]` and is translatable.
- **FR-004**: The ZTL warning box MUST display an image of the Italian ZTL road
  sign. The image MUST be embedded in `index.html` as a base64 data URI — no
  external image URL.
- **FR-005**: The road sign image MUST be replaced via `build.sh` (same mechanism
  as the background image in feature 001). A placeholder token MUST be used in
  `index.html` until the real image is injected.
- **FR-006**: The ZTL warning box MUST be positioned so that it is encountered
  early in the section — either before or immediately after a brief introductory
  line — not buried at the bottom.
- **FR-007**: The section MUST work fully offline. No part of the section content
  — including the road sign image — may depend on a network request.
- **FR-008**: The section MUST use the visual design system from feature 002.
  The ZTL warning box MUST use a visually distinct style — a new `.warning-box`
  component variant of `.info-box` with a high-visibility colour (e.g., amber/gold
  border and background tint, or a red-tinted variant).
- **FR-009**: The section MUST include a "Reach the House" sub-section, positioned
  after the ZTL warning box. The sub-section heading MUST be translatable.
- **FR-010**: The "Reach the House" sub-section MUST display a description text
  covering: the gate at number 2, the MELLI bell, WhatsApp contact option,
  late-arrival key safe, walkway navigation to the second floor, and the note not
  to close the gate at the bottom of the stairs. The text is stored in
  `CONTENT.strings[lang].reachTheHouse` and is translatable.
- **FR-011**: The "Reach the House" sub-section MUST display exactly three photos
  (e.g., gate, walkway, staircase). Photos are embedded as base64 data URIs and
  injected by `build.sh` from `assets/`. Tokens `{{REACH_PHOTO_1}}`,
  `{{REACH_PHOTO_2}}`, `{{REACH_PHOTO_3}}` are used as placeholders.
- **FR-012**: Each photo in the "Reach the House" sub-section MUST render as a
  full-width (or near full-width) image within the content column, with a brief
  optional caption. No horizontal overflow on 320 dp screens.
- **FR-013**: The section MUST include a "Parking" sub-section, positioned after
  "Reach the House". The sub-section heading MUST be translatable.
- **FR-014**: Each parking entry MUST display: a **name**, a **description**, and
  an optional **photo**. An optional **Google Maps link** opens the location
  externally.
- **FR-015**: Parking entries are stored in `CONTENT.sections.parking` as an array
  of objects. Adding or removing entries requires only editing the data array.
- **FR-016**: Each parking photo MUST be embedded as a base64 data URI — no external
  image URLs. Photos are injected by `build.sh` from `assets/parking/`. A parking
  entry without a photo MUST render gracefully (card layout must not break).
- **FR-017**: The parking list MUST use the same card visual style as other list
  sections (beaches, supermarkets) from feature 002, for consistency.

### Key Entities

- **Directions Block**: Free-form prose text (one or more paragraphs) describing
  the route to the property. Stored in `CONTENT.strings[lang].directions`.
- **ZTL Warning Box**: A high-visibility component containing warning text and the
  road sign image. Stored in `CONTENT.strings[lang].ztlWarning`.
- **ZTL Road Sign Image**: An Italian traffic sign image, embedded as base64.
  Injected by `build.sh` from `assets/ztl-sign.png`.
- **Reach the House Block**: Description text + 3 sequential photos guiding the
  guest from Piazza San Rocco to the apartment door. Text stored in
  `CONTENT.strings[lang].reachTheHouse`. Photos injected by `build.sh` from
  `assets/door1.jpg`, `assets/door2.jpg`, `assets/door3.jpg`.
- **Parking Entry**: `{ name: string, description: string, mapsUrl?: string, photoToken?: string }`.
  `photoToken` is a placeholder replaced by `build.sh` with a base64 data URI.
  Stored in `CONTENT.sections.parking[]`.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The ZTL warning box is immediately recognisable as a warning on first
  glance — verified by showing the section to a person unfamiliar with the guide
  and asking them to identify the most important element.
- **SC-002**: The road sign image renders correctly (not broken, not blurred) on
  iOS Safari and Android Chrome with airplane mode enabled.
- **SC-003**: Updating the directions text in `CONTENT` produces the correct output
  with zero other file changes.
- **SC-004**: The section renders without horizontal overflow on a 320 dp screen.
- **SC-005**: The ZTL warning box and image are visible without scrolling on a
  360 × 640 dp phone when the section first loads (or are the first elements
  encountered when scrolling).
- **SC-006**: The "Reach the House" description text is fully visible and readable
  when the sub-section is scrolled to, on both iOS Safari and Android Chrome.
- **SC-007**: All three "Reach the House" photos render correctly (not broken) with
  airplane mode enabled on iOS and Android.
- **SC-008**: Adding a new parking entry to `CONTENT.sections.parking` produces a
  correctly rendered card with zero changes to HTML structure.
- **SC-009**: A parking card with no photo renders without layout breakage on
  320 dp and 390 dp screens.
- **SC-010**: Tapping a parking map link opens Google Maps to the correct location.

## Assumptions

- The Italian ZTL road sign image will be provided by the owner (a photograph or
  a standard sign illustration). A placeholder will be used during development.
- The directions text will be written by the owner at content-entry time; this spec
  defines the structure, not the content.
- The ZTL warning is the most critical safety/legal information in the guide; its
  visual prominence takes priority over aesthetic consistency with other sections.
- A new `.warning-box` CSS component (a variant of `.info-box` with a more urgent
  visual style) will be introduced in this feature and added to the design system
  contract (feature 002).
- The section does not include a live map embed — a "Open in Maps" link to the
  property address may be added as an optional enhancement in a future version.
- The "Reach the House" sub-section contains exactly 3 fixed photo slots
  (`assets/door1.jpg`, `assets/door2.jpg`, `assets/door3.jpg`). This count is fixed by design;
  if more photos are needed in the future a new spec revision is required.
- The seed text for `reachTheHouse` (all languages) is provided by the owner:
  *"When you reach Piazza San Rocco, search the gate at number 2. The bell is MELLI,
  push it or call me via WhatsApp. Usually, I will be waiting for you. If you plan
  to arrive very late, I will leave the keys in a safebox. Go to the end of the
  walkway and go to the second floor. NOTE: please do not close the gate at the
  beginning of the stairs."* Translation to IT and DE is the owner's responsibility.
- Parking photos are optional per entry; the owner provides them at content-entry
  time. Cards without photos must render gracefully.
- Parking photo assets are stored in `assets/parking/` and injected by `build.sh`
  using the same token-replacement mechanism as the background image and ZTL sign.
- The parking card layout reuses the beaches/supermarkets card pattern (feature 002
  `.card` component) extended with an optional photo block.

## Seed Content

Owner-provided content for the English version. IT and DE translations are the
owner's responsibility.

### ZTL Warning (`CONTENT.strings.en.ztlWarning`)

```
IMPORTANT NOTE: the B&B is in a restricted area. Access by car is permitted only
during selected hours and is controlled remotely by a camera.

If the sign is GREEN (like in the picture), you can enter.
If it shows RED with the message "ZTL ATTIVA", you cannot access the street.

Free passage hours:
  08:00 – 12:30  and  14:30 – 20:00

Note: parking is not possible in Piazza San Rocco itself, but there is a free
parking area nearby.
```

**UI note**: The ZTL sign image (`assets/ztl-sign.png`, 412×724px PNG) shows the
camera-controlled sign at the entrance. Green state = entry permitted. Red "ZTL ATTIVA"
state = entry forbidden. Image is already in the repository and will be embedded
via `build.sh`.

### Reach the House (`CONTENT.strings.en.reachTheHouse`)

```
When you reach Piazza San Rocco, search the gate at number 2. The bell is MELLI —
push it or call me via WhatsApp. Usually, I will be waiting for you. If you plan
to arrive very late, I will leave the keys in a safebox.
Go to the end of the walkway and go to the second floor.
NOTE: please do not close the gate at the beginning of the stairs.
```

### Parking (`CONTENT.sections.parking`)

```js
[
  {
    name:        "Via Brigata Cesare Battisti",
    description: "Close to the river — always free. The square near the river is partially free and partially with a maximum allowed parking time.",
    mapsUrl:     "https://maps.app.goo.gl/F9z5cLR5GGD1kumg9",
    photoToken:  null   // no photo yet
  },
  {
    name:        "Largo degli Invalidi del Lavoro",
    description: "Pay parking, very close to the house. Perfect for a short stay.",
    mapsUrl:     "https://maps.app.goo.gl/VWoqszTRxdSu42Ao6",
    photoToken:  null   // no photo yet
  }
  // more entries to follow
]
```

