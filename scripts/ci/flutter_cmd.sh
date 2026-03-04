#!/usr/bin/env bash
set -euo pipefail

if command -v flutter >/dev/null 2>&1; then
  exec flutter "$@"
fi

if [[ -n "${FLUTTER_BIN:-}" ]]; then
  if [[ -x "${FLUTTER_BIN}" ]]; then
    exec "${FLUTTER_BIN}" "$@"
  fi
  if [[ -x "${FLUTTER_BIN}/flutter" ]]; then
    exec "${FLUTTER_BIN}/flutter" "$@"
  fi
fi

if [[ -n "${HOME:-}" && -x "${HOME}/.local/flutter/bin/flutter" ]]; then
  exec "${HOME}/.local/flutter/bin/flutter" "$@"
fi

echo "Flutter executable was not found." >&2
echo "Use one of the following options:" >&2
echo "1) Add flutter to PATH" >&2
echo "2) Export FLUTTER_BIN=/absolute/path/to/flutter or /absolute/path/to/flutter/bin" >&2
exit 1
