-- Schema bridge migration (idempotent)
-- Goal: keep legacy and corporate app code operational during transition.

-- 1) Legacy tasks view over corporate schema
DO $$
BEGIN
  IF to_regclass('public.work_tasks') IS NOT NULL
     AND to_regclass('public.tasks') IS NULL THEN
    EXECUTE $sql$
      CREATE VIEW public.tasks AS
      SELECT
        id,
        assignee_id AS user_id,
        title,
        COALESCE(description, '') AS description,
        CASE
          WHEN priority IN ('urgent', 'critical') THEN 'high'
          WHEN priority = 'high' THEN 'high'
          WHEN priority = 'low' THEN 'low'
          ELSE 'medium'
        END AS priority,
        COALESCE(category, 'General') AS category,
        due_date,
        created_at,
        updated_at,
        COALESCE(is_completed, status IN ('completed','done','closed')) AS is_completed
      FROM public.work_tasks;
    $sql$;
  END IF;
END $$;

-- 2) Legacy user_stats view over corporate schema
DO $$
BEGIN
  IF to_regclass('public.corporate_users') IS NOT NULL
     AND to_regclass('public.user_stats') IS NULL THEN
    EXECUTE $sql$
      CREATE VIEW public.user_stats AS
      SELECT
        COALESCE(user_id, id) AS id,
        COALESCE(username, split_part(email, '@', 1), 'user') AS username,
        COALESCE(email, '') AS email,
        COALESCE(total_xp, 0) AS xp,
        COALESCE(current_level, 1) AS level,
        COALESCE(streak_count, 0) AS streak,
        last_task_date,
        created_at,
        updated_at
      FROM public.corporate_users;
    $sql$;
  END IF;
END $$;

-- 3) Corporate work_tasks view over legacy schema
DO $$
BEGIN
  IF to_regclass('public.tasks') IS NOT NULL
     AND to_regclass('public.work_tasks') IS NULL THEN
    EXECUTE $sql$
      CREATE VIEW public.work_tasks AS
      SELECT
        id,
        NULL::uuid AS organization_id,
        NULL::uuid AS department_id,
        NULL::uuid AS team_id,
        NULL::uuid AS project_id,
        user_id AS assignee_id,
        user_id AS reporter_id,
        title,
        NULLIF(description, '') AS description,
        'personal' AS task_type,
        CASE
          WHEN priority::text = 'low' THEN 'low'
          WHEN priority::text = 'high' THEN 'high'
          ELSE 'medium'
        END AS priority,
        category,
        CASE WHEN is_completed THEN 'completed' ELSE 'todo' END AS status,
        due_date,
        CASE WHEN is_completed THEN updated_at ELSE NULL END AS completed_at,
        NULL::numeric AS estimated_hours,
        NULL::numeric AS actual_hours,
        NULL::integer AS quality_rating,
        NULL::text AS feedback,
        0::integer AS xp_reward,
        '{}'::jsonb AS settings,
        created_at,
        updated_at,
        is_completed,
        FALSE AS is_archived
      FROM public.tasks;
    $sql$;
  END IF;
END $$;
