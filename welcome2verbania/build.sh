#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/index.html"
OUT="$ROOT/index.html"

echo "🔨 Building welcome2verbania..."

inject() {
  local token="$1"
  local file="$2"
  local mime="$3"
  if [ ! -f "$file" ]; then
    echo "⚠️  Skipping $token — $file not found"
    return
  fi
  local b64
  b64=$(base64 -i "$file" | tr -d '\n')
  # Use perl for reliable in-place replacement (macOS compatible)
  perl -i -pe "s|$token|data:$mime;base64,$b64|g" "$OUT"
  echo "✅  Injected $token ($(wc -c < "$file" | tr -d ' ') bytes)"
}

# Fonts
inject "{{FONT_CORMORANT_400}}" "$ROOT/assets/fonts/cormorant-400.woff2" "font/woff2"
inject "{{FONT_CORMORANT_700}}" "$ROOT/assets/fonts/cormorant-700.woff2" "font/woff2"
inject "{{FONT_JOST_400}}"      "$ROOT/assets/fonts/jost-400.woff2"      "font/woff2"
inject "{{FONT_JOST_500}}"      "$ROOT/assets/fonts/jost-500.woff2"      "font/woff2"
inject "{{FONT_JOST_700}}"      "$ROOT/assets/fonts/jost-700.woff2"      "font/woff2"

# Background image
inject "{{HOME_BG}}"       "$ROOT/assets/home.jpeg"    "image/jpeg"
# ZTL sign
inject "{{ZTL_SIGN}}"      "$ROOT/assets/ztl-sign.png" "image/png"
# Door photos
inject "{{DOOR_PHOTO_1}}"  "$ROOT/assets/door1.jpg"    "image/jpeg"
inject "{{DOOR_PHOTO_2}}"  "$ROOT/assets/door2.jpg"    "image/jpeg"
inject "{{DOOR_PHOTO_3}}"  "$ROOT/assets/door3.jpg"    "image/jpeg"

SIZE=$(wc -c < "$OUT" | tr -d ' ')
echo ""
echo "✅  Build complete → index.html ($(echo "scale=1; $SIZE/1024/1024" | bc) MB)"
