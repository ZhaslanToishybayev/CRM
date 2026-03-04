#!/usr/bin/env bash
set -euo pipefail

: "${SUPABASE_URL:?SUPABASE_URL is required}"
: "${SUPABASE_ANON_KEY:?SUPABASE_ANON_KEY is required}"
: "${E2E_EMAIL:?E2E_EMAIL is required}"
: "${E2E_PASSWORD:?E2E_PASSWORD is required}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
E2E_DIR="${ROOT_DIR}/e2e"

if [[ ! -d "${E2E_DIR}" ]]; then
  echo "e2e directory not found: ${E2E_DIR}" >&2
  exit 1
fi

pushd "${E2E_DIR}" >/dev/null

npm ci
if ! npm run install:browsers; then
  echo "playwright install --with-deps failed, retrying without system deps..."
  npx playwright install chromium
fi

# Mandatory browser evidence path: login + CRM flow + AI retry
E2E_MANAGED_SERVER="${E2E_MANAGED_SERVER:-true}" \
DEMO_MODE="${DEMO_MODE:-false}" \
SUPABASE_URL="${SUPABASE_URL}" \
SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY}" \
E2E_EMAIL="${E2E_EMAIL}" \
E2E_PASSWORD="${E2E_PASSWORD}" \
RUN_VERBOSE="${RUN_VERBOSE:-false}" \
npm run test:mandatory

# Optional AI success validation only when key is present.
if [[ -n "${MINIMAX_API_KEY:-}" ]]; then
  E2E_MANAGED_SERVER="${E2E_MANAGED_SERVER:-true}" \
  DEMO_MODE="${DEMO_MODE:-false}" \
  SUPABASE_URL="${SUPABASE_URL}" \
  SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY}" \
  E2E_EMAIL="${E2E_EMAIL}" \
  E2E_PASSWORD="${E2E_PASSWORD}" \
  MINIMAX_API_KEY="${MINIMAX_API_KEY}" \
  RUN_VERBOSE="${RUN_VERBOSE:-false}" \
  npm run test:ai-success
else
  echo "MINIMAX_API_KEY is not set; skipping optional AI success e2e."
fi

popd >/dev/null
