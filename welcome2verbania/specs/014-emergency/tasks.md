# Tasks: Emergency Section

**Input**: `specs/014-emergency/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.emergency-card`, `.emergency-card--primary`, `.btn-maps`)

---

## Phase 1: Data

- [x] T014-01 In `index.html` `<script>` block, add `CONTENT.sections.emergency` array (7 entries):
  ```js
  CONTENT.sections.emergency = [
    { name: "112 — Single Emergency Number", number: "112",
      description: "The single European emergency number for ALL emergencies in Italy: police, ambulance, and fire brigade. Free call — works without credit or SIM card, even with no signal. Operators speak multiple languages.", primary: true },
    { name: "118 — Ambulance & Medical Emergency", number: "118",
      description: "Dedicated Italian ambulance and medical emergency line. Free call." },
    { name: "113 — Police (Polizia di Stato)", number: "113",
      description: "Italian state police emergency line. For theft, assault, public order incidents. Free call." },
    { name: "115 — Fire Brigade (Vigili del Fuoco)", number: "115",
      description: "Italian fire brigade. For fires, flooding, structural collapses. Free call." },
    { name: "Ospedale Castelli — DEA Verbania", number: "0323 541111",
      description: "Nearest hospital. DEA = Italian A&E/Emergency Room. For life-threatening emergencies call 118 or 112 first. Go directly to DEA for urgent non-life-threatening situations.",
      address: "Via Crocetta, 1, 28922 Pallanza VB",
      mapsUrl: "https://maps.app.goo.gl/CkoTPrXedQsYcgEP9" },
    { name: "Farmacia San Giorgio", number: "0323 401355",
      description: "Open Sundays — closed Mondays.",
      address: "Corso Goffredo Mameli, 141, 28921 Verbania VB",
      mapsUrl: "https://maps.app.goo.gl/bHsu9fh8UvaoWdm28" },
    { name: "Farmacia Nava", number: "0323 519181",
      address: "Piazza Giacomo Matteotti, 25, 28921 Verbania VB",
      mapsUrl: "https://maps.app.goo.gl/WDfzTyRQtEQqBtJW6" }
  ]
  ```
- [x] T014-02 Add string keys to `CONTENT.strings.en`: `emergency_title`, `emergency_intro`, `emergency_openMaps`
  - `emergency_intro`: full "How 112 works in Italy" text from spec seed content

**Checkpoint**: Array and string keys defined.

---

## Phase 2: Section Markup & Render

- [x] T014-03 Add `<div class="screen" id="emergency" hidden>` to `index.html`; prepend `createSectionHeader('emergency_title')`
- [x] T014-04 Write `renderEmergency()` in JS:
  - Render intro text as `.info-box` above the cards
  - Loop over `CONTENT.sections.emergency[]`
  - If `entry.primary === true` → `<div class="emergency-card emergency-card--primary">`; else `<div class="emergency-card">`
  - Card content: entry name, description (if present), `<a class="emergency-number" href="tel:{number_normalised}">{number}</a>` (strip spaces for href)
  - If `entry.address` → small address line below number
  - If `entry.mapsUrl` → `<a class="btn btn-maps" href="{mapsUrl}" target="_blank">` using `emergency_openMaps` label
- [x] T014-05 Call `renderEmergency()` on `DOMContentLoaded`

**Checkpoint**: 7 cards render; 112 uses primary variant; hospital and pharmacies show Maps button.

---

## Phase 3: Validation

- [x] T014-06 112 is first and visually most prominent on 360 dp ✅
- [x] T014-07 Tap all 7 numbers → correct dialler pre-fill on real device ✅
- [x] T014-08 Tap Maps links for hospital and pharmacies → Google Maps opens ✅
- [x] T014-09 Airplane mode: all 7 cards readable, no broken elements ✅
- [x] T014-10 Back button returns to home ✅

---

## Dependencies

- T014-01 and T014-02 can run in parallel
- T014-03 → T014-04 → T014-05 (markup → render → call)
- Phase 3 depends on Phase 2

---

## Additional Tasks (Implemented but not originally planned)

- [x] T014-NEW Add `name_it`, `name_de`, `it`, `de` fields to all 7 emergency entries — fully translated to Italian and German (critical safety information)
