-- CRM Notifications Table Schema
-- This file contains the SQL to create the notifications table for CRM system

-- Notifications Table
CREATE TABLE IF NOT EXISTS crm_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  type VARCHAR(50) NOT NULL,
  priority VARCHAR(20) NOT NULL DEFAULT 'normal',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_read BOOLEAN NOT NULL DEFAULT false,
  read_at TIMESTAMP WITH TIME ZONE,
  metadata JSONB,
  client_id UUID REFERENCES crm_clients(id) ON DELETE SET NULL,
  deal_id UUID REFERENCES crm_deals(id) ON DELETE SET NULL,
  task_id UUID REFERENCES crm_tasks(id) ON DELETE SET NULL,
  user_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for better performance
CREATE INDEX IF NOT EXISTS idx_crm_notifications_user_id ON crm_notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_crm_notifications_is_read ON crm_notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_crm_notifications_created_at ON crm_notifications(created_at);
CREATE INDEX IF NOT EXISTS idx_crm_notifications_type ON crm_notifications(type);
CREATE INDEX IF NOT EXISTS idx_crm_notifications_priority ON crm_notifications(priority);

-- Trigger for updated_at
CREATE TRIGGER update_crm_notifications_updated_at
  BEFORE UPDATE ON crm_notifications
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- RLS (Row Level Security)
ALTER TABLE crm_notifications ENABLE ROW LEVEL SECURITY;

-- Basic policies - All authenticated users can read/write
CREATE POLICY "Enable read access for all authenticated users" ON crm_notifications
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable insert for all authenticated users" ON crm_notifications
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for all authenticated users" ON crm_notifications
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for all authenticated users" ON crm_notifications
  FOR DELETE USING (auth.role() = 'authenticated');

-- Sample notifications for testing
INSERT INTO crm_notifications (title, message, type, priority, metadata)
VALUES
  (
    'Welcome to CRM!',
    'Your CRM system is now ready. Start by adding your first client.',
    'system',
    'normal',
    '{"welcome": true}'
  ),
  (
    'Getting Started',
    'Check out our guide to learn how to use the CRM system effectively.',
    'system',
    'low',
    '{"guide_url": "/docs/getting-started"}'
  )
ON CONFLICT DO NOTHING;
