# Research: Welcome Page

**Feature**: 001-welcome-page  
**Date**: 2026-04-10

## Decision 1: Full-Viewport Background Image (Inline)

**Decision**: Use a `<div>` with `background-image: url('data:image/jpeg;base64,...')` styled
with `background-size: cover; background-position: center` covering 100vw × 100vh. The image
data URI is embedded directly in the HTML.

**Rationale**: CSS background images with `cover` are the most reliable cross-browser technique
for full-bleed backgrounds on mobile. Using a data URI keeps the file self-contained. A
`<img>` element with `object-fit: cover` would also work but is harder to position behind
layered text without extra wrapper elements.

**Alternatives considered**:
- `<img>` with `position: fixed` — rejected: more fragile on iOS Safari (100vh issues).
- External image URL — rejected: violates Self-Contained principle.

---

## Decision 2: Text Legibility Over Background Image

**Decision**: Place a semi-transparent dark overlay (`rgba(0,0,0,0.35)`) between the
background image and the text. Text is white (`#ffffff`) with a subtle `text-shadow`.

**Rationale**: The background image content is unknown; a translucent overlay guarantees
WCAG AA contrast (≥ 4.5:1) regardless of image brightness. `text-shadow` adds additional
separation without altering the design.

**Alternatives considered**:
- Blurred backdrop — rejected: too heavy visually for a cover page.
- Dark gradient from bottom — considered for future; overlay is simpler and safer.

---

## Decision 3: Language Selector — Flag Icons

**Decision**: Use emoji flag characters (🇬🇧 🇮🇹 🇩🇪) as language buttons. Active language
gets a visible border/underline. Inactive languages are rendered at reduced opacity and
are non-interactive (for this version, IT and DE are placeholders).

**Rationale**: Emoji flags require zero external assets, are universally supported on iOS
and Android, and are self-contained. No SVG files, no font icons, no CDN.

**Alternatives considered**:
- SVG flag sprites inlined in HTML — rejected: adds significant file size and complexity
  for no user-visible improvement on mobile.
- Text labels ("EN / IT / DE") — rejected: flags are faster to understand across languages.

---

## Decision 4: Language-Switching Mechanism

**Decision**: A JavaScript `CONTENT` object keyed by language code (`en`, `it`, `de`) holds
all user-visible strings. A `setLanguage(code)` function updates `textContent` of labelled
DOM elements and persists the choice in a `data-lang` attribute on `<html>`. No page reload.

**Rationale**: Vanilla JS with a single content object is the simplest possible
implementation. No frameworks. No `localStorage` (stateless per constitution). Language
resets to the browser default (or `en` fallback) on each open — which is correct since
the file is opened fresh each time.

**Alternatives considered**:
- Multiple hidden `<div lang="...">` blocks — rejected: duplicates all content in the DOM,
  making future content updates error-prone.
- `localStorage` persistence — rejected: constitution forbids stateful storage.

---

## Decision 5: Build vs. Hand-Edit

**Decision**: The HTML file is hand-editable for simple text changes. A `build.sh`
script is provided to re-encode a new background image (base64) and inject it into
the HTML. Content strings live in a clearly labelled `<script>` block at the top.

**Rationale**: Keeps the workflow simple for non-developers. The "build" is optional
and only needed when replacing the background image. All other updates (text, links)
are one-line edits in the `CONTENT` object.

**Alternatives considered**:
- Full static-site generator (11ty, Hugo) — rejected: massive overkill; adds a Node/Go
  dependency for what is a single HTML file.
- Separate JSON content file + fetch at runtime — rejected: violates Offline-First and
  Self-Contained principles.

---

## Decision 6: Viewport & Safe Area Handling (iOS Notch / Dynamic Island)

**Decision**: Use `min-height: 100dvh` (dynamic viewport height) with a fallback to
`100vh`. Apply `padding: env(safe-area-inset-*)` to the content layer so text is never
obscured by notch or home indicator.

**Rationale**: `100vh` on iOS Safari historically includes the browser chrome, causing
content to be hidden. `100dvh` (supported iOS 15.4+) fixes this. The `env()` safe-area
variables handle notch/Dynamic Island padding automatically.

**Alternatives considered**:
- JavaScript-based viewport height fix (`--vh` custom property) — rejected: adds JS
  complexity; `100dvh` + `100vh` fallback is pure CSS and sufficient.
