# Welcome to Verbania Constitution

## Core Principles

### I. Self-Contained (NON-NEGOTIABLE)
The deliverable MUST be a single HTML file with no external dependencies at runtime.
All CSS, JavaScript, images, and content MUST be embedded inline or as data URIs.
No CDN links, no external stylesheets, no API calls, no web fonts loaded from the network.
The file MUST open correctly when saved as an attachment and launched from WhatsApp,
email clients, iOS, Android, or any file manager — without any internet connection.

### II. Offline-First
Every feature MUST work fully without network access.
No feature MAY degrade or show errors when the device is offline.
Any functionality that would require a network request is out of scope.

### III. Mobile-First
All layouts and interactions MUST be designed for smartphone screens first
(Android and iPhone, small viewport, touch input).
Desktop rendering is a secondary concern — acceptable but not the design target.
Tap targets MUST be comfortably sized. Text MUST be readable without zooming.

### IV. Multilingual (it / en / de)
All user-visible content MUST be available in Italian, English, and German.
Language switching MUST work without reloading or leaving the page.
The default language SHOULD be detected from the browser/OS locale if possible,
with a manual selector always visible as fallback.
Adding a new language MUST not require structural changes — only new content strings.

### V. Version-Based Content Updates
Content is updated by building and distributing a new version of the file.
There is no CMS, no in-place editing, no persistence layer.
Each release MUST be a standalone, complete, self-describing HTML file.
Versioning follows MAJOR.MINOR.PATCH: MAJOR for structural changes,
MINOR for content additions or new sections, PATCH for corrections.
The current version number MUST be visible inside the document.

## Technology Constraints

- **Format**: Single `.html` file — no build artifacts, no folders, no companion files
- **Styling**: Inline CSS or `<style>` block only; no external stylesheet references
- **Scripting**: Vanilla JavaScript only; no frameworks, no npm dependencies
- **Images**: Embedded as base64 data URIs or SVG inline — no `<img src="http...">` references
- **Fonts**: Cormorant Garamond (serif, headings) and Jost (sans-serif, body) embedded
  as WOFF2 base64 data URIs via `@font-face`. System font stack used only as fallback.
  Total embedded font payload: 5 variants.
- **Storage**: No `localStorage`, `IndexedDB`, or cookies — stateless by design

## Content Update Workflow

1. Edit content in source (structured data file or directly in the HTML template)
2. Bump the version number following MAJOR.MINOR.PATCH rules
3. Build/generate the new single HTML file
4. Distribute the new file via the same channel (email, WhatsApp link, etc.)
5. Recipients open the new file — no installation, no update prompt required

Content authors MUST NOT be required to understand HTML to update text, links, or
restaurant/attraction entries. Content SHOULD be separable from presentation.

## Deployment

The project is live and deployed at:

- **Netlify**: https://welcome2verbania.netlify.app
- **GitHub**: https://github.com/mmelli70/sanrocco

The single `index.html` file (~1.4 MB with all base64-embedded assets) is also
distributable directly as a WhatsApp/email attachment — fully offline capable.

## Governance

This constitution supersedes all other practices and guidelines for this project.
Any proposed change to a Core Principle requires:
1. A documented rationale explaining why the change is necessary
2. A new version of this constitution with incremented version number
3. A review of all existing specs and plans for compliance impact

All feature specifications MUST reference and comply with these principles.
Any spec that conflicts with a Core Principle is invalid and MUST be revised before planning.

**Version**: 1.1.0 | **Ratified**: 2026-04-10 | **Last Amended**: 2026-07-09
