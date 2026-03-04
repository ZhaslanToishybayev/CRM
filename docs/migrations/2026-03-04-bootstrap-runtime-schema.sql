-- Runtime bootstrap schema for Flutter Web CRM (backend-first path)
-- Safe to run multiple times.

CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ------------------------------------------------------------------
-- Base tables
-- ------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.crm_clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_user_id UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  company_name TEXT,
  position TEXT,
  status TEXT NOT NULL DEFAULT 'lead',
  source TEXT NOT NULL DEFAULT 'other',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT crm_clients_email_not_blank CHECK (btrim(email) <> '')
);

CREATE TABLE IF NOT EXISTS public.tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  client_id UUID,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  priority INTEGER NOT NULL DEFAULT 2,
  status TEXT NOT NULL DEFAULT 'pending',
  category TEXT NOT NULL DEFAULT 'General',
  due_date TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT tasks_priority_range CHECK (priority BETWEEN 1 AND 3)
);

CREATE TABLE IF NOT EXISTS public.user_stats (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT,
  email TEXT,
  xp INTEGER NOT NULL DEFAULT 0,
  level INTEGER NOT NULL DEFAULT 1,
  streak INTEGER NOT NULL DEFAULT 0,
  completed_tasks INTEGER NOT NULL DEFAULT 0,
  total_tasks INTEGER NOT NULL DEFAULT 0,
  last_active_date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ------------------------------------------------------------------
-- Backfill/compat columns (for environments with older tables)
-- ------------------------------------------------------------------

ALTER TABLE public.crm_clients
  ADD COLUMN IF NOT EXISTS owner_user_id UUID DEFAULT auth.uid(),
  ADD COLUMN IF NOT EXISTS first_name TEXT,
  ADD COLUMN IF NOT EXISTS last_name TEXT,
  ADD COLUMN IF NOT EXISTS email TEXT,
  ADD COLUMN IF NOT EXISTS phone TEXT,
  ADD COLUMN IF NOT EXISTS company_name TEXT,
  ADD COLUMN IF NOT EXISTS position TEXT,
  ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'lead',
  ADD COLUMN IF NOT EXISTS source TEXT DEFAULT 'other',
  ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT now(),
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT now();

ALTER TABLE public.tasks
  ADD COLUMN IF NOT EXISTS user_id UUID,
  ADD COLUMN IF NOT EXISTS client_id UUID,
  ADD COLUMN IF NOT EXISTS title TEXT,
  ADD COLUMN IF NOT EXISTS description TEXT DEFAULT '',
  ADD COLUMN IF NOT EXISTS priority INTEGER DEFAULT 2,
  ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending',
  ADD COLUMN IF NOT EXISTS category TEXT DEFAULT 'General',
  ADD COLUMN IF NOT EXISTS due_date TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT now(),
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT now();

ALTER TABLE public.user_stats
  ADD COLUMN IF NOT EXISTS username TEXT,
  ADD COLUMN IF NOT EXISTS email TEXT,
  ADD COLUMN IF NOT EXISTS xp INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS level INTEGER DEFAULT 1,
  ADD COLUMN IF NOT EXISTS streak INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS completed_tasks INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS total_tasks INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS last_active_date DATE DEFAULT CURRENT_DATE,
  ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT now(),
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT now();

-- ------------------------------------------------------------------
-- Constraints / FK
-- ------------------------------------------------------------------

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'tasks_client_id_fkey'
      AND conrelid = 'public.tasks'::regclass
  ) THEN
    ALTER TABLE public.tasks
      ADD CONSTRAINT tasks_client_id_fkey
      FOREIGN KEY (client_id)
      REFERENCES public.crm_clients(id)
      ON DELETE SET NULL;
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'crm_clients_owner_user_id_fkey'
      AND conrelid = 'public.crm_clients'::regclass
  ) THEN
    ALTER TABLE public.crm_clients
      ADD CONSTRAINT crm_clients_owner_user_id_fkey
      FOREIGN KEY (owner_user_id)
      REFERENCES auth.users(id)
      ON DELETE CASCADE;
  END IF;
END $$;

-- ------------------------------------------------------------------
-- Indexes
-- ------------------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_tasks_user_id ON public.tasks(user_id);
CREATE INDEX IF NOT EXISTS idx_tasks_client_id ON public.tasks(client_id);
CREATE INDEX IF NOT EXISTS idx_tasks_created_at ON public.tasks(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON public.tasks(status);

CREATE INDEX IF NOT EXISTS idx_crm_clients_owner_user_id ON public.crm_clients(owner_user_id);
CREATE INDEX IF NOT EXISTS idx_crm_clients_created_at ON public.crm_clients(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_crm_clients_email_lower ON public.crm_clients ((lower(email)));

CREATE INDEX IF NOT EXISTS idx_user_stats_email_lower ON public.user_stats ((lower(email)));

-- ------------------------------------------------------------------
-- updated_at helper + triggers
-- ------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgname = 'trg_tasks_updated_at'
  ) THEN
    CREATE TRIGGER trg_tasks_updated_at
    BEFORE UPDATE ON public.tasks
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgname = 'trg_crm_clients_updated_at'
  ) THEN
    CREATE TRIGGER trg_crm_clients_updated_at
    BEFORE UPDATE ON public.crm_clients
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgname = 'trg_user_stats_updated_at'
  ) THEN
    CREATE TRIGGER trg_user_stats_updated_at
    BEFORE UPDATE ON public.user_stats
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();
  END IF;
END $$;

-- ------------------------------------------------------------------
-- Auto-create user_stats for new auth users
-- ------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.handle_new_user_stats()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_stats (id, username, email)
  VALUES (
    NEW.id,
    COALESCE(NULLIF(NEW.raw_user_meta_data->>'full_name', ''), split_part(NEW.email, '@', 1)),
    NEW.email
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_trigger
    WHERE tgname = 'on_auth_user_created_user_stats'
  ) THEN
    CREATE TRIGGER on_auth_user_created_user_stats
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_stats();
  END IF;
END $$;

-- ------------------------------------------------------------------
-- Grants
-- ------------------------------------------------------------------

GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.tasks TO authenticated, service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.crm_clients TO authenticated, service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_stats TO authenticated, service_role;

-- ------------------------------------------------------------------
-- RLS policies
-- ------------------------------------------------------------------

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.crm_clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_stats ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'tasks' AND policyname = 'tasks_select_own'
  ) THEN
    CREATE POLICY tasks_select_own
      ON public.tasks
      FOR SELECT
      USING (auth.uid() = user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'tasks' AND policyname = 'tasks_insert_own'
  ) THEN
    CREATE POLICY tasks_insert_own
      ON public.tasks
      FOR INSERT
      WITH CHECK (
        auth.uid() = user_id
        AND (
          client_id IS NULL OR EXISTS (
            SELECT 1
            FROM public.crm_clients c
            WHERE c.id = client_id
              AND c.owner_user_id = auth.uid()
          )
        )
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'tasks' AND policyname = 'tasks_update_own'
  ) THEN
    CREATE POLICY tasks_update_own
      ON public.tasks
      FOR UPDATE
      USING (auth.uid() = user_id)
      WITH CHECK (
        auth.uid() = user_id
        AND (
          client_id IS NULL OR EXISTS (
            SELECT 1
            FROM public.crm_clients c
            WHERE c.id = client_id
              AND c.owner_user_id = auth.uid()
          )
        )
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'tasks' AND policyname = 'tasks_delete_own'
  ) THEN
    CREATE POLICY tasks_delete_own
      ON public.tasks
      FOR DELETE
      USING (auth.uid() = user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'crm_clients' AND policyname = 'crm_clients_select_own'
  ) THEN
    CREATE POLICY crm_clients_select_own
      ON public.crm_clients
      FOR SELECT
      USING (auth.uid() = owner_user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'crm_clients' AND policyname = 'crm_clients_insert_own'
  ) THEN
    CREATE POLICY crm_clients_insert_own
      ON public.crm_clients
      FOR INSERT
      WITH CHECK (auth.uid() = owner_user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'crm_clients' AND policyname = 'crm_clients_update_own'
  ) THEN
    CREATE POLICY crm_clients_update_own
      ON public.crm_clients
      FOR UPDATE
      USING (auth.uid() = owner_user_id)
      WITH CHECK (auth.uid() = owner_user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'crm_clients' AND policyname = 'crm_clients_delete_own'
  ) THEN
    CREATE POLICY crm_clients_delete_own
      ON public.crm_clients
      FOR DELETE
      USING (auth.uid() = owner_user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'user_stats' AND policyname = 'user_stats_select_own'
  ) THEN
    CREATE POLICY user_stats_select_own
      ON public.user_stats
      FOR SELECT
      USING (auth.uid() = id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'user_stats' AND policyname = 'user_stats_insert_own'
  ) THEN
    CREATE POLICY user_stats_insert_own
      ON public.user_stats
      FOR INSERT
      WITH CHECK (auth.uid() = id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public' AND tablename = 'user_stats' AND policyname = 'user_stats_update_own'
  ) THEN
    CREATE POLICY user_stats_update_own
      ON public.user_stats
      FOR UPDATE
      USING (auth.uid() = id)
      WITH CHECK (auth.uid() = id);
  END IF;
END $$;

-- Ask PostgREST to reload schema cache.
SELECT pg_notify('pgrst', 'reload schema');
