# Strict-mode source and dictionary setup

Strict mode requires the complete official ASD-STE100 Issue 9 PDF. Soft mode must not read or search the PDF and does not use this reference for substantive rule decisions.

The current portable skill can contain the user-supplied PDF at `references/ASD-STE100_ISSUE9.pdf`. The PDF is copyrighted. Keep or distribute it only when the copyright holder's terms give you permission. If the file is not present on a device, supply a lawfully obtained copy before using Strict mode.

## Expected source

- Title: ASD-STE100 Simplified Technical English
- Issue: 9
- Issue date: 2025-01-15
- Published: January 2025
- Pages: 434
- SHA-256 of the source used to create this skill: `D1F4EA9E7CD6E46B47AA9057209F99E78C0E9CFC4E27A5B07895B05C1A166431`

A later official correction can have a different checksum. Verify its issue and date instead of rejecting it only because the checksum differs.

## Configure a device

Use one of these methods, in priority order:

1. Pass the path on each command with `--pdf`.
2. Set the `ASD_STE100_PDF` environment variable to the official PDF path.
3. Use `references/ASD-STE100_ISSUE9.pdf` inside this skill folder.
4. Place a file named `ASD-STE100_ISSUE9.pdf` in the current working directory.

Verify the selected source before a Strict review:

```text
python scripts/ste_reference.py verify --pdf /path/to/ASD-STE100_ISSUE9.pdf
```

## Verify an exact dictionary entry

Run:

```text
python scripts/ste_reference.py lookup WORD --pdf /path/to/ASD-STE100_ISSUE9.pdf
```

Then inspect all entries for the word:

1. Match the intended part of speech.
2. Treat an uppercase headword as approved and a lowercase headword as not approved.
3. For an approved word, match the exact approved meaning, verb or adjective form, and any help restriction.
4. For an unapproved word, select an alternative that preserves the intended meaning.
5. Change the sentence structure when the alternative has a different part of speech or direct substitution gives poor English.
6. If no entry exists, decide whether the word is a valid technical noun or technical verb under rules 1.5, 1.6, and 1.12.

The PDF dictionary starts on PDF page 129, its introduction starts on page 131, and the word list starts on page 149. The source states that Issue 9 contains 875 approved words and 1,274 selected unapproved words.

## Verify an exact rule

Run:

```text
python scripts/ste_reference.py rule 8.6 --pdf /path/to/ASD-STE100_ISSUE9.pdf
```

The utility returns candidate source excerpts. Read the complete applicable rule and its help text before making a close compliance decision.

## Dependency fallback

The scripts require Python 3. Use `python3` or `py -3` instead of `python` when that is the command available on the device. The linter uses only the Python standard library.

The reference utility also requires `pypdf`. Codex document environments commonly include it. If Python or `pypdf` is unavailable, do the rule checks manually and use an installed PDF text-extraction tool or an applicable PDF skill to inspect the official source. Do not replace exact dictionary validation with a general English dictionary or an unofficial online word list.
