# Tasks: House Rules

**Input**: `specs/008-house-rules/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.info-box`, `.warning-box`)

---

## Phase 1: Data & Strings

- [x] T008-01 Add all 8 sub-section string keys to `CONTENT.strings.en` (+ `it`/`de` placeholders):
  - `rules_title`
  - `rules_checkin_title`, `rules_checkin_body` — Check-in 15:00–20:00; check-out by 10:00; late check-out by arrangement
  - `rules_smoking_title`, `rules_smoking_body` — No smoking anywhere inside; smoking permitted on the terrace
  - `rules_citytax_title`, `rules_citytax_body` — €2/person/night; paid in cash at check-in; exempt under 12
  - `rules_wifi_title`, `rules_wifi_ssid`, `rules_wifi_password` — SSID: melli-fibra; Password: 04930493
  - `rules_kitchen_title`, `rules_kitchen_body` — Dishwasher caution: do not use the "Eco" programme; it uses very hot water and may damage plastic items
  - `rules_jacuzzi_title`, `rules_jacuzzi_body` — Jacuzzi instructions: fill level, temperature, cleaning tablet after use
  - `rules_aircon_title`, `rules_aircon_body` — A/C usage: turn off when leaving; clean filter monthly; set max 22°C
  - `rules_waste_title`, `rules_waste_body` — Waste disposal placeholder (details to follow in May)

**Checkpoint**: All 8 sub-section string key groups present in `CONTENT.strings.en`.

---

## Phase 2: Section Markup

- [x] T008-02 Add `<div class="screen" id="house-rules" hidden>` to `index.html`; prepend `createSectionHeader('rules_title')`
- [x] T008-03 Write `renderHouseRules()`: render 8 sub-sections in order. Each sub-section: `<h3 data-i18n="{title_key}">` + appropriate component:
  - Check-In/Out → `.info-box`
  - Smoking → `.info-box`
  - City Tax → `.info-box`
  - WiFi → `.info-box` with SSID and password in `<code>` or visually distinct span
  - Kitchen → `.warning-box` (dishwasher caution)
  - Jacuzzi → `.warning-box` (caution)
  - Air Conditioning → `.info-box`
  - Waste → `.info-box` (placeholder text)
- [x] T008-04 Call `renderHouseRules()` on `DOMContentLoaded`

**Checkpoint**: 8 sub-sections render with correct component styles (warning boxes visually distinct).

---

## Phase 3: Validation

- [x] T008-05 All 8 sub-sections readable at 360 dp without horizontal overflow ✅
- [x] T008-06 WiFi SSID `melli-fibra` and password `04930493` readable at a glance ✅
- [x] T008-07 Kitchen and Jacuzzi warning boxes use amber/gold `.warning-box` style (not blue `.info-box`) ✅
- [x] T008-08 Back button returns to home ✅

---

## Dependencies

- T008-01 runs first
- T008-02 → T008-03 → T008-04
- Phase 3 depends on Phase 2

---

## Additional Tasks (Implemented — no unplanned additions for this spec)
