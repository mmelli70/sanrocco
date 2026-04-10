# Research: Design System

**Feature**: 002-design-system
**Date**: 2026-04-10

## Decision 1: Font Embedding Strategy — WOFF2 Base64 in `@font-face`

**Decision**: Download WOFF2 files for Cormorant Garamond (5 variants) and Jost
(3 variants) from Google Fonts, subset them to Latin Extended (covering IT + DE
diacritics), base64-encode each file, and declare them via `@font-face` rules with
`src: url('data:font/woff2;base64,...') format('woff2')` in the `<style>` block.

**Rationale**: This is the only technique that makes web fonts available offline
inside a single HTML file without any external URLs. WOFF2 is the most compressed
web font format (typically 30–50% smaller than WOFF). Latin Extended subsetting
covers all characters needed for Italian and German guests.

**Alternatives considered**:
- Google Fonts `@import` — rejected: violates Self-Contained + Offline-First principles.
- System font stack only — rejected: would not match the `demo.html` aesthetic;
  Cormorant Garamond's thin-weight serif character is integral to the luxury feel.
- SVG fonts — rejected: obsolete, larger, and not supported in modern mobile browsers.

**Font variants required**:

| Font | Weight | Style | Usage |
|------|--------|-------|-------|
| Cormorant Garamond | 300 | normal | Splash title, section titles |
| Cormorant Garamond | 300 | italic | Decorative/accent text |
| Cormorant Garamond | 400 | normal | Card titles, wifi values |
| Cormorant Garamond | 400 | italic | Optional emphasis |
| Cormorant Garamond | 600 | normal | Future bold headings |
| Jost | 300 | normal | Body text (default) |
| Jost | 400 | normal | Nav items, standard weight |
| Jost | 500 | normal | Labels, card-label, badge |

**Estimated embedded size** (Latin Extended subset):
~8–15 KB per variant × 8 variants = ~65–120 KB total font payload (well within 150 KB target).

---

## Decision 2: Font Download — Automated `download-fonts.sh` Script

**Decision**: Provide a `download-fonts.sh` script at the repo root that downloads
the 8 WOFF2 files automatically using `curl`. The script fetches the Google Fonts CSS
with a WOFF2-compatible User-Agent (Chrome), parses the WOFF2 URLs, and saves each
file to `assets/fonts/`. The developer runs this once; guests never need internet.

```bash
bash download-fonts.sh   # one-time setup, downloads ~100 KB of WOFF2 files
bash build.sh --fonts    # embeds them into index.html
```

**Rationale**: Both Cormorant Garamond and Jost are OFL (SIL Open Font License)
fonts — legally free to download and embed. Google Fonts serves pre-subsetted
WOFF2 files from `fonts.gstatic.com` that are directly `curl`-downloadable when
a WOFF2-capable User-Agent header is provided. This requires zero browser UI,
zero account, zero npm/pip install — just `curl`, which ships with macOS and Linux.
Font download is a BUILD-TIME operation on the developer's machine; it has no effect
on the guest's offline experience.

**Alternatives considered**:
- Manual browser download (google-webfonts-helper) — rejected: unnecessary friction;
  the same files are accessible via `curl`.
- `pyftsubset` + raw TTF — viable but adds a Python dependency for no extra benefit;
  Google Fonts already serves subsetted WOFF2.
- System font stack only (no download) — accepted as **fallback** (see Decision 2b).

---

## Decision 2b: System Font Fallback (Zero-Setup Alternative)

**Decision**: If the developer chooses not to run `download-fonts.sh`, the design
system degrades gracefully to an elegant system font stack defined as fallbacks in
the CSS tokens:

```css
--font-serif: 'Cormorant Garamond', 'Palatino Linotype', Palatino, 'Book Antiqua', Georgia, serif;
--font-sans:  'Jost', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
```

On iOS, `Palatino` is pre-installed and provides a comparable elegant serif.
On Android, `Georgia` is the best available fallback serif. The `system-ui` stack
covers sans-serif well on both platforms.

**Rationale**: The fallback stack means `index.html` is immediately usable for
content editing and testing without any setup. The visual difference (Palatino vs
Cormorant Garamond) is noticeable but not jarring — acceptable for development.
For distribution to guests, the embedded fonts SHOULD be used.

**Alternatives considered**:
- Fail visibly with no fallback — rejected: a blank or misrendered page during
  development is a poor experience and breaks the quickstart flow.

---

## Decision 3: CSS Custom Properties for Colour Tokens

**Decision**: All colours defined as CSS custom properties in `:root`. Components
reference `var(--token)` exclusively. No hardcoded hex values outside `:root`.

Token set (from `demo.html`):

```css
:root {
  --cream:       #F7F3EE;
  --warm-white:  #FDFAF6;
  --charcoal:    #2C2C2C;
  --stone:       #8C8478;
  --gold:        #B8996A;
  --gold-light:  #D4B896;
  --border:      #E2D9CF;
  --accent-bg:   #F0EAE1;
}
```

**Rationale**: CSS custom properties are natively supported in all target browsers
(iOS Safari 10+, Android Chrome 49+). They enable future theming or dark-mode
support with zero structural changes. A single `:root` block is the authoritative
source of truth for colours — matching SC-002.

**Alternatives considered**:
- Sass/LESS variables — rejected: requires a build toolchain, violating simplicity
  and the single-file constraint.
- Hardcoded hex in each rule — rejected: makes colour updates error-prone and
  violates SC-002.

---

## Decision 4: Typography Scale Rationalisation

**Decision**: Consolidate `demo.html`'s 18 distinct font-size values into a
structured scale of 8 named steps, expressed as `rem` or `clamp()` values.
Map existing component usage to the nearest step.

**Proposed scale**:

| Step | Value | Used for |
|------|-------|---------|
| `--text-2xs` | `0.58rem` | Badge, card-label |
| `--text-xs` | `0.68rem` | Splash enter, section-desc, emergency-name |
| `--text-sm` | `0.78rem` | Card body, rule text, wifi-key |
| `--text-base` | `0.9rem` | Card detail, general body |
| `--text-md` | `1.05rem` | Wifi value |
| `--text-lg` | `1.2rem` | Card title |
| `--text-xl` | `1.55rem` | Header name, emergency number, rule num |
| `--text-hero` | `clamp(1.8rem, 5vw, 2.4rem)` | Section titles |
| `--text-splash` | `clamp(2.8rem, 8vw, 4.2rem)` | Splash property name |

**Rationale**: Named steps make future updates predictable. Changing `--text-sm`
updates all body text consistently. Reduces the cognitive load of finding the right
font size from 18 arbitrary values to 9 semantic steps.

**Alternatives considered**:
- Keep all 18 raw values — rejected: no semantic meaning, hard to maintain.
- Strict modular scale (e.g., 1.25× ratio) — considered but rejected: would change
  the visual look; values are derived from the reference `demo.html` instead.

---

## Decision 5: Component Architecture — Class-Based CSS

**Decision**: Each UI component is a CSS class (or small class composition) defined
in the `<style>` block. No JavaScript is involved in styling. Component classes use
only token variables. New components follow the same pattern.

**Component inventory** (from `demo.html`, all to be formalised):

| Class | Role |
|-------|------|
| `.card` | Content card (white surface, border, hover shadow) |
| `.section-hero` | Dark charcoal header for each section |
| `.nav-item` | Horizontal nav tab, active state with gold underline |
| `.ornament-divider` | Thin horizontal rule with centred gold label |
| `.badge` | Small uppercase gold pill label |
| `.rule-item` | Numbered rule row (gold serif number + content) |
| `.wifi-box` / `.info-box` | Accent-bg box with gold left border |
| `.emergency-card` | Dark charcoal card for emergency numbers |
| `.map-btn` | Gold-bordered "Open in Maps" button |

**Rationale**: Pure CSS components require no JavaScript, add no weight, and are
trivially copy-pasteable into new sections. The class-based approach means any new
section can reuse existing components without touching the CSS.

**Alternatives considered**:
- Web Components (`<custom-element>`) — rejected: overkill for a single HTML file;
  adds JavaScript complexity.
- Inline styles per element — rejected: impossible to maintain across sections.

---

## Decision 6: `build.sh` Extension for Font Injection

**Decision**: Extend `build.sh` (created in feature 001) with a `inject_fonts()`
function. It reads each WOFF2 file from `assets/fonts/`, base64-encodes it, and
writes the complete `@font-face` block into a clearly marked section of `index.html`
between `/* FONTS:START */` and `/* FONTS:END */` comment markers.

**Rationale**: Keeps the HTML source human-readable — the raw base64 strings are
long and should not be hand-edited. The marker-based injection allows `build.sh` to
be run repeatedly to refresh fonts without corrupting other CSS.

**Alternatives considered**:
- Store base64 in a separate `.js` file loaded at runtime — rejected: requires a
  network request or a second file attachment, violating Self-Contained principle.
- Embed fonts manually once and never update — viable for stable fonts but fragile;
  `build.sh` automation is safer and repeatable.
