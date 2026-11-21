CREATE TABLE IF NOT EXISTS team_run_events (
  id TEXT PRIMARY KEY,
  team_run_id TEXT NOT NULL REFERENCES team_runs(id) ON DELETE CASCADE,
  agent_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_team_run_events_run ON team_run_events(team_run_id, created_at);
