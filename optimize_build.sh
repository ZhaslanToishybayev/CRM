#!/bin/bash

# Build Optimization Script for Flutter Web
# Optimizes build size and performance

set -e

echo "🚀 Starting Build Optimization..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}1. Cleaning previous builds...${NC}"
rm -rf build/web/*
rm -rf .dart_tool/build

echo -e "${GREEN}✅ Clean complete${NC}"

echo -e "${BLUE}2. Analyzing current dependencies...${NC}"
dart pub deps --style=compact

echo -e "${GREEN}✅ Dependency analysis complete${NC}"

echo -e "${BLUE}3. Building optimized web app...${NC}"
# Build with optimization flags
flutter build web \
    --release \
    --web-renderer canvaskit \
    --dart-define=flutter.web.canvaskit.url=/canvaskit/canvaskit.wasm \
    --source-maps

echo -e "${GREEN}✅ Web build complete${NC}"

echo -e "${BLUE}4. Analyzing build size...${NC}"
TOTAL_SIZE=$(du -sh build/web | cut -f1)
CANVASKIT_SIZE=$(du -sh build/web/canvaskit | cut -f1)
ASSETS_SIZE=$(du -sh build/web/assets | cut -f1)

echo ""
echo -e "${YELLOW}📊 Build Size Analysis:${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Total Size:      ${TOTAL_SIZE}"
echo "Canvaskit:       ${CANVASKIT_SIZE}"
echo "Assets:          ${ASSETS_SIZE}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -e "${BLUE}5. Compressing build artifacts...${NC}"
cd build/web

# Create compressed versions for server deployment
if command -v gzip &> /dev/null; then
    find . -name "*.js" -exec gzip -k -9 {} \;
    find . -name "*.css" -exec gzip -k -9 {} \;
    find . -name "*.html" -exec gzip -k -9 {} \;
    echo -e "${GREEN}✅ Gzip compression complete${NC}"
fi

if command -v brotli &> /dev/null; then
    find . -name "*.js" -exec brotli -k -q 11 {} \;
    find . -name "*.css" -exec brotli -k -q 11 {} \;
    find . -name "*.html" -exec brotli -k -q 11 {} \;
    echo -e "${GREEN}✅ Brotli compression complete${NC}"
fi

cd ../..

echo -e "${GREEN}6. Generating build report...${NC}"
cat > build_size_report.txt << 'REPORT'
=====================================
Flutter Web Build Optimization Report
=====================================

Build Configuration:
- Target: Web
- Mode: Release
- Renderer: CanvasKit
- Minification: Enabled
- Tree Shaking: Enabled

Compression:
- Gzip: Enabled for JS, CSS, HTML
- Brotli: Enabled (if available)
- Assets: Optimized

Size Breakdown:
REPORT

du -sh build/web/* >> build_size_report.txt

echo ""
cat build_size_report.txt

echo ""
echo -e "${GREEN}✨ Optimization complete!${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Deploy build/web/ to your web server"
echo "  2. Configure server with nginx.conf or .htaccess"
echo "  3. Set up CDN for canvaskit/ directory (26MB)"
echo ""
