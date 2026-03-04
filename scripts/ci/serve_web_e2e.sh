#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
FLUTTER_CMD="${SCRIPT_DIR}/flutter_cmd.sh"

DEMO_MODE_VALUE="${DEMO_MODE:-false}"
if [[ "${DEMO_MODE_VALUE}" != "true" ]]; then
  : "${SUPABASE_URL:?SUPABASE_URL is required when DEMO_MODE=false}"
  : "${SUPABASE_ANON_KEY:?SUPABASE_ANON_KEY is required when DEMO_MODE=false}"
fi

build_cmd=(
  "${FLUTTER_CMD}" build web --release
  --no-web-resources-cdn
  --no-wasm-dry-run
  "--dart-define=DEMO_MODE=${DEMO_MODE_VALUE}"
)

if [[ -n "${SUPABASE_URL:-}" ]]; then
  build_cmd+=("--dart-define=SUPABASE_URL=${SUPABASE_URL}")
fi
if [[ -n "${SUPABASE_ANON_KEY:-}" ]]; then
  build_cmd+=("--dart-define=SUPABASE_ANON_KEY=${SUPABASE_ANON_KEY}")
fi
if [[ -n "${MINIMAX_API_KEY:-}" ]]; then
  build_cmd+=("--dart-define=MINIMAX_API_KEY=${MINIMAX_API_KEY}")
fi

"${build_cmd[@]}"

HOST="${WEB_HOSTNAME:-127.0.0.1}"
PORT="${WEB_PORT:-18080}"

if ! command -v npx >/dev/null 2>&1; then
  echo "npx is required to serve SPA routes for web e2e." >&2
  exit 1
fi

exec npx -y serve -s "${ROOT_DIR}/build/web" -l "tcp://${HOST}:${PORT}"
