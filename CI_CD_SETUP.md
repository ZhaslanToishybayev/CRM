# 🚀 CI/CD Setup Guide

## Overview

This project includes automated CI/CD pipelines for building, testing, and deploying your Gamified Task Management App.

---

## 🏗️ Workflow Files

### 1. `ci.yml` - Continuous Integration
**Triggered on**: Every push to `main`/`develop` and pull requests

**What it does**:
- ✅ Code quality checks (analyze, format)
- ✅ Security scanning (Trivy)
- ✅ Unit & Widget tests (>80% coverage)
- ✅ Build Web application
- ✅ Build Android APK (main branch only)
- ✅ Deploy to GitHub Pages (main branch)
- ✅ Performance checks (bundle size analysis)

### 2. `release.yml` - Release Pipeline
**Triggered on**: Git tags (`v*`)

**What it does**:
- 📦 Create GitHub releases
- 📱 Deploy to Firebase App Distribution (Android)
- 🍎 Upload to TestFlight (iOS)
- 🌐 Deploy to Firebase Hosting (Web)

---

## 🔧 Setup Instructions

### Step 1: Enable GitHub Actions
1. Go to repository **Settings** → **Actions**
2. Enable "Allow all actions and reusable workflows"
3. Choose "Read and write permissions" for workflow

### Step 2: Configure Secrets

Add these secrets in **Repository Settings** → **Secrets and variables** → **Actions**:

#### Required Secrets for CI:
```
# None required for basic CI workflow
```

#### Optional Secrets for Enhanced CI:
```
CODECOV_TOKEN    # For coverage reporting (get from codecov.io)
```

#### Required Secrets for Release:
```
FIREBASE_SERVICE_ACCOUNT          # Firebase service account JSON
FIREBASE_APP_ID_ANDROID           # Firebase App ID for Android

# iOS (only if deploying to TestFlight)
APPSTORE_CONNECT_USERNAME         # Apple ID
APPSTORE_CONNECT_PASSWORD         # App-specific password
APPSTORE_CONNECT_ISSUER_ID        # App Store Connect Issuer ID
APPSTORE_CONNECT_PROVIDER_SHORT_NAME
P12_PASSWORD                      # Password for p12 certificate
BUILD_CERTIFICATE_BASE64          # Base64 encoded p12 certificate
BUILD_PROVISION_PROFILE_BASE64    # Base64 encoded provisioning profile

# Web Hosting
FIREBASE_SERVICE_ACCOUNT          # Firebase service account for hosting
```

### Step 3: Get Required Credentials

#### Firebase Setup:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create project (or use existing)
3. Enable:
   - App Distribution
   - Hosting
4. Create service account:
   - Go to **Project Settings** → **Service accounts**
   - Generate new private key
   - Copy JSON content → use as `FIREBASE_SERVICE_ACCOUNT`

#### Apple Developer Setup (iOS only):
1. Go to [Apple Developer Portal](https://developer.apple.com/)
2. Create/Use App ID
3. Create distribution certificate
4. Create provisioning profile
5. Convert certificate to p12 format
6. Base64 encode p12 file: `base64 -i certificate.p12`
7. Base64 encode provisioning profile: `base64 -i Profile.mobileprovision`

---

## 📊 CI Workflow Jobs

### Job 1: quality-check
- **Purpose**: Code quality validation
- **Checks**: `flutter analyze`, `flutter format`
- **Exit on failure**: Yes

### Job 2: test
- **Purpose**: Run all tests
- **Coverage**: Required >80%
- **Artifacts**: Coverage report (Codecov)

### Job 3: build-web
- **Purpose**: Build web application
- **Output**: `build/web/` artifact
- **Environment**: Production

### Job 4: build-android
- **Purpose**: Build Android APK
- **Trigger**: Main branch only
- **Output**: APK artifact

### Job 5: security-scan
- **Purpose**: Vulnerability scanning
- **Tool**: Trivy
- **Output**: SARIF report to Security tab

### Job 6: deploy-web
- **Purpose**: Deploy to GitHub Pages
- **Trigger**: Main branch
- **URL**: `https://<username>.github.io/<repo>`

### Job 7: performance-check
- **Purpose**: Analyze bundle size
- **Checks**: APK size (<50MB), Web bundle size

---

## 🎯 Release Workflow Jobs

### Job 1: github-release
- **Trigger**: Git tag `v*` (e.g., v1.0.0)
- **Action**: Create GitHub release with artifacts
- **Artifacts**: Web build, Android APK, iOS IPA

### Job 2: firebase-deploy
- **Trigger**: After GitHub release
- **Action**: Deploy to Firebase App Distribution
- **Recipients**: Testers group

### Job 3: testflight-deploy
- **Trigger**: After GitHub release (macOS only)
- **Action**: Upload to TestFlight
- **Platform**: iOS

### Job 4: deploy-web-hosting
- **Trigger**: After GitHub release
- **Action**: Deploy to Firebase Hosting
- **Channel**: Live

---

## 🚦 Workflow Status

Check workflow status in:
- **GitHub Actions tab**: `https://github.com/<user>/<repo>/actions`
- **Commit/PR checks**: Green ✅ or Red ❌
- **Release page**: For release artifacts

---

## 🔍 Troubleshooting

### Build Failures

**"flutter analyze" errors**:
```bash
# Fix locally before pushing
flutter analyze
flutter format .
```

**Test failures**:
```bash
# Run tests locally
flutter test --no-pub --coverage
```

**Build failures**:
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build
```

### Permission Issues

**Firebase deploy fails**:
- Verify `FIREBASE_SERVICE_ACCOUNT` is correct
- Check service account has App Distribution permissions

**TestFlight upload fails**:
- Verify Apple Developer credentials
- Check certificate/provisioning profile validity
- Ensure App ID matches in Apple Developer portal

### Performance Issues

**Bundle too large (>50MB)**:
- Check `pubspec.yaml` for unused dependencies
- Enable tree-shaking: `flutter build apk --tree-shake-icons`
- Use ProGuard: `flutter build apk --obfuscate --split-debug-info`

---

## 📝 CI Best Practices

### 1. Write Tests
- Aim for >80% code coverage
- Include unit, widget, and integration tests
- Test edge cases and error handling

### 2. Keep Builds Fast
- Cache dependencies: `actions/cache@v4`
- Use build artifacts wisely
- Avoid rebuilding if not necessary

### 3. Security First
- Never commit secrets to `.env`
- Use GitHub Secrets for sensitive data
- Enable Dependabot alerts
- Run security scans regularly

### 4. Monitor Performance
- Track bundle size trends
- Monitor test execution time
- Set up performance budgets
- Use `flutter build --analyze-size` for APK

### 5. Documentation
- Update `CHANGELOG.md` for releases
- Document breaking changes
- Keep README updated
- Add release notes

---

## 🎓 Learning Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/testing/integration-tests)
- [Firebase App Distribution](https://firebase.google.com/docs/app-distribution)
- [TestFlight Documentation](https://developer.apple.com/testflight/)

---

## ✅ Quick Start Checklist

- [ ] Enable GitHub Actions
- [ ] Add required secrets
- [ ] Test CI workflow (push to feature branch)
- [ ] Configure Firebase (optional)
- [ ] Configure Apple Developer (optional)
- [ ] Create first release tag
- [ ] Verify all jobs pass
- [ ] Check deployed artifacts

---

## 📞 Support

If you encounter issues:
1. Check GitHub Actions logs
2. Review error messages in workflow output
3. Consult troubleshooting section above
4. Search GitHub Actions documentation
5. Ask in Flutter community forums

---

**Last Updated**: November 2025
**Version**: 1.0
**Status**: ✅ Ready to Use
