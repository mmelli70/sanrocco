# Feature Specification: Welcome Page

**Feature Branch**: `001-welcome-page`
**Created**: 2026-04-10
**Status**: Draft
**Input**: User description: "a welcome page with a image in background and the text 'San Rocco' below 'bed and breakfast guest guide' and below 'Verbania - Italy' and below the flags for the available languages (we will start with english version only)"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Opens the Guide (Priority: P1)

A guest receives the HTML file via WhatsApp or email, opens it on their phone, and
immediately sees the welcome screen with the property name, type, location, and a
clear way to select their language.

**Why this priority**: This is the entry point of the entire experience. Without a
clear, welcoming first screen, the guide fails its core purpose.

**Independent Test**: Open the HTML file from a phone's file manager or directly
from WhatsApp/email, with no internet connection. The welcome page loads instantly
and all text and the background image are visible.

**Acceptance Scenarios**:

1. **Given** the guest receives the file via WhatsApp, **When** they tap to open it,
   **Then** the welcome screen displays with background image, "San Rocco",
   "Bed & Breakfast Guest Guide", and "Verbania - Italy" visible without scrolling.
2. **Given** the device is in airplane mode, **When** the guest opens the file,
   **Then** the page loads fully with no broken images or missing text.
3. **Given** the page is open, **When** the guest looks for the language selector,
   **Then** they see one or more flag icons below the location text.

---

### User Story 2 - Guest Selects Their Language (Priority: P2)

A guest taps a language flag to switch the guide to their preferred language.
In the current version only English is available; additional flags (IT, DE) will
appear in future versions.

**Why this priority**: Language selection is the gateway to all content. Even with
one language, the flag UI must work correctly and set expectations for future versions.

**Independent Test**: Tap the English flag. Verify the guide acknowledges the
selection (e.g., stays in English or shows a brief confirmation). No page reload
occurs.

**Acceptance Scenarios**:

1. **Given** the welcome page is displayed, **When** the guest taps the English flag,
   **Then** the guide content is shown in English with no page reload.
2. **Given** only English is available, **When** the guest views the language selector,
   **Then** the English flag is shown and clearly active/selected.
3. **Given** the English flag is tapped, **When** the transition completes,
   **Then** the guest is taken to (or shown) the guide's main content in English.

---

### Edge Cases

- What happens if the background image fails to load? The text must remain legible
  against a solid fallback colour.
- What if the screen is very small (< 320 px wide)? Text must not overflow or be cut off.
- What if the device font size is set to "large"? Layout must not break.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The page MUST display the property name "San Rocco" prominently.
- **FR-002**: The page MUST display the subtitle "Bed & Breakfast Guest Guide" below
  the property name.
- **FR-003**: The page MUST display the location "Verbania - Italy" below the subtitle.
- **FR-004**: The page MUST display a language selector with flag icons below the
  location line.
- **FR-005**: The background MUST be a full-screen image that covers the entire viewport.
- **FR-006**: The page MUST be fully legible with no internet connection (image inlined).
- **FR-007**: All text MUST remain readable over the background image (contrast/overlay).
- **FR-008**: The English language MUST be selectable and result in English content
  being shown. Flags for future languages (IT, DE) MAY be shown as inactive placeholders
  or omitted until implemented.
- **FR-009**: The page MUST work correctly when opened from WhatsApp, email clients,
  iOS Safari, and Android Chrome without any installation or extra permissions.
- **FR-010**: The entire welcome screen MUST be visible without scrolling on a typical
  smartphone screen (360 × 640 dp and above).

### Key Entities

- **Welcome Screen**: The full-viewport landing view containing background image,
  property name, subtitle, location, and language selector.
- **Language Selector**: A set of flag icons representing available languages;
  tapping one activates that language for the guide.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The file opens and the welcome screen is fully visible within 2 seconds
  on a mid-range smartphone with no internet connection.
- **SC-002**: All required text elements (property name, subtitle, location) are
  visible without scrolling on screens 360 dp wide and taller than 640 dp.
- **SC-003**: The background image and text are visible in 100% of test opens across
  iOS Safari, Android Chrome, WhatsApp in-app browser, and Gmail in-app browser.
- **SC-004**: Tapping the English flag results in guide content being shown in English
  with no full-page reload.

## Assumptions

- The background image is `assets/home.jpeg` (provided by the owner).
- Only English content is in scope for this feature; Italian and German language
  flags may be shown as disabled placeholders.
- The welcome screen is the first thing the guest sees when opening the file;
  it acts as a cover page before navigating to the guide content.
- Text capitalisation follows the user's specification exactly:
  "San Rocco" / "Bed & Breakfast Guest Guide" / "Verbania - Italy".
- The file will be distributed as a `.html` email/WhatsApp attachment, not hosted
  on a web server.
