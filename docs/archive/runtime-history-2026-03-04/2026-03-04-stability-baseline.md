# Stability Baseline Report (Week 1)

Date: 2026-03-04
Scope: Fast stable demo/web contour

## Baseline Before Changes

- `flutter analyze`: failed with 2113 issues (including compile-level errors).
- `flutter test`: 54 passed, 20 failed, plus legacy `flutter_driver` compile failures.
- Default widget test failed (`MyApp` constructor does not exist).

## Implemented Stabilization

- Fixed stale widget smoke test to target current app bootstrap.
- Fixed flaky `task_provider` unit tests (non-unique IDs and init-state assertion).
- Fixed `UserModel` tests to match current required fields and JSON field names.
- Restored codegen pipeline and regenerated missing `freezed/json/riverpod` outputs.
- Reworked invalid generated-provider usage in `achievement_detail_screen.dart`.
- Added CI scripts:
  - `scripts/ci/run_non_integration_tests.sh`
  - `scripts/ci/run_integration_smoke.sh`
- Added demo runner:
  - `scripts/run_demo_web.sh` (default `BACKEND_MODE=sql`).
- Updated CI workflows for:
  - Blocking smoke checks for compile + curated non-integration tests.
  - Non-blocking integration smoke job.
- Excluded legacy integration paths from analyzer:
  - `test/integration/**`
  - `test_driver/**`

## Verification After Changes

- `flutter test test/widget_test.dart` -> PASS
- `flutter test test/models/user_model_test.dart` -> PASS
- `flutter test test/unit/providers/task_provider_test.dart` -> PASS
- `bash scripts/ci/run_non_integration_tests.sh` -> PASS
- `bash scripts/ci/run_integration_smoke.sh` -> PASS (legacy flutter_driver tests skipped)
- `flutter analyze --no-fatal-infos --no-fatal-warnings lib/main.dart lib/providers.dart lib/providers_crm.dart lib/features/auth/models/user_model.dart` -> PASS (0 compile errors, warnings remain)

## Known Remaining Gaps

- Full-repo `flutter analyze` still reports many non-blocking warnings and test-module errors outside the curated smoke scope.
- Legacy `flutter_driver` E2E tests are still outdated and require migration to modern `integration_test`.
- Several feature/test modules outside week-1 smoke scope still need refactor to enter strict compile gate.

## Wave-2 Update (Same Day)

- Migrated legacy `flutter_driver` tests:
  - `test/integration/e2e_auth_flow_test.dart`
  - `test/integration/gamification_flow_test.dart`
  - `test/integration/task_management_flow_test.dart`
- Added `integration_test` SDK dependency in `pubspec.yaml`.
- Integration smoke script now executes all integration files without legacy skip behavior.
