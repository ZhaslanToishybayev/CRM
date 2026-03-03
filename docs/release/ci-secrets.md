# CI Secrets (GitHub Actions)

## Required
- `STAGING_DATABASE_URL`: PostgreSQL connection string for staging DB (`schema_drift` job).

## Recommended
- `SUPABASE_URL`: runtime URL for deployment workflows (if used outside app config).
- `SUPABASE_ANON_KEY`: runtime anon key for deployment workflows (never commit in repo).
- `SENTRY_DSN`: error tracking DSN for staging/prod release verification.
- `STAGING_BASE_URL`: URL staging web environment for diagnostic Playwright smoke (`staging_e2e` job).
- `E2E_STAGING_EMAIL`: e2e sign-in account email (optional, enables credential flow).
- `E2E_STAGING_PASSWORD`: e2e sign-in account password (optional, enables credential flow).

## Validation
1. Open GitHub repo settings: `Settings -> Secrets and variables -> Actions`.
2. Ensure `STAGING_DATABASE_URL` is present and points to staging (not production).
3. If web smoke is used, ensure `STAGING_BASE_URL` is reachable from GitHub Actions.
4. Trigger workflow manually (`workflow_dispatch`) and confirm `Schema Drift Check` runs; `staging_e2e` runs when URL configured.
5. Verify logs do not print secret values.
