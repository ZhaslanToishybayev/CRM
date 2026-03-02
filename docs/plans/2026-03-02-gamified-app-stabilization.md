# Gamified App Stabilization Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Stabilize app bootstrap, auth contracts, and config/security hygiene so the project has one reliable runtime path and compilable baseline tests.

**Architecture:** Keep `core/database/supabase_config.dart` as the canonical Supabase config; make other config entry points delegate to it. Use compile-time defines (`--dart-define`) for sensitive runtime settings and remove credentials from tracked files. Tighten auth data-source contract so repository code is type-safe (no `dynamic`).

**Tech Stack:** Flutter, Dart, Riverpod, Supabase, flutter_test

---

### Task 1: Canonical Supabase Config

**Files:**
- Modify: `gamified_app/lib/core/database/supabase_config.dart`
- Modify: `gamified_app/lib/core/supabase/supabase_config.dart`

**Step 1: Write failing test**
- Add tests for missing config and configured state.

**Step 2: Verify failure**
- Run: `flutter test test/core/supabase_config_test.dart`

**Step 3: Minimal implementation**
- Read config from `String.fromEnvironment`.
- Add explicit `StateError` when config is missing.
- Make legacy `core/supabase/supabase_config.dart` re-export canonical config.

**Step 4: Verify pass**
- Run same test command.

### Task 2: Single Entry Point

**Files:**
- Modify: `gamified_app/lib/main.dart`
- Modify: `gamified_app/lib/main_final.dart`

**Step 1: Write failing test**
- Ensure widget smoke test targets exported app root (no stale `MyApp`).

**Step 2: Verify failure**
- Run: `flutter test test/widget_test.dart`

**Step 3: Minimal implementation**
- Make `main.dart` delegate to `main_final.dart`.
- Ensure `main_final.dart` has clean imports only.

**Step 4: Verify pass**
- Run same widget test command.

### Task 3: Auth Contract Safety

**Files:**
- Modify: `gamified_app/lib/features/auth/data_sources/auth_data_source.dart`
- Modify: `gamified_app/lib/features/auth/data_sources/supabase_auth_data_source.dart`
- Modify: `gamified_app/lib/features/auth/repositories/auth_repository_impl.dart`

**Step 1: Write failing test**
- Add repository tests asserting profile fetch path without `dynamic` casting.

**Step 2: Verify failure**
- Run: `flutter test test/auth/auth_repository_test.dart`

**Step 3: Minimal implementation**
- Extend `AuthDataSource` with `getCurrentUserWithProfile()`.
- Implement robust profile mapping with fallback field names.
- Remove `dynamic` casts in repository.

**Step 4: Verify pass**
- Run same auth test command.

### Task 4: Security Hygiene

**Files:**
- Modify: `gamified_app/.gitignore`
- Modify: `gamified_app/.env.development`
- Modify: `gamified_app/.env.production`
- Modify: `gamified_app/.env.staging`

**Step 1: Write failing test**
- Add a simple repository hygiene check script/test (optional in this iteration).

**Step 2: Verify failure**
- Run: `rg "eyJhbGci" gamified_app`

**Step 3: Minimal implementation**
- Sanitize tracked env files to placeholders.
- Ignore `.env.*` while keeping `.env.example` trackable.

**Step 4: Verify pass**
- Re-run grep command; no real key in tracked files.

### Task 5: Test Baseline Cleanup

**Files:**
- Modify: `gamified_app/test/widget_test.dart`
- Modify: `gamified_app/test/services/analytics_service_test.dart`
- Modify: `gamified_app/test/providers/auth_provider_test.dart`
- Modify: `gamified_app/test/integration/auth_flow_test.dart`
- Modify: `gamified_app/test/services/supabase_service_test.dart`

**Step 1: Write failing tests**
- Replace compile-broken patterns (`MyApp`, `null as any`, manual provider notifier construction).

**Step 2: Verify failure**
- Run targeted tests for each file.

**Step 3: Minimal implementation**
- Convert invalid tests to compilable unit-level checks.
- Keep assertions meaningful (not only `expect(true, true)`).

**Step 4: Verify pass**
- Run: `flutter test`

### Task 6: Documentation

**Files:**
- Modify: `gamified_app/README.md`

**Step 1: Write failing expectation**
- Validate README has actual startup steps and config method.

**Step 2: Minimal implementation**
- Add run commands using `--dart-define`.
- Document canonical entrypoint and secrets policy.

**Step 3: Verify**
- Manual read-through for correctness.
