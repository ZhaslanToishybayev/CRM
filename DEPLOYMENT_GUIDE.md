# Deployment Guide

## Overview
This guide covers the deployment process for the Gamified Task Management App across multiple platforms.

## Prerequisites
- Flutter SDK 3.24.0+
- Git
- Firebase CLI (for web deployment)
- Android SDK (for Android deployment)
- Xcode (for iOS deployment)

## Environment Configuration

### Development
```bash
cp .env.development .env
flutter run
```

### Staging
```bash
cp .env.staging .env
./deploy_web.sh staging
```

### Production
```bash
cp .env.production .env
./deploy_web.sh production
```

## Deployment Platforms

### Web Deployment

#### Option 1: Firebase Hosting
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in project
firebase init hosting

# Deploy
./deploy_web.sh production
firebase deploy --only hosting
```

#### Option 2: Vercel
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
./deploy_web.sh production
vercel --prod
```

#### Option 3: Netlify
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
./deploy_web.sh production
netlify deploy --prod --dir=build/web
```

### Android Deployment

#### Build APK
```bash
./deploy_android.sh production
```

The APK will be generated at:
`build/app/outputs/flutter-apk/app-release.apk`

#### Build App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

The AAB will be generated at:
`build/app/outputs/bundle/release/app-release.aab`

### iOS Deployment

#### Build for iOS
```bash
# Build for iOS
flutter build ios --release

# Open in Xcode for App Store submission
open ios/Runner.xcworkspace
```

## CI/CD Pipeline

The project uses GitHub Actions for automated deployment:

### Workflow File
`.github/workflows/tests.yml`

### Triggered On
- Push to `main` or `develop` branch
- Pull requests to `main` branch

### Pipeline Steps
1. Code analysis (`flutter analyze`)
2. Unit tests (`flutter test`)
3. Widget tests
4. Integration tests
5. Build applications
6. Upload artifacts

## Environment Variables

| Variable | Development | Staging | Production |
|----------|-------------|---------|------------|
| ENVIRONMENT | development | staging | production |
| SUPABASE_URL | ✓ | ✓ | ✓ |
| SUPABASE_ANON_KEY | ✓ | ✓ | ✓ |
| SENTRY_DSN | - | - | ✓ |

## Performance Optimization

### Build Optimizations
- Tree shaking enabled
- Code splitting
- Asset optimization
- Lazy loading
- Image optimization

### Performance Targets
- Build size: < 50MB
- Cold start: < 3s
- API response: < 100ms
- Uptime: 99.9%

## Monitoring

### Error Tracking
- Sentry integration configured
- Automatic error reporting in production
- Performance monitoring enabled

### Analytics
- User behavior tracking
- Performance metrics
- Custom events

## Troubleshooting

### Common Issues

#### Build Failures
```bash
# Clean build cache
flutter clean
flutter pub get

# Upgrade dependencies
flutter pub upgrade
```

#### Environment Variables Not Loaded
```bash
# Ensure .env file exists
ls -la .env*

# Check file permissions
chmod 600 .env.production
```

#### Performance Issues
```bash
# Analyze bundle size
flutter build web --analyze-size

# Check performance
flutter build web --profile
```

## Security Considerations

### API Keys
- Never commit API keys to git
- Use environment variables
- Rotate keys regularly

### Authentication
- Secure token storage
- HTTPS only in production
- Regular security audits

### Data Protection
- Encrypt sensitive data
- Validate all inputs
- Implement rate limiting

## Post-Deployment Checklist

- [ ] Verify all environments
- [ ] Test critical user flows
- [ ] Monitor error rates
- [ ] Check performance metrics
- [ ] Review analytics data
- [ ] Update documentation
- [ ] Notify stakeholders

## Support

For deployment issues:
1. Check GitHub Actions logs
2. Review Sentry error reports
3. Check environment configurations
4. Contact DevOps team

## Links

- [Firebase Console](https://console.firebase.google.com)
- [Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com)
- [Sentry Dashboard](https://sentry.io)
