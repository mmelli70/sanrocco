# Quickstart: Welcome Page

**Feature**: 001-welcome-page  
**Date**: 2026-04-10

## Prerequisites

- A text editor (VS Code, TextEdit, Notepad — any will do)
- A JPEG or PNG background image (owner-supplied; recommended: 1200 × 800 px minimum)
- Optional: `bash` + `base64` command-line tool (for image re-encoding via `build.sh`)

## Open the Guide

1. Locate `index.html` in the project root.
2. Double-click it, or open it from WhatsApp / email.
3. The welcome screen displays immediately — no internet required.

## Update Text Content

All user-visible text lives in the `CONTENT` object near the top of `index.html`:

```js
const CONTENT = {
  strings: {
    en: {
      propertyName: "San Rocco",
      subtitle:     "Bed & Breakfast Guest Guide",
      location:     "Verbania - Italy",
      ...
    }
  }
};
```

1. Open `index.html` in a text editor.
2. Find the `CONTENT` object (search for `const CONTENT`).
3. Edit the string values.
4. Save the file — done. No build step needed.

## Replace the Background Image

### With `build.sh` (recommended)

```bash
# Place new image at:
cp /path/to/your/photo.jpg assets/background.jpg

# Re-encode and inject into index.html:
bash build.sh
```

The script base64-encodes `assets/background.jpg` and replaces the
`data:image/...` URI inside `index.html`.

### Without `build.sh` (manual)

```bash
# Encode the image to base64 (macOS / Linux):
base64 -i assets/background.jpg | tr -d '\n' > /tmp/bg.b64

# In index.html, find the line:
#   background-image: url('data:image/jpeg;base64,XXXX...');
# Replace XXXX... with the contents of /tmp/bg.b64
```

## Release a New Version

1. Make your content or image changes.
2. Bump the version in `index.html`:
   ```js
   const VERSION = "1.1.0"; // MAJOR.MINOR.PATCH
   ```
3. Distribute `index.html` to guests via email or WhatsApp.

## Test Before Distributing

Open `index.html` in each of these before sending:

| Environment | How to test |
|-------------|-------------|
| iOS Safari | AirDrop to iPhone, open from Files app |
| Android Chrome | Send via WhatsApp, open attachment |
| Desktop Chrome / Firefox | Double-click the file |
| Airplane mode | Enable airplane mode, then open — must work fully |

Checklist:
- [ ] Background image visible
- [ ] "San Rocco" / subtitle / location text visible without scrolling
- [ ] Language flags visible
- [ ] English flag tappable and active
- [ ] No broken images or console errors
