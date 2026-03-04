-- Adds optional client linkage for tasks in the runtime flow.
-- Safe to run multiple times.

ALTER TABLE public.tasks
ADD COLUMN IF NOT EXISTS client_id UUID;

-- Attach FK only if CRM clients table exists in this environment.
DO $$
BEGIN
  IF to_regclass('public.crm_clients') IS NOT NULL THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_constraint
      WHERE conname = 'tasks_client_id_fkey'
    ) THEN
      ALTER TABLE public.tasks
        ADD CONSTRAINT tasks_client_id_fkey
        FOREIGN KEY (client_id)
        REFERENCES public.crm_clients(id)
        ON DELETE SET NULL;
    END IF;
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_tasks_client_id ON public.tasks(client_id);
