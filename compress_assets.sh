#!/bin/bash

# Asset Compression Script
# Optimizes images, fonts, and other assets for web delivery

set -e

echo "🖼️  Starting Asset Compression..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

TOTAL_SAVINGS=0

compress_png() {
    local file=$1
    local original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    
    echo -e "${BLUE}Compressing PNG: $file${NC}"
    
    # Try pngquant (best for PNG)
    if command -v pngquant &> /dev/null; then
        pngquant --force --ext .png --quality=65-80 "$file" 2>/dev/null || true
        local new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    # Try optipng as fallback
    elif command -v optipng &> /dev/null; then
        optipng -o2 "$file" 2>/dev/null || true
        local new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    else
        echo -e "${YELLOW}⚠️  pngquant/optipng not found, skipping PNG optimization${NC}"
        return
    fi
    
    local saved=$((original_size - new_size))
    local percent=$((saved * 100 / original_size))
    TOTAL_SAVINGS=$((TOTAL_SAVINGS + saved))
    
    echo -e "${GREEN}✅ Saved ${saved} bytes (${percent}%)${NC}"
}

compress_jpeg() {
    local file=$1
    local original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    
    echo -e "${BLUE}Compressing JPEG: $file${NC}"
    
    # Try jpegoptim
    if command -v jpegoptim &> /dev/null; then
        jpegoptim --strip-all --max=80 "$file" 2>/dev/null || true
        local new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    # Try mozjpeg as fallback
    elif command -v cjpeg &> /dev/null; then
        local temp_file=$(mktemp)
        cjpeg -quality 80 "$file" > "$temp_file" 2>/dev/null || true
        mv "$temp_file" "$file"
        local new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    else
        echo -e "${YELLOW}⚠️  jpegoptim/mozjpeg not found, skipping JPEG optimization${NC}"
        return
    fi
    
    local saved=$((original_size - new_size))
    local percent=$((saved * 100 / original_size))
    TOTAL_SAVINGS=$((TOTAL_SAVINGS + saved))
    
    echo -e "${GREEN}✅ Saved ${saved} bytes (${percent}%)${NC}"
}

compress_svg() {
    local file=$1
    local original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    
    echo -e "${BLUE}Optimizing SVG: $file${NC}"
    
    # Try svgo
    if command -v svgo &> /dev/null; then
        svgo --input="$file" --output="$file" 2>/dev/null || true
        local new_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    else
        echo -e "${YELLOW}⚠️  svgo not found, skipping SVG optimization${NC}"
        return
    fi
    
    local saved=$((original_size - new_size))
    local percent=$((saved * 100 / original_size))
    TOTAL_SAVINGS=$((TOTAL_SAVINGS + saved))
    
    echo -e "${GREEN}✅ Saved ${saved} bytes (${percent}%)${NC}"
}

compress_webp() {
    local file=$1
    local original_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
    
    echo -e "${BLUE}Converting to WebP: $file${NC}"
    
    # Try cwebp
    if command -v cwebp &> /dev/null; then
        local webp_file="${file%.*}.webp"
        cwebp -q 80 "$file" -o "$webp_file" 2>/dev/null || true
        
        if [ -f "$webp_file" ]; then
            local new_size=$(stat -f%z "$webp_file" 2>/dev/null || stat -c%s "$webp_file")
            local saved=$((original_size - new_size))
            local percent=$((saved * 100 / original_size))
            TOTAL_SAVINGS=$((TOTAL_SAVINGS + saved))
            
            echo -e "${GREEN}✅ WebP: Saved ${saved} bytes (${percent}%)${NC}"
            
            # Replace original with WebP if smaller
            if [ $new_size -lt $original_size ]; then
                mv "$webp_file" "$file"
                echo -e "${GREEN}✅ Replaced with WebP${NC}"
            else
                rm "$webp_file"
            fi
        fi
    else
        echo -e "${YELLOW}⚠️  cwebp not found, skipping WebP conversion${NC}"
    fi
}

echo -e "${BLUE}1. Compressing PNG images...${NC}"
find web -name "*.png" -type f 2>/dev/null | while read file; do
    compress_png "$file"
done

echo -e "${BLUE}2. Compressing JPEG images...${NC}"
find web -name "*.jpg" -o -name "*.jpeg" -type f 2>/dev/null | while read file; do
    compress_jpeg "$file"
done

echo -e "${BLUE}3. Optimizing SVG files...${NC}"
find web -name "*.svg" -type f 2>/dev/null | while read file; do
    compress_svg "$file"
done

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}📊 Compression Summary${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "Total bytes saved: ${TOTAL_SAVINGS}"
echo "Total KB saved: $((TOTAL_SAVINGS / 1024))"
echo "Total MB saved: $((TOTAL_SAVINGS / 1024 / 1024))"
echo ""
echo -e "${GREEN}✨ Asset compression complete!${NC}"

# Create report
cat > asset_compression_report.txt << REPORT
Asset Compression Report
========================

Date: $(date)
Total Bytes Saved: $TOTAL_SAVINGS
Total KB Saved: $((TOTAL_SAVINGS / 1024))
Total MB Saved: $((TOTAL_SAVINGS / 1024 / 1024))

Recommendations:
1. Use WebP format for photos (25-35% smaller)
2. Use SVG for icons and graphics (60-80% smaller)
3. Enable GZIP/Brotli compression on server
4. Set proper cache headers for static assets
5. Consider lazy loading for below-the-fold images

Next Steps:
- Update HTML to reference optimized assets
- Set up automated compression in build process
- Implement responsive images with srcset
REPORT

echo -e "${BLUE}📄 Report saved to: asset_compression_report.txt${NC}"
