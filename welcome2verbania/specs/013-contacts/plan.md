# Implementation Plan: Contacts Section

**Branch**: `013-contacts` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)

## Summary

Build the Contacts section — the first section guests see after the home screen.
Displays owner contact details (name, cell, WhatsApp) with one-tap call and
WhatsApp deep-link actions. Also includes a note about weak signal at the property.

## Technical Context

**Language/Version**: HTML5, CSS3, Vanilla JS (ES6+)  
**Primary Dependencies**: Feature 003 (section routing + back nav), Feature 002 (design tokens, `.card`)  
**Storage**: Stateless  
**Testing**: Manual — tap-to-call and tap-to-WhatsApp on real device  
**Constraints**: Single `.html` file; `tel:` and `https://wa.me/` links only

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Self-Contained | ✅ PASS | No external deps |
| II. Offline-First | ✅ PASS | Contact data embedded; `tel:`/`wa.me` use device OS |
| III. Mobile-First | ✅ PASS | Large tap targets for call/WhatsApp buttons |
| IV. Multilingual | ✅ PASS | Strings via `CONTENT.strings[lang]` |
| V. Version-Based Updates | ✅ PASS | Contact data in `CONTENT.sections.contacts` |

## Project Structure

```text
index.html   ← add #contacts screen with markup + CONTENT.sections.contacts data
```

## Seed Data

```js
CONTENT.sections.contacts = {
  name:      "Marco Melli",
  phone:     "+39 335 6328554",
  whatsapp:  "+39 335 6328554",   // wa.me/393356328554
  note:      "At the summer house WhatsApp is preferred — mobile signal is weak."
}
```

## Implementation Phases

### Phase 1 — Section Markup
- Add `<div class="screen" id="contacts">` with back-nav header
- `.contact-card` component: owner name, phone (tap-to-call), WhatsApp button
- Info box with the weak-signal note

### Phase 2 — Data & Strings
- Add `CONTENT.sections.contacts` object
- Add translatable strings: section title, button labels, note text
- `wa.me` deep link constructed from phone number (strip `+` → `393356328554`)

### Phase 3 — Validation
- Tap phone number → dialler pre-filled ✅
- Tap WhatsApp → WhatsApp opens with contact pre-filled ✅
- Works on airplane mode (no network needed for link construction) ✅
