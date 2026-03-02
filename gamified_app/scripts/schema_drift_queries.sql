-- Manual schema-drift inspection queries

SELECT to_regclass('public.tasks') AS tasks_table,
       to_regclass('public.work_tasks') AS work_tasks_table,
       to_regclass('public.user_stats') AS user_stats_table,
       to_regclass('public.corporate_users') AS corporate_users_table;

SELECT
  (SELECT COUNT(*) FROM public.tasks) AS legacy_tasks_count,
  (SELECT COUNT(*) FROM public.work_tasks) AS corporate_tasks_count;

SELECT
  (SELECT COUNT(*) FROM public.user_stats) AS legacy_user_stats_count,
  (SELECT COUNT(DISTINCT user_id) FROM public.corporate_users WHERE user_id IS NOT NULL) AS corporate_users_count;
