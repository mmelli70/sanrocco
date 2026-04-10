# Tasks: Adrenaline Attractions Section

**Input**: `specs/011-adrenaline/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge-favourite`, `.btn-maps`, `.btn-info`), spec 010 (same render pattern)

---

## Phase 1: Data

- [x] T011-01 Add `CONTENT.sections.adrenaline` array (3 entries) to `index.html`:
  ```js
  CONTENT.sections.adrenaline = [
    { name: "Lake Maggiore Zipline", description: "One of the longest ziplines in Europe, flying over Lake Maggiore with spectacular views. A truly unique adrenaline experience above the water.", infoUrl: "https://www.ziplinelakemaggiore.it", favourite: true },
    { name: "Acquadventure Park", description: "Water park on Lake Maggiore with slides, pools, and attractions for all ages. Great for families and thrill-seekers alike. Book tickets online for best prices.", infoUrl: "https://www.acquadventure.it" },
    { name: "Alpyland Mottarone", description: "Alpine coaster (luge on rails) on Monte Mottarone above Stresa. Reach the top by cable car from Stresa and ride the track down through the forest. Fun for adults and children.", infoUrl: "https://www.alpyland.com" }
  ]
  ```
- [x] T011-02 Add string keys to `CONTENT.strings.en`: `adrenaline_title`, `adrenaline_openMaps`, `adrenaline_moreInfo`, `adrenaline_favourite`

**Checkpoint**: 3 entries defined; Zipline marked `favourite: true`; all 3 have `infoUrl`.

---

## Phase 2: Section Markup & Render

- [x] T011-03 Add `<div class="screen" id="adrenaline" hidden>` to `index.html`; prepend `createSectionHeader('adrenaline_title')`
- [x] T011-04 Write `renderAdrenaline()`: reuse same render pattern as `renderThingsToVisit()` from spec 010 — `.card` with name, badge, description, Maps + info buttons. Call on `DOMContentLoaded`.

**Checkpoint**: 3 cards render; Zipline shows ★ badge; all 3 have 2 action buttons.

---

## Phase 3: Validation

- [x] T011-05 All 3 cards render at 360 dp ✅
- [x] T011-06 Zipline shows ★ favourite badge ✅
- [x] T011-07 All Maps and info links open on device ✅
- [x] T011-08 Back button returns to home ✅

---

## Dependencies

- T011-01 and T011-02 can run in parallel
- T011-03 → T011-04
- Reuses render pattern from spec 010 — implement spec 010 first

---

## Additional Tasks (Implemented but not originally planned)

- [x] T011-NEW Replace `mapsUrl` with `infoUrl` in data schema; add `it` and `de` description fields to each entry
