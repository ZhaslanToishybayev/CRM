#!/bin/bash
# Web Deployment Script

set -e

echo "🚀 Starting Web Deployment..."

# Get environment
ENV=${1:-production}
echo "Environment: $ENV"

# Load environment variables
if [ -f ".env.$ENV" ]; then
    echo "Loading environment variables from .env.$ENV"
    export $(cat .env.$ENV | grep -v '^#' | xargs)
else
    echo "❌ Environment file .env.$ENV not found"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Analyze code
echo "🔍 Analyzing code..."
flutter analyze

# Run tests
echo "🧪 Running tests..."
flutter test

# Build optimized web version
echo "🏗️ Building web application..."
if [ "$ENV" = "production" ]; then
    flutter build web --release \
        --dart-define=ENVIRONMENT=production \
        --web-renderer canvaskill \
        --tree-shake-icons \
        --no-sound-null-safety
else
    flutter build web --release \
        --dart-define=ENVIRONMENT=$ENV \
        --web-renderer canvaskill
fi

# Deploy to Firebase Hosting (if configured)
if [ "$DEPLOY_FIREBASE" = "true" ]; then
    echo "🔥 Deploying to Firebase..."
    firebase deploy --only hosting
fi

# Deploy to Vercel (if configured)
if [ "$DEPLOY_VERCEL" = "true" ]; then
    echo "▲ Deploying to Vercel..."
    npx vercel --prod
fi

echo "✅ Web deployment completed!"
echo "Build location: build/web/"
