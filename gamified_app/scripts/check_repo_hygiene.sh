#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "[hygiene] Checking for real JWT-like tokens in tracked files..."
if rg -n "eyJhbGciOiJIUzI1Ni" lib test .env* README.md SCHEMA_MIGRATION.md >/dev/null 2>&1; then
  echo "[hygiene] Found possible hardcoded JWT-like token"
  rg -n "eyJhbGciOiJIUzI1Ni" lib test .env* README.md SCHEMA_MIGRATION.md || true
  exit 1
fi

echo "[hygiene] Checking for test placeholders..."
if rg -n "expect\(true, true\)|Placeholder|mock test|null as any|MyApp\(" test >/dev/null 2>&1; then
  echo "[hygiene] Found placeholder/invalid tests"
  rg -n "expect\(true, true\)|Placeholder|mock test|null as any|MyApp\(" test || true
  exit 1
fi

echo "[hygiene] Checking for TODO/HACK in critical runtime paths..."
if rg -n "TODO|FIXME|HACK" lib/core/supabase lib/core/database lib/features/auth lib/features/tasks >/dev/null 2>&1; then
  echo "[hygiene] Found TODO/FIXME/HACK in critical runtime paths"
  rg -n "TODO|FIXME|HACK" lib/core/supabase lib/core/database lib/features/auth lib/features/tasks || true
  exit 1
fi

echo "[hygiene] OK"
