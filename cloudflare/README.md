# AI Workforce — Cloudflare edition

This directory contains the Worker-first deployment package for the private AI Workforce Control Centre.

## Components
- Cloudflare Worker: `worker-bundle.js` serves the dashboard and API from one deployment.
- Cloudflare D1: persistent conversations, messages, company knowledge, agent memories, tasks, approvals, automations, plans and usage metrics.
- Five agents: AI Manager, Customer Service & Operations, Marketing & Growth, Technology & Development, Data & Intelligence.
- Thirteen company workspaces, with JIBET marked as the primary company.
- Groq adapter defaults to `openai/gpt-oss-120b`.
- Each agent has its own provider/model/base URL/secret-binding configuration. Multiple keys from one provider do not multiply that provider's account quota; use different providers to distribute usage.
- Five-minute scheduler; queued work is bounded to protect free-tier quotas.
- Sensitive external actions remain approval-gated.

## Cloudflare bindings
The Worker expects a D1 binding named `DB` pointing to `ai-workforce-db`, and these Worker Secrets:
- `GROQ_API_KEY`
- `ADMIN_PASSWORD`
- `SESSION_SECRET`

Optional independent provider keys may be added later as Worker Secrets:
- `API_MANAGER_KEY`
- `API_CUSTOMER_SERVICE_KEY`
- `API_MARKETING_KEY`
- `API_TECHNOLOGY_KEY`
- `API_INTELLIGENCE_KEY`

The API Settings page lets each agent select a provider, model, HTTPS-compatible base URL and secret binding. Do not put provider keys in source files or browser code.

## Deployment
Cloudflare Workers & Pages → Create application → Workers → Connect to Git. Select this repository and set the root/build directory to `cloudflare`. Build command: `npm install`; deploy command: `npx wrangler deploy`. Confirm the existing Worker name is `ai-workforce-control` and keep `workers.dev` enabled. Do not add a paid plan.

The D1 database and both migrations were already initialized in the target Cloudflare account. If the deployment UI proposes rerunning migrations, inspect the migration state first rather than reapplying an already executed initial schema.

## Test
After deployment:
- `GET /health` should return `ok: true`.
- Sign in at the Worker URL using `ADMIN_PASSWORD`.
- Open Settings → API Settings to configure each agent.
- Send one test message to each agent and inspect the per-agent usage list.

Free-tier limits apply. Groq quotas are shared at the provider organization/account level; separate keys within the same account do not create extra quota. No paid fallback is configured.
