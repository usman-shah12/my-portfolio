#!/bin/bash
# Run this script ONCE to download Poppins fonts into assets/fonts/
# Usage: cd portfolio_app && bash download_fonts.sh

set -e

FONTS_DIR="assets/fonts"
mkdir -p "$FONTS_DIR"

echo "Downloading Poppins fonts from Google Fonts CDN..."

BASE="https://fonts.gstatic.com/s/poppins/v21"

declare -A FONTS=(
  ["Poppins-Regular.ttf"]="pxiEyp8kv8JHgFVrJJfecg.woff2"
  ["Poppins-Italic.ttf"]="pxiGyp8kv8JHgFVrJJLed3FBGg.woff2"
  ["Poppins-Medium.ttf"]="pxiByp8kv8JHgFVrLGT9Z1xlFQ.woff2"
  ["Poppins-SemiBold.ttf"]="pxiByp8kv8JHgFVrLEj6Z1xlFQ.woff2"
  ["Poppins-Bold.ttf"]="pxiByp8kv8JHgFVrLCz7Z1xlFQ.woff2"
  ["Poppins-ExtraBold.ttf"]="pxiByp8kv8JHgFVrLDD4Z1xlFQ.woff2"
)

# Better: download full TTF files from GitHub mirror
TTF_BASE="https://github.com/itfoundry/Poppins/raw/master/fonts/ttf"

curl -L -o "$FONTS_DIR/Poppins-Regular.ttf"   "$TTF_BASE/Poppins-Regular.ttf"
curl -L -o "$FONTS_DIR/Poppins-Italic.ttf"    "$TTF_BASE/Poppins-Italic.ttf"
curl -L -o "$FONTS_DIR/Poppins-Medium.ttf"    "$TTF_BASE/Poppins-Medium.ttf"
curl -L -o "$FONTS_DIR/Poppins-SemiBold.ttf"  "$TTF_BASE/Poppins-SemiBold.ttf"
curl -L -o "$FONTS_DIR/Poppins-Bold.ttf"      "$TTF_BASE/Poppins-Bold.ttf"
curl -L -o "$FONTS_DIR/Poppins-ExtraBold.ttf" "$TTF_BASE/Poppins-ExtraBold.ttf"

echo ""
echo "Done! Fonts saved to $FONTS_DIR/"
ls -lh "$FONTS_DIR/"
echo ""
echo "Now run: flutter pub get && flutter run"
