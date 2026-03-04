#!/usr/bin/env bash
set -euo pipefail

LCOV_FILE="${1:-coverage/lcov.info}"
THRESHOLD="${2:-55}"
SCOPE_FILE="${3:-scripts/ci/runtime_coverage_scope.txt}"

if [[ ! -f "${LCOV_FILE}" ]]; then
  echo "Coverage file not found: ${LCOV_FILE}" >&2
  exit 1
fi

if [[ ! -f "${SCOPE_FILE}" ]]; then
  echo "Scope file not found: ${SCOPE_FILE}" >&2
  exit 1
fi

python3 - "${LCOV_FILE}" "${THRESHOLD}" "${SCOPE_FILE}" <<'PY'
import fnmatch
import sys

lcov_file = sys.argv[1]
threshold = float(sys.argv[2])
scope_file = sys.argv[3]

includes: list[str] = []
excludes: list[str] = []

with open(scope_file, 'r', encoding='utf-8') as f:
    for raw_line in f:
        line = raw_line.strip()
        if not line or line.startswith('#'):
            continue
        marker = line[0]
        pattern = line[1:].strip() if marker in '+-' else line
        if not pattern:
            continue
        if marker == '-':
            excludes.append(pattern)
        else:
            includes.append(pattern)

if not includes:
    print(f'No include patterns found in {scope_file}', file=sys.stderr)
    sys.exit(1)

def in_scope(path: str) -> bool:
    included = any(fnmatch.fnmatch(path, pat) for pat in includes)
    excluded = any(fnmatch.fnmatch(path, pat) for pat in excludes)
    return included and not excluded

current_file = None
keep = False
hit = 0
total = 0

with open(lcov_file, 'r', encoding='utf-8') as f:
    for line in f:
        line = line.rstrip('\n')
        if line.startswith('SF:'):
            current_file = line[3:]
            keep = in_scope(current_file)
            continue
        if keep and line.startswith('DA:'):
            payload = line[3:]
            _, count = payload.split(',', 1)
            total += 1
            if int(count) > 0:
                hit += 1

pct = 0.0 if total == 0 else (hit / total) * 100.0

print(f'Coverage scope file: {scope_file}')
print('Include patterns:')
for p in includes:
    print(f'  + {p}')
if excludes:
    print('Exclude patterns:')
    for p in excludes:
        print(f'  - {p}')
print(f'Coverage result: {pct:.2f}% ({hit}/{total})')

if pct + 1e-9 < threshold:
    print(
        f'Coverage gate failed: {pct:.2f}% < {threshold:.2f}%',
        file=sys.stderr,
    )
    sys.exit(1)

print(f'Coverage gate passed: {pct:.2f}% >= {threshold:.2f}%')
PY
