# Content Schema Contract

**Feature**: 001-welcome-page  
**Date**: 2026-04-10  
**Type**: In-file JavaScript content contract

## Purpose

Defines the shape of the `CONTENT` object embedded in `index.html`. This is the single
point of truth for all user-visible text. Content authors edit only this object.

## Schema

```js
const CONTENT = {
  // --- Languages available in this version ---
  languages: [
    { code: "en", flag: "🇬🇧", label: "English", active: true  },
    { code: "it", flag: "🇮🇹", label: "Italiano", active: false },  // future
    { code: "de", flag: "🇩🇪", label: "Deutsch",  active: false },  // future
  ],

  defaultLanguage: "en",

  // --- Per-language content strings ---
  // Each key in `strings` MUST match a `code` in `languages`.
  // Every active language MUST define all keys listed under `en`.
  strings: {
    en: {
      propertyName:           "San Rocco",
      subtitle:               "Bed & Breakfast Guest Guide",
      location:               "Verbania - Italy",
      languageSelectorLabel:  "Select language",
    },
    // it: { ... },  // add when Italian content is ready
    // de: { ... },  // add when German content is ready
  },
};
```

## Rules

1. `languages` array order determines the left-to-right display order of flags.
2. A language with `active: false` MUST render its flag at reduced opacity and MUST NOT
   be tappable (disabled interaction) until content is added and `active` is set to `true`.
3. Every key present in `strings.en` MUST also be present in every other active language's
   strings block. Missing keys fall back to `en` silently (no error shown to guest).
4. `propertyName` and `location` are proper nouns and MAY be identical across all
   languages — but MUST still be explicitly listed in each language block.
5. Adding a new language requires:
   - Adding an entry to `languages` with `active: true`
   - Adding a matching block under `strings` with all required keys

## Versioning

Changes to this schema that add optional keys are backward-compatible (MINOR bump).
Changes that remove or rename keys require a MAJOR bump and an update of all active
language string blocks.
