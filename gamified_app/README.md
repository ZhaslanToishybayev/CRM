# Gamified Task App

Flutter CRM/gamification app with Supabase backend and Riverpod state management.

## Run Locally

1. Install Flutter SDK (stable channel).
2. Install dependencies:

```bash
flutter pub get
```

3. Run app with runtime credentials:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<project>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<anon_key>
```

Optional schema routing during migration:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<project>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<anon_key> \
  --dart-define=TASKS_TABLE=work_tasks \
  --dart-define=USER_STATS_TABLE=corporate_users \
  --dart-define=PROFILES_TABLE=profiles
```

## Tests

```bash
./scripts/test_release_scope.sh
./scripts/test_full_audit.sh   # extended (nightly/diagnostic)
```

## Prod-Readiness Checks

```bash
./scripts/check_repo_hygiene.sh
./scripts/check_schema_drift.sh
./scripts/run_staging_e2e.sh   # optional diagnostic, requires STAGING_BASE_URL
./scripts/prod_gate.sh --use-docker
```

If you run `build/web` locally for smoke checks, compile with
`SUPABASE_URL`/`SUPABASE_ANON_KEY` defines first (see `e2e/README.md`).

For full release criteria and runbooks, see:
- `../docs/release/prod-readiness-spec.md`
- `../docs/release/prod-readiness-checklist.md`
- `../docs/release/staging-smoke.md`
- `../docs/release/rollback-runbook.md`
- `../docs/release/ci-secrets.md`
- `../docs/release/test-coverage-matrix.md`

## Configuration

- Canonical Supabase config: `lib/core/database/supabase_config.dart`
- Legacy path `lib/core/supabase/supabase_config.dart` is a shim.
- Do not commit real credentials into `.env*` or Dart source files.
- See migration notes: `SCHEMA_MIGRATION.md`
