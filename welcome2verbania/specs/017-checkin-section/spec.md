# Feature Specification: Check-in Subsection in How to Reach Us

**Feature Branch**: `017-checkin-section`
**Created**: 2026-08-10
**Status**: IMPLEMENTED
**Input**: Add a new "Check-in" subsection in the How to Reach Us section, positioned before the Parking block. The subsection explains how check-in works (owner present or self check-in via lockbox) and includes a photo of the lockbox on the balcony. All five languages (EN/IT/DE/ES/FR) implemented in the same release.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Reads Check-in Instructions (Priority: P1)

A guest navigating to "How to Reach Us" finds a dedicated Check-in block explaining
that the owner is usually present, and — if not — how to retrieve the keys from the
lockbox on the balcony (code: 0493). A photo of the lockbox helps locate it.

**Why this priority**: Without clear check-in instructions, guests may not know
how to enter the apartment if the owner is unavailable.

**Independent Test**: Open `index.html`, navigate to How to Reach Us. A Check-in
block appears before the Parking section in all five languages, with the lockbox
photo displayed below the text.

**Acceptance Scenarios**:

1. **Given** the guest is on the How to Reach Us screen, **When** they scroll,
   **Then** the Check-in block appears after the Reaching the Apartment block and
   before the Parking section.
2. **Given** the guest reads the Check-in block, **Then** they see the lockbox
   code (0493) and the instruction to go to the balcony.
3. **Given** the file is opened offline, **Then** both text and lockbox photo
   render correctly from embedded data.
4. **Given** the guest switches language, **Then** the Check-in text appears in
   the selected language; the lockbox photo is language-independent.

---

### Edge Cases

- The lockbox photo must not overflow the container on 360 dp screens.
- The Check-in block must not displace or break the Parking section layout.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: A new info-box block with title `reach_checkin_title` and body
  `reach_checkin_body` MUST be inserted in `renderHowToReach()` after the
  "Reaching the Apartment" box and before the Parking section.
- **FR-002**: Immediately below the text block, the lockbox photo MUST be
  displayed as an embedded base64 JPEG (`LOCKBOX_IMG` constant), width 100%,
  inside an info-box with minimal padding.
- **FR-003**: Content strings MUST be defined in all five languages
  (`en`, `it`, `de`, `es`, `fr`) in `CONTENT.strings`.
- **FR-004**: `LOCKBOX_IMG` MUST be a `const` in the `<script>` block, holding
  a `data:image/jpeg;base64,...` data URI. Source image resized to max 900 px
  tall, JPEG 82% quality (~247 KB / ~337 KB base64).
- **FR-005**: No structural changes to other subsections (ZTL, Apartment,
  Parking) are required.

### Key Entities

- **`CONTENT.strings.{lang}.reach_checkin_title`** — section title ("Check-in" or localised equivalent)
- **`CONTENT.strings.{lang}.reach_checkin_body`** — instructions text
- **`LOCKBOX_IMG`** — base64 JPEG const, defined after `WASTE_CALENDAR_B64`
- **`renderHowToReach()`** — function modified to include the new block

## Success Criteria *(mandatory)*

- **SC-001**: Check-in block appears before Parking in all five languages.
- **SC-002**: Lockbox photo renders at full container width on mobile.
- **SC-003**: Page loads and renders fully offline.

## Assumptions

- The lockbox code (0493) is hardcoded in the body text; it is not a separate key.
- The photo is language-independent; no caption key is needed.
- Title localisation: same word "Check-in" used across all languages (universally understood).

## Seed Content

### English
**Title**: `🔑 Check-in`
**Body**: `Usually I'll be home to welcome you, so please send me a message with your expected arrival time. If I can't be there, I'll set up self check-in. Here are the instructions for getting the keys: once you're at the apartment door, continue onto the balcony. On the wall you'll find a lockbox — the code is 0493. You can use the same lockbox for check-out.`

### Translations

| Lang | Title | Wednesday note (Wednesday → whole body) |
|---|---|---|
| IT | `🔑 Check-in` | Di solito sarò a casa per accogliervi... cassaforte codice 0493 |
| DE | `🔑 Check-in` | Normalerweise bin ich zu Hause... Schlüsselsafe Code 0493 |
| ES | `🔑 Check-in` | Normalmente estaré en casa... caja de seguridad código 0493 |
| FR | `🔑 Check-in` | En général je serai à la maison... boîte à clés code 0493 |
