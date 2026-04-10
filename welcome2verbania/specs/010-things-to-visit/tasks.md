# Tasks: Things to Visit Section

**Input**: `specs/010-things-to-visit/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge-favourite`, `.btn-maps`, `.btn-info`)

---

## Phase 1: Data

- [x] T010-01 Add `CONTENT.sections.thingsToVisit` array (11 entries) to `index.html`:
  ```js
  CONTENT.sections.thingsToVisit = [
    { name: "Borromean Islands", description: "Three iconic islands in Lake Maggiore: Isola Bella (baroque palace and gardens), Isola Madre (botanical garden), and Isola Pescatori (authentic fishing village). A must-see — book ferry tickets in advance in peak season.", infoUrl: "https://www.borromeoturismo.it" },
    { name: "Villa Taranto", description: "World-famous botanical garden in Verbania with over 20,000 plant species. Spectacular in spring during the tulip and dahlia seasons. Allow at least 2–3 hours.", infoUrl: "https://www.villataranto.it" },
    { name: "Stresa", description: "Elegant Belle Époque resort town on Lake Maggiore. Grand hotels, lakeside promenade, and cable car to Monte Mottarone. Gateway to the Borromean Islands." },
    { name: "Sacro Monte di Ghiffa", description: "UNESCO World Heritage site. A sanctuary complex on a wooded hillside with panoramic views over Lake Maggiore. Peaceful walk through chapels in the forest." },
    { name: "Baveno", description: "Charming lakeside town with pink granite quarries and beautiful lakefront. Good base for visiting the Borromean Islands — closer ferry connection." },
    { name: "Cannero Riviera", description: "Unspoilt village 15 km north of Verbania. Castle ruins on two tiny islands just offshore. Microclimate allows subtropical plants. Blue Flag beach.", favourite: true },
    { name: "Mergozzo", description: "Tiny medieval village on the shore of Lake Mergozzo — the purest lake in Italy, no motor boats allowed. Crystal-clear swimming. Very peaceful. Gelateria Aurora nearby.", favourite: true },
    { name: "Orta San Giulio", description: "One of Italy's most beautiful villages, on a peninsula jutting into Lake Orta. Car-free historic centre, Sacro Monte (UNESCO), and the island of San Giulio with its ancient basilica.", favourite: true },
    { name: "Valle Vigezzo", description: "The 'Valley of Painters' — a scenic Alpine valley connecting to Switzerland. Charming villages, hiking, and the historic Vigezzina-Centovalli railway (one of Europe's most scenic routes).", infoUrl: "https://www.vigezzina.com" },
    { name: "Valle Formazza", description: "Dramatic Alpine valley north of Verbania leading to the Cascata del Toce — one of Europe's highest waterfalls (at full flow in summer). Walser villages and excellent hiking." },
    { name: "Valle Verzasca (Switzerland)", description: "Just over the Swiss border — stunning turquoise river in a deep gorge. The famous Verzasca Dam (GoldenEye bungee jump site). Crystal-clear water for swimming and snorkelling.", infoUrl: "https://www.valleverzasca.ch" }
  ]
  ```
- [x] T010-02 Add string keys to `CONTENT.strings.en`: `visit_title`, `visit_openMaps`, `visit_moreInfo`, `visit_favourite`

**Checkpoint**: 11 entries defined; 3 marked `favourite: true`; 4 have `infoUrl`.

---

## Phase 2: Section Markup & Render

- [x] T010-03 Add `<div class="screen" id="things-to-visit" hidden>` to `index.html`; prepend `createSectionHeader('visit_title')`
- [x] T010-04 Write `renderThingsToVisit()`: loop over array, build `.card`:
  - Header: name + (if `favourite`) badge
  - Description paragraph
  - Action row: Maps button + (if `infoUrl`) `.btn-info` "More info" button
  Call on `DOMContentLoaded`

**Checkpoint**: 11 cards render; starred entries show badge; entries with infoUrl show 2 buttons.

---

## Phase 3: Validation

- [x] T010-05 All 11 cards render at 360 dp; 2-button action rows fit without overflow ✅
- [x] T010-06 3 starred entries show ★ badge ✅
- [x] T010-07 infoUrl entries show "More info" button ✅
- [x] T010-08 All Maps and info links open on device ✅
- [x] T010-09 Back button returns to home ✅

---

## Dependencies

- T010-01 and T010-02 can run in parallel
- T010-03 → T010-04
- Phase 3 depends on Phase 2
- Reuses `renderFavouriteBadge()` from spec 004

---

## Additional Tasks (Implemented but not originally planned)

- [x] T010-NEW Replace `mapsUrl` with `infoUrl` in data schema; add `it` and `de` description fields to each entry
