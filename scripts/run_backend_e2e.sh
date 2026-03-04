#!/usr/bin/env bash
set -euo pipefail

: "${SUPABASE_URL:?SUPABASE_URL is required}"
: "${SUPABASE_ANON_KEY:?SUPABASE_ANON_KEY is required}"
: "${E2E_EMAIL:?E2E_EMAIL is required}"
: "${E2E_PASSWORD:?E2E_PASSWORD is required}"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required (sudo apt-get install jq)" >&2
  exit 1
fi

CREATE_TEST_USER="${CREATE_TEST_USER:-false}"
if [[ "${CREATE_TEST_USER}" == "true" ]]; then
  : "${SUPABASE_SERVICE_ROLE_KEY:?SUPABASE_SERVICE_ROLE_KEY is required when CREATE_TEST_USER=true}"
fi

PROJECT_URL="${SUPABASE_URL%/}"
SUFFIX="$(date +%s)"
CLIENT_EMAIL="e2e.client.${SUFFIX}@example.com"
TASK_TITLE="E2E linked task ${SUFFIX}"
NO_CLIENT_TITLE="E2E no-client task ${SUFFIX}"

mask() {
  local value="$1"
  if [[ ${#value} -le 8 ]]; then
    echo "********"
  else
    echo "${value:0:4}****${value: -4}"
  fi
}

echo "[1/7] Backend URL: ${PROJECT_URL}"

if [[ "${CREATE_TEST_USER}" == "true" ]]; then
  echo "[2/7] Ensuring test user exists via admin API"
  curl -sS -X POST "${PROJECT_URL}/auth/v1/admin/users" \
    -H "apikey: ${SUPABASE_SERVICE_ROLE_KEY}" \
    -H "Authorization: Bearer ${SUPABASE_SERVICE_ROLE_KEY}" \
    -H 'Content-Type: application/json' \
    -d "{\"email\":\"${E2E_EMAIL}\",\"password\":\"${E2E_PASSWORD}\",\"email_confirm\":true,\"user_metadata\":{\"full_name\":\"E2E User\"}}" \
    >/dev/null || true
else
  echo "[2/7] CREATE_TEST_USER=false (skip user provisioning)"
fi

echo "[3/7] Sign-in via Auth API"
AUTH_JSON="$(curl -sS -X POST "${PROJECT_URL}/auth/v1/token?grant_type=password" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"${E2E_EMAIL}\",\"password\":\"${E2E_PASSWORD}\"}")"

ACCESS_TOKEN="$(echo "${AUTH_JSON}" | jq -r '.access_token')"
USER_ID="$(echo "${AUTH_JSON}" | jq -r '.user.id')"

if [[ -z "${ACCESS_TOKEN}" || "${ACCESS_TOKEN}" == "null" ]]; then
  echo "Auth failed: $(echo "${AUTH_JSON}" | jq -c '.')" >&2
  exit 1
fi

echo "Signed in as user_id=${USER_ID} token=$(mask "${ACCESS_TOKEN}")"

echo "[4/7] Create CRM client"
CLIENT_JSON="$(curl -sS -X POST "${PROJECT_URL}/rest/v1/crm_clients" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H 'Content-Type: application/json' \
  -H 'Prefer: return=representation' \
  -d "{\"first_name\":\"E2E\",\"last_name\":\"Client\",\"email\":\"${CLIENT_EMAIL}\",\"phone\":\"+77001234567\",\"company_name\":\"E2E Inc\",\"position\":\"QA\",\"status\":\"lead\",\"source\":\"manual\"}")"
CLIENT_ID="$(echo "${CLIENT_JSON}" | jq -r '.[0].id')"
if [[ -z "${CLIENT_ID}" || "${CLIENT_ID}" == "null" ]]; then
  echo "Create client failed: ${CLIENT_JSON}" >&2
  exit 1
fi

echo "Created client_id=${CLIENT_ID}"

echo "[5/7] Create linked task + no-client task"
TASK_JSON="$(curl -sS -X POST "${PROJECT_URL}/rest/v1/tasks" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H 'Content-Type: application/json' \
  -H 'Prefer: return=representation' \
  -d "{\"user_id\":\"${USER_ID}\",\"client_id\":\"${CLIENT_ID}\",\"title\":\"${TASK_TITLE}\",\"description\":\"backend e2e\",\"priority\":2,\"status\":\"pending\",\"category\":\"General\"}")"
TASK_ID="$(echo "${TASK_JSON}" | jq -r '.[0].id')"

NO_CLIENT_JSON="$(curl -sS -X POST "${PROJECT_URL}/rest/v1/tasks" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H 'Content-Type: application/json' \
  -H 'Prefer: return=representation' \
  -d "{\"user_id\":\"${USER_ID}\",\"client_id\":null,\"title\":\"${NO_CLIENT_TITLE}\",\"description\":\"negative flow\",\"priority\":1,\"status\":\"pending\",\"category\":\"General\"}")"
NO_CLIENT_TASK_ID="$(echo "${NO_CLIENT_JSON}" | jq -r '.[0].id')"

if [[ -z "${TASK_ID}" || "${TASK_ID}" == "null" || -z "${NO_CLIENT_TASK_ID}" || "${NO_CLIENT_TASK_ID}" == "null" ]]; then
  echo "Create tasks failed: linked=${TASK_JSON} noClient=${NO_CLIENT_JSON}" >&2
  exit 1
fi

echo "Created task_id=${TASK_ID}, no_client_task_id=${NO_CLIENT_TASK_ID}"

echo "[6/7] Verify linked filter + negative case"
LINKED_COUNT="$(curl -sS "${PROJECT_URL}/rest/v1/tasks?select=id,title,client_id&client_id=eq.${CLIENT_ID}" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" | jq 'length')"
NO_CLIENT_IN_LINKED="$(
  curl -sS --get "${PROJECT_URL}/rest/v1/tasks" \
    --data-urlencode "select=id,title,client_id" \
    --data-urlencode "client_id=eq.${CLIENT_ID}" \
    --data-urlencode "title=eq.${NO_CLIENT_TITLE}" \
    -H "apikey: ${SUPABASE_ANON_KEY}" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" | jq 'length'
)"

if [[ "${LINKED_COUNT}" -lt 1 ]]; then
  echo "Expected at least 1 linked task, got ${LINKED_COUNT}" >&2
  exit 1
fi
if [[ "${NO_CLIENT_IN_LINKED}" -ne 0 ]]; then
  echo "Negative check failed: no-client task appeared in linked tasks" >&2
  exit 1
fi

echo "Linked check passed (count=${LINKED_COUNT}), negative check passed"

echo "[7/7] Cleanup"
curl -sS -X DELETE "${PROJECT_URL}/rest/v1/tasks?id=eq.${TASK_ID}" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" >/dev/null
curl -sS -X DELETE "${PROJECT_URL}/rest/v1/tasks?id=eq.${NO_CLIENT_TASK_ID}" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" >/dev/null
curl -sS -X DELETE "${PROJECT_URL}/rest/v1/crm_clients?id=eq.${CLIENT_ID}" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" >/dev/null

echo "Backend E2E: PASS"
