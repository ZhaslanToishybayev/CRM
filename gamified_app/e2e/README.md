# Staging E2E Smoke

Playwright suite for staging web smoke checks.

> Note: suite targets deployed staging. Local static builds of `main.dart`
> require valid `SUPABASE_URL`/`SUPABASE_ANON_KEY` `--dart-define` values.
> Without these defines, app bootstrap can fail with a blank screen.
> Demo-mode flow also requires reachable Supabase and anonymous sign-in enabled.

## Required env
- `STAGING_BASE_URL` (example: `https://staging.example.com`)

## Optional env
- `E2E_EMAIL`
- `E2E_PASSWORD`

If credentials are missing, credential-based test is skipped but demo-mode smoke still runs.

## Local run
```bash
cd gamified_app/e2e
npm ci
npx playwright install --with-deps chromium
STAGING_BASE_URL=https://staging.example.com npm run test:staging
```

## Optional local debug against static web build
```bash
cd gamified_app
docker run --rm -v "$PWD":/workspace -w /workspace ghcr.io/cirruslabs/flutter:stable \
  bash -lc 'flutter pub get && flutter build web --release \
    --dart-define=SUPABASE_URL=https://example.supabase.co \
    --dart-define=SUPABASE_ANON_KEY=test-key'

cd build/web && python3 -m http.server 18080

# In another terminal:
cd gamified_app/e2e
STAGING_BASE_URL=http://127.0.0.1:18080 npm run test:staging
```
