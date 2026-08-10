# Feature Specification: Waste Collection Calendar Image

**Feature Branch**: `016-waste-calendar-image`
**Created**: 2026-08-08
**Status**: IMPLEMENTED
**Input**: Add the municipal waste collection calendar (July–September) as an embedded image immediately after the Waste Disposal card in the House Rules section. English-only in this update; other languages to follow.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Views the Waste Calendar (Priority: P1)

A guest opens the House Rules section, reads the Waste Disposal instructions, and
immediately below sees the official municipal waste collection calendar for
July–September showing which bin to put out on each day.

**Why this priority**: The calendar is a concrete daily reference that complements
the written instructions — without it, guests must remember the schedule from text alone.

**Independent Test**: Open `index.html`, select English, navigate to House Rules.
After the Waste Disposal card, a calendar image is displayed at full container
width. The image is legible on a 360 dp phone screen (pinch-to-zoom if needed).
The page loads fully offline.

**Acceptance Scenarios**:

1. **Given** the guest is on the House Rules screen in English, **When** they scroll
   past the Waste Disposal card, **Then** the waste calendar image is visible
   immediately below.
2. **Given** the device has no internet connection, **When** the guest opens the
   file, **Then** the calendar image loads from the embedded base64 data URI
   without any network request.
3. **Given** the guest switches to Italian, German, Spanish, or French, **When**
   they view House Rules, **Then** the calendar image appears in the same position
   (language-independent visual; text on the calendar is in Italian which is fine
   as it is the official municipal document).

---

### Edge Cases

- On very narrow screens (320 dp), the image must not overflow the card container.
- The image must not break the page scroll or push other cards out of alignment.
- A long-press on mobile may trigger browser's native image save — acceptable.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The waste calendar image MUST be embedded as a base64 JPEG data URI
  inside `index.html` — no external `src` reference.
- **FR-002**: The image MUST be displayed in a card (`.info-box`) immediately after
  the Waste Disposal text card in the `renderHouseRules` function.
- **FR-003**: The image MUST be rendered with `width: 100%` so it fills the card
  container on all screen sizes.
- **FR-004**: The image MUST have a descriptive `alt` attribute for accessibility.
- **FR-005**: The calendar card is language-independent — it appears for all
  languages using the same image.
- **FR-006**: The source image is resized to max 1400 px wide and encoded as JPEG
  at 80% quality before embedding (~430 KB / ~590 KB base64) to keep the file
  size reasonable.

### Key Entities

- **`renderHouseRules()`** (around line 1529 of `index.html`) — the function that
  builds the House Rules screen. The calendar image card must be appended after
  the `ruleBlocks` join, before the WiFi block.
- **`WASTE_CALENDAR_B64`** — a `const` holding the base64 JPEG data URI, defined
  at the top of the inline `<script>` block alongside other constants.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The calendar image renders correctly below the Waste Disposal card on
  a 360 dp phone viewport in portrait mode.
- **SC-002**: No network request is made when the image loads — verified by
  opening the file from a local filesystem with network disabled.
- **SC-003**: The `.info-box` card containing the image aligns with the other cards
  in the section — same margins, same border-radius.
- **SC-004**: Switching language does not hide or duplicate the image.

## Assumptions

- The calendar image is the official municipal waste schedule for July–September
  of the current season. It will need to be replaced each year with an updated version.
- The image text is in Italian (the official language of the document); no
  translation overlay is required.
- Pinch-to-zoom is the expected interaction for guests who want to read fine detail
  on a small screen.
- A `const` is used rather than storing the base64 in `CONTENT` because the image
  is not language-keyed and is not a user-editable content string.

## Implementation Notes

- Store the JPEG base64 string in a `const WASTE_CALENDAR_B64 = 'data:image/jpeg;base64,...'`
  near the top of the `<script>` block (after existing image constants, if any).
- In `renderHouseRules`, after `ruleBlocks`, append:

```js
const calendarBlock = `<div class="info-box" style="padding:8px;">
  <img src="${WASTE_CALENDAR_B64}" style="width:100%;border-radius:6px;display:block;"
       alt="Waste collection calendar July–September">
</div>`;
```

- Set `el.innerHTML` to include `calendarBlock` between `ruleBlocks` and the WiFi block.
