# Feature Specification: House Rules

**Feature Branch**: `008-house-rules`
**Created**: 2026-04-10
**Status**: IMPLEMENTED
**Input**: Owner-provided content covering check-in/check-out times, smoking policy,
city tax, WiFi credentials, dishwasher caution, and air-conditioning maintenance.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Reads the House Rules (Priority: P1)

A guest opens the House Rules section and reads all the rules that apply to their
stay. The rules are clearly organised into named sub-sections so the guest can
quickly find what they need (e.g., WiFi credentials, check-out time, air-con
instructions).

**Why this priority**: This is the primary purpose of the section — guests must be
able to quickly locate and understand the rules before and during their stay.

**Independent Test**: Open `index.html`, navigate to "House Rules". All six
sub-sections are visible and readable. The WiFi password is displayed. The city
tax PayPal/cash note is clear. Works fully offline.

**Acceptance Scenarios**:

1. **Given** the guest opens the "House Rules" section, **When** the section loads,
   **Then** all rule sub-sections are visible and each has a clear heading.
2. **Given** the guest looks for WiFi details, **When** they find the WiFi
   sub-section, **Then** both SSIDs (`melli-fibra` and `melli-fibra-ext`) and the
   password are displayed prominently.
3. **Given** the guest reads the city tax sub-section, **When** they scan it,
   **Then** the amount (€1/person/day), the child exemption (under 6), and the
   payment method (cash or PayPal) are all clearly stated.
4. **Given** the guest reads the check-in/check-out sub-section, **When** they
   scan it, **Then** check-in from 4:00 PM and check-out by 10:00 AM are clearly
   displayed.
5. **Given** the section is displayed, **When** the guest reads the dishwasher
   caution, **Then** the warning not to open the door during a cycle is clearly
   communicated.
6. **Given** the section is displayed, **When** the guest reads the air conditioning
   sub-section, **Then** the instruction to empty the water container every two days
   (when in regular use) is clearly stated.

---

### User Story 2 - Guest Copies the WiFi Password (Priority: P1)

A guest wants to connect their devices to WiFi. They find the WiFi sub-section and
can read (or copy) the password with minimal friction.

**Why this priority**: WiFi is one of the first things guests look for on arrival.
The password must be unmistakably visible — not buried in prose.

**Independent Test**: Navigate to House Rules > WiFi. The SSID and password are
displayed in a visually distinct box (e.g., the existing `.wifi-box` component from
feature 002). The password is readable at a glance.

**Acceptance Scenarios**:

1. **Given** the guest opens the WiFi sub-section, **When** they look at it,
   **Then** SSID and password are displayed in a visually distinct credential block
   (not inline in a paragraph of text).
2. **Given** two WiFi networks exist, **When** the WiFi block is shown, **Then**
   both networks are listed with a brief note explaining when to use the second
   (signal extension).
3. **Given** the device is offline, **When** the guest views the WiFi block,
   **Then** it renders correctly — no external resources required.

---

### User Story 3 - Guest Pays the City Tax (Priority: P1)

A guest reads the city tax sub-section and understands how much they owe, who is
exempt, and how to pay (cash or PayPal directly to the owner). They can tap the
official city link for full details.

**Why this priority**: City tax is a legal obligation and a common source of
confusion for Airbnb guests. The owner is legally responsible for collection, so
clarity here protects both parties.

**Independent Test**: Navigate to House Rules > City Tax. Amount, exemption, and
payment instructions are visible. The official Verbania link opens in a browser.

**Acceptance Scenarios**:

1. **Given** the guest reads the city tax block, **When** they finish reading,
   **Then** they know: the amount (€1/person/day), that under-6s are exempt, and
   that payment must be cash or PayPal directly to the owner.
2. **Given** the city tax block is shown, **When** the guest taps the official link,
   **Then** the browser opens
   `https://www.comune.verbania.it/Servizi/Imposta-di-Soggiorno-IDS`.
3. **Given** a translation is active (DE or IT), **When** the city tax block is
   shown, **Then** all text is in the selected language; only the external URL
   remains language-independent.

---

### User Story 5 - Guest Uses the Kitchen (Priority: P1)

A guest opens the Kitchen sub-section and learns they can use all kitchen equipment
freely, that supplies should be replaced when consumed, and that the owner can give
a Pastamaker demonstration on request. They also see the dishwasher caution clearly
called out so they don't accidentally cause a mess.

**Why this priority**: The kitchen is a central shared space. Guests need to know
what's available, what's expected of them, and the one operational caution.

**Independent Test**: Navigate to House Rules > Kitchen. The welcome message, the
supplies fairness note, the Pastamaker offer, and the dishwasher caution are all
visible. The dishwasher caution is visually distinct from the body text.

**Acceptance Scenarios**:

1. **Given** the guest reads the Kitchen sub-section, **When** they finish reading,
   **Then** they know they may use all kitchen items freely.
2. **Given** the guest reads the supplies note, **When** they understand it,
   **Then** it is clear they should replace anything they consume.
3. **Given** the guest is interested in pasta-making, **When** they read the
   Pastamaker note, **Then** it is clear they should contact the owner to arrange
   a demonstration.
4. **Given** the guest reads the dishwasher caution, **When** they see it,
   **Then** it stands out visually from the surrounding text and the risk
   (water spray) is clearly explained.

---

### User Story 6 - Guest Uses the Jacuzzi (Priority: P1)

A guest wants to use the jacuzzi. They read the Jacuzzi sub-section and understand
that regular bath soap must not be used, and that a specific oil is available in
the bathroom instead.

**Why this priority**: Using the wrong product can damage the pump — this is a
property protection issue as well as a guest experience issue.

**Independent Test**: Navigate to House Rules > Jacuzzi. The soap prohibition and
the approved oil alternative are both clearly stated.

**Acceptance Scenarios**:

1. **Given** the guest reads the Jacuzzi sub-section, **When** they finish reading,
   **Then** it is unambiguous that bath soap must not be used.
2. **Given** the guest reads the Jacuzzi sub-section, **When** they look for an
   alternative, **Then** the specific oil in the bathroom is mentioned as the
   approved product.

---

### User Story 4 - Owner Updates the House Rules (Priority: P2)

The owner updates any rule (e.g., changes the WiFi password, adjusts check-out time)
by editing the `CONTENT` object. No HTML structure changes are required.

**Independent Test**: Change the WiFi password in `CONTENT.strings.en.wifi`. Open
the file — the new password is shown in the WiFi block.

**Acceptance Scenarios**:

1. **Given** the WiFi password is updated in `CONTENT`, **When** the page opens,
   **Then** the new password is displayed in the WiFi block.
2. **Given** a new rule sub-section is needed, **When** the owner adds an entry to
   `CONTENT.sections.houseRules`, **Then** the new sub-section card appears in the
   list with no HTML structural changes.

---

### Edge Cases

- What if the guest's screen is very narrow (320 dp)? The WiFi credential block,
  city tax note, dishwasher caution, and jacuzzi warning must not overflow horizontally.
- What if the city tax link is tapped while offline? The link will fail gracefully
  (browser shows "no connection") — this is acceptable as it is an external resource.
- What if a rule sub-section is very long? The section scrolls vertically; no text
  is clipped or hidden behind other elements.
- What if the owner adds an eighth rule? The list must extend naturally —
  no hardcoded number of visible items.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The section MUST display a welcoming introductory line (stored in
  `CONTENT.strings[lang].houseRulesIntro`) before the rule list.
- **FR-002**: The section MUST contain the following named sub-sections, each with
  a translatable heading:
  1. Check-In / Check-Out
  2. Smoking Policy
  3. City Tax
  4. WiFi
  5. Kitchen
  6. Jacuzzi
  7. Air Conditioning
  8. Waste *(content TBD — placeholder until May)*
- **FR-003**: The **Check-In / Check-Out** sub-section MUST display check-in time
  (from 4:00 PM) and check-out time (by 10:00 AM) as distinct labelled items.
- **FR-004**: The **Smoking Policy** sub-section MUST clearly state that smoking is
  not permitted indoors.
- **FR-005**: The **City Tax** sub-section MUST state the rate (€1 per person per
  day), the child exemption (under 6 years), the payment method (cash or PayPal
  directly to the owner), and include a tappable link to the official Verbania page.
- **FR-006**: The **WiFi** sub-section MUST display credentials in a visually
  distinct block using the `.wifi-box` component from feature 002:
  - Primary SSID: `melli-fibra`
  - Extension SSID: `melli-fibra-ext` (with note: use if primary signal is weak)
  - Password: `04930493`
- **FR-007**: The **Kitchen** sub-section MUST convey:
  - Guests may freely use all kitchen items and accessories.
  - Some supplies are provided; guests are asked to replace whatever they consume
    (fairness to future guests).
  - The owner offers to demonstrate the Pastamaker for guests interested in making
    fresh homemade pasta — guests should contact the owner to arrange.
  - ⚠️ **Dishwasher warning**: do not open the door once the cycle has started —
    a sensor fault means it will not stop and water may spray out. This warning
    MUST be visually distinct (e.g., using an `.info-box` or `.warning-box`
    component) — it must not be buried in body text.
- **FR-008**: The **Jacuzzi** sub-section MUST convey:
  - Do not use regular bath soap in the jacuzzi — it creates excessive foam and
    can damage the pump.
  - Guests may use the specific oil provided in the bathroom instead.
  - This restriction MUST be communicated clearly as a caution, not a suggestion.
- **FR-009**: The **Air Conditioning** sub-section MUST instruct the guest to empty
  the water container on the balcony of the largest single room every two days when
  the air conditioner is in regular use.
- **FR-010**: The **Waste** sub-section heading MUST be present and translatable.
  The body content (`CONTENT.strings[lang].houseRulesBody.waste`) is a placeholder
  — content will be provided by the owner before the May release. During development
  the sub-section MUST render with a visible "Content coming soon" placeholder so
  the layout is validated before real content is available.
- **FR-011**: All rule text MUST be stored in `CONTENT.strings[lang]` and be
  translatable (IT / EN / DE).
- **FR-012**: The section MUST use the visual design system from feature 002.
  Each sub-section MUST render as a `.rule-item` (or equivalent card) component.
- **FR-013**: The WiFi block MUST use the `.wifi-box` component from feature 002
  — credentials displayed in a distinct, easy-to-scan layout, not inline prose.
- **FR-014**: The city tax external link MUST open in a new browser tab
  (`target="_blank" rel="noopener"`).
- **FR-015**: The section MUST work fully offline. No assets or fonts may depend on
  a network request.

### Key Entities

- **House Rule Item**: A named sub-section with a heading and body content.
  Headings stored in `CONTENT.strings[lang].houseRulesTitles.*`.
  Body content stored in `CONTENT.strings[lang].houseRulesBody.*`.
- **WiFi Credentials**: `{ ssid1: string, ssid2: string, password: string }` —
  stored in `CONTENT.strings[lang].wifi` (or a language-neutral shared block since
  credentials are the same in all languages).
- **City Tax Info**: Rate, exemption, payment method, and link — stored in
  `CONTENT.strings[lang].cityTax`.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All eight rule sub-sections are visible and readable on iOS Safari and
  Android Chrome with no horizontal overflow.
- **SC-002**: The WiFi SSID and password are identifiable within 3 seconds of
  opening the WiFi sub-section — verified by quick visual scan.
- **SC-003**: The city tax amount, exemption, and payment method are all present in
  a single sub-section without requiring scrolling past unrelated content.
- **SC-004**: Tapping the city tax link opens the correct Verbania URL in a browser.
- **SC-005**: Updating the WiFi password in `CONTENT` and reloading shows the new
  password with no other file changes needed.
- **SC-006**: The dishwasher caution inside the Kitchen sub-section is visually
  distinct from surrounding body text — identifiable as a warning on first glance.
- **SC-007**: The jacuzzi soap prohibition is clearly stated as a caution, not a
  suggestion, on both iOS Safari and Android Chrome.
- **SC-008**: The section renders correctly (no broken layout) on a 320 dp screen.
- **SC-009**: The section works fully offline — verified with airplane mode on iOS
  and Android.

## Assumptions

- WiFi credentials are the same regardless of active language; they are displayed
  identically in all languages (only the surrounding explanatory text is translated).
- The city tax rate (€1/person/day) and the under-6 exemption are current as of the
  spec date. The owner is responsible for updating this if the rules change.
- The external city tax URL
  (`https://www.comune.verbania.it/Servizi/Imposta-di-Soggiorno-IDS`) is the
  authoritative reference and will be included as a static link — no live data fetch.
- The eight sub-sections listed in FR-002 cover all current rules. Future rules can be
  added as new `.rule-item` entries without structural HTML changes.
- The **Waste** sub-section is intentionally empty at spec time. A placeholder
  ("Content coming soon") will be used until the owner provides the final text
  before the May release. A spec revision will be required when the content is ready.
- The `.rule-item`, `.wifi-box`, and `.info-box`/`.warning-box` components are
  already defined in the feature 002 design system contract; this feature uses them
  without modification.
- The introductory sentence ("To make your stay and the stay of future guests
  enjoyable, we kindly ask you to observe the following rules:") is seed content
  for `houseRulesIntro`. Translation to IT and DE is the owner's responsibility.
- Kitchen seed content (welcome message, supplies note, Pastamaker offer, dishwasher
  caution) and Jacuzzi seed content (soap prohibition, approved oil) are provided by
  the owner. Translation to IT and DE is the owner's responsibility.
- The "specific oil" for the jacuzzi is assumed to be physically present in the
  bathroom; its name/brand is not specified in this guide — "the specific oil you
  can find in the bathroom" is sufficient.
