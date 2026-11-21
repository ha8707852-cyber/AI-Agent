# Deployment status

The Cloudflare Worker source is in `worker-bundle.js`.
The Worker serves its dashboard and API from the same origin.
The D1 database binding is `DB` and points to `ai-workforce-db`.
The Worker uses the existing Cloudflare runtime secrets; never commit secret values here.

This file records the first Git-connected deployment trigger. Verify the resulting Cloudflare build before treating the new source as live.
