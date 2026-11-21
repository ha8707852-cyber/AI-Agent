ALTER TABLE memories ADD COLUMN category TEXT NOT NULL DEFAULT 'Agent Memory';
CREATE INDEX IF NOT EXISTS idx_memories_category ON memories(user_id, category, updated_at DESC);
