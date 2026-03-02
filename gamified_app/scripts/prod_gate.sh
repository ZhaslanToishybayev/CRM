#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

USE_DOCKER_FLUTTER="${USE_DOCKER_FLUTTER:-0}"
SKIP_FLUTTER_CHECKS=0
RUN_APK_BUILD=0

for arg in "$@"; do
  case "$arg" in
    --use-docker)
      USE_DOCKER_FLUTTER=1
      ;;
    --skip-flutter)
      SKIP_FLUTTER_CHECKS=1
      ;;
    --with-apk)
      RUN_APK_BUILD=1
      ;;
    *)
      echo "[prod-gate] Unknown argument: $arg" >&2
      echo "Usage: ./scripts/prod_gate.sh [--use-docker] [--skip-flutter] [--with-apk]" >&2
      exit 2
      ;;
  esac
done

run_local_flutter() {
  echo "[prod-gate] Running Flutter checks (local toolchain)"
  flutter pub get
  ./scripts/analyze_release_scope.sh
  ./scripts/test_release_scope.sh
  flutter build web --release
  if [[ "$RUN_APK_BUILD" == "1" ]]; then
    flutter build apk --release
  fi
}

run_docker_flutter() {
  local image="ghcr.io/cirruslabs/flutter:stable"
  echo "[prod-gate] Running Flutter checks in Docker image: $image"
  docker run --rm \
    -v "$ROOT_DIR":/workspace \
    -w /workspace \
    "$image" \
    bash -lc "
      set -euo pipefail
      flutter pub get
      ./scripts/analyze_release_scope.sh
      ./scripts/test_release_scope.sh
      flutter build web --release
      if [[ \"$RUN_APK_BUILD\" == \"1\" ]]; then
        flutter build apk --release
      fi
    "
}

echo "[prod-gate] Running repository hygiene checks"
./scripts/check_repo_hygiene.sh

echo "[prod-gate] Running schema drift checks"
./scripts/check_schema_drift.sh

if [[ "$SKIP_FLUTTER_CHECKS" == "1" ]]; then
  echo "[prod-gate] Flutter checks were skipped (--skip-flutter)."
  exit 0
fi

if command -v flutter >/dev/null 2>&1; then
  run_local_flutter
  exit 0
fi

if [[ "$USE_DOCKER_FLUTTER" == "1" ]]; then
  if ! command -v docker >/dev/null 2>&1; then
    echo "[prod-gate] Docker is not installed, cannot run Flutter in container." >&2
    exit 1
  fi
  run_docker_flutter
  exit 0
fi

echo "[prod-gate] Flutter is not installed. Use one of the options:"
echo "  1) install Flutter locally"
echo "  2) rerun with --use-docker"
echo "  3) rerun with --skip-flutter (hygiene-only mode)"
exit 1
