ALTER TABLE tasks ADD COLUMN automation_id TEXT;
CREATE INDEX IF NOT EXISTS idx_tasks_automation_created ON tasks(automation_id, created_at DESC);
CREATE TABLE IF NOT EXISTS team_runs (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  conversation_id TEXT NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  orchestration_id TEXT NOT NULL REFERENCES orchestration_plans(id) ON DELETE CASCADE,
  user_message_id TEXT,
  status TEXT NOT NULL DEFAULT 'queued',
  final_message_id TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_team_runs_conversation ON team_runs(conversation_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_team_runs_orchestration ON team_runs(orchestration_id);
