#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

usage() {
  cat <<USAGE
Usage:
  scripts/deploy_web.sh [github-pages|netlify] [environment]

Examples:
  SUPABASE_URL=... SUPABASE_ANON_KEY=... scripts/deploy_web.sh github-pages production
  SUPABASE_URL=... SUPABASE_ANON_KEY=... NETLIFY_AUTH_TOKEN=... NETLIFY_SITE_ID=... scripts/deploy_web.sh netlify production

Notes:
  - Build is executed via ./deploy_web.sh in project root.
  - github-pages mode prints deterministic URL pattern.
USAGE
}

TARGET="${1:-github-pages}"
ENVIRONMENT="${2:-production}"

if [[ "${TARGET}" == "-h" || "${TARGET}" == "--help" ]]; then
  usage
  exit 0
fi

case "${TARGET}" in
  github-pages|netlify) ;;
  *)
    echo "Unknown deploy target: ${TARGET}" >&2
    usage
    exit 1
    ;;
esac

"${ROOT_DIR}/deploy_web.sh" "${ENVIRONMENT}" "${@:3}"

if [[ "${TARGET}" == "github-pages" ]]; then
  REPO_SLUG="${GITHUB_REPOSITORY:-}" # owner/repo
  if [[ -z "${REPO_SLUG}" ]]; then
    echo "Build ready at: ${ROOT_DIR}/build/web"
    echo "For GitHub Pages URL set GITHUB_REPOSITORY=owner/repo"
    exit 0
  fi

  OWNER="${REPO_SLUG%%/*}"
  REPO="${REPO_SLUG##*/}"
  echo "Build ready at: ${ROOT_DIR}/build/web"
  echo "Expected GitHub Pages URL: https://${OWNER}.github.io/${REPO}/"
  echo "Deploy via workflow or gh-pages action."
  exit 0
fi

: "${NETLIFY_AUTH_TOKEN:?NETLIFY_AUTH_TOKEN is required for netlify deploy}"
: "${NETLIFY_SITE_ID:?NETLIFY_SITE_ID is required for netlify deploy}"

if ! command -v npx >/dev/null 2>&1; then
  echo "npx is required for netlify deploy" >&2
  exit 1
fi

echo "Deploying to Netlify..."
NETLIFY_OUTPUT="$(npx -y netlify-cli deploy --prod --dir "${ROOT_DIR}/build/web" --site "${NETLIFY_SITE_ID}" --auth "${NETLIFY_AUTH_TOKEN}")"
echo "${NETLIFY_OUTPUT}"

echo "Deploy complete."
