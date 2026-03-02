#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${DATABASE_URL:-}" ]]; then
  echo "[schema-drift] DATABASE_URL is not set; skipping"
  exit 0
fi

if ! command -v psql >/dev/null 2>&1; then
  echo "[schema-drift] psql not found"
  exit 1
fi

echo "[schema-drift] Running schema drift checks"

has_tasks=$(psql "$DATABASE_URL" -Atc "SELECT to_regclass('public.tasks') IS NOT NULL;")
has_work_tasks=$(psql "$DATABASE_URL" -Atc "SELECT to_regclass('public.work_tasks') IS NOT NULL;")

if [[ "$has_tasks" == "t" && "$has_work_tasks" == "t" ]]; then
  legacy_tasks=$(psql "$DATABASE_URL" -Atc "SELECT COUNT(*) FROM public.tasks;")
  corporate_tasks=$(psql "$DATABASE_URL" -Atc "SELECT COUNT(*) FROM public.work_tasks;")
  echo "[schema-drift] tasks=$legacy_tasks work_tasks=$corporate_tasks"
  if [[ "$legacy_tasks" != "$corporate_tasks" ]]; then
    echo "[schema-drift] Task count drift detected"
    exit 1
  fi
fi

has_user_stats=$(psql "$DATABASE_URL" -Atc "SELECT to_regclass('public.user_stats') IS NOT NULL;")
has_corporate_users=$(psql "$DATABASE_URL" -Atc "SELECT to_regclass('public.corporate_users') IS NOT NULL;")

if [[ "$has_user_stats" == "t" && "$has_corporate_users" == "t" ]]; then
  legacy_users=$(psql "$DATABASE_URL" -Atc "SELECT COUNT(*) FROM public.user_stats;")
  corporate_users=$(psql "$DATABASE_URL" -Atc "SELECT COUNT(DISTINCT user_id) FROM public.corporate_users WHERE user_id IS NOT NULL;")
  echo "[schema-drift] user_stats=$legacy_users corporate_users=$corporate_users"
  if [[ "$legacy_users" != "$corporate_users" ]]; then
    echo "[schema-drift] User stats count drift detected"
    exit 1
  fi
fi

echo "[schema-drift] OK"
