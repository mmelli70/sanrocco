# Data Model: Design System

**Feature**: 002-design-system
**Date**: 2026-04-10

## Design Token Model

All tokens are CSS custom properties declared in `:root`. They are the only
source of raw values; all components reference tokens via `var(--token)`.

### Colour Tokens

| Token | Value | Role |
|-------|-------|------|
| `--cream` | `#F7F3EE` | Page background |
| `--warm-white` | `#FDFAF6` | Card and surface background |
| `--charcoal` | `#2C2C2C` | Dark backgrounds (splash, header, section-hero, emergency) |
| `--stone` | `#8C8478` | Secondary text, muted labels, footer text |
| `--gold` | `#B8996A` | Primary accent — borders, active states, highlights |
| `--gold-light` | `#D4B896` | Secondary accent — subtitles, badge bg-adjacent text |
| `--border` | `#E2D9CF` | Dividers, card borders, nav separator |
| `--accent-bg` | `#F0EAE1` | Info/wifi box background |

### Typography Tokens

| Token | Value | Role |
|-------|-------|------|
| `--font-serif` | `'Cormorant Garamond', Georgia, serif` | Headings, property name, large numbers |
| `--font-sans` | `'Jost', system-ui, sans-serif` | Body, labels, navigation, buttons |
| `--text-2xs` | `0.58rem` | Badge, card-label uppercase |
| `--text-xs` | `0.68rem` | Splash enter, section-desc, emergency-name |
| `--text-sm` | `0.78rem` | Card body, rule text |
| `--text-base` | `0.9rem` | Card detail, general body text |
| `--text-md` | `1.05rem` | Wifi value, minor headings |
| `--text-lg` | `1.2rem` | Card title |
| `--text-xl` | `1.55rem` | Header name, rule numbers |
| `--text-hero` | `clamp(1.8rem, 5vw, 2.4rem)` | Section titles |
| `--text-splash` | `clamp(2.8rem, 8vw, 4.2rem)` | Splash property name |

### Geometry Tokens

| Token | Value | Role |
|-------|-------|------|
| `--radius-sm` | `1px` | Buttons, badges |
| `--radius-md` | `2px` | Cards, boxes |

### Spacing (not tokenised — use rem multiples directly)

Spacing follows an informal 4 px base grid (0.25rem steps). Not tokenised to
avoid over-engineering a single-file document.

## Typeface Variants

| Font file | Family | Weight | Style |
|-----------|--------|--------|-------|
| `cormorant-garamond-300.woff2` | Cormorant Garamond | 300 | normal |
| `cormorant-garamond-300-italic.woff2` | Cormorant Garamond | 300 | italic |
| `cormorant-garamond-400.woff2` | Cormorant Garamond | 400 | normal |
| `cormorant-garamond-400-italic.woff2` | Cormorant Garamond | 400 | italic |
| `cormorant-garamond-600.woff2` | Cormorant Garamond | 600 | normal |
| `jost-300.woff2` | Jost | 300 | normal |
| `jost-400.woff2` | Jost | 400 | normal |
| `jost-500.woff2` | Jost | 500 | normal |

All files are Latin Extended subset (~8–15 KB each, ~65–120 KB total).

## Component Class Inventory

| Class | Surface | Border | Typography | Notes |
|-------|---------|--------|------------|-------|
| `.card` | `--warm-white` | `1px --border`, `--radius-md` | `--font-sans` body | Hover: subtle box-shadow |
| `.card-label` | — | — | `--text-2xs`, `--gold`, uppercase, tracking | Gold category label above title |
| `.card-title` | — | — | `--font-serif`, `--text-lg`, weight 400 | Card headline |
| `.card-body` | — | — | `--text-sm`, `color #5a5550`, line-height 1.75 | Card prose |
| `.section-hero` | `--charcoal` | — | `--font-serif`, `--text-hero`, `--warm-white` | Section entry header |
| `.nav-item` | `--warm-white` | bottom `2px solid transparent` | `--text-2xs`, uppercase, tracking | Active: `--charcoal` + `--gold` border |
| `.ornament-divider` | — | `1px --border` (pseudo lines) | `--text-2xs`, `--gold`, uppercase | Flex row with `::before`/`::after` lines |
| `.badge` | `--gold` | `--radius-sm` | `--text-2xs`, white, uppercase | Inline pill tag |
| `.rule-item` | — | bottom `1px --border` | mixed serif/sans | Numbered rule row |
| `.wifi-box` / `.info-box` | `--accent-bg` | `1px --border`, left `3px --gold` | `--text-sm` body | Highlighted info block |
| `.emergency-card` | `--charcoal` | `--radius-md` | `--font-serif` number, `--gold-light` label | Emergency contact card |
| `.map-btn` | transparent | `1px --gold-light`, `--radius-sm` | `--text-2xs`, `--gold`, uppercase | Hover: fills `--gold`, white text |
