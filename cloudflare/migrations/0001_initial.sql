PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS conversations (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, agent_id TEXT NOT NULL, company_id TEXT,
 title TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'active', message_count INTEGER NOT NULL DEFAULT 0,
 created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_conversations_user_updated ON conversations(user_id, updated_at DESC);
CREATE TABLE IF NOT EXISTS messages (
 id TEXT PRIMARY KEY, conversation_id TEXT NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
 role TEXT NOT NULL, content TEXT NOT NULL, model TEXT, usage_json TEXT, created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_messages_conversation_created ON messages(conversation_id, created_at);
CREATE TABLE IF NOT EXISTS knowledge (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, company_id TEXT, category TEXT NOT NULL DEFAULT 'General',
 title TEXT NOT NULL, content TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'active', created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_knowledge_scope ON knowledge(user_id, company_id, status);
CREATE TABLE IF NOT EXISTS memories (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, agent_id TEXT NOT NULL, company_id TEXT,
 title TEXT NOT NULL, content TEXT NOT NULL, source TEXT, importance INTEGER NOT NULL DEFAULT 3,
 created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_memories_scope ON memories(user_id, agent_id, company_id);
CREATE TABLE IF NOT EXISTS tasks (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, company_id TEXT, agent_id TEXT NOT NULL,
 title TEXT NOT NULL, description TEXT NOT NULL DEFAULT '', priority TEXT NOT NULL DEFAULT 'normal',
 status TEXT NOT NULL DEFAULT 'queued', attempts INTEGER NOT NULL DEFAULT 0, max_attempts INTEGER NOT NULL DEFAULT 3,
 result TEXT, error TEXT, orchestration_id TEXT, dependency_ids TEXT NOT NULL DEFAULT '[]',
 created_at TEXT NOT NULL, updated_at TEXT NOT NULL, finished_at TEXT
);
CREATE INDEX IF NOT EXISTS idx_tasks_status_created ON tasks(status, created_at);
CREATE INDEX IF NOT EXISTS idx_tasks_user_created ON tasks(user_id, created_at DESC);
CREATE TABLE IF NOT EXISTS approvals (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, company_id TEXT, title TEXT NOT NULL, change_text TEXT NOT NULL,
 reason TEXT, status TEXT NOT NULL DEFAULT 'pending', decision_note TEXT, created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_approvals_user_status ON approvals(user_id, status, created_at DESC);
CREATE TABLE IF NOT EXISTS automations (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, company_id TEXT, name TEXT NOT NULL, instruction TEXT NOT NULL,
 agent_id TEXT NOT NULL, frequency TEXT NOT NULL, interval_minutes INTEGER, time_of_day TEXT, day_of_week INTEGER,
 enabled INTEGER NOT NULL DEFAULT 1, next_run_at TEXT, last_run_at TEXT, last_status TEXT,
 created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_automations_due ON automations(enabled, next_run_at);
CREATE TABLE IF NOT EXISTS orchestration_plans (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, company_id TEXT, goal TEXT NOT NULL, summary TEXT NOT NULL,
 status TEXT NOT NULL, final_result TEXT, created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS audit_logs (
 id TEXT PRIMARY KEY, user_id TEXT NOT NULL, event TEXT NOT NULL, detail TEXT, created_at TEXT NOT NULL
);
