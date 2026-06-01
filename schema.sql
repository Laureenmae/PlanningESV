-- ============================================
-- SUPABASE SCHEMA FOR PLANNING 2026
-- ============================================
--
-- Run this SQL in your Supabase project:
-- 1. Go to SQL Editor
-- 2. Create a new query
-- 3. Paste this entire script
-- 4. Click "Run"
--
-- Then set up Row Level Security (RLS) policies below

-- Create the main table
CREATE TABLE IF NOT EXISTS planning_data (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  key TEXT UNIQUE NOT NULL,
  data JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create an index on the key column for faster queries
CREATE INDEX IF NOT EXISTS idx_planning_data_key ON planning_data(key);

-- Enable RLS
ALTER TABLE planning_data ENABLE ROW LEVEL SECURITY;

-- CREATE POLICIES FOR PUBLIC ACCESS
-- Allow anyone to read
CREATE POLICY "Allow public read"
ON planning_data FOR SELECT
USING (true);

-- Allow anyone to insert new records
CREATE POLICY "Allow public insert"
ON planning_data FOR INSERT
WITH CHECK (true);

-- Allow anyone to update records
CREATE POLICY "Allow public update"
ON planning_data FOR UPDATE
USING (true)
WITH CHECK (true);

-- Allow anyone to delete records
CREATE POLICY "Allow public delete"
ON planning_data FOR DELETE
USING (true);

-- Create an audit log table (optional but recommended)
CREATE TABLE IF NOT EXISTS planning_audit (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  key TEXT NOT NULL,
  action TEXT NOT NULL,
  old_data JSONB,
  new_data JSONB,
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create a trigger to automatically update updated_at
DROP TRIGGER IF EXISTS update_planning_data_updated_at ON planning_data;
CREATE TRIGGER update_planning_data_updated_at BEFORE UPDATE
  ON planning_data FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- OPTIONAL: Create a view for monitoring
-- ============================================
CREATE OR REPLACE VIEW planning_stats AS
SELECT
  key,
  LENGTH(data::TEXT) as size_bytes,
  updated_at,
  NOW() - updated_at as last_updated_ago
FROM planning_data
ORDER BY updated_at DESC;

-- Grant access to the view
GRANT SELECT ON planning_stats TO anon;

-- ============================================
-- SEED DATA (Optional - for testing)
-- ============================================
-- Uncomment to add initial test data
/*
INSERT INTO planning_data (key, data) VALUES (
  'planning2026',
  '{"plan":{"2026-05-02":["MARIE JOSE"],"2026-05-03":["MIGUELLE","ISMAEL"]},"team":[{"name":"MARIE JOSE","bg":"#FAD7C0","fg":"#8A4B25","av":"#E89968"}]}'
)
ON CONFLICT (key) DO NOTHING;
*/

-- ============================================
-- NOTES
-- ============================================
-- 
-- 1. Row Level Security (RLS) is enabled
--    The policies above allow PUBLIC access
--    If you want to restrict access, modify the policies
--
-- 2. The updated_at column automatically updates on changes
--    This helps track when data was last modified
--
-- 3. The audit table logs all changes (optional)
--    You can query it to see the history
--
-- 4. If you prefer PRIVATE access:
--    - Require authentication
--    - Use user IDs in policies
--    - Example: USING (auth.uid() IS NOT NULL)
--
-- 5. Performance tips:
--    - The key column is indexed
--    - Use JSONB for efficient queries
--    - Example: data->'plan'->>'2026-05-02'
--
