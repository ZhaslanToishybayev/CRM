#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_CMD="${SCRIPT_DIR}/ci/flutter_cmd.sh"

PORT="${PORT:-8090}"
HOST="${HOST:-0.0.0.0}"
BACKEND_MODE="${BACKEND_MODE:-sql}"
TARGET="${TARGET:-lib/main.dart}"
KILL_PORT="${KILL_PORT:-0}"

if [[ "${KILL_PORT}" == "1" ]]; then
  # Optional safety switch for local reruns.
  pids="$(lsof -ti :"${PORT}" 2>/dev/null || true)"
  if [[ -n "${pids}" ]]; then
    echo "Killing process(es) on port ${PORT}: ${pids}"
    kill -9 ${pids}
  fi
fi

echo "Starting web demo on http://${HOST}:${PORT}"
echo "Target: ${TARGET}"
echo "BACKEND_MODE=${BACKEND_MODE}"
echo "KILL_PORT=${KILL_PORT}"

"${FLUTTER_CMD}" run \
  -d web-server \
  --target "${TARGET}" \
  --web-port "${PORT}" \
  --web-hostname "${HOST}" \
  --dart-define=BACKEND_MODE="${BACKEND_MODE}"
