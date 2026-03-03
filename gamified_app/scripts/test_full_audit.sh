#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "[full-audit] Running extended Flutter test suites"
flutter test \
  test/models/ \
  test/services/ \
  test/widgets/
