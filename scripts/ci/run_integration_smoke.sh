#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLUTTER_CMD="${SCRIPT_DIR}/flutter_cmd.sh"

mapfile -t integration_files < <(find test/integration -type f -name '*_test.dart' | sort)

if [[ ${#integration_files[@]} -eq 0 ]]; then
  echo "No integration tests found."
  exit 0
fi

"${FLUTTER_CMD}" test "${integration_files[@]}" "$@"
