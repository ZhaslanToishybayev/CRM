#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_CMD="${SCRIPT_DIR}/scripts/ci/flutter_cmd.sh"

usage() {
  cat <<USAGE
Usage:
  ./deploy_web.sh [environment] [extra flutter build args]

Examples:
  SUPABASE_URL=... SUPABASE_ANON_KEY=... ./deploy_web.sh production
  SUPABASE_URL=... SUPABASE_ANON_KEY=... MINIMAX_API_KEY=... ./deploy_web.sh production --base-href /crm/
  ./deploy_web.sh demo

Environment variables:
  SUPABASE_URL         Required for production/runtime backend path
  SUPABASE_ANON_KEY    Required for production/runtime backend path
  MINIMAX_API_KEY      Optional AI runtime key
  DEMO_MODE            Optional (default false in production, true in demo)
  WEB_RENDERER         Optional: canvaskit | skwasm | auto (default auto)
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

ENVIRONMENT="${1:-production}"
shift || true

case "${ENVIRONMENT}" in
  production|staging|demo) ;;
  *)
    echo "Unknown environment: ${ENVIRONMENT}" >&2
    usage
    exit 1
    ;;
esac

if [[ "${ENVIRONMENT}" == "demo" ]]; then
  DEMO_MODE_VALUE="${DEMO_MODE:-true}"
else
  DEMO_MODE_VALUE="${DEMO_MODE:-false}"
  : "${SUPABASE_URL:?SUPABASE_URL is required for ${ENVIRONMENT}}"
  : "${SUPABASE_ANON_KEY:?SUPABASE_ANON_KEY is required for ${ENVIRONMENT}}"
fi

WEB_RENDERER_VALUE="${WEB_RENDERER:-auto}"

echo "Building web app"
echo "  environment: ${ENVIRONMENT}"
echo "  demo mode:   ${DEMO_MODE_VALUE}"
echo "  renderer:    ${WEB_RENDERER_VALUE}"

echo "Running quality checks..."
"${FLUTTER_CMD}" pub get
"${FLUTTER_CMD}" analyze
"${FLUTTER_CMD}" test

build_cmd=(
  "${FLUTTER_CMD}" build web --release
  "--dart-define=ENVIRONMENT=${ENVIRONMENT}"
  "--dart-define=DEMO_MODE=${DEMO_MODE_VALUE}"
  "--dart-define=WEB_RENDERER=${WEB_RENDERER_VALUE}"
  "--tree-shake-icons"
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

if [[ $# -gt 0 ]]; then
  build_cmd+=("$@")
fi

"${build_cmd[@]}"

echo "Web build completed: ${SCRIPT_DIR}/build/web"
