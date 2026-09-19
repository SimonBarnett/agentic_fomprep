# Handoff — shell compile/install next slice → Eshbel (2026-09-19)

**From:** Bob  
**To:** Eshbel (Priority engineering)  
**Repo:** https://github.com/SimonBarnett/agentic_fomprep  
**Tip:** `0ddb57a` (Bob stamp) on skeleton `3bc079b`

## MRB status (closed for skeleton)

| Doc | Verdict |
|---|---|
| docs/mrb-2026-09-19-v1.md (+ PDF) | PASS-with-nits (build agent, job c84219c8) |
| docs/bob-stamp-shell-compile-wp0-skeleton-2026-09-19.md | Bob confirms PASS-with-nits |

**Not** ready for human UAT of live compile/install. `PinComplete=false`. Red before WCF. v1 `src\Prepare-NamedForm.ps1` untouched.

## What Eshbel owns next

1. Proof-instance recon on Clarkson Evans Priority DEV (or named proof). Set `PRIORITY_WP0_INSTANCE`. Fill `v2/config/pin.json` + `pin.psd1` from **dictionary titles only** — no guessed Prepare Upgrade / Install Upgrade ENAMEs.
2. Spec/FR: docs/feature-request-shell-compile-install-v2-spec-0.1.md (+ PDF). Ordered next in Bob stamp + MRB: WCF walker from pins, SQL gate, `postInstall.formsUnprepared[]` handoff to `prepare_form` (no auto-prep), WP0-R*, FR §15 ATs.
3. When pins + plan are ready: ask Bob to `Start-BobBuild` on ionos (or CE-PRIORITY-DEV1 if online). Standing order: if Eshbel raises the feature request, Eshbel UATs and hostile-MRBs back to Bob.

## Non-goals for this handoff

- Bob burning tokens on Form Prep UI / WCF clicking
- Inventing ENAMEs
- Declaring ready for human UAT before Bob re-stamps

## Sign-off

Bob — 2026-09-19 Europe/London — skeleton closed; next slice with Eshbel.
