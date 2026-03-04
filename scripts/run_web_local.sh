#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
FLUTTER_CMD="${ROOT_DIR}/scripts/ci/flutter_cmd.sh"

usage() {
  cat <<USAGE
Usage:
  scripts/run_web_local.sh [chrome|web-server] [extra flutter run args]

Examples:
  SUPABASE_URL=... SUPABASE_ANON_KEY=... scripts/run_web_local.sh chrome
  SUPABASE_URL=... SUPABASE_ANON_KEY=... scripts/run_web_local.sh web-server --web-port 18080
  DEMO_MODE=true scripts/run_web_local.sh chrome

Env:
  DEMO_MODE            false by default
  SUPABASE_URL         required if DEMO_MODE=false
  SUPABASE_ANON_KEY    required if DEMO_MODE=false
  MINIMAX_API_KEY      optional (AI success path)
  WEB_PORT             optional (default 18080 for web-server)
  WEB_HOSTNAME         optional (default 0.0.0.0 for web-server)
  RUN_VERBOSE          true/false (default true)
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

TARGET="${1:-chrome}"
shift || true

if [[ "${TARGET}" != "chrome" && "${TARGET}" != "web-server" ]]; then
  echo "Unsupported target: ${TARGET}" >&2
  usage
  exit 1
fi

DEMO_MODE_VALUE="${DEMO_MODE:-false}"
if [[ "${DEMO_MODE_VALUE}" != "true" ]]; then
  : "${SUPABASE_URL:?SUPABASE_URL is required when DEMO_MODE=false}"
  : "${SUPABASE_ANON_KEY:?SUPABASE_ANON_KEY is required when DEMO_MODE=false}"
fi

LOG_DIR="${ROOT_DIR}/tmp/evidence"
mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/web_run_$(date +%Y%m%d_%H%M%S).log"

cmd=(
  "${FLUTTER_CMD}" run
  -d "${TARGET}"
  --dart-define=DEMO_MODE="${DEMO_MODE_VALUE}"
)

if [[ -n "${SUPABASE_URL:-}" ]]; then
  cmd+=(--dart-define=SUPABASE_URL="${SUPABASE_URL}")
fi
if [[ -n "${SUPABASE_ANON_KEY:-}" ]]; then
  cmd+=(--dart-define=SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY}")
fi
if [[ -n "${MINIMAX_API_KEY:-}" ]]; then
  cmd+=(--dart-define=MINIMAX_API_KEY="${MINIMAX_API_KEY}")
fi

if [[ "${TARGET}" == "web-server" ]]; then
  has_port_arg=false
  has_host_arg=false
  for arg in "$@"; do
    if [[ "${arg}" == "--web-port" || "${arg}" == --web-port=* ]]; then
      has_port_arg=true
    fi
    if [[ "${arg}" == "--web-hostname" || "${arg}" == --web-hostname=* ]]; then
      has_host_arg=true
    fi
  done
  if [[ "${has_port_arg}" == "false" ]]; then
    cmd+=(--web-port "${WEB_PORT:-18080}")
  fi
  if [[ "${has_host_arg}" == "false" ]]; then
    cmd+=(--web-hostname "${WEB_HOSTNAME:-0.0.0.0}")
  fi
fi

if [[ "${RUN_VERBOSE:-true}" == "true" ]]; then
  cmd+=(--verbose)
fi

if [[ $# -gt 0 ]]; then
  cmd+=("$@")
fi

echo "Running: ${cmd[*]}"
echo "Log file: ${LOG_FILE}"

# Keep both console output and a reproducible log for evidence pack.
"${cmd[@]}" 2>&1 | tee "${LOG_FILE}"
