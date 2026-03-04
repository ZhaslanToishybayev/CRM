#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_CMD="${SCRIPT_DIR}/flutter_cmd.sh"

mapfile -t test_files < <(find test -type f -name '*_test.dart' ! -path 'test/integration/*' | sort)

if [[ ${#test_files[@]} -eq 0 ]]; then
  echo "No non-integration tests found."
  exit 0
fi

"${FLUTTER_CMD}" test "${test_files[@]}" "$@"
