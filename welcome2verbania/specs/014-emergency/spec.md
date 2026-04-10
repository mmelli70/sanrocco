# Feature Specification: Emergency Section

**Feature Branch**: `014-emergency`
**Created**: 2026-04-10
**Status**: Draft
**Input**: Emergency and useful local numbers — 112, ambulance, police, nearest
hospital, pharmacy, and any other safety-critical contacts for the Verbania area.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Needs Emergency Help (Priority: P1)

A guest faces an emergency — medical, fire, or police — and needs to call for help
immediately. They open the Emergency section and see the most important numbers
displayed prominently and in a high-visibility style. One tap dials the number.

**Why this priority**: This is safety-critical. Clarity and speed are paramount.
The UI must be unmistakable — no visual clutter, large tap targets, immediately
actionable.

**Independent Test**: Open `index.html`, navigate to "Emergency". The general
emergency number (112) is the first and most prominent entry. Tapping it dials
immediately. Works fully offline.

**Acceptance Scenarios**:

1. **Given** the guest opens the Emergency section, **When** it loads, **Then**
   the general emergency number (112) is the first visible entry and is styled
   most prominently.
2. **Given** any emergency number is displayed, **When** the guest taps it,
   **Then** the phone dialler opens with the number pre-filled — one tap to call.
3. **Given** an entry has a name and description, **When** the card is displayed,
   **Then** both are readable at a glance without requiring the guest to zoom in.
4. **Given** the device is offline, **When** the guest views the section, **Then**
   all numbers and descriptions are visible — no network request is needed.

---

### User Story 2 - Guest Finds a Nearby Pharmacy or Hospital (Priority: P1)

A guest or family member needs non-emergency medical help — a pharmacy for medicine,
or the nearest hospital for urgent care. They open the Emergency section and find
the name, address, and phone number for the nearest facilities.

**Why this priority**: Medical non-emergencies are a frequent guest need. Having
this information easily accessible is a meaningful hospitality gesture.

**Independent Test**: Navigate to Emergency. A pharmacy and a hospital entry are
visible with name, address, and tappable phone number. Tapping the phone dials.

**Acceptance Scenarios**:

1. **Given** the guest looks for a pharmacy, **When** they view the Emergency
   section, **Then** at least one pharmacy entry is present with name, address,
   and phone number.
2. **Given** the guest looks for a hospital, **When** they view the section,
   **Then** at least one hospital entry is present with name, address, and phone.
3. **Given** an entry has a Google Maps link, **When** the guest taps it,
   **Then** the device opens Google Maps to the correct location.

---

### User Story 3 - Owner Updates the Emergency List (Priority: P2)

The owner updates a number or adds a new entry (e.g., local GP, dentist) by editing
`CONTENT.sections.emergency`. No structural HTML changes are needed.

**Acceptance Scenarios**:

1. **Given** an entry is updated in `CONTENT`, **When** the page opens,
   **Then** the updated information is shown.
2. **Given** a new entry is added, **When** the page opens, **Then** the new card
   appears without any structural changes.

---

### Edge Cases

- What if the guest taps a number while on airplane mode? The OS will show a "no
  service" error — acceptable and unavoidable. The number is still displayed so the
  guest can use another device.
- What if the screen is very narrow (320 dp)? All cards and tap targets must fit
  without horizontal overflow.
- What if the list grows beyond the initial entries? Cards stack vertically without
  layout breakage.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display the general emergency number **112** as the
  first and most visually prominent entry, using the `.emergency-card` component
  from feature 002.
- **FR-002**: Each emergency entry MUST support these fields:
  - `name` (string, required) — e.g., "Emergency", "Carabinieri", "Hospital"
  - `number` (string, required) — phone number, rendered as a tappable `tel:` link
  - `description` (string, optional) — brief clarification
  - `address` (string, optional) — physical address
  - `mapsUrl` (string URL, optional) — opens location in Google Maps
- **FR-003**: Every `number` field MUST be rendered as a tappable `tel:` link with
  a minimum tap target of 44 × 44 CSS pixels. The display format is preserved;
  the `href` is normalised (spaces stripped).
- **FR-004**: If `mapsUrl` is present, the card MUST show an "Open in Maps" button.
- **FR-005**: The initial entry list MUST include at minimum:
  - 112 (General Emergency — police, ambulance, fire)
  - 118 (Ambulance / Medical Emergency)
  - 113 (Police — Polizia di Stato)
  - 115 (Fire Brigade — Vigili del Fuoco)
  - Nearest hospital (Ospedale Castelli, Verbania — to be filled by owner)
  - Nearest pharmacy (to be filled by owner)
- **FR-006**: The emergency list MUST be stored in `CONTENT.sections.emergency[]`.
  Adding or removing an entry requires editing only that array.
- **FR-007**: Entry names and descriptions MUST be translatable
  (`CONTENT.strings[lang]`). Phone numbers are language-neutral.
- **FR-008**: The section MUST use the `.emergency-card` component from feature 002
  for all entries. The component's visual style signals urgency (distinct from
  regular `.card` and `.info-box`).
- **FR-009**: The section MUST work fully offline.

### Key Entities

- **Emergency Entry**: `{ name, number, description?, address?, mapsUrl? }`
  stored in `CONTENT.sections.emergency[]`.
- **Emergency Card**: The `.emergency-card` component — high-visibility layout with
  large tap target on the phone number.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 112 is the first visible entry and is visually the most prominent
  element in the section — verified on 360 dp and 390 dp phones.
- **SC-002**: Tapping any phone number opens the dialler with the correct number
  pre-filled — verified for at least 3 entries.
- **SC-003**: All entries are readable at arm's length on a 360 dp screen with no
  zooming required.
- **SC-004**: The section renders correctly with airplane mode enabled.
- **SC-005**: Adding a new entry to `CONTENT.sections.emergency` produces a
  correctly styled card with zero HTML structural changes.

## Assumptions

- The standard Italian emergency numbers (112, 118, 113, 115) are static and
  language-neutral — they are the same regardless of the guest's language.
- The nearest hospital and pharmacy addresses/numbers will be provided by the owner
  at content-entry time. Placeholder entries will be used during development.
- The `.emergency-card` component from feature 002 is already defined as a reusable
  component. Its high-visibility visual style (distinct from `.card` and `.info-box`)
  makes this section unmistakable as an emergency reference.
- This section is positioned 4th in the home screen grid (after Contacts, How to
  Reach Us, House Rules) — close to the top but after the most-used sections.
- No map embed or route planning is in scope. A "Open in Maps" link per entry
  is sufficient for navigation to a hospital or pharmacy.

## Seed Content

Generic Italian emergency services information for `CONTENT.sections.emergency`.
Hospital and pharmacy details to be filled by owner before publish.

### How 112 works in Italy (intro text — `CONTENT.strings.en.emergencyIntro`)

```
In Italy, 112 is the single European Emergency Number and the recommended number
for ALL emergencies — police, ambulance, and fire brigade.

How it works:
• Free call — no credit or SIM card required
• Works even with no mobile signal (the call is routed through any available network)
• Operators speak multiple languages — ask for English if needed
• The operator will dispatch the correct service (police, ambulance, fire)
• Stay on the line and follow the operator's instructions
• Give your location clearly — the address is: Piazza San Rocco 2, Verbania (VB)
```

### Emergency entries (`CONTENT.sections.emergency`)

```js
[
  {
    name:        "112 — Single Emergency Number",
    number:      "112",
    description: "The single European emergency number for ALL emergencies in Italy: police, ambulance, and fire brigade. Free call — works without credit or SIM card, even with no signal. Operators speak multiple languages. This is always the right number to call first.",
  },
  {
    name:        "118 — Ambulance & Medical Emergency",
    number:      "118",
    description: "Dedicated Italian ambulance and medical emergency line. Use if you need an ambulance or urgent medical assistance. Free call.",
  },
  {
    name:        "113 — Police (Polizia di Stato)",
    number:      "113",
    description: "Italian state police emergency line. For theft, assault, public order incidents. Free call.",
  },
  {
    name:        "115 — Fire Brigade (Vigili del Fuoco)",
    number:      "115",
    description: "Italian fire brigade. For fires, flooding, structural collapses, and technical rescues. Free call.",
  },
  {
    name:        "Ospedale Castelli — DEA Verbania",
    number:      "0323 541111",   // main switchboard — owner to confirm direct DEA number if available
    description: "The nearest hospital to the B&B. Verbania's hospital includes a DEA (Dipartimento di Emergenza e Accettazione) — the Italian equivalent of an A&E / Emergency Room. The DEA handles all medical emergencies: trauma, cardiac events, acute illness, and urgent care. For life-threatening emergencies always call 118 or 112 first so an ambulance is dispatched; go directly to the DEA for urgent but non-life-threatening situations.",
    address:     "Via Crocetta, 1, 28922 Pallanza VB",
    mapsUrl:     "https://maps.app.goo.gl/CkoTPrXedQsYcgEP9"
  },
  {
    name:        "Farmacia San Giorgio",
    number:      "0323 401355",
    description: "Open on Sundays — closed on Mondays.",
    address:     "Corso Goffredo Mameli, 141, 28921 Verbania VB",
    mapsUrl:     "https://maps.app.goo.gl/bHsu9fh8UvaoWdm28"
  },
  {
    name:        "Farmacia Nava",
    number:      "0323 519181",
    description: "TBD",
    address:     "Piazza Giacomo Matteotti, 25, 28921 Verbania VB",
    mapsUrl:     "https://maps.app.goo.gl/WDfzTyRQtEQqBtJW6"
  }
]
```

> ⚠️ The four Italian emergency numbers (112, 118, 113, 115) are final and
> require no owner input. Both pharmacies share the same Maps link — please
> confirm if Farmacia Nava has a different link. Phone numbers and addresses
> still needed before publishing.
