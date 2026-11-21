CREATE TABLE IF NOT EXISTS agent_api_configs (
  agent_id TEXT PRIMARY KEY,
  provider TEXT NOT NULL DEFAULT 'groq',
  base_url TEXT NOT NULL DEFAULT 'https://api.groq.com/openai/v1',
  model TEXT NOT NULL DEFAULT 'openai/gpt-oss-120b',
  secret_binding TEXT NOT NULL DEFAULT 'GROQ_API_KEY',
  enabled INTEGER NOT NULL DEFAULT 1,
  updated_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS api_usage (
  id TEXT PRIMARY KEY,
  agent_id TEXT NOT NULL,
  provider TEXT NOT NULL,
  model TEXT NOT NULL,
  prompt_tokens INTEGER NOT NULL DEFAULT 0,
  completion_tokens INTEGER NOT NULL DEFAULT 0,
  total_tokens INTEGER NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'success',
  latency_ms INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_api_usage_agent_date ON api_usage(agent_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_api_usage_date ON api_usage(created_at DESC);
