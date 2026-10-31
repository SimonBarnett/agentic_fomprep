# Merge on green (FR #247)

## Why `--auto` failed on PR #243

`GET /repos/SimonBarnett/agentic_fomprep` had `allow_auto_merge: true`, but
`main` had **no** branch protection (`GET .../branches/main/protection` = 404).
GitHub then refuses `enablePullRequestAutoMerge` with:

`Protected branch rules not configured for this branch`

## Required settings

| Setting | Value |
|---------|--------|
| Repo `allow_auto_merge` | true |
| `main` classic protection | present |
| Required approving reviews | 0 (PRs still required) |
| Required status checks | none (do not pin `validate`) |
| Force push / delete | disabled |
| Enforce admins | false |

Do not require the `validate` check from `.github/workflows/launcher-release.yml`.
That job only runs when launcher paths change.

## Apply / assert

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Assert-FomprepMainAutoMerge.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Assert-FomprepMainAutoMerge.ps1 -Apply
```

`-Apply` PUTs the protection JSON (needs admin). Assert-only is the default.

## MRB wire

`gh pr merge <n> --auto --merge` after PASS. On the GraphQL protection error,
comment `merge-on-green pending` and leave merge to the owner. Do not poll CI.
