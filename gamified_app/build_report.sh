#!/bin/bash
# Build Report Generator

echo "📊 Generating Build Report..."

# Get build info
BUILD_DATE=$(date '+%Y-%m-%d %H:%M:%S')
GIT_COMMIT=$(git rev-parse --short HEAD)
GIT_BRANCH=$(git branch --show-current)
FLUTTER_VERSION=$(flutter --version | head -n 1)

echo "Build Report - $BUILD_DATE"
echo "================================"
echo "Git Commit: $GIT_COMMIT"
echo "Git Branch: $GIT_BRANCH"
echo "Flutter Version: $FLUTTER_VERSION"
echo ""

# Build web and analyze
echo "Building Web (Production)..."
flutter build web --release --analyze-size

# Build Android and analyze
echo ""
echo "Building Android..."
flutter build apk --release --analyze-size

echo ""
echo "✅ Build report generated successfully!"
