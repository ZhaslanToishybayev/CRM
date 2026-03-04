# BACKEND_TESTING

Проверка реального backend-path (`DEMO_MODE=false`) для Supabase Auth + CRUD.

## 1) Требования

- Таблицы runtime-схемы применены:
  - `public.crm_clients`
  - `public.tasks`
  - `public.user_stats`
- Включены RLS/policies (см. `docs/migrations/2026-03-04-bootstrap-runtime-schema.sql`)

Если схема еще не применена:

```bash
PGPASSWORD='<DB_PASSWORD>' psql \
  "host=aws-1-eu-west-2.pooler.supabase.com port=6543 dbname=postgres user=postgres.<project-ref> sslmode=require" \
  -v ON_ERROR_STOP=1 \
  -f docs/migrations/2026-03-04-bootstrap-runtime-schema.sql
```

## 2) Переменные окружения

Обязательные:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `E2E_EMAIL`
- `E2E_PASSWORD`

Опционально для автосоздания тест-пользователя:
- `CREATE_TEST_USER=true`
- `SUPABASE_SERVICE_ROLE_KEY`

## 3) Прогон backend e2e

```bash
export SUPABASE_URL='https://<project-ref>.supabase.co'
export SUPABASE_ANON_KEY='<anon-key>'
export E2E_EMAIL='e2e.user@example.com'
export E2E_PASSWORD='StrongPassword123!'

# optional: auto-create user
# export CREATE_TEST_USER=true
# export SUPABASE_SERVICE_ROLE_KEY='<service-role-key>'

bash scripts/run_backend_e2e.sh
```

Скрипт делает:
1. Auth sign-in
2. Create client
3. Create linked task
4. Create `No client` task
5. Verify linked-filter + negative case (no-client не попал в linked)
6. Cleanup

## 4) Как создать тестового пользователя вручную (без service role)

В Supabase Dashboard:
1. Authentication -> Users
2. `Add user`
3. Email + Password
4. Confirm email (если требуется)

## 5) Безопасность

- Не храните ключи/пароли в репозитории.
- Используйте CI secrets или локальные env.
- После публичной утечки ключей — обязательная ротация.
