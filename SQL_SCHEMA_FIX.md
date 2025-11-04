# 🔧 РЕШЕНИЕ ОШИБКИ: type "task_priority" already exists

## ❌ **ПРОБЛЕМА**

```
ERROR: 42710: type "task_priority" already exists
```

## ✅ **ПРИЧИНА**

Типы (ENUM) уже существуют в базе данных - схема уже выполнялась ранее!

---

## 🚀 **РЕШЕНИЕ (3 МИНУТЫ)**

### **Шаг 1: Откройте Supabase**

Перейдите на https://supabase.com/dashboard → проект **gamified-tasks**

### **Шаг 2: Выполните SQL**

1. SQL Editor → **New Query**
2. Откройте файл: `/home/zhaslan/code/gamified_task_app/fix_schema.sql`
3. Скопируйте **ВСЁ** содержимое (371 строка)
4. Вставьте в SQL Editor
5. **Run** → Выполнить

### **Шаг 3: Проверьте результат**

Должно появиться сообщение:
```
Database schema updated successfully!
```

---

## 📊 **ЧТО ДЕЛАЕТ СКРИПТ**

✅ Создает типы **ТОЛЬКО если их нет** (IF NOT EXISTS)
✅ Создает таблицы **ТОЛЬКО если их нет** (CREATE TABLE IF NOT EXISTS)
✅ Настраивает RLS политики
✅ Создает триггеры
✅ Добавляет 10 достижений по умолчанию
✅ **НЕ УДАЛЯЕТ** существующие данные!

---

## ✅ **ПРОВЕРКА УСПЕХА**

После выполнения выполните этот запрос:

```sql
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

**Результат**: 6 строк без ошибок ✅

---

## 🚀 **СЛЕДУЮЩИЙ ШАГ**

После успешного выполнения SQL:

```bash
cd /home/zhaslan/code/gamified_task_app
flutter run -d web-server --target lib/main_final.dart --web-port 8085
```

Откройте: **http://localhost:8085**

---

## 📁 **ФАЙЛЫ**

- ✅ `fix_schema.sql` - безопасный скрипт (371 строка)
- ✅ `FIX_SCHEMA.md` - инструкция
- ✅ `check_schema.sh` - скрипт проверки

---

## 🎯 **АЛЬТЕРНАТИВА**

Если скрипт не работает, можно **удалить всё и создать заново**:

```sql
-- ⚠️ ВНИМАНИЕ: Удалит ВСЕ данные!

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

DROP TYPE IF EXISTS report_period CASCADE;
DROP TYPE IF EXISTS achievement_category CASCADE;
DROP TYPE IF EXISTS task_type CASCADE;
DROP TYPE IF EXISTS user_role CASCADE;
DROP TYPE IF EXISTS task_priority CASCADE;
```

Затем выполните: `database_schema_complete.sql`

---

## ✅ **ИТОГ**

**Время**: 3 минуты
**Результат**: Схема без ошибок
**Статус**: Готово к запуску приложения

---

**Составлено**: 3 ноября 2025
**Статус**: ✅ **ИСПРАВЛЕНИЕ ГОТОВО**
