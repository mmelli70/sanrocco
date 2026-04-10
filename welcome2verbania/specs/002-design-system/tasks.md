# Tasks: Design System

**Input**: `specs/002-design-system/`
**Prerequisites**: plan.md ✅, spec.md ✅, contracts/ ✅

---

## Phase 1: Fonts

**Purpose**: Embed Cormorant Garamond + Jost as base64 WOFF2 — no CDN, fully offline.

- [ ] T002-01 Run `download-fonts.sh` (or equivalent curl commands) to fetch Cormorant Garamond (Regular 400, Bold 700) and Jost (Regular 400, Medium 500, Bold 700) WOFF2 files from fonts.gstatic.com into `assets/fonts/`
- [ ] T002-02 In `index.html` `<style>` block, add `@font-face` declarations for each font file using `src: url('data:font/woff2;base64,{{FONT_NAME}}') format('woff2')` tokens; one declaration per weight/style
- [ ] T002-03 Extend `build.sh` to inject all 5 font tokens: read each `.woff2` file, base64-encode, replace corresponding `{{FONT_NAME}}` token in `index.html`

**Checkpoint**: Open `index.html` in airplane mode — Cormorant Garamond and Jost render correctly (not system fallback).

---

## Phase 2: CSS Design Tokens

**Purpose**: Establish the canonical `:root` token set used by every component.

- [ ] T002-04 Add CSS `:root` block to `index.html` `<style>` (after `@font-face`):
  - Colours: `--color-primary: #8B6F47`, `--color-primary-dark: #6B5337`, `--color-accent: #C9A96E`, `--color-bg: #FAFAF8`, `--color-surface: #FFFFFF`, `--color-text: #2C2C2C`, `--color-text-muted: #6B6B6B`, `--color-warning: #B8860B`
  - Typography: `--font-heading: 'Cormorant Garamond', Georgia, serif`, `--font-body: 'Jost', system-ui, sans-serif`, `--font-size-xs: 0.75rem`, `--font-size-sm: 0.875rem`, `--font-size-base: 1rem`, `--font-size-lg: 1.125rem`, `--font-size-xl: 1.375rem`, `--font-size-2xl: 1.75rem`, `--font-size-3xl: 2.25rem`, `--font-size-4xl: 3rem`, `--line-height-tight: 1.2`, `--line-height-normal: 1.5`
  - Geometry: `--radius: 0.75rem`, `--shadow: 0 2px 8px rgba(0,0,0,0.08)`

**Checkpoint**: Open browser DevTools — all tokens are present in `:root`.

---

## Phase 3: Base Styles

**Purpose**: Global resets and typography applied to the whole document.

- [ ] T002-05 [P] Add global base styles to `<style>`: `body { font-family: var(--font-body); font-size: var(--font-size-base); color: var(--color-text); background: var(--color-bg); line-height: var(--line-height-normal); }`, `h1,h2,h3,h4 { font-family: var(--font-heading); line-height: var(--line-height-tight); color: var(--color-primary-dark); }`, `a { color: var(--color-primary); }`
- [ ] T002-06 [P] Add layout utility classes: `.container { max-width: 640px; margin: 0 auto; padding: 0 1rem; }`, `.screen { min-height: 100dvh; display: flex; flex-direction: column; }`, `.section-content { padding: 1rem 0 4rem; }`

**Checkpoint**: Any screen using these classes renders with correct fonts and spacing.

---

## Phase 4: Component Classes

**Purpose**: Build all reusable UI components defined in `specs/002-design-system/contracts/component-classes.md`.

- [ ] T002-07 Add `.section-header` component: sticky top bar, `background: var(--color-surface)`, `border-bottom: 1px solid rgba(0,0,0,0.08)`, `padding: 0.75rem 1rem`, flex row with back button + section title; `position: sticky; top: 0; z-index: 10`
- [ ] T002-08 [P] Add `.back-btn` component: `background: none; border: none; color: var(--color-primary); font-size: var(--font-size-lg); cursor: pointer; padding: 0.25rem 0.5rem; min-width: 44px; min-height: 44px; display: flex; align-items: center; gap: 0.25rem`
- [ ] T002-09 [P] Add `.card` component: `background: var(--color-surface); border-radius: var(--radius); box-shadow: var(--shadow); padding: 1rem; margin-bottom: 1rem`; child `.card-title { font-family: var(--font-heading); font-size: var(--font-size-xl); color: var(--color-primary-dark); margin-bottom: 0.25rem }`; child `.card-description { font-size: var(--font-size-sm); color: var(--color-text-muted); line-height: var(--line-height-normal); }`
- [ ] T002-10 [P] Add `.info-box` component: `background: #F0EBE3; border-left: 3px solid var(--color-primary); border-radius: 0 var(--radius) var(--radius) 0; padding: 0.875rem 1rem; margin-bottom: 1rem; font-size: var(--font-size-sm)`
- [ ] T002-11 [P] Add `.warning-box` component: `background: #FFF8E7; border-left: 3px solid var(--color-warning); border-radius: 0 var(--radius) var(--radius) 0; padding: 0.875rem 1rem; margin-bottom: 1rem; font-size: var(--font-size-sm)`; title in `color: var(--color-warning); font-weight: 600`
- [ ] T002-12 [P] Add `.emergency-card` component: `background: var(--color-surface); border-radius: var(--radius); border-left: 4px solid #D32F2F; box-shadow: var(--shadow); padding: 1rem; margin-bottom: 0.75rem`; `.emergency-card--primary { border-left-width: 6px; background: #FFF5F5; }` child `.emergency-number { font-size: var(--font-size-2xl); font-weight: 700; color: #D32F2F; display: block; min-height: 44px; line-height: 44px; }`
- [ ] T002-13 [P] Add `.btn` and `.btn-maps` components: `.btn { display: inline-flex; align-items: center; gap: 0.375rem; padding: 0.5rem 1rem; border-radius: calc(var(--radius)/2); font-size: var(--font-size-sm); font-weight: 500; cursor: pointer; border: none; min-height: 44px; text-decoration: none; }`, `.btn-maps { background: var(--color-primary); color: #fff; }`, `.btn-info { background: var(--color-surface); color: var(--color-primary); border: 1px solid var(--color-primary); }`
- [ ] T002-14 [P] Add `.badge` and `.badge-favourite` components: `.badge { display: inline-block; padding: 0.125rem 0.5rem; border-radius: 999px; font-size: var(--font-size-xs); font-weight: 600; }`, `.badge-favourite { background: var(--color-accent); color: #fff; }`, `.badge-not-tested { background: #E0E0E0; color: #555; }`
- [ ] T002-15 [P] Add `.rating` and `.price` display components: `.rating span, .price span { font-size: var(--font-size-base); }`, `.rating .filled { color: var(--color-accent); }`, `.rating .empty { color: #DDD; }`, `.price .filled { color: var(--color-primary); }`, `.price .empty { color: #DDD; }`
- [ ] T002-16 [P] Add `.contact-card` component: `background: var(--color-surface); border-radius: var(--radius); box-shadow: var(--shadow); padding: 1.25rem; margin-bottom: 1rem`; `.contact-name { font-family: var(--font-heading); font-size: var(--font-size-2xl); }`, `.contact-actions { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: 0.75rem; }`; action buttons use `.btn` base with icons

**Checkpoint**: Create a scratch HTML page with one of each component — all render correctly with correct colours and spacing at 360 dp.

---

## Phase 5: Section Grid (Home Screen Components)

- [ ] T002-17 Add `.section-grid` and `.section-box` components for the home screen: `.section-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 0.75rem; padding: 1rem; }`, `.section-box { background: var(--color-surface); border-radius: var(--radius); box-shadow: var(--shadow); display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 1.25rem 0.5rem; gap: 0.5rem; cursor: pointer; min-height: 88px; border: none; width: 100%; }`, `.section-box .icon { font-size: 2rem; }`, `.section-box .label { font-size: var(--font-size-sm); font-weight: 500; text-align: center; color: var(--color-text); }`

**Checkpoint**: Grid of 11 boxes renders in 2-column layout at 360 dp with no overflow.

---

## Dependencies

- T002-01 → T002-02 → T002-03 (fonts must exist before tokens)
- T002-04 must complete before any component tasks (T002-07 through T002-17) — tokens must exist
- T002-05 to T002-17 can all run in parallel once T002-04 is done
