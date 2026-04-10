# Component Classes Contract

**Feature**: 002-design-system
**Date**: 2026-04-10
**Type**: CSS class definitions in `index.html` `<style>` block

## Purpose

Defines the expected visual behaviour of each reusable component class.
Implementations MUST produce the described result. Only design tokens from
`design-tokens.md` may be used as values.

## Components

### `.card`
A content card on a warm-white surface with a subtle border and hover elevation.

- Background: `var(--warm-white)`
- Border: `1px solid var(--border)`, `border-radius: var(--radius-md)`
- Padding: `22px 20px`
- Margin-bottom: `16px`
- Hover: `box-shadow: 0 4px 20px rgba(0,0,0,0.07)`

**Sub-elements** (must be styled as part of `.card` rules):
- `.card-label` — `var(--text-2xs)`, `var(--gold)`, uppercase, `letter-spacing: 0.28em`, `font-weight: 500`
- `.card-title` — `var(--font-serif)`, `var(--text-lg)`, `font-weight: 400`, `var(--charcoal)`
- `.card-body` — `var(--text-sm)`, `color: #5a5550`, `line-height: 1.75`
- `.card-detail` — flex row, `gap: 10px`, `var(--text-base)`, `var(--stone)`
- `.card-footer` — flex row, `justify-content: flex-end`, top border `1px solid var(--border)`, `margin-top: 14px`, `padding-top: 12px`

---

### `.section-hero`
Full-width dark header displayed at the top of each section.

- Background: `var(--charcoal)`
- Padding: `44px 28px 36px`
- Text-align: center
- `.section-icon` — `font-size: 1.6rem`, `margin-bottom: 12px`
- `.section-title` — `var(--font-serif)`, `var(--text-hero)`, `font-weight: 300`, `var(--warm-white)`, `letter-spacing: 0.1em`
- `.section-desc` — `var(--text-xs)`, `letter-spacing: 0.2em`, `var(--gold-light)`, uppercase, `margin-top: 8px`

---

### `.nav-item`
Horizontal navigation tab, part of a scrollable `<nav>` bar.

- Flex: `0 0 auto`
- Padding: `14px 20px`
- Font: `var(--text-2xs)`, uppercase, `letter-spacing: 0.22em`, `var(--stone)`, `font-weight: 400`
- Border-bottom: `2px solid transparent`
- Transition: `all 0.25s ease`
- **Active state** (`.nav-item.active`): `color: var(--charcoal)`, `border-bottom-color: var(--gold)`
- **Hover**: `color: var(--charcoal)`
- Min touch target: `44px` height enforced via padding

---

### `.ornament-divider`
Decorative section separator — thin lines flanking a centred gold label.

- Display: flex, `align-items: center`, `gap: 12px`
- `::before` and `::after`: `flex: 1`, `height: 1px`, `background: var(--border)`
- Inner `<span>`: `var(--text-2xs)`, uppercase, `letter-spacing: 0.25em`, `var(--gold)`, `font-weight: 500`
- Margin: `28px 0 20px`

---

### `.badge`
Small inline pill label (used inside `.card-label`).

- Display: `inline-block`
- Font: `var(--text-2xs)`, uppercase, `letter-spacing: 0.2em`, `color: white`, `font-weight: 500`
- Background: `var(--gold)`
- Padding: `3px 8px`
- Border-radius: `var(--radius-sm)`
- Margin-left: `8px`, `vertical-align: middle`

---

### `.rule-item`
A numbered rule row (used in House Rules section).

- Display: flex, `gap: 16px`, `align-items: flex-start`
- Padding: `18px 0`
- Border-bottom: `1px solid var(--border)` (last child: none)
- `.rule-num` — `var(--font-serif)`, `1.4rem`, `font-weight: 300`, `var(--gold)`, `width: 28px`, `text-align: right`
- `.rule-title` — `font-weight: 500`, `var(--text-sm)`, `letter-spacing: 0.05em`, `margin-bottom: 4px`
- `.rule-text` — `var(--text-sm)`, `color: #6a6560`, `line-height: 1.65`

---

### `.wifi-box` / `.info-box`
Highlighted information block with a gold left accent border.

- Background: `var(--accent-bg)`
- Border: `1px solid var(--border)`, `border-left: 3px solid var(--gold)`
- Padding: `22px 20px`
- Border-radius: `var(--radius-md)`
- Margin-bottom: `20px`
- `.wifi-label` — `var(--text-2xs)`, `var(--gold)`, uppercase, `letter-spacing: 0.28em`, `font-weight: 500`
- `.wifi-row` — flex, `justify-content: space-between`, `align-items: center`
- `.wifi-key` — `var(--text-xs)`, `var(--stone)`, uppercase, `letter-spacing: 0.1em`
- `.wifi-value` — `var(--font-serif)`, `var(--text-md)`, `var(--charcoal)`, `font-weight: 400`
- `.info-box` body text — `var(--text-sm)`, `line-height: 1.7`, `color: #5a5550`

---

### `.emergency-card`
Dark card for emergency contact numbers.

- Background: `var(--charcoal)`
- Border-radius: `var(--radius-md)`
- Padding: `20px`
- Margin-bottom: `12px`
- Display: flex, `align-items: center`, `gap: 16px`
- `.emergency-icon` — `font-size: 1.5rem`
- `.emergency-name` — `var(--text-xs)`, uppercase, `letter-spacing: 0.2em`, `var(--gold-light)`
- `.emergency-number` — `var(--font-serif)`, `var(--text-xl)`, `font-weight: 300`, `var(--warm-white)`, `letter-spacing: 0.05em`
- `.emergency-note` — `var(--text-xs)`, `var(--stone)`, `margin-top: 2px`

---

### `.map-btn`
A small bordered button linking to an external map.

- Display: `inline-flex`, `align-items: center`, `gap: 6px`
- Font: `var(--text-2xs)`, uppercase, `letter-spacing: 0.2em`, `font-weight: 500`, `var(--gold)`, `var(--font-sans)`
- Border: `1px solid var(--gold-light)`, `border-radius: var(--radius-sm)`
- Padding: `7px 14px`
- Transition: `all 0.2s ease`
- Text-decoration: none
- **Hover**: `background: var(--gold)`, `color: white`, `border-color: var(--gold)`
- Min touch target: `44px` height via `min-height: 44px`

## Extension Rules

1. New components MUST use only tokens from `design-tokens.md`.
2. New components MUST be documented in this file before implementation.
3. Modifier classes (e.g., `.card--dark`) follow BEM-lite naming: `block--modifier`.
4. No hardcoded hex, px font sizes, or raw font-family strings in component rules.
