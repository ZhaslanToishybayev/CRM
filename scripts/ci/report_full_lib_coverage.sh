#!/usr/bin/env bash
set -euo pipefail

LCOV_FILE="${1:-coverage/lcov.info}"

if [[ ! -f "${LCOV_FILE}" ]]; then
  echo "Coverage file not found: ${LCOV_FILE}" >&2
  exit 1
fi

python3 - "${LCOV_FILE}" <<'PY'
import sys

lcov_file = sys.argv[1]
current_file = None
hit = total = 0

with open(lcov_file, 'r', encoding='utf-8') as f:
    for line in f:
        line = line.rstrip('\n')
        if line.startswith('SF:'):
            current_file = line[3:]
            continue
        if not current_file:
            continue
        if not current_file.startswith('lib/'):
            continue
        if current_file.endswith('.g.dart') or current_file.endswith('.freezed.dart'):
            continue
        if line.startswith('DA:'):
            _, count = line[3:].split(',', 1)
            total += 1
            if int(count) > 0:
                hit += 1

pct = 0.0 if total == 0 else (hit / total) * 100.0
print(f'Full lib coverage (non-generated): {pct:.2f}% ({hit}/{total})')
PY
