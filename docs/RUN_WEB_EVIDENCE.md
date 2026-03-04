# RUN_WEB_EVIDENCE

Документ для демонстрации реальной работоспособности Flutter Web + Backend + AI.

## 1) Что считается доказательством

Минимальный evidence pack:
1. Лог запуска Web (`flutter run ... --verbose`)
2. Скринкаст S1–S6 (одним дублем)
3. Скриншоты ключевых экранов (login, clients, tasks, client details, AI)
4. Если есть CI browser e2e: ссылка на job + артефакты (screenshots/trace/video)
5. Deployed URL (GitHub Pages/Netlify)

Рекомендуемая папка для артефактов:
- `tmp/evidence/<date>/`

## 2) Обязательные переменные

- `DEMO_MODE=false`
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `MINIMAX_API_KEY` (опционально, для AI success)

## 3) Локальный запуск (Linux/macOS)

```bash
export DEMO_MODE=false
export SUPABASE_URL='https://<project-ref>.supabase.co'
export SUPABASE_ANON_KEY='<anon-key>'
# optional
export MINIMAX_API_KEY='<minimax-key>'

scripts/run_web_local.sh chrome
# или fallback без Chrome:
scripts/run_web_local.sh web-server --web-port 18080
```

Лог запуска будет сохранен автоматически в:
- `tmp/evidence/web_run_YYYYMMDD_HHMMSS.log`

## 4) Локальный запуск (Windows PowerShell)

```powershell
$env:DEMO_MODE='false'
$env:SUPABASE_URL='https://<project-ref>.supabase.co'
$env:SUPABASE_ANON_KEY='<anon-key>'
# optional
$env:MINIMAX_API_KEY='<minimax-key>'

./scripts/run_web_local.ps1 -Target chrome
# fallback:
./scripts/run_web_local.ps1 -Target web-server
```

## 5) Сценарий скринкаста S1–S6

Показывать без монтажных склеек.

1. **S1 Login**
- Открыть `/login`
- Войти реальным backend-пользователем
- Показать переход в `/app`

2. **S2 Create Client**
- Перейти CRM
- Создать клиента
- Показать его карточку в списке

3. **S3 Create Linked Task**
- Перейти Tasks
- Создать задачу с выбранным клиентом
- Показать в списке `Клиент: <имя>`

4. **S4 Client Details Link Proof**
- Открыть клиента
- В блоке `Связанные задачи` показать эту задачу

5. **S5 Error + Retry**
- Имитировать ошибку (отключить сеть или временно убрать `SUPABASE_URL`/`MINIMAX_API_KEY`)
- Показать понятный error state
- Нажать Retry и показать восстановление

6. **S6 AI Assistant**
- Открыть AI чат
- Отправить запрос
- Вариант A: успех (если `MINIMAX_API_KEY` задан)
- Вариант B: корректная ошибка + Retry (если ключ отсутствует)

## 6) Чеклист перед отправкой преподавателю

- [ ] Приложен verbose лог web-запуска
- [ ] Есть deployed URL
- [ ] Есть скринкаст S1–S6
- [ ] Есть 4+ скриншотов экранов
- [ ] Есть backend e2e лог (`scripts/run_backend_e2e.sh`)
- [ ] Указано, какой режим AI показан (success/retry)

## 7) Быстрые команды для отчета

```bash
flutter analyze
flutter test
flutter test --coverage
bash scripts/ci/report_full_lib_coverage.sh coverage/lcov.info
bash scripts/ci/check_coverage_gate.sh coverage/lcov.info 55 scripts/ci/runtime_coverage_scope.txt
bash scripts/run_backend_e2e.sh
```
