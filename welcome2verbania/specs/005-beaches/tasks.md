# Tasks: Beaches Section

**Input**: `specs/005-beaches/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge-favourite`, `.btn-maps`)

---

## Phase 1: Data

- [ ] T005-01 Add `CONTENT.sections.beaches` array (6 entries) to `index.html`:
  ```js
  CONTENT.sections.beaches = [
    { name: "Teatro Maggiore", description: "Most convenient beach — under 10 minutes walk from the house. Sandy and pebble beach with large grassy area at the Il Maggiore Events Centre. Free access with sun lounger/umbrella rentals and a bar.", mapsUrl: "https://maps.app.goo.gl/5iFGesixXWEY6XqM9" },
    { name: "Spiaggia di Suna", description: "Recently renovated public beach in Verbania. Free access with concrete steps to a small pebble beach. Disabled access. Authentic and uncommercial. Parking can be challenging in peak season — arrive early.", mapsUrl: "https://maps.app.goo.gl/DUPcYcDEEwEyiaQ26" },
    { name: "Tre Ponti", description: "Relatively new beach with fresh facilities and modern amenities. Located 1.6 miles from Verbania centre with parking nearby. Arrive early in summer — limited spaces fill up quickly.", mapsUrl: "https://maps.app.goo.gl/yRziXxgh8PnZQrYG6" },
    { name: "Canneto", description: "Hidden gem between Fondotoce and Feriolo inside the Special Nature Reserve of the Fondotoce Reed beds. Small secluded beach via a short walk through riparian woods. Views of the Borromean Gulf. No facilities — bring water and snacks.", mapsUrl: "https://maps.app.goo.gl/PTKs3YCRaHrjfLp18" },
    { name: "Quartina e Lido (Mergozzo)", description: "Beautiful beach on the pristine waters of Lake Mergozzo. Crystal-clear swimming. Gets crowded — arrive before 10:30 AM. Parking €10/day but fills quickly. Lake Mergozzo is small and very clear.", mapsUrl: "https://maps.app.goo.gl/6wiNUuzM8xJJZz9h6" },
    { name: "Cannero Riviera", description: "15 minutes from the Swiss border. Wide, well-organised Blue Flag certified beach in a naturally protected bay. Crystal-clear waters. Floating water platform anchored offshore in summer — ideal for diving and jumping.", mapsUrl: "https://maps.app.goo.gl/pcbsKW1iPUyjayn29", favourite: true }
  ]
  ```
- [ ] T005-02 Add string keys to `CONTENT.strings.en`: `beaches_title`, `beaches_openMaps`, `beaches_favourite`

**Checkpoint**: 6 entries defined; Cannero Riviera marked `favourite: true`.

---

## Phase 2: Section Markup & Render

- [ ] T005-03 Add `<div class="screen" id="beaches" hidden>` to `index.html`; prepend `createSectionHeader('beaches_title')`
- [ ] T005-04 Write `renderBeaches()`: loop over `CONTENT.sections.beaches[]`, for each entry build a `.card`:
  - Card header row: name + (if `favourite`) `renderFavouriteBadge()` from spec 004
  - Description paragraph
  - Maps button
  Append all cards to section container; call on `DOMContentLoaded`

**Checkpoint**: 6 cards render; Cannero Riviera shows ★ badge.

---

## Phase 3: Validation

- [ ] T005-05 All 6 cards render at 360 dp; long descriptions wrap cleanly ✅
- [ ] T005-06 Cannero Riviera shows ★ favourite badge ✅
- [ ] T005-07 All Maps links open on device ✅
- [ ] T005-08 Back button returns to home ✅

---

## Dependencies

- T005-01 and T005-02 can run in parallel
- T005-03 → T005-04
- Phase 3 depends on Phase 2
- Reuses `renderFavouriteBadge()` from T004-05 — must be done first
