#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR/e2e"

if [[ -z "${STAGING_BASE_URL:-}" ]]; then
  echo "[staging-e2e] STAGING_BASE_URL is required" >&2
  exit 1
fi

echo "[staging-e2e] Running Playwright smoke suite against: $STAGING_BASE_URL"
npm run test:staging
