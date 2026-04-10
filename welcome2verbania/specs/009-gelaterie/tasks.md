# Tasks: Gelaterie Section

**Input**: `specs/009-gelaterie/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge-favourite`), spec 004 (`renderFavouriteBadge()`)

---

## Phase 1: Data

- [x] T009-01 Add `CONTENT.sections.gelaterie` array (4 entries) to `index.html`:
  ```js
  CONTENT.sections.gelaterie = [
    { name: "Gelato d'Altri Tempi", description: "Best gelateria in Verbania. Very good quality — try pistacchio, nocciola, marron glacé and all cream flavours. Portions could be a little more generous.", mapsUrl: "https://maps.app.goo.gl/5ebF1SE2WgoPop9y9" },
    { name: "Gelatomania", description: "Second best gelateria. You must try the Tiramisù.", mapsUrl: "https://maps.app.goo.gl/9pGWiMNAo2TMamyj6" },
    { name: "K2 (Pallanza)", description: "Very good gelateria in Pallanza — excellent for both creams and fruits. The best in Pallanza.", mapsUrl: "https://maps.app.goo.gl/1XdBDSuKwYC3sjvX7" },
    { name: "Gelateria Aurora (Mergozzo/Candoglia)", description: "A little far — in Candoglia near Mergozzo, but it deserves a detour. Best gelato especially for fruits: Macedonia, mango and raspberries. Large quantity, small price. Try the large cups served at the tables. 'Giant, good and at a very fair price.'", mapsUrl: "https://g.co/kgs/p6wfSfF", favourite: true }
  ]
  ```
- [x] T009-02 Add string keys to `CONTENT.strings.en`: `gelaterie_title`, `gelaterie_openMaps`, `gelaterie_favourite`

**Checkpoint**: 4 entries defined; Gelateria Aurora marked `favourite: true`.

---

## Phase 2: Section Markup & Render

- [x] T009-03 Add `<div class="screen" id="gelaterie" hidden>` to `index.html`; prepend `createSectionHeader('gelaterie_title')`
- [x] T009-04 Write `renderGelaterie()`: same pattern as `renderRestaurants()` from spec 004 — reuse `renderFavouriteBadge()`. Call on `DOMContentLoaded`.

**Checkpoint**: 4 cards render with Maps button; Aurora shows ★ badge.

---

## Phase 3: Validation

- [x] T009-05 All 4 cards render at 360 dp ✅
- [x] T009-06 Gelateria Aurora shows ★ favourite badge ✅
- [x] T009-08 Maps links open on device ✅
- [x] T009-09 Back button returns to home ✅

---

## Dependencies

- T009-01 and T009-02 can run in parallel
- T009-03 → T009-04
- `renderFavouriteBadge()` from spec 004 must be implemented first

---

## Additional Tasks (Implemented but not originally planned)

- [x] T009-NEW Add Italian and German description fields (`it`, `de`) to each gelateria entry
