# 🔧 ИСПРАВЛЕНИЕ ОШИБКИ: type "task_priority" already exists

## ❌ **ПРОБЛЕМА**

При выполнении SQL схемы появилась ошибка:
```
ERROR: 42710: type "task_priority" already exists
```

## ✅ **ПРИЧИНА**

Типы (ENUM) уже существуют в базе данных - значит схема уже выполнялась ранее!

## 🚀 **РЕШЕНИЕ (3 варианта)**

### **Вариант 1: Выполнить безопасный скрипт (РЕКОМЕНДУЕТСЯ)**

1. Откройте **Supabase Dashboard**
2. Перейдите в проект **gamified-tasks**
3. SQL Editor → **New Query**
4. Скопируйте и выполните содержимое файла:
   ```
   fix_schema.sql
   ```
5. Убедитесь, что получили сообщение:
   ```
   Database schema updated successfully!
   ```

**Этот скрипт безопасно обработает все существующие элементы!**

---

### **Вариант 2: Удалить и пересоздать (если нужно с нуля)**

```sql
-- ВНИМАНИЕ: Удалит ВСЕ данные!

-- Удалить таблицы
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS leaderboard_entries CASCADE;
DROP TABLE IF EXISTS task_activity_log CASCADE;
DROP TABLE IF EXISTS user_xp CASCADE;
DROP TABLE IF EXISTS user_achievements CASCADE;
DROP TABLE IF EXISTS achievements CASCADE;
DROP TABLE IF EXISTS work_tasks CASCADE;
DROP TABLE IF EXISTS team_members CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS corporate_users CASCADE;
DROP TABLE IF EXISTS teams CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS organizations CASCADE;

-- Удалить типы
DROP TYPE IF EXISTS report_period CASCADE;
DROP TYPE IF EXISTS achievement_category CASCADE;
DROP TYPE IF EXISTS task_type CASCADE;
DROP TYPE IF EXISTS user_role CASCADE;
DROP TYPE IF EXISTS task_priority CASCADE;

-- Затем выполнить полную схему
-- Скопируйте содержимое database_schema_complete.sql
```

---

### **Вариант 3: Проверить существующую схему**

```sql
-- Проверить существующие таблицы
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;

-- Проверить существующие типы
SELECT typname 
FROM pg_type 
WHERE typname IN ('task_priority', 'user_role', 'task_type', 'achievement_category', 'report_period');
```

---

## ✅ **ПРОВЕРКА РЕЗУЛЬТАТА**

После выполнения скрипта выполните:

```sql
-- Проверить, что таблицы созданы
SELECT 'organizations' as table_name FROM organizations LIMIT 1
UNION ALL
SELECT 'departments' FROM departments LIMIT 1
UNION ALL
SELECT 'teams' FROM teams LIMIT 1
UNION ALL
SELECT 'corporate_users' FROM corporate_users LIMIT 1
UNION ALL
SELECT 'work_tasks' FROM work_tasks LIMIT 1
UNION ALL
SELECT 'achievements' FROM achievements LIMIT 1;
```

**Должно вернуть 6 строк без ошибок!**

---

## 📊 **ОЖИДАЕМЫЙ РЕЗУЛЬТАТ**

После успешного выполнения у вас будет:

- ✅ 12 таблиц (organizations, departments, teams, corporate_users, projects, team_members, work_tasks, achievements, user_achievements, user_xp, task_activity_log, leaderboard_entries, notifications)
- ✅ 5 типов (task_priority, user_role, task_type, achievement_category, report_period)
- ✅ RLS политики
- ✅ Триггеры
- ✅ 10+ достижений по умолчанию

---

## 🚀 **СЛЕДУЮЩИЙ ШАГ**

После успешного выполнения SQL:

```bash
# Запустить приложение
cd /home/zhaslan/code/gamified_task_app
flutter run -d web-server --target lib/main_final.dart --web-port 8085
```

---

## 📞 **ЕСЛИ НЕ РАБОТАЕТ**

1. Убедитесь, что выполняете в **правильном проекте** (gamified-tasks)
2. Проверьте, что используете **SQL Editor** (не REST API)
3. Попробуйте **Вариант 1** - безопасный скрипт
4. Если ничего не помогает - используйте **Вариант 2** (с нуля)

---

**Составлено**: 3 ноября 2025
**Статус**: ✅ **ИСПРАВЛЕНИЕ ГОТОВО**
