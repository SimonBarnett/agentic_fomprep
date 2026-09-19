# Bob stamp — shell compile/install WP0 skeleton (2026-09-19)

**Repo:** SimonBarnett/agentic_fomprep  
**Tip:** `3bc079b`  
**Upstream MRB:** docs/mrb-2026-09-19-v1.md (+ PDF) — PASS-with-nits (build agent, job c84219c8)  
**Reviewer:** Bob  

## Stamp

**PASS-with-nits** for the locked WP0 skeleton slice only.

**Not** ready for human UAT of live compile/install (or any WCF success path).

## Why

- Matches FR lock: until `PinComplete`, skeleton only — parser, allowlist, WhatIf, schemas, refuse paths, SKILL.md, WP0 fail-fast.
- Two tools `compile_shell` / `install_shell`; v1 `src\Prepare-NamedForm.ps1` untouched; no guessed ENAMEs; red before WCF.
- Evidence on ionos: `Test-WP0` PASS; `Test-Pack` PASS (WP0 first); `pinComplete=false`.

## Explicit non-claims

- Live Version Revision compile
- Live `.sh` install
- Pinned Prepare Upgrade / Install Upgrade ENAMEs
- WP0-R* on a proof instance
- Amplify/catalog host redeploy verification

## Ordered next (human / next build slice)

1. Proof-instance recon (`PRIORITY_WP0_INSTANCE`); fill pins from dictionary titles only.
2. WCF walker from pins; SQL gate; `postInstall.formsUnprepared[]` handoff (no auto-prep).
3. WP0-R* green; FR §15 ATs; then Bob may reconsider **ready for human UAT**.

## Sign-off

Bob — 2026-09-19 Europe/London — skeleton **PASS-with-nits**; live compile/install **not** ready for human UAT.
