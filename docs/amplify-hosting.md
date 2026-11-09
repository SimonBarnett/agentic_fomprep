# Amplify Hosting for https://mcp.ntsa.uk

The only component Amplify can host from this repository is the skill **catalog**
at `v2/apps/mcp-catalog`. It is a Next.js 14 App Router server (lockfile
`next@14.2.35`). It reads `catalog/` from disk and answers stateless JSON-RPC.

This document is the deploy contract. It does not create the Amplify app, change
DNS, or attach a certificate. Those steps use the existing AWS account.

## What is hosted

| Piece | Runtime | On Amplify |
| --- | --- | --- |
| `v2/apps/mcp-catalog` landing page and `POST /mcp` | Node, Next.js route handlers, filesystem reads of `catalog/` | Yes, Hosting compute (`WEB_COMPUTE`) |
| `v2/apps/mcp-catalog/stdio.mjs` | Long-lived stdin/stdout process, Node 18+ | No. Amplify compute is HTTP request/response. Keep stdio on the agent machine. |
| `v2/plugins/priority-formprep`, `priority-shell-compile`, `priority-shell-install`, `priority-odata-dev` | Local Node/PowerShell, on-prem WCF and dictionary SQL, CredMan | No. They need a network path Amplify does not have. |
| `src/web` Playwright Form Prep, `src/Prepare-NamedForm.ps1`, the launcher | Windows desktop / Priority DEV session | No. |

There is no Amplify Gen 2 backend (`amplify/` auth, data, or functions) in this
repo. Do not add one to stand in for Form Prep.

## Console settings

| Setting | Value |
| --- | --- |
| Repository | `SimonBarnett/agentic_fomprep` |
| Branch | `main` (repository default) |
| Monorepo | Yes |
| App root | `v2/apps/mcp-catalog` |
| Platform | `WEB_COMPUTE` (Hosting compute / SSR). Not `WEB` (static). |
| Build image | Amazon Linux 2023 |
| Build spec | Repository root `amplify.yml` (overrides a console spec) |
| Service role | The role Amplify offers for Hosting compute logs. Do not add ERP, SQL, or secret permissions. |

`WEB` static hosting publishes files. It does not run `POST /mcp`. Create the
app as Next.js SSR / Web compute. Amplify does not offer a reliable in-place
switch from `WEB` to `WEB_COMPUTE`; a static app has to be recreated.

Connecting the monorepo in the console sets `AMPLIFY_MONOREPO_APP_ROOT`. If the
app is created outside that flow, set it yourself. The Next.js process does not
read it.

## Build, start, artifacts

`amplify.yml` runs with its working directory at the app root.

| Phase | Command |
| --- | --- |
| preBuild | `nvm use 20` |
| preBuild | `node -v` |
| preBuild | `npm ci --include=dev --no-audit --fund=false` |
| build | `npm run build` |

`npm run build` is `node scripts/sync-skill-dag.mjs` (copy `docs/skill-sources/medatech-network/_dag` into `data/`), `next build`, `check-catalog-trace.mjs` (catalog + `data/dag.json` traced), and `check-dag.mjs` (catalog↔DAG sync + public-safe scan).
The check fails the build if `catalog/` was not traced into the server bundle,
if the build is a static export, or if `output: 'standalone'` reappears.
The spec then deletes `.next/cache`. That cache is not used at runtime.

| Artifact field | Value |
| --- | --- |
| `baseDirectory` | `.next` (relative to `v2/apps/mcp-catalog`) |
| `files` | `**/*` |
| Cache | `node_modules/**/*` only. Do not cache `.next/cache`. |

There is no start command in `amplify.yml`. Hosting compute starts the Next.js
server itself. Do not set a custom start command and do not point it at
`node .next/standalone/server.js`. Amplify no longer deploys Next standalone
output (aws-amplify/amplify-hosting#3682). Standalone output inside `.next`
would also be uploaded and can push the bundle toward the 220 MB cap.

Local equivalents, from `v2/apps/mcp-catalog`:

```bash
nvm use 20
npm ci --include=dev --no-audit --fund=false
npm test
npm run build
npm run smoke
```

`npm start` is `next start` and listens on port 3000. `npm run stdio` is the
local process only.

Node 20, 22, and 24 are the Amplify SSR runtimes. Node 14, 16, and 18 fail the
SSR build (blocked since 15 September 2025). `.nvmrc` in the app root is `20`.
`package.json` `engines.node` is `>=20`.

## Environment variable names

The running app needs no environment variables.

| Name | Required | Purpose |
| --- | --- | --- |
| `AMPLIFY_MONOREPO_APP_ROOT` | Yes, in the Amplify console when the console did not set it | Must be `v2/apps/mcp-catalog`. Build wiring only. |
| `CATALOG_PUBLIC_ORIGIN` | No | Fallback origin when the request Host is not allowlisted. Allowlisted hosts: `mcp.ntsa.uk`, `mcp-priority.ntsa.uk`, `*.amplifyapp.com`, and local `localhost` / `127.0.0.1`. https only, except localhost. No userinfo, path, query, or hash. |

Do not set `PRIORITY_SDK_PASSWORD`, OData passwords, PAT tokens, SQL passwords,
or CredMan material on the Amplify app. The hosted process never executes the
runners. A secret stored there would be unused and one bad change away from a
public log.

Amplify injects its own names (`AWS_BRANCH`, `AWS_APP_ID`, and others). The
catalog code does not read them.

## Custom domain

In the Amplify console, after a `main` deploy has succeeded:

1. Domain management → Add domain → `ntsa.uk`.
2. Subdomain `mcp` → branch `main`. Do not attach the apex `ntsa.uk` in this step.
3. Use the certificate Amplify requests in AWS Certificate Manager. That
   certificate is created in us-east-1 because CloudFront requires it. Amplify
   does this; do not import a private key into the repo.
4. Copy the DNS records the console shows. They are a certificate-validation
   CNAME and a CNAME from `mcp.ntsa.uk` to the branch's `*.amplifyapp.com`
   hostname. The target is printed only after the app exists. Do not guess it.
5. Leave existing `ntsa.uk` records alone except for the records Amplify lists
   for `mcp`.

`mcp-priority.ntsa.uk` is the older name still written in skill leaflets and
local plugin manifests. The server allowlists it. Attach it only as a second
subdomain on this same app if those links must resolve. It is not a second
build.

## HTTP surface

| Method | Path | Behavior |
| --- | --- | --- |
| GET | `/` | HTML skill index. `Cache` follows the dynamic page. |
| GET | `/mcp` | Discovery JSON. `Cache-Control: no-store`. Not an event stream. |
| POST | `/mcp` | One JSON-RPC 2.0 object. `Content-Type: application/json`. |
| OPTIONS | `/mcp` | `204` and CORS. |

`POST /mcp` methods that are implemented:

| Method | Result |
| --- | --- |
| `initialize` | Protocol `2024-11-05`, `serverInfo.name` `mcp-priority`, tools capability only |
| `notifications/initialized`, `initialized` | `204` empty body |
| `ping` | empty result |
| `tools/list` | `list_catalog`, `get_skill`, `get_instance_schema`, `get_runner_files`, `resolve_skills`, `get_dag_index`, `get_dag_node`, `get_skill_dag` (FR #354) |
| `tools/call` | those eight tools |
| `resources/list`, `resources/read` | `skill://<id>` markdown |

A JSON array (batched JSON-RPC) is rejected. There is no SSE `GET`, no
`mcp-session-id` session, and no protocol negotiation up to `2025-03-26` on the
hosted server. The stdio entry point negotiates newer protocol versions; Amplify
does not run it.

Client URL: `https://mcp.ntsa.uk/mcp`.

```bash
curl -sS https://mcp.ntsa.uk/mcp
curl -sS -X POST https://mcp.ntsa.uk/mcp \
  -H 'content-type: application/json' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"list_catalog","arguments":{}}}'
```

`list_catalog` reports `host` from the request when the Host header is
allowlisted. A disallowed Host does not get echoed.

## Authentication and exposure

The catalog is public on purpose. The GitHub repository is already public.
Amplify does not add a login.

- `Access-Control-Allow-Origin` is `*`.
- Anyone who can POST can read every `SKILL.md` and every file under `runner/`.
- `get_runner_files` rejects a path containing `..`.
- `instances.example.json` uses `priority.example.com`. Passwords are not in
  those files. Runners read `PRIORITY_SDK_PASSWORD` only when executed locally.
- Skill text includes example customer hostnames and an example SQL address.
  That text is already in the public repo. Hosting the catalog does not make
  it private.
- Do not put a live `instances.json`, a cookie jar, or `si-web-state.json` in
  `catalog/`. The trace ships every file under that directory.

No application auth header is required or checked. Adding one would stop the
grab-only clients this host is for.

## Limits that are real on Amplify

| Limit | Effect here |
| --- | --- |
| SSR response body about 5.72 MB | A larger `get_skill` or `get_runner_files` body returns an empty 504. The catalog's largest file is under 15 KB. |
| Compute bundle about 220 MB uncompressed | `catalog/` is about 1.4 MB. The trace check is what keeps it inside the bundle. |
| Compute writable path is `/tmp` only | The catalog is read-only. That matches the app. |
| Execution up to 15 minutes, 512 MB ephemeral disk | Catalog reads finish in one request. |
| No Edge runtime | `export const runtime = 'nodejs'` is set on `/` and `/mcp`. |
| No on-demand ISR | Not used. |
| Request rate | Amplify returns 429 when the app exceeds its request-token quota. `POST /mcp` is uncached, so every tool call counts. |

## Verification after the coordinator deploys

Run these against the default `*.amplifyapp.com` URL before changing DNS, then
again at `https://mcp.ntsa.uk` after the certificate is issued.

1. `GET /mcp` returns HTTP 200, `cache-control: no-store`, and the eight tool names (includes `resolve_skills`).
2. `POST /mcp` `initialize` returns `protocolVersion` `2024-11-05` and `serverInfo.name` `mcp-priority`.
3. `tools/call` `list_catalog` returns `host` `https://mcp.ntsa.uk` (or the amplifyapp.com host before DNS) and a non-empty `skills` array that includes `priority-formprep`.
4. The same response does not offer `prepare_form`, `compile_shell`, `install_shell`, or `odata_get`.
5. `get_skill` with `name` `priority-formprep` returns markdown.
6. `tools/call` `resolve_skills` with `task` `form prep UAT` returns a non-empty `skills` array (FR #354).

### Customer overlay (FR #362 / #354 acceptance 8)

Public `resolve_skills` on mcp.ntsa.uk stays generic-only. Customer lessons and skills stay in the
customer repo (`.grok/skills/` at repo root; SO/SC markdown under `SCxxxxxx` / `SOxxxxxx`) and are
merged **on the seat** via `tools/priority-skill-dag/resolve-with-overlay.mjs` (or
`Resolve-WithOverlay.ps1`). Only `{ task, maxLessons?, maxSkills?, maxBytes? }` is POSTed to MCP —
never overlay paths or bodies. Unit gate: `v2/apps/mcp-catalog/lib/customer-overlay.test.mjs`.

7. `get_dag_node` with a known skill id succeeds; unknown id returns an error result.
8. `get_runner_files` with `path` `../meta.json` returns an error result.
9. `GET /` shows the same origin in the `grok mcp add` example.
10. A local `priority-catalog` stdio registration still answers without using the website.

Verified with Node 20.19.5 (the Amplify `nvm use 20` runtime) in
`v2/apps/mcp-catalog`: `npm test` (public-origin + skill-dag), `npm run build` (dynamic `/`
and `/mcp`, 202 traced catalog files, 69 `SKILL.md` files, no standalone
output), and `npm run smoke`. Smoke boots `next start` on port 3456 and checks
the list above, including a forged `Host: evil.example` and `Host: mcp.ntsa.uk`.
That build's `.next` directory was 30 MB, of which 29 MB was `.next/cache`
(removed before upload). `.next/server` was 492 KB and `.next/static` was
732 KB. The traced `catalog/` files are about 480 KB and stay in the build
workspace so Amplify's compute bundler can copy them. Do not delete `catalog/`
in the build spec.
