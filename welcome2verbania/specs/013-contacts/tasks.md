# Tasks: Contacts Section

**Input**: `specs/013-contacts/`
**Prerequisites**: plan.md ✅, spec.md ✅
**Depends on**: spec 003 (`navigate()`, `createSectionHeader()`), spec 002 (`.contact-card`, `.btn`)

---

## Phase 1: Data

- [ ] T013-01 In `index.html` `<script>` block, add `CONTENT.sections.contacts` object:
  ```js
  CONTENT.sections.contacts = {
    name:     "Marco Melli",
    phone:    "+39 335 6328554",
    whatsapp: "393356328554",   // wa.me/ format — no + or spaces
  }
  ```
- [ ] T013-02 Add translatable string keys to `CONTENT.strings.en` (+ `it`/`de` placeholders):
  `contacts_title`, `contacts_call`, `contacts_whatsapp`, `contacts_signalNote`
  - `contacts_signalNote`: "At the summer house, WhatsApp is preferred — the mobile signal is weak."

**Checkpoint**: `CONTENT.sections.contacts` defined; string keys present.

---

## Phase 2: Section Markup

- [ ] T013-03 Add `<div class="screen" id="contacts" hidden>` to `index.html`; prepend `createSectionHeader('contacts_title')`
- [ ] T013-04 Render the contact card from JS (`renderContacts()`):
  - `.contact-card` with owner name in `.contact-name`
  - "Call" button: `<a class="btn btn-maps" href="tel:+393356328554">📞 <span data-i18n="contacts_call"></span></a>`
  - "WhatsApp" button: `<a class="btn btn-info" href="https://wa.me/393356328554" target="_blank">💬 WhatsApp</a>`
  - `.info-box` below with `contacts_signalNote` text

**Checkpoint**: Contacts section shows name, two action buttons, and info note.

---

## Phase 3: Validation

- [ ] T013-05 Tap "Call" button on real device → phone dialler opens with +39 335 6328554 pre-filled ✅
- [ ] T013-06 Tap "WhatsApp" button → WhatsApp opens with Marco Melli's number pre-filled ✅
- [ ] T013-07 Section renders correctly at 360 dp; back button returns to home ✅
- [ ] T013-08 Works fully offline (WhatsApp deep link uses OS, no network needed for rendering) ✅

---

## Dependencies

- T013-01 and T013-02 can run in parallel
- T013-03 → T013-04 (markup before render)
- Phase 3 depends on Phase 2
