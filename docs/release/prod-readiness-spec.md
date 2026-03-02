# Prod-Readiness Spec (Business)

## Характеристики
- Надежный релизный цикл: CI gates + staging smoke + rollback drill.
- Dual-schema совместимость: legacy и corporate data-path работают без потери данных.
- Безопасная конфигурация: только runtime secrets, без hardcoded ключей.
- Наблюдаемость: crash/error capture, release telemetry, runbook инцидентов.

## Требования
- Обязательные окружения: Dev, Staging, Prod.
- Обязательный gate: CI green, smoke green, rollback green.
- Схемы БД: `tasks|work_tasks`, `user_stats|corporate_users|profiles`.
- Все новые операции БД должны поддерживать schema routing или явно помечаться как schema-specific.
- Legacy-модули вне release-scope допускаются только при явном analyzer exclude и отдельном tech-debt трекинге.

## Тестовые требования
- Unit/Widget/Integration тесты обязательны в CI для release-scope (`scripts/test_release_scope.sh`).
- Тесты безопасности и data-protection обязательны.
- Smoke-набор на staging перед prod.
- Drift-проверка схемы в CI (при наличии `STAGING_DATABASE_URL`).
