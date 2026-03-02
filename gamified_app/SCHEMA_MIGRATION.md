# Schema Migration (Legacy <-> Corporate)

## Goal
Run the app during migration between:
- Legacy: `tasks`, `user_stats`
- Corporate: `work_tasks`, `corporate_users`

## Runtime routing
The app now supports runtime table routing via `--dart-define`:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<project>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<anon_key> \
  --dart-define=TASKS_TABLE=work_tasks \
  --dart-define=USER_STATS_TABLE=corporate_users \
  --dart-define=PROFILES_TABLE=profiles
```

Defaults remain legacy-compatible (`tasks`, `user_stats`, `profiles`).

## Optional DB bridge
Apply SQL bridge script in Supabase SQL editor:

- `migrations/2026-03-02_schema_bridge.sql`

This script creates compatibility views only when target tables are missing.

## Compatibility risk
- If your DB has strict RLS tied to base tables, views may require additional policies.
- If your schema uses custom enum values beyond defaults, priority/status mapping should be reviewed.

## Recommended rollout
1. Deploy app with runtime table routing first.
2. Verify reads/writes in staging.
3. Optionally apply bridge SQL for backward compatibility.
4. Remove deprecated path after one release cycle.
