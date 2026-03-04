# Gamified Task CRM (Flutter Web)

Учебный CRM-проект с задачами, клиентами и AI-ассистентом.

## 1. Быстрый старт

### Требования
- Flutter `3.41.3+`
- Dart `3.11+`

### Установка зависимостей
```bash
flutter pub get
```

### Запуск Web
```bash
flutter run -d chrome
```

## 2. Конфигурация окружения

Скопируйте значения из [.env.example](.env.example) и передавайте секреты через `--dart-define`.

### Режимы runtime
- `DEMO_MODE=false` (по умолчанию): backend-first путь, реальный Supabase Auth + CRUD.
- `DEMO_MODE=true`: локальный demo-путь (mock auth + локальное хранилище) и явный banner в UI.

### Обязательные переменные для production-пути
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `MINIMAX_API_KEY` (для AI-чата)

### Опциональные
- `ZAI_API_KEY` (если используете GLM-сервис)
- `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_HOST`, `SMTP_PORT`, `SMTP_FROM_EMAIL`, `SMTP_FROM_NAME`
- `DEMO_MODE=true` (добавляет demo-клиентов при старте)
- `AI_DEMO_MODE=true` (явный demo-режим AI, показывается в UI)

### Пример запуска с define
```bash
flutter run -d chrome \
  --dart-define=DEMO_MODE=false \
  --dart-define=SUPABASE_URL=... \
  --dart-define=SUPABASE_ANON_KEY=... \
  --dart-define=MINIMAX_API_KEY=...
```

### Воспроизводимый запуск для evidence-pack
```bash
# Linux/macOS
SUPABASE_URL=... SUPABASE_ANON_KEY=... scripts/run_web_local.sh chrome

# fallback без Chrome в среде:
SUPABASE_URL=... SUPABASE_ANON_KEY=... scripts/run_web_local.sh web-server --web-port 18080
```

Подробный чеклист и сценарии записи: `docs/RUN_WEB_EVIDENCE.md`.

## 3. CRM flow (актуальный runtime)

Основной поток:
1. Login
2. Create Client
3. Create Task (с выбором клиента или `No client`)
4. Client details показывает связанные задачи (`task.clientId == client.id`)
5. Global tasks list показывает клиента задачи

### Данные
- Поле связи: `tasks.client_id` (nullable)
- Локальная модель: `Task.clientId`
- Миграция: [docs/migrations/2026-03-04-add-client-id-to-public-tasks.sql](docs/migrations/2026-03-04-add-client-id-to-public-tasks.sql)
- Bootstrap runtime-схемы: [docs/migrations/2026-03-04-bootstrap-runtime-schema.sql](docs/migrations/2026-03-04-bootstrap-runtime-schema.sql)

### Таблицы backend (минимум для Phase 1)
- `public.tasks` (`id`, `user_id`, `client_id`, `title`, `description`, `priority`, `status`, `category`, `due_date`, `created_at`, `updated_at`)
- `public.crm_clients` (`id`, `first_name`, `last_name`, `email`, `phone`, `company_name`, `position`, `status`, `source`, `created_at`, `updated_at`)
- `public.user_stats` (для профиля/прогресса)

SQL:
1. Базовая схема задач/статов: `supabase_schema.sql`
2. CRM таблицы: `supabase_crm_schema.sql`
3. Связь задачи с клиентом: `docs/migrations/2026-03-04-add-client-id-to-public-tasks.sql`

## 4. Проверка качества

### Analyze (полный runtime-код, без soft-флагов)
```bash
flutter analyze
```

### Тесты (полный набор)
```bash
flutter test
flutter test --coverage

# Coverage: full lib report + runtime gate
bash scripts/ci/report_full_lib_coverage.sh coverage/lcov.info
bash scripts/ci/check_coverage_gate.sh coverage/lcov.info 55 scripts/ci/runtime_coverage_scope.txt

# Integration smoke (web flow)
bash scripts/ci/run_integration_smoke.sh
```

### Реальный Web E2E (Chrome + Supabase)
```bash
SUPABASE_URL=... \
SUPABASE_ANON_KEY=... \
E2E_EMAIL=... \
E2E_PASSWORD=... \
E2E_DEVICE=chrome \
bash scripts/ci/run_web_supabase_e2e.sh
```

E2E сценарий: `Login -> Create Client -> Create Task (linked client) -> Verify in tasks + client details`.

### Backend CRUD evidence (Auth + Client/Task CRUD + cleanup)
```bash
SUPABASE_URL=... \
SUPABASE_ANON_KEY=... \
E2E_EMAIL=... \
E2E_PASSWORD=... \
bash scripts/run_backend_e2e.sh
```

## 5. Краткая архитектура

- Entry point + bootstrap: `lib/main.dart`
- Router: `GoRouter` через `appRouterProvider` в `lib/main.dart`
- App shell: `lib/app/root_layout.dart`
- Features:
  - `lib/features/dashboard/presentation/`
  - `lib/features/tasks/presentation/`
  - `lib/features/crm/presentation/`
  - `lib/features/reports/presentation/`
  - `lib/features/profile/presentation/`
  - `lib/features/ai/presentation/`
- Runtime state: `lib/providers.dart`, `lib/providers_crm.dart`
- AI chat service: `lib/features/ai/services/minimax_ai_service.dart`
- Runtime coverage scope: `scripts/ci/runtime_coverage_scope.txt`
- Security/rotation guide: [docs/security/KEY_ROTATION_AND_HISTORY_CLEANUP.md](docs/security/KEY_ROTATION_AND_HISTORY_CLEANUP.md)

## 6. Backend / SQL

Если используете Supabase:
1. Примените idempotent bootstrap-скрипт:
```bash
PGPASSWORD='<DB_PASSWORD>' psql \
  "host=aws-1-eu-west-2.pooler.supabase.com port=6543 dbname=postgres user=postgres.<project-ref> sslmode=require" \
  -v ON_ERROR_STOP=1 \
  -f docs/migrations/2026-03-04-bootstrap-runtime-schema.sql
```
2. Скрипт создаст/обновит `public.tasks`, `public.crm_clients`, `public.user_stats`, RLS/policies, FK `tasks.client_id -> crm_clients.id`, индексы и триггеры `updated_at`.
3. Дополнительные исторические SQL (`supabase_schema.sql`, `supabase_crm_schema.sql`) оставлены для справки, но для текущего runtime используйте bootstrap-скрипт выше.

## 7. Web Build / Deploy

```bash
SUPABASE_URL=... SUPABASE_ANON_KEY=... ./deploy_web.sh production
```

Альтернативные deploy/evidence-скрипты:
- `scripts/deploy_web.sh` (GitHub Pages/Netlify wrapper)
- `docs/DEPLOY_WEB.md`
- `docs/BACKEND_TESTING.md`
- `docs/RUN_WEB_EVIDENCE.md`

Подробная навигация по актуальной документации: `docs/README.md`.  
Устаревшие конфликтующие документы перенесены в `docs/archive/root-legacy-2026-03-04/`.
