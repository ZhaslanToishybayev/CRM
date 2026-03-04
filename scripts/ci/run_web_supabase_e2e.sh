#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_CMD="${SCRIPT_DIR}/flutter_cmd.sh"
E2E_DEVICE="${E2E_DEVICE:-chrome}"

: "${SUPABASE_URL:?SUPABASE_URL is required}"
: "${SUPABASE_ANON_KEY:?SUPABASE_ANON_KEY is required}"
: "${E2E_EMAIL:?E2E_EMAIL is required}"
: "${E2E_PASSWORD:?E2E_PASSWORD is required}"

if ! "${FLUTTER_CMD}" devices | grep -qi "${E2E_DEVICE}"; then
  echo "Requested device '${E2E_DEVICE}' is not available." >&2
  echo "Set E2E_DEVICE to one of the devices listed by: ${FLUTTER_CMD} devices" >&2
  exit 1
fi

"${FLUTTER_CMD}" test integration_test/web_supabase_crud_e2e_test.dart \
  -d "${E2E_DEVICE}" \
  --dart-define=DEMO_MODE=false \
  --dart-define=SUPABASE_URL="${SUPABASE_URL}" \
  --dart-define=SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY}" \
  --dart-define=E2E_EMAIL="${E2E_EMAIL}" \
  --dart-define=E2E_PASSWORD="${E2E_PASSWORD}" \
  "$@"
