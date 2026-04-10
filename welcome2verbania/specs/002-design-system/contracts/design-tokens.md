# Design Tokens Contract

**Feature**: 002-design-system
**Date**: 2026-04-10
**Type**: CSS custom properties in `:root`

## Purpose

Defines the canonical set of CSS tokens for the San Rocco guide. All components
MUST use these tokens. No hardcoded hex, rem, or font-family values are permitted
outside this `:root` block and the `@font-face` declarations.

## Contract

```css
:root {
  /* Colour palette */
  --cream:       #F7F3EE;
  --warm-white:  #FDFAF6;
  --charcoal:    #2C2C2C;
  --stone:       #8C8478;
  --gold:        #B8996A;
  --gold-light:  #D4B896;
  --border:      #E2D9CF;
  --accent-bg:   #F0EAE1;

  /* Typography — font families (fallbacks cover iOS Palatino + Android Georgia) */
  --font-serif: 'Cormorant Garamond', 'Palatino Linotype', Palatino, 'Book Antiqua', Georgia, serif;
  --font-sans:  'Jost', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;

  /* Typography — size scale */
  --text-2xs:    0.58rem;
  --text-xs:     0.68rem;
  --text-sm:     0.78rem;
  --text-base:   0.9rem;
  --text-md:     1.05rem;
  --text-lg:     1.2rem;
  --text-xl:     1.55rem;
  --text-hero:   clamp(1.8rem, 5vw, 2.4rem);
  --text-splash: clamp(2.8rem, 8vw, 4.2rem);

  /* Geometry */
  --radius-sm: 1px;
  --radius-md: 2px;
}
```

## Rules

1. **Adding a token**: New tokens MUST be added to `:root` before use. Name format:
   `--category-name` (e.g., `--color-error`, `--text-3xl`).
2. **Removing a token**: Search all usages in `index.html` before removing. Remove
   only if zero usages remain.
3. **Changing a colour**: Edit only the `:root` value — all components update automatically.
4. **Geometry tokens**: Border radius values MUST remain 1 px or 2 px to preserve the
   minimal aesthetic. Values above 4 px are not permitted without a constitution amendment.
5. **Font fallbacks**: `--font-serif` MUST include `Georgia, serif` as fallback;
   `--font-sans` MUST include `system-ui, -apple-system, sans-serif`. This ensures
   legibility even if the `@font-face` injection has not been run yet.
