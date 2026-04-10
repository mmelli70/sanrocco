# Data Model: Welcome Page

**Feature**: 001-welcome-page  
**Date**: 2026-04-10

## Content Model

The welcome page has no persistent data. All content is static and embedded in the HTML file
at build/edit time. The logical content model is:

### WelcomeScreen

| Field | Type | Example | Notes |
|-------|------|---------|-------|
| `propertyName` | string | `"San Rocco"` | Large heading; top of text stack |
| `subtitle` | string | `"Bed & Breakfast Guest Guide"` | Below property name |
| `location` | string | `"Verbania - Italy"` | Below subtitle |
| `backgroundImage` | base64 data URI | `data:image/jpeg;base64,...` | Inlined in CSS |
| `version` | string | `"1.0.0"` | Visible in document footer or meta |

### LanguageSelector

| Field | Type | Example | Notes |
|-------|------|---------|-------|
| `availableLanguages` | Language[] | `[{code:"en", flag:"🇬🇧", label:"English"}]` | Ordered list |
| `defaultLanguage` | string (code) | `"en"` | Fallback if browser locale not matched |

### Language

| Field | Type | Example | Notes |
|-------|------|---------|-------|
| `code` | string | `"en"` | BCP-47 language tag |
| `flag` | string (emoji) | `"🇬🇧"` | Rendered as tap target |
| `label` | string | `"English"` | Accessible label (aria-label) |
| `active` | boolean | `true` | Whether this language has content yet |

### ContentStrings (per language)

Each language entry in the `CONTENT` object maps the same keys to translated strings.

| Key | EN value | Notes |
|-----|----------|-------|
| `propertyName` | `"San Rocco"` | Proper noun — likely same across languages |
| `subtitle` | `"Bed & Breakfast Guest Guide"` | Translated per language |
| `location` | `"Verbania - Italy"` | Likely same across languages |
| `languageSelectorLabel` | `"Select language"` | Screen-reader label for the selector |

## State Model

The welcome screen has one piece of runtime state: **active language**.

| State | Initial value | Transitions |
|-------|---------------|-------------|
| `currentLang` | Browser locale match or `"en"` | User taps a flag → `setLanguage(code)` |

State is NOT persisted. Each time the file is opened, language defaults to browser locale
(with `"en"` fallback). This is correct behaviour per constitution (stateless).
