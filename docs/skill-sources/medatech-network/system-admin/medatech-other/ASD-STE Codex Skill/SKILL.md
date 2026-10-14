---
name: write-asd-ste100
description: Draft, rewrite, and review technical documentation against ASD-STE100 Simplified Technical English Issue 9 in Strict or Soft mode. Strict is the default and uses the complete official PDF for exact rules and dictionary decisions. Soft is explicitly Markdown-only. Use for procedures, descriptions, safety instructions, maintenance content, technical manuals, controlled-language edits, STE compliance reports, sentence and paragraph checks, terminology checks, or requests to convert standard technical English into ASD-STE100.
---

# Write ASD-STE100

Apply ASD-STE100 Issue 9 without changing technical meaning. Treat the official specification and the user's approved terminology as authoritative in Strict mode.

## Select the mode

Use **Strict mode** unless the user explicitly requests **Soft mode**. Never switch modes silently.

### Strict mode - default

Use the complete official Issue 9 PDF as the primary authority.

1. Resolve and verify the PDF as described in `references/source-and-dictionary.md`.
2. Read `references/rules-issue-9.md` as a navigation guide, then read the complete applicable rules, explanatory text, help, and examples in the PDF.
3. Verify each non-technical word against the PDF dictionary for its headword status, part of speech, meaning, forms, alternatives, and restrictions.
4. Validate technical nouns and technical verbs against the PDF categories and the user's approved terminology source.
5. Run the automated checker as a preliminary pass, not as a substitute for the PDF review.
6. If the PDF is unavailable or cannot be read, stop the Strict review. Ask the user to supply the PDF or explicitly authorize Soft mode. Do not fall back to Soft mode automatically.

### Soft mode - Markdown-only

Use only the bundled Markdown guidance.

1. Read `references/rules-issue-9.md`.
2. Do not open, read, search, quote, or infer from the PDF, even if it is available.
3. Do not run `scripts/ste_reference.py` or use a remembered dictionary entry as evidence.
4. Apply the Markdown rules. You can run `scripts/ste_lint.py --profile soft` only as a mechanical application of those rules.
5. Mark dictionary approval, exact meaning, part of speech, approved forms, and technical-term status as unverified.
6. Describe the result as Soft-mode guidance. Never present it as full ASD-STE100 compliance.

## Start every task

1. Select Strict or Soft mode. Default to Strict.
2. Load only the sources permitted by that mode.
3. Classify each passage as procedural, descriptive, safety-related, or mixed.
4. Preserve values, limits, units, identifiers, sequence, conditions, cross-references, and risk information.
5. Identify the governing company glossary, terminology database, publication specification, and spelling directive when the user provides them.
6. Ask for clarification only when an ambiguity could change technical meaning, sequence, or safety.

## Select the workflow

### Draft or rewrite

1. Extract the required facts and actions before changing the wording.
2. Make a terminology list for components, systems, actions, and repeated phrases.
3. In Strict mode, use approved dictionary words only with their approved part of speech, meaning, and form.
4. In Strict mode, treat a word outside the dictionary as a technical noun or technical verb only when it meets the applicable PDF category and is accepted in the subject field.
5. In Soft mode, use short and consistent wording but do not claim that its vocabulary is dictionary-approved.
6. Apply the procedural, descriptive, and safety rules in `references/rules-issue-9.md`.
7. Prefer a new sentence construction when a word-for-word substitution is unclear or changes meaning.
8. Run the checker, correct valid findings, and run it again.
9. Manually check rules that software cannot decide reliably.

### Review or audit

1. Do not silently rewrite the source when the user asks only for a review.
2. Run the checker in the correct mode.
3. In Strict mode, check every non-technical word and every proposed replacement against the official Issue 9 dictionary.
4. In Soft mode, identify all vocabulary and technical-term decisions as unverified.
5. Report each finding with its rule number, location, explanation, and proposed correction.
6. Separate definite violations from contextual or automated-review findings.
7. Confirm that each proposed correction preserves the source meaning.

### Safety instructions

1. Preserve or increase clarity about the hazard, prohibited action, precaution, and possible result.
2. Never infer a risk level from wording alone when the source risk assessment is unavailable.
3. Use the organization's approved safety taxonomy. Under the Issue 9 definitions, use a warning for injury or death and a caution for damage to objects.
4. Put the command or condition first, then state the risk or possible result.
5. Apply the 20-word procedural limit to every safety sentence.

## Use the official source in Strict mode

Always read `references/source-and-dictionary.md` in Strict mode. Never read it to obtain PDF-derived guidance in Soft mode.

Use the bundled reference utility:

```text
python scripts/ste_reference.py verify --pdf /path/to/ASD-STE100_ISSUE9.pdf
python scripts/ste_reference.py lookup WORD --pdf /path/to/ASD-STE100_ISSUE9.pdf
python scripts/ste_reference.py rule 5.1 --pdf /path/to/ASD-STE100_ISSUE9.pdf
python scripts/ste_reference.py find "search phrase" --pdf /path/to/ASD-STE100_ISSUE9.pdf
```

Do not decide that a word is approved only because it appears somewhere in the PDF. Interpret the dictionary entry as follows:

- Uppercase entry: approved only for the listed part of speech, forms, meaning, and restrictions.
- Lowercase entry: not approved in that use; evaluate the listed alternatives and examples.
- Missing entry: use it only if it qualifies as an approved technical noun or technical verb, or rewrite the sentence.
- Alternative with a different part of speech: change the sentence construction.

Use only a lawfully obtained copy of the official specification. Follow the source and distribution guidance in `references/source-and-dictionary.md`.

## Run the checker

Use the standard-library checker on plain-text or Markdown input:

```text
python scripts/ste_lint.py INPUT.txt --profile strict --mode procedure
python scripts/ste_lint.py INPUT.md --profile soft --mode description --format json
python scripts/ste_lint.py INPUT.txt --profile strict --mode auto
```

Use `--mode procedure` for work steps and safety text, `--mode description` for explanatory text, and `--mode auto` only for mixed or unknown content. Use `-` as the input path to read standard input.

Use `--profile strict` in Strict mode. It includes selected PDF-derived review hints, but it does not replace the complete PDF review.

Use `--profile soft` in Soft mode. It disables the selected spelling, dictionary-word, and phrasal-verb lists because those details are not fully contained in the Markdown rule guide. It does not read the PDF.

Treat checker results as an advisory first pass. It checks sentence length, paragraph length, semicolons, contractions, and several contextual patterns. It cannot certify dictionary meaning, part of speech, technical-term status, one-topic paragraphs, risk classification, or preservation of technical meaning.

## Complete the manual review

Check these items after automated review:

- Strict only: every non-technical word is approved for its exact meaning, part of speech, and form, and every technical term is valid.
- Soft only: vocabulary and technical-term status remain unverified.
- Multi-word nouns are clear, consistently named, and normally no longer than three words.
- Verb tense and form are permitted; active voice is used unless the descriptive-writing exception applies.
- Each procedural sentence has one instruction, except simultaneous actions.
- Each descriptive sentence has one subject, and each paragraph has one topic.
- Articles or demonstrative adjectives are present where applicable.
- Phrasal verbs do not create meanings different from their component words.
- Conditions, notes, lists, parentheses, quoted text, identifiers, proper nouns, and units are counted correctly.
- Safety instructions have the correct risk level, command or condition, and consequence.
- Terminology and repeated wording remain consistent throughout the document.

## Deliver the result

For a rewrite, provide the clean revised text first. Add a brief change summary only when useful.

For an audit, use columns such as:

| Location | Rule | Status | Finding | Proposed correction |
|---|---|---|---|---|
| Step 3 | 5.1 | Violation | Sentence exceeds 20 words. | Divide it into two instructions. |

State the selected mode in the result. In Strict mode, identify the verified Issue 9 PDF. In Soft mode, state that the PDF was intentionally not used and that vocabulary compliance is unverified.

Use `Violation` only for a result supported by the sources permitted in the selected mode and by the context. Use `Review` for heuristic findings or missing context. Do not call an automated or AI-assisted result certified compliance unless a qualified authority completes the required review.
