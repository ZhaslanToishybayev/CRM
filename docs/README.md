# Docs Index

## Source Of Truth (current runtime)

- `../README.md` - setup, runtime modes, quality checks, deploy commands
- `architecture/ENTRYPOINT_AND_ROUTER.md` - single entrypoint/router policy
- `RUN_WEB_EVIDENCE.md` - browser evidence checklist S1-S6 + run commands
- `BACKEND_TESTING.md` - real backend auth/CRUD test instructions
- `DEPLOY_WEB.md` - minimal deploy flow for evidence URL
- `security/KEY_ROTATION_AND_HISTORY_CLEANUP.md` - key rotation + git history cleanup
- `migrations/2026-03-04-add-client-id-to-public-tasks.sql` - `tasks.client_id` migration
- `migrations/2026-03-04-bootstrap-runtime-schema.sql` - runtime bootstrap schema (tables/RLS/policies)
- `reports/2026-03-04-defense-demo-script.md` - defense flow script

## Historical / Archived

- `archive/root-legacy-2026-03-04/` contains old root-level docs that referenced legacy entrypoints (`main_final.dart`, `main_simple.dart`) or outdated runtime assumptions.
- `archive/runtime-history-2026-03-04/` contains intermediate stabilization plans/reports kept for history only.

Use archived docs only as historical context; do not use them as implementation instructions.
