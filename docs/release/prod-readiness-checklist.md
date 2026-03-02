# Prod Readiness Checklist

## 1. Build & Quality (Release Scope)
- [ ] Local preflight gate green (`gamified_app/scripts/prod_gate.sh --use-docker`)
- [ ] `scripts/analyze_release_scope.sh` green
- [ ] `scripts/test_release_scope.sh` green
- [ ] `flutter build web --release` green
- [ ] `flutter build apk --release` green (main branch)

## 2. Security
- [ ] Repo hygiene check green (`scripts/check_repo_hygiene.sh`)
- [ ] Dependency audit green (`flutter pub audit`)
- [ ] No real secrets in tracked files
- [ ] Runtime secrets configured in deployment environment

## 3. Schema Compatibility
- [ ] Runtime defines validated in staging (`TASKS_TABLE`, `USER_STATS_TABLE`, `PROFILES_TABLE`)
- [ ] Bridge SQL applied if needed (`migrations/2026-03-02_schema_bridge.sql`)
- [ ] Schema drift check green (`scripts/check_schema_drift.sh`)
- [ ] CRUD verified for tasks + profile/stats flows

## 4. Observability
- [ ] Error tracking enabled and verified
- [ ] Release telemetry reviewed
- [ ] Incident contacts and escalation path verified

## 5. Release Ops
- [ ] Staging smoke suite green
- [ ] Rollback drill executed and documented
- [ ] Release notes prepared
- [ ] Go/No-Go decision signed off
