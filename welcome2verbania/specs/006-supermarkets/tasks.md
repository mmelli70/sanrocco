# Tasks: Supermarkets Section

**Input**: `specs/006-supermarkets/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge-favourite`, `.btn-maps`), spec 005 (same render pattern)

---

## Phase 1: Data

- [ ] T006-01 Add `CONTENT.sections.supermarkets` array (4 entries) to `index.html`:
  ```js
  CONTENT.sections.supermarkets = [
    { name: "Esselunga", description: "Best quality for fresh produce and vegetables. Meat and fish are OK. Register for the Fidaty loyalty card at the entrance desk — many discounts are only available with it.", mapsUrl: "https://g.co/kgs/nFqzzXW" },
    { name: "Tigros", description: "Easily reachable on a quick walk. Smaller but good choice, good prices and interesting promotions. Register for the loyalty card too.", mapsUrl: "https://g.co/kgs/74WugM6" },
    { name: "Colombo", description: "Best place to buy fruits. Very hidden — the local supplier for restaurants. A little more expensive than Esselunga but quality is much higher. Fruits are juicy, large choice. Absolutely the best place to buy fruits.", mapsUrl: "https://g.co/kgs/Lv4oodn", favourite: true },
    { name: "Cusio Formaggi", description: "Best place to buy cheese — only on Saturday mornings at the street market in Intra. Try the Erborinato stagionato sotto vinacce (blue cheese under grape pomace), Toma del Mottarone, Monte 27, Castelmagno, Gorgonzola, Burrata, and Guanciale. Owners are very kind and will let you taste many cheeses.", mapsUrl: "https://maps.app.goo.gl/qfxzwD8Xhu4danhe9", favourite: true, note: "Only on Saturday mornings" }
  ]
  ```
- [ ] T006-02 Add string keys to `CONTENT.strings.en`: `supermarkets_title`, `supermarkets_openMaps`, `supermarkets_favourite`

**Checkpoint**: 4 entries defined; Colombo and Cusio Formaggi marked `favourite: true`.

---

## Phase 2: Section Markup & Render

- [ ] T006-03 Add `<div class="screen" id="supermarkets" hidden>` to `index.html`; prepend `createSectionHeader('supermarkets_title')`
- [ ] T006-04 Write `renderSupermarkets()`: loop over `CONTENT.sections.supermarkets[]`, build `.card` for each:
  - Header row: name + (if `favourite`) badge
  - If `entry.note` → `<span class="badge" style="background:#FFF0CC; color:#7A5C00">{note}</span>` (Saturday-only tag)
  - Description paragraph
  - Maps button
  Call on `DOMContentLoaded`

**Checkpoint**: 4 cards render; Cusio Formaggi shows "Only on Saturday mornings" tag.

---

## Phase 3: Validation

- [ ] T006-05 All 4 cards render at 360 dp ✅
- [ ] T006-06 Colombo and Cusio Formaggi show ★ badge ✅
- [ ] T006-07 Cusio Formaggi Saturday-only note is clearly visible ✅
- [ ] T006-08 Maps links open on device ✅
- [ ] T006-09 Back button returns to home ✅

---

## Dependencies

- T006-01 and T006-02 can run in parallel
- T006-03 → T006-04
- Phase 3 depends on Phase 2
