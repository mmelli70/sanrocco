# Quickstart: Design System

**Feature**: 002-design-system
**Date**: 2026-04-10

## Prerequisites

- `curl` (pre-installed on macOS and Linux)
- `build.sh` at repo root (extended in this feature to handle fonts)
- A text editor for CSS edits in `index.html`

## Get and Embed the Fonts (Recommended)

One command downloads all 8 WOFF2 files from Google Fonts and saves them to `assets/fonts/`:

```bash
bash download-fonts.sh
```

Then embed them into `index.html`:

```bash
bash build.sh --fonts
```

That's it. The fonts (Cormorant Garamond + Jost) are OFL-licensed — free to download
and embed. This is a build-time step on the developer's machine; guests never need
internet access once the file is built.

## Use Without Downloading Fonts (Zero-Setup Fallback)

Skip the font download entirely. The CSS token fallbacks kick in automatically:

- **iOS / macOS**: Palatino (serif) + system-ui (sans) — elegant, very close to the target look
- **Android / Windows**: Georgia (serif) + Roboto/system-ui (sans) — clean and legible

The guide is fully usable for content editing and testing with system fonts.
For final distribution to guests, run `download-fonts.sh` + `build.sh --fonts` once.

## Use Design Tokens

All tokens are in the `:root` block at the top of the `<style>` block in `index.html`.

```css
/* Correct — always use tokens */
.my-component { color: var(--gold); font-family: var(--font-serif); }

/* Wrong — never hardcode values */
.my-component { color: #B8996A; font-family: 'Cormorant Garamond', serif; }
```

See `specs/002-design-system/contracts/design-tokens.md` for the full token list.

## Add a New Component

1. Document the component in `specs/002-design-system/contracts/component-classes.md`
2. Add the CSS class to the `<style>` block in `index.html`, using only `var(--token)` values
3. Use the class in the HTML — no JS needed

## Verify the Design System

Open `index.html` with airplane mode enabled and check:

- [ ] Cormorant Garamond renders correctly (thin, elegant serif) — not a system fallback
- [ ] Jost renders correctly (clean geometric sans-serif) — not a system fallback
- [ ] All 8 colour tokens visually match the reference in `demo.html`
- [ ] `.card`, `.section-hero`, `.ornament-divider`, `.badge` all render as documented
- [ ] No hardcoded colours visible outside `:root` (search `index.html` for `#` outside `:root`)
- [ ] Touch targets on `.nav-item` and `.map-btn` are ≥ 44 px height (check with browser DevTools)
