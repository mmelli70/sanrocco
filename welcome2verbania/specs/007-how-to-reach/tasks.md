# Tasks: How to Reach Us

**Input**: `specs/007-how-to-reach/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.warning-box`, `.card`, `.btn-maps`), spec 001 `build.sh`

---

## Phase 1: Data & Strings

- [ ] T007-01 Add string keys to `CONTENT.strings.en` (+ `it`/`de` placeholders):
  - `reach_title` — "How to Reach Us"
  - `reach_ztl_title` — "⚠️ ZTL — Restricted Traffic Zone"
  - `reach_ztl_body` — full ZTL warning text from spec seed: camera system, access hours 08:00–12:30 and 14:30–20:00, GREEN = enter, RED = do not enter, no parking in Piazza San Rocco
  - `reach_house_title` — "Reaching the Apartment"
  - `reach_house_body` — full reach-the-house directions from spec seed (gate at number 2, bell MELLI, stairs, close gate)
  - `reach_parking_title` — "Parking"
  - `reach_openMaps` — "Open in Maps"
- [ ] T007-02 Add `CONTENT.sections.parking` array to `index.html`:
  ```js
  CONTENT.sections.parking = [
    { name: "Via Brigata Cesare Battisti",
      description: "Close to the river — always free. The square near the river is partially free and partially with a maximum allowed time.",
      mapsUrl: "https://maps.app.goo.gl/F9z5cLR5GGD1kumg9" },
    { name: "Largo degli Invalidi del Lavoro",
      description: "Pay parking very close to the house. Perfect for a short stay.",
      mapsUrl: "https://maps.app.goo.gl/VWoqszTRxdSu42Ao6" }
  ]
  ```

**Checkpoint**: All string keys and parking data defined.

---

## Phase 2: Section Markup

- [ ] T007-03 Add `<div class="screen" id="how-to-reach" hidden>` to `index.html`; prepend `createSectionHeader('reach_title')`
- [ ] T007-04 Write `renderHowToReach()`:
  - **ZTL sub-section**: `.warning-box` with title + body text; inside, `<img src="{{ZTL_SIGN}}" alt="ZTL sign" style="max-width:180px; display:block; margin: 0.75rem auto 0">` — token replaced by `build.sh`
  - **Reach the House sub-section**: `<h3>` + prose text + 3 `<img>` tags with tokens `{{DOOR_PHOTO_1}}`, `{{DOOR_PHOTO_2}}`, `{{DOOR_PHOTO_3}}` (full-width, `style="width:100%; border-radius: var(--radius); margin-bottom: 0.75rem"`)
  - **Parking sub-section**: `<h3>` + render loop over `CONTENT.sections.parking[]` — `.card` with name, description, Maps button
- [ ] T007-05 Call `renderHowToReach()` on `DOMContentLoaded`

**Checkpoint**: Section renders with placeholder image tokens; text sub-sections visible.

---

## Phase 3: build.sh — Image Injection

- [ ] T007-06 Extend `build.sh` to inject ZTL sign: `base64 -i assets/ztl-sign.png` → replace `{{ZTL_SIGN}}` with `data:image/png;base64,{encoded}` in `index.html`
- [ ] T007-07 [P] Extend `build.sh` to inject door photos: `base64 -i assets/door1.jpg` → `{{DOOR_PHOTO_1}}`; repeat for door2 and door3 (JPEG → `data:image/jpeg;base64,`)
- [ ] T007-08 Consider optimising `ztl-sign.png` before injection: resize to max 400 px width using `sips` (macOS) or `convert` (ImageMagick) to reduce base64 payload; document chosen approach in `build.sh` comments

**Checkpoint**: Run `build.sh` — open `index.html` — ZTL sign and 3 door photos render correctly.

---

## Phase 4: Validation

- [ ] T007-09 ZTL warning box is visually prominent (amber/gold style) — impossible to miss ✅
- [ ] T007-10 ZTL sign image renders at ~180 px width inside the warning box ✅
- [ ] T007-11 3 door photos render full-width in sequence ✅
- [ ] T007-12 Both parking cards render with Maps buttons ✅
- [ ] T007-13 Maps links for both parking entries open Google Maps ✅
- [ ] T007-14 Back button returns to home ✅
- [ ] T007-15 Section works with airplane mode (images are embedded) ✅

---

## Dependencies

- T007-01 and T007-02 can run in parallel
- T007-03 → T007-04 → T007-05
- T007-06 and T007-07 can run in parallel; T007-08 should precede T007-06 if optimisation is done
- Phase 4 depends on Phase 3 (images must be injected for full validation)
