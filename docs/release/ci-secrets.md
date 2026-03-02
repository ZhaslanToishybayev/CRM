# CI Secrets (GitHub Actions)

## Required
- `STAGING_DATABASE_URL`: PostgreSQL connection string for staging DB (`schema_drift` job).

## Recommended
- `SUPABASE_URL`: runtime URL for deployment workflows (if used outside app config).
- `SUPABASE_ANON_KEY`: runtime anon key for deployment workflows (never commit in repo).
- `SENTRY_DSN`: error tracking DSN for staging/prod release verification.

## Validation
1. Open GitHub repo settings: `Settings -> Secrets and variables -> Actions`.
2. Ensure `STAGING_DATABASE_URL` is present and points to staging (not production).
3. Trigger workflow manually (`workflow_dispatch`) and confirm `Schema Drift Check` runs.
4. Verify logs do not print secret values.
