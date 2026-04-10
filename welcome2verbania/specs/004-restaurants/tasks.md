# Tasks: Restaurants Section

**Input**: `specs/004-restaurants/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge-favourite`, `.btn-maps`)

---

## Phase 1: Data

- [ ] T004-01 Add `CONTENT.sections.restaurants` array (11 entries) to `index.html`:
  ```js
  CONTENT.sections.restaurants = [
    { name: "Dalì", description: "Located in the old embarcadero. Perfect for breakfast, aperitivo or pizza. Main dishes are good but other restaurants are preferred.", mapsUrl: "https://g.co/kgs/MsXgfzD" },
    { name: "La Casera", description: "Super foodie. High quality, a little pricey. Very good cheese, affettati and wine. A must for an aperitivo!", mapsUrl: "https://g.co/kgs/K4gpVGi" },
    { name: "Osteria del Castello", description: "In Piazza Castello with a nice pergola for outdoor dining. Historical osteria with good food and wine selection. Reserve in advance!", mapsUrl: "https://g.co/kgs/YBBz5QV" },
    { name: "L'Alchimista", description: "Very good pizzeria. Contemporanea style with large cornicione. Excellent pizza.", mapsUrl: "https://g.co/kgs/k7R4zea" },
    { name: "Gattabuia", description: "Community canteen supporting social integration. Lunch fixed price €10.50. Evening: best pizza in Verbania, very cheap — book well in advance. Sit outside (inside is noisy).", mapsUrl: "https://g.co/kgs/wRwwzoX" },
    { name: "Damm'a Traa", description: "In Suna. Generous portions of local cuisine at great prices. Excellent food in a beautiful setting with lake views.", mapsUrl: "https://g.co/kgs/hCBG59e" },
    { name: "Estremadura", description: "Perfect for cocktails and gin tonics. Loved by young people. Dramatic cocktail list. Drinks are not cheap.", mapsUrl: "https://g.co/kgs/b5xugtA" },
    { name: "Donna Francesca", description: "In Cossogno. Cozy rustic osteria with hearty homemade Italian cuisine using local seasonal ingredients. All dishes excellent, prices reasonable. Request a table outside. Book in advance, especially weekends.", mapsUrl: "https://g.co/kgs/cYiBsFk", favourite: true },
    { name: "Cantina Leonardo", description: "In Mergozzo, on the lakeshore with a stunning view of Lake Mergozzo. Good pizzas and food, superb location. Highly recommended — prices reasonable especially at sunset.", mapsUrl: "https://g.co/kgs/aqLci7Y", favourite: true },
    { name: "L'Imbarcadero (Isola Pescatori)", description: "On Isola Superiore (Borromean Islands). Very good, reasonable price, nice view. Slightly better food than La Pescheria.", mapsUrl: "https://maps.app.goo.gl/mW5Knm882zSTd33NA" },
    { name: "La Pescheria (Isola Pescatori)", description: "On Isola Superiore (Borromean Islands). Very good, reasonable price. Better location under the pergola. Perfect for dining al fresco.", mapsUrl: "https://maps.app.goo.gl/mW5Knm882zSTd33NA", favourite: true },
    { name: "La Terrazza", description: "One of the best locations on the lake. Outstanding pizza, very good food overall, very reasonable prices. Highly recommended.", mapsUrl: "https://maps.app.goo.gl/LNbFp2L1VceG2uC78", favourite: true }
  ]
  ```
- [ ] T004-02 Add string keys to `CONTENT.strings.en`: `restaurants_title`, `restaurants_openMaps`, `restaurants_favourite`

**Checkpoint**: Array of 12 entries defined; 4 marked `favourite: true`.

---

## Phase 2: Shared Render Helpers

**Purpose**: Favourite badge helper will be reused by Gelaterie (spec 009).

- [ ] T004-05 [P] Write `renderFavouriteBadge(label)` JS helper: returns `<span class="badge badge-favourite">★ {label}</span>` or empty string if not favourite

**Checkpoint**: Call each helper in browser console — correct HTML output.

---

## Phase 3: Section Markup & Render

- [ ] T004-06 Add `<div class="screen" id="restaurants" hidden>` to `index.html`; prepend `createSectionHeader('restaurants_title')`
- [ ] T004-07 Write `renderRestaurants()`: loop over `CONTENT.sections.restaurants[]`, for each entry build a `.card`:
  - Card header row: name + (if `favourite`) badge from `renderFavouriteBadge()`
  - Description paragraph
  - Maps button: `<a class="btn btn-maps" href="{mapsUrl}" target="_blank">🗺 openMaps</a>`
- [ ] T004-08 Call `renderRestaurants()` on `DOMContentLoaded`

**Checkpoint**: 12 cards render; 4 starred entries show badge; Maps links work.

---

## Phase 4: Validation

- [ ] T004-09 All 12 cards render at 360 dp without overflow ✅
- [ ] T004-10 Donna Francesca, Cantina Leonardo, La Pescheria, La Terrazza show ★ favourite badge ✅
- [ ] T004-12 Maps links open on device ✅
- [ ] T004-13 Back button returns to home ✅

---

## Dependencies

- T004-01 and T004-02 can run in parallel
- T004-05 is an independent helper
- T004-06 → T004-07 → T004-08
- Phase 4 depends on Phase 3
