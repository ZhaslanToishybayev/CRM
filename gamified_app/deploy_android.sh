#!/bin/bash
# Android Deployment Script

set -e

echo "🚀 Starting Android Deployment..."

# Get environment
ENV=${1:-production}
echo "Environment: $ENV"

# Load environment variables
if [ -f ".env.$ENV" ]; then
    echo "Loading environment variables from .env.$ENV"
    export $(cat .env.$ENV | grep -v '^#' | xargs)
fi

# Clean and get dependencies
flutter clean
flutter pub get

# Analyze and test
flutter analyze
flutter test

# Build Android APK
echo "🏗️ Building Android APK..."
flutter build apk --release \
    --dart-define=ENVIRONMENT=$ENV \
    --no-sound-null-safety

# Build Android App Bundle (for Play Store)
echo "🏗️ Building Android App Bundle..."
flutter build appbundle --release \
    --dart-define=ENVIRONMENT=$ENV \
    --no-sound-null-safety

echo "✅ Android build completed!"
echo "APK: build/app/outputs/flutter-apk/app-release.apk"
echo "AAB: build/app/outputs/bundle/release/app-release.aab"
