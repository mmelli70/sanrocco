# Feature Specification: Boat Rental Section

**Feature Branch**: `012-boat-rental`
**Created**: 2026-04-10
**Status**: Draft
**Input**: "Boat rental is just a document section." Rich content provided by owner,
originally written by a guest (Philipp). Covers 6 rental operators + general tips.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Reads the Boat Rental Guide (Priority: P1)

A guest interested in renting a boat opens this section and finds a complete,
well-organised guide with contact details, fleet options, pricing, and personal
reviews for each operator, plus general tips at the bottom. Everything they need
to choose and book a boat rental is in one place.

**Why this priority**: This is the entire value of the section. Guests need to read
and reference specific details (phone numbers, prices, boat specs) while planning.

**Independent Test**: Open `index.html`, navigate to "Boat Rental". All 6 operator
sub-sections and the General Tips section are visible and readable. All phone/website
links are tappable. Works fully offline.

**Acceptance Scenarios**:

1. **Given** the guest opens the Boat Rental section, **When** the section loads,
   **Then** an attribution note crediting the guest author (Philipp) is visible at
   the top.
2. **Given** the section is displayed, **When** the guest scans it, **Then** 6
   operator sub-sections are present, each showing: name, contact details, fleet
   & pricing, and — where provided — a personal review or notes.
3. **Given** an operator has a website URL, **When** the guest taps it, **Then**
   the browser opens the URL in a new tab.
4. **Given** an operator has a phone or mobile number, **When** the guest taps it,
   **Then** the device initiates a call (`tel:` link).
5. **Given** an operator has a WhatsApp number, **When** the guest taps it,
   **Then** the device opens WhatsApp to that contact (`https://wa.me/` link).
6. **Given** the section is displayed, **When** the guest scrolls to the bottom,
   **Then** a "General Tips" block is visible covering fuel costs, water sports
   advice, and booking recommendations.
7. **Given** the device is offline, **When** the guest views the section, **Then**
   all content renders correctly; only external links (websites, maps) require
   connectivity.

---

### User Story 2 - Guest Calls or Contacts an Operator Directly (Priority: P1)

A guest finds an operator they like and wants to contact them without manually
copying the number. They tap the phone, mobile, or WhatsApp link and are connected
immediately.

**Why this priority**: The section's primary actionable value for the guest is
being able to contact an operator with one tap.

**Independent Test**: Tap the mobile number for Lago Charter — the phone dialler
opens with the number pre-filled. Tap the WhatsApp number for Rent Boat Lago
Maggiore — WhatsApp opens the chat.

**Acceptance Scenarios**:

1. **Given** a phone/mobile number is displayed, **When** the guest taps it,
   **Then** the phone dialler opens with the number ready to call.
2. **Given** a WhatsApp number is displayed, **When** the guest taps it,
   **Then** WhatsApp opens a chat with that contact number.
3. **Given** an email address is displayed, **When** the guest taps it,
   **Then** the device mail client opens a new message to that address.

---

### User Story 3 - Owner Updates the Boat Rental Guide (Priority: P2)

The owner updates pricing, contact details, or adds a new operator by editing the
`CONTENT` data for this section. The layout adjusts automatically.

**Independent Test**: Update the price of Lago Charter's Bayliner 180 XL in
`CONTENT`. Open the file — the new price is shown.

**Acceptance Scenarios**:

1. **Given** a price is updated in `CONTENT`, **When** the page opens, **Then**
   the updated price is shown.
2. **Given** a new operator entry is added to the data array, **When** the page
   opens, **Then** the new operator sub-section appears.
3. **Given** an optional field (e.g., `whatsapp`) is removed from an operator,
   **When** the page opens, **Then** the WhatsApp link does not appear — no broken
   layout.

---

### Edge Cases

- What if a phone number format is non-standard (e.g., German `+49 151 / 65 63 46 83`)?
  The `tel:` link must strip spaces and special characters for correct dialling.
- What if the guest's screen is very narrow (320 dp)? Pricing bullet lists and
  contact detail blocks must not overflow horizontally.
- What if an operator has no website, phone, or email? The contact block renders
  gracefully — only the fields that are present are shown.
- What if the General Tips section is very long? It scrolls vertically without
  any content being clipped.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display an attribution note at the top crediting the
  original author ("written by a guest: thank you Philipp!!"). The note is stored in
  `CONTENT.strings[lang].boatRentalAttribution` and is translatable.
- **FR-002**: The section MUST display a list of operator sub-sections, one per
  entry in `CONTENT.sections.boatRental`. The initial list MUST contain these 6
  operators in order: Lago Charter, Rent Boat Lago Maggiore, Cantiere di Ghiffa
  Boat Service, Marina di Pallanza, Rent Boat Cannobio, Feriolo Sporting Club.
- **FR-003**: Each operator entry MUST support these fields:
  - `name` (string, required)
  - `website` (URL, optional)
  - `location` (string, optional)
  - `contact` object with optional sub-fields: `person`, `phone`, `mobile`,
    `whatsapp`, `email`
  - `fleet` (array of strings, optional — each item is one boat/price line)
  - `notes` (array of strings, optional — important bullet points)
  - `review` (string, optional — personal experience text)
  - `notTested` (boolean, optional — displays a "not personally tested" disclaimer)
- **FR-004**: Each operator sub-section MUST display its `name` as a heading.
- **FR-005**: If `website` is present, it MUST be shown as a tappable link opening
  in a new tab (`target="_blank" rel="noopener"`).
- **FR-006**: If `contact.phone` or `contact.mobile` is present, it MUST be shown
  as a tappable `tel:` link. Phone numbers MUST be normalised for the `tel:` href
  (spaces and formatting characters stripped).
- **FR-007**: If `contact.whatsapp` is present, it MUST be shown as a tappable
  `https://wa.me/<number>` link opening in a new tab.
- **FR-008**: If `contact.email` is present, it MUST be shown as a tappable
  `mailto:` link.
- **FR-009**: If `notTested: true`, the operator sub-section MUST display a visible
  disclaimer ("Not personally tested") so the guest understands the review is
  sourced from third-party information.
- **FR-010**: The section MUST end with a "General Tips" block covering: fuel cost
  estimates, water sports guidance, and booking advice. This block is stored in
  `CONTENT.strings[lang].boatRentalTips` and is translatable.
- **FR-011**: All text content MUST be stored in `CONTENT` and be translatable
  (IT / EN / DE). Contact details (phone numbers, URLs) are language-neutral.
- **FR-012**: The section MUST use the visual design system from feature 002.
  Operator sub-sections use the `.info-box` or `.rule-item` component. The General
  Tips block uses `.info-box`. No new component variants are introduced.
- **FR-013**: The section MUST work fully offline. No assets may depend on a network
  request. External links (websites, maps) require connectivity — acceptable.

### Key Entities

- **Operator Entry**: `{ name, website?, location?, contact?: { person?, phone?,
  mobile?, whatsapp?, email? }, fleet?: string[], notes?: string[], review?: string,
  notTested?: bool }` — stored in `CONTENT.sections.boatRental[]`.
- **Attribution Note**: Introductory credit line to the guest author.
- **General Tips Block**: Closing advisory text on fuel, water sports, and booking.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All 6 operator sub-sections and the General Tips block are visible
  and readable on a 360 dp phone in iOS Safari and Android Chrome with no
  truncation or overflow.
- **SC-002**: Tapping a mobile number opens the phone dialler with the number
  pre-filled — verified for Lago Charter (+49) and Cantiere di Ghiffa (+39).
- **SC-003**: Tapping the WhatsApp number for Rent Boat Lago Maggiore opens
  WhatsApp to that contact.
- **SC-004**: The "not personally tested" disclaimer appears on Marina di Pallanza
  and Rent Boat Cannobio cards — verified by inspection.
- **SC-005**: Adding a new operator entry to `CONTENT.sections.boatRental` produces
  a correctly rendered sub-section with zero HTML structural changes.
- **SC-006**: The section renders correctly with airplane mode enabled on iOS and
  Android.

## Assumptions

- The section is a **document/guide** — it does not use the interactive card list
  pattern of restaurants or beaches. Each operator is a sub-section with structured
  prose and tappable links, not a uniform `.card` component.
- The attribution line ("written by a guest: thank you Philipp!!") is intentionally
  personal and warm — it should be styled as a subtitle or introductory note, not
  buried in body text.
- Two operators are flagged as "not personally tested" by the owner (Marina di
  Pallanza, Rent Boat Cannobio). The `notTested` flag controls a visible disclaimer.
- Phone numbers are stored as written (e.g., `+49 151 / 65 63 46 83`) and the
  renderer normalises them for `tel:` hrefs. Display format is preserved as-is.
- Pricing is stored as plain strings within the `fleet` array — no structured
  currency fields. This makes it easy for the owner to update without numeric parsing.
- The General Tips block is editorial prose contributed by the same guest (Philipp)
  and is stored as translatable content strings. IT/DE translation is the owner's
  responsibility.
- Google Maps links for operator locations are not in the seed content; they may be
  added later as an optional `mapsUrl` field per operator.
