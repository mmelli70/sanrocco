# Feature Specification: Contacts Section

**Feature Branch**: `013-contacts`
**Created**: 2026-04-10
**Status**: Draft
**Input**: Owner contact information — the first section guests see, providing direct
ways to reach the owner before, during, and after the stay.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Contacts the Owner (Priority: P1)

A guest needs to reach the owner — to announce arrival, ask a question, report an
issue, or request the key safe code. They open the Contacts section and find all
the owner's contact details with one-tap call, WhatsApp, and email actions.

**Why this priority**: Direct owner contact is the most important practical
information in the guide. It must be the first section and require zero friction.

**Independent Test**: Open `index.html`, navigate to Contacts. All contact methods
are visible. Tapping the phone number opens the dialler. Tapping WhatsApp opens a
chat. Tapping email opens the mail client. Works offline (links are local, no
network needed to display them).

**Acceptance Scenarios**:

1. **Given** the guest opens the Contacts section, **When** it loads, **Then** the
   owner's name is visible as the primary heading.
2. **Given** a phone/mobile number is shown, **When** the guest taps it, **Then**
   the phone dialler opens with the number pre-filled.
3. **Given** a WhatsApp number is shown, **When** the guest taps it, **Then**
   WhatsApp opens a chat with the owner.
4. **Given** an email address is shown, **When** the guest taps it, **Then** the
   mail client opens a new message to the owner.
5. **Given** the device is offline, **When** the guest views the section, **Then**
   all contact details are visible — no network request is needed to display them.

---

### User Story 2 - Owner Updates Contact Details (Priority: P2)

The owner updates a phone number or adds a new contact method by editing `CONTENT`.
No structural HTML changes are needed.

**Independent Test**: Change the mobile number in `CONTENT.strings.en.ownerContact`.
Open the file — the new number is shown.

**Acceptance Scenarios**:

1. **Given** a contact field is updated in `CONTENT`, **When** the page opens,
   **Then** the updated value is shown.
2. **Given** an optional field (e.g., `email`) is removed, **When** the page opens,
   **Then** the section renders gracefully without that field.

---

### Edge Cases

- What if the WhatsApp link is tapped on a device without WhatsApp installed? The
  browser opens `wa.me` — the user sees WhatsApp Web or an install prompt. Acceptable.
- What if the screen is very narrow (320 dp)? Contact buttons must not overflow.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display the owner's name as the primary heading.
- **FR-002**: The section MUST display contact details stored in `CONTENT.strings[lang].ownerContact`.
  Supported fields (all optional except at least one contact method):
  - `name` (string) — displayed as heading
  - `phone` (string, optional) — tappable `tel:` link
  - `mobile` (string, optional) — tappable `tel:` link
  - `whatsapp` (string, optional) — tappable `https://wa.me/` link
  - `email` (string, optional) — tappable `mailto:` link
  - `note` (string, optional) — a short contextual note (e.g., "For late arrivals,
    please use WhatsApp")
- **FR-003**: Phone and mobile numbers MUST be rendered as tappable `tel:` links.
  The display format is preserved as written; the `href` is normalised (spaces/
  punctuation stripped).
- **FR-004**: The WhatsApp contact MUST open via `https://wa.me/<number>` in a new
  tab so the OS can deep-link to the WhatsApp app.
- **FR-005**: The email contact MUST open via a `mailto:` link.
- **FR-006**: The section MUST work fully offline. All content is in `CONTENT` —
  no network request is needed to display the section.
- **FR-007**: The section MUST use the visual design system from feature 002.
  Contact details SHOULD use the `.info-box` or `.emergency-card` component for
  a clear, scannable layout.
- **FR-008**: All text content (labels, note) MUST be stored in `CONTENT.strings[lang]`
  and be translatable (IT / EN / DE). Phone numbers and email are language-neutral.

### Key Entities

- **Owner Contact Block**: `{ name, phone?, mobile?, whatsapp?, email?, note? }`
  stored in `CONTENT.strings[lang].ownerContact` (with language-neutral fields
  shared across language variants).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All contact methods are visible and tappable on a 360 dp phone in
  iOS Safari and Android Chrome with no overflow.
- **SC-002**: Tapping the WhatsApp link opens a WhatsApp chat (or `wa.me` web page)
  with the correct number.
- **SC-003**: Tapping the phone/mobile number opens the phone dialler with the
  correct number pre-filled.
- **SC-004**: The section renders correctly with airplane mode enabled.
- **SC-005**: Updating a contact field in `CONTENT` and reloading shows the new
  value with no other file changes.

## Assumptions

- The owner will provide their actual contact details at content-entry time. This
  spec defines the structure and UI behaviour only.
- At minimum, a WhatsApp number is required — this is the owner's preferred contact
  channel for guests (established in spec 007).
- The `note` field allows the owner to add a short advisory such as "For emergencies
  call, otherwise prefer WhatsApp".
- This section is positioned first in the home screen grid (position 1) as it is
  the most universally needed information.
- Phone numbers are stored as written by the owner; normalisation for `tel:` hrefs
  is handled at render time.

## Seed Content

Owner-provided content for the English version. IT and DE translations are the
owner's responsibility.

**Introductory line**: "For any question or problem, feel free to call me:"
**Name**: Marco Melli
**Cell / WhatsApp**: +39 335 6328554
**Note**: "At my summer house (where I'm currently staying), it's best to contact
me via WhatsApp, as the mobile phone signal is weak."

```js
CONTENT.strings.en.ownerContact = {
  intro:    "For any question or problem, feel free to call me:",
  name:     "Marco Melli",
  mobile:   "+39 335 6328554",
  whatsapp: "+39 335 6328554",  // same number — mobile and WhatsApp
  note:     "At my summer house (where I'm currently staying), it's best to contact me via WhatsApp, as the mobile phone signal is weak."
}
```
