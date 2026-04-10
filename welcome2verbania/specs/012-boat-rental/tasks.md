# Tasks: Boat Rental Section

**Input**: `specs/012-boat-rental/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.card`, `.badge`, `.info-box`, `.btn`)

---

## Phase 1: Data

- [x] T012-01 Add `CONTENT.sections.boatRental` array (6 operators) to `index.html`:
  ```js
  CONTENT.sections.boatRental = [
    {
      name: "Lago Charter (Feriolo)",
      website: "https://www.lago-charter.com",
      location: "Feriolo",
      contact: { person: "Holger Brozio", mobile: "+49 151 65 63 46 83" },
      fleet: [
        "Bayliner 180 XL (40 HP): €220/day",
        "Stingray (220 HP): €240/day — licence required",
        "Bayliner 2050 & Stingray: €220–240/day, €1,440–1,580/week",
        "Maxum 2300 SC (7.35m, 260 HP): €290/day, €1,930/week"
      ],
      notes: [
        "Parking: available except Thursdays (market day)",
        "Online availability check and reservation system",
        "Fully booked in August — book 2–4 days in advance",
        "No water skiing/wakeboarding officially (Z-drive)"
      ],
      review: "Good value for money. Boat was 25 years old but powerful V8. Water skis and wakeboard can be loaded at Intra harbour (guest berths up to 6 hours)."
    },
    {
      name: "Rent Boat Lago Maggiore",
      website: "https://www.rentboatlagomaggiore.com",
      location: "Via Carlo Alberto dalla Chiesa, 6, Verbania (VB) 28921",
      contact: { email: "info@rentboatlagomaggiore.com", phone: "+39 0323 404544", mobile: "+39 0323 062000", whatsapp: "393316687251" },
      fleet: [
        "40 HP boats: Compass Boat Blue 190 CC — €275/day (€235/205 half-day)",
        "115 HP boats: from €300 half-day",
        "Stingray: €620/day"
      ],
      review: "Excellent condition boats (~2 years old). Modern 40HP outboards with great performance. More expensive but excellent service. Very fuel-efficient — only €20 fuel for 8 hours. Water skiing and wakeboarding worked perfectly with 3 people."
    },
    {
      name: "Cantiere di Ghiffa Boat Service",
      location: "Very close — 5 minutes by car from Pallanza",
      contact: { person: "Michele", mobile: "+39 346 373 5367" },
      fleet: [
        "40 HP (no licence required): €220/day + €25 fuel"
      ],
      notes: [
        "Book by phone, on-site, or via clickandboat.com",
        "Also rents moorings for multi-day periods"
      ],
      review: "Michele is reliable and accommodating. Budget-friendly with older boats (~25 years). No objection to water skiing; somewhat underpowered for wakeboarding."
    },
    {
      name: "Marina di Pallanza",
      website: "https://www.marinadipallanza.com/rent-boat-lake-maggiore",
      location: "Corso Vittorio Tonolli, 17, 28922 Verbania VB",
      fleet: ["Many 40 HP boats available"],
      notTested: true
    },
    {
      name: "Rent Boat Cannobio",
      website: "https://www.rentboatcannobio.com",
      location: "Cannobio (23 km / 30 min from Pallanza)",
      fleet: [
        "Standard boats: 2/3/4 h — €110/140/170",
        "Newer boats: 2/3/4 h — €130/160/190",
        "Eden 18: 2/3/4 h — €150/180/210"
      ],
      notTested: true
    },
    {
      name: "Feriolo Sporting Club",
      website: "https://feriolosportingclub.it",
      contact: {},
      fleet: ["Professional water ski boat with certified instructor"],
      notes: [
        "Rate: €3.00 per minute",
        "Services: water skiing, wakeboarding, wakesurfing (no rope!)",
        "Our son learned wakesurfing in just 40 minutes"
      ],
      review: "Expensive but worth every euro. Professional boat with excellent wake. Instructor highly skilled and friendly."
    }
  ]
  ```
- [x] T012-02 Add string keys to `CONTENT.strings.en`: `boat_title`, `boat_attribution`, `boat_notTested`, `boat_fleet`, `boat_notes`, `boat_review`, `boat_website`, `boat_tipsTitle`, `boat_tipsFuel`, `boat_tipsWater`, `boat_tipsBooking`
  - `boat_attribution`: "Written by a guest — thank you, Philipp!"
  - `boat_tipsTitle`: "General Tips for Lake Maggiore Boat Rentals"
  - `boat_tipsFuel`: full fuel costs text from spec seed
  - `boat_tipsWater`: full water sports tips from spec seed
  - `boat_tipsBooking`: full booking advice from spec seed

**Checkpoint**: 6 operators and all string keys defined.

---

## Phase 2: Section Markup & Render

- [x] T012-03 Add `<div class="screen" id="boat-rental" hidden>` to `index.html`; prepend `createSectionHeader('boat_title')`
- [x] T012-04 Write `renderBoatRental()`:
  - Attribution banner: `.info-box` with `boat_attribution` text
  - Loop over `CONTENT.sections.boatRental[]`, for each operator render a `.card`:
    - Header: operator name + (if `notTested`) `<span class="badge badge-not-tested">Not personally tested</span>`
    - If `contact.person` → name line
    - Contact links: `tel:` for phone/mobile, `wa.me` for whatsapp, `<a href=website>` for website
    - If `fleet` array → `<h4>` + `<ul>` bullet list
    - If `notes` array → `<ul>` bullet list
    - If `review` → italic `<p class="review">`
  - After operators: General Tips sub-section (3 paragraphs with sub-headings)
  Call on `DOMContentLoaded`

**Checkpoint**: 6 operator cards render; Marina di Pallanza and Rent Boat Cannobio show "Not personally tested" badge; General Tips section visible at the bottom.

---

## Phase 3: Validation

- [x] T012-05 All 6 operator cards render at 360 dp without overflow ✅
- [x] T012-06 "Not tested" badge appears on Marina di Pallanza and Rent Boat Cannobio ✅
- [x] T012-07 Phone/mobile tap-to-call links work on device ✅
- [x] T012-08 WhatsApp link for Rent Boat Lago Maggiore opens WhatsApp ✅
- [x] T012-09 Website links open in browser ✅
- [x] T012-10 General Tips section visible after all 6 operators ✅
- [x] T012-11 Attribution banner visible at top of section ✅
- [x] T012-12 Back button returns to home ✅

---

## Dependencies

- T012-01 and T012-02 can run in parallel
- T012-03 → T012-04
- Phase 3 depends on Phase 2

---

## Additional Tasks (Implemented but not originally planned)

- [x] T012-NEW Add Italian and German fields (`it`, `de`) for descriptions and reviews to each boat rental operator entry
