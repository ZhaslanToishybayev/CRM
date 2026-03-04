-- CRM Database Schema for Supabase
-- Tables: clients, deals, companies, tasks, activities, pipelines, pipeline_stages

-- Enable RLS (Row Level Security)
ALTER DATABASE postgres SET "app.jwt_secret" TO 'your-jwt-secret';

-- Clients Table
CREATE TABLE IF NOT EXISTS crm_clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(50),
  company_name VARCHAR(255),
  avatar_url TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'lead',
  source VARCHAR(50) DEFAULT 'manual',
  lead_score INTEGER DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Companies Table
CREATE TABLE IF NOT EXISTS crm_companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  industry VARCHAR(100),
  size VARCHAR(50),
  website TEXT,
  phone VARCHAR(50),
  email VARCHAR(255),
  address TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'prospect',
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pipelines Table
CREATE TABLE IF NOT EXISTS crm_pipelines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pipeline Stages Table
CREATE TABLE IF NOT EXISTS crm_pipeline_stages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pipeline_id UUID NOT NULL REFERENCES crm_pipelines(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  order_position INTEGER NOT NULL,
  color_hex INTEGER NOT NULL DEFAULT 4289511610,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Deals Table
CREATE TABLE IF NOT EXISTS crm_deals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  amount DECIMAL(12, 2) NOT NULL DEFAULT 0,
  probability INTEGER DEFAULT 0,
  expected_close_date DATE,
  actual_close_date DATE,
  status VARCHAR(20) NOT NULL DEFAULT 'open',
  stage_id UUID NOT NULL REFERENCES crm_pipeline_stages(id),
  client_id UUID REFERENCES crm_clients(id) ON DELETE SET NULL,
  client_name VARCHAR(255),
  products JSONB,
  source VARCHAR(50) DEFAULT 'manual',
  assigned_to UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- CRM Tasks Table
CREATE TABLE IF NOT EXISTS crm_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  type VARCHAR(20) NOT NULL DEFAULT 'task',
  status VARCHAR(20) NOT NULL DEFAULT 'pending',
  priority VARCHAR(20) NOT NULL DEFAULT 'medium',
  due_date TIMESTAMP WITH TIME ZONE NOT NULL,
  completed_at TIMESTAMP WITH TIME ZONE,
  client_id UUID REFERENCES crm_clients(id) ON DELETE SET NULL,
  client_name VARCHAR(255),
  deal_id UUID REFERENCES crm_deals(id) ON DELETE SET NULL,
  assigned_to UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Activities Table
CREATE TABLE IF NOT EXISTS crm_activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type VARCHAR(50) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  client_id UUID REFERENCES crm_clients(id) ON DELETE SET NULL,
  deal_id UUID REFERENCES crm_deals(id) ON DELETE SET NULL,
  activity_date TIMESTAMP WITH TIME ZONE NOT NULL,
  metadata JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for better performance
CREATE INDEX IF NOT EXISTS idx_crm_clients_status ON crm_clients(status);
CREATE INDEX IF NOT EXISTS idx_crm_clients_email ON crm_clients(email);
CREATE INDEX IF NOT EXISTS idx_crm_clients_created_at ON crm_clients(created_at);

CREATE INDEX IF NOT EXISTS idx_crm_companies_status ON crm_companies(status);
CREATE INDEX IF NOT EXISTS idx_crm_companies_industry ON crm_companies(industry);

CREATE INDEX IF NOT EXISTS idx_crm_deals_status ON crm_deals(status);
CREATE INDEX IF NOT EXISTS idx_crm_deals_stage_id ON crm_deals(stage_id);
CREATE INDEX IF NOT EXISTS idx_crm_deals_client_id ON crm_deals(client_id);
CREATE INDEX IF NOT EXISTS idx_crm_deals_created_at ON crm_deals(created_at);

CREATE INDEX IF NOT EXISTS idx_crm_tasks_status ON crm_tasks(status);
CREATE INDEX IF NOT EXISTS idx_crm_tasks_type ON crm_tasks(type);
CREATE INDEX IF NOT EXISTS idx_crm_tasks_client_id ON crm_tasks(client_id);
CREATE INDEX IF NOT EXISTS idx_crm_tasks_due_date ON crm_tasks(due_date);

CREATE INDEX IF NOT EXISTS idx_crm_activities_client_id ON crm_activities(client_id);
CREATE INDEX IF NOT EXISTS idx_crm_activities_deal_id ON crm_activities(deal_id);
CREATE INDEX IF NOT EXISTS idx_crm_activities_activity_date ON crm_activities(activity_date);

CREATE INDEX IF NOT EXISTS idx_crm_pipeline_stages_pipeline_id ON crm_pipeline_stages(pipeline_id);

-- Functions for updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updated_at
CREATE TRIGGER update_crm_clients_updated_at
  BEFORE UPDATE ON crm_clients
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crm_companies_updated_at
  BEFORE UPDATE ON crm_companies
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crm_deals_updated_at
  BEFORE UPDATE ON crm_deals
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crm_tasks_updated_at
  BEFORE UPDATE ON crm_tasks
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crm_activities_updated_at
  BEFORE UPDATE ON crm_activities
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_crm_pipelines_updated_at
  BEFORE UPDATE ON crm_pipelines
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Insert default pipeline with stages
INSERT INTO crm_pipelines (id, name, description)
VALUES (
  gen_random_uuid(),
  'Default Sales Pipeline',
  'Default sales pipeline for tracking deals'
);

-- Get the pipeline ID for creating stages
DO $$
DECLARE
  pipeline_uuid UUID;
BEGIN
  SELECT id INTO pipeline_uuid FROM crm_pipelines WHERE name = 'Default Sales Pipeline' LIMIT 1;

  INSERT INTO crm_pipeline_stages (pipeline_id, name, order_position, color_hex)
  VALUES
    (pipeline_uuid, 'Lead', 1, 4289511610),
    (pipeline_uuid, 'Qualified', 2, 4294198070),
    (pipeline_uuid, 'Proposal', 3, 4294924608),
    (pipeline_uuid, 'Negotiation', 4, 4294956800),
    (pipeline_uuid, 'Closed Won', 5, 4278190080),
    (pipeline_uuid, 'Closed Lost', 6, 4294901760)
  ON CONFLICT DO NOTHING;
END
$$;

-- Sample data for testing
INSERT INTO crm_clients (first_name, last_name, email, status, source, lead_score, company_name)
VALUES
  ('John', 'Doe', 'john.doe@example.com', 'active', 'website', 85, 'Acme Corp'),
  ('Jane', 'Smith', 'jane.smith@example.com', 'lead', 'referral', 65, 'Tech Solutions Inc'),
  ('Bob', 'Johnson', 'bob.johnson@example.com', 'prospect', 'campaign', 45, 'Innovation Labs')
ON CONFLICT (email) DO NOTHING;

INSERT INTO crm_companies (name, industry, size, website, status)
VALUES
  ('Acme Corp', 'Technology', '51-200', 'https://acme.com', 'active'),
  ('Tech Solutions Inc', 'Consulting', '11-50', 'https://techsol.com', 'prospect'),
  ('Innovation Labs', 'Research', '201-500', 'https://innovlabs.com', 'active')
ON CONFLICT DO NOTHING;

-- RLS Policies (Row Level Security)
ALTER TABLE crm_clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE crm_companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE crm_deals ENABLE ROW LEVEL SECURITY;
ALTER TABLE crm_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE crm_activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE crm_pipelines ENABLE ROW LEVEL SECURITY;
ALTER TABLE crm_pipeline_stages ENABLE ROW LEVEL SECURITY;

-- Basic policies - All authenticated users can read/write
CREATE POLICY "Enable read access for all authenticated users" ON crm_clients
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_clients
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_clients
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_clients
  FOR DELETE USING (auth.role() = 'authenticated');

-- Repeat for other tables
CREATE POLICY "Enable read access for all authenticated users" ON crm_companies
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_companies
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_companies
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_companies
  FOR DELETE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable read access for all authenticated users" ON crm_deals
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_deals
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_deals
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_deals
  FOR DELETE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable read access for all authenticated users" ON crm_tasks
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_tasks
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_tasks
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_tasks
  FOR DELETE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable read access for all authenticated users" ON crm_activities
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_activities
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_activities
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_activities
  FOR DELETE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable read access for all authenticated users" ON crm_pipelines
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_pipelines
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_pipelines
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_pipelines
  FOR DELETE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable read access for all authenticated users" ON crm_pipeline_stages
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_pipeline_stages
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_pipeline_stages
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_pipeline_stages
  FOR DELETE USING (auth.role() = 'authenticated');
