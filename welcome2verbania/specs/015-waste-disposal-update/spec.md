# Feature Specification: Waste Disposal Text Update

**Feature Branch**: `015-waste-disposal-update`
**Created**: 2026-08-08
**Status**: IMPLEMENTED
**Input**: Update the waste disposal body text (`rules_waste_body`) in all five languages (EN/IT/DE/ES/FR) to add punctuation fixes and an important new note about the Wednesday special bags (electronic chip, household identification, no substitute bags allowed). All translations were delivered in the same release.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Reads Waste Disposal Instructions (Priority: P1)

A guest opens the House Rules section and reads the Waste Disposal card. The
Wednesday entry now clearly explains that the special bags have an electronic chip
identifying the household, and that regular plastic bags must not be substituted.

**Why this priority**: The chip/bag restriction is a practical requirement with
real consequences — using the wrong bags could result in fines or uncollected waste.

**Independent Test**: Open `index.html`, navigate to House Rules, open the Waste
Disposal card. Switch through all five languages — each Wednesday entry includes
the chip warning in the appropriate language.

**Acceptance Scenarios**:

1. **Given** the guest selects English and opens House Rules, **When** they read
   the Waste Disposal card, **Then** the Wednesday entry includes the chip warning
   and the instruction to use only the provided bags.
2. **Given** the guest switches to Italian, German, Spanish, or French, **When**
   they read the Waste Disposal card, **Then** the Wednesday entry includes the
   chip warning translated into the selected language.
3. **Given** the file is opened offline on a smartphone, **When** the guest reads
   the card, **Then** all text renders correctly with no truncation.

---

### Edge Cases

- Verify the new Wednesday text does not overflow the card on a 360 dp phone screen in any language.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The `rules_waste_body` string in all five languages (`en`, `it`, `de`,
  `es`, `fr`) MUST be updated with the chip warning for Wednesday and punctuation fixes.
- **FR-002**: No structural or visual changes to the Waste Disposal card are
  required — this is a content-only update.
- **FR-003**: The `rules_waste_title` keys MUST remain unchanged in all languages.

### Key Entities

- **`CONTENT.strings.{lang}.rules_waste_body`** — the body text for the Waste
  Disposal card in each language, starting around line 782 of `index.html`.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All five `rules_waste_body` strings include the chip warning for
  Wednesday, each in the appropriate language — verified by inspection.
- **SC-002**: The page opens and the Waste Disposal card renders correctly in all
  five languages on a mobile viewport with no visible regression.

## Assumptions

- All five languages were updated in the same release; no follow-up translation spec is needed.
- No version bump is required beyond a PATCH increment.

## Seed Content

### English (`CONTENT.strings.en.rules_waste_body`)

```
The municipality of Verbania has implemented a door-to-door waste collection system to promote effective waste management and encourage recycling among residents. This system ensures that different types of waste are collected directly from households on designated days of the week, reducing the need for centralized collection points. You need only to put the bins or the bags of the correct type outside the gate before 8:00 AM.\nAll bins can be put outside in the evening of the previous day: i.e. you can put the green bin out on Sunday evening.\nMonday: Glass - Place the glass in the green bin.\nTuesday: Organic Waste - Place the organic waste in a compostable bag and put it in the brown bin.\nWednesday: Mixed Waste - Non-recyclable waste must be placed only in the special bags found in the built-in closet in the hallway. These bags are fitted with an electronic chip that identifies our household, so please use only the bags provided and do not substitute regular plastic bags. Put the bag out only on Wednesday, the designated collection day.\nThursday: Paper & Cardboard - Place the paper in the white bin.\nFriday: Organic Waste - Place the organic waste in a compostable bag and put it in the brown bin.\nSaturday: Plastic & Metal - Place plastic waste and metals (iron and aluminum) in the yellow plastic bag.
```

### Translations

The Wednesday chip warning was translated into all supported languages with equivalent meaning:

- **IT** (`Mercoledì`): "sacchetti dotati di chip elettronico... utilizzare solo i sacchetti forniti... mettere il sacco fuori solo il mercoledì"
- **DE** (`Mittwoch`): "Beutel mit elektronischem Chip... nur bereitgestellte Beutel verwenden... nur am Mittwoch herausstellen"
- **ES** (`Miércoles`): "bolsas con chip electrónico... utilice solo las bolsas proporcionadas... saque la bolsa solo el miércoles"
- **FR** (`Mercredi`): "sacs avec puce électronique... utiliser exclusivement les sacs fournis... sortez le sac uniquement le mercredi"

### Changes from previous version

| Field | Change |
|---|---|
| Intro paragraph (EN) | Added period after `8:00 AM` |
| All-bins note (EN) | Added period after `Sunday evening` |
| Wednesday (all languages) | Explicit chip/household warning + use-only-provided-bags instruction + restrict to Wednesday only |
| All other days | Minor punctuation fixes where missing |
