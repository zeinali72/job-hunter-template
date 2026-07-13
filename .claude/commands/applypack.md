---
description: Assemble a submit-ready application pack and checklist for one listing.
argument-hint: <listing folder name>
allowed-tools: Read, Write, Edit, Bash, Glob
---
Run pipeline step 5 (applypack) from CLAUDE.md for: $ARGUMENTS

Precondition: `cv.pdf`, `cover.md`, and `score.md` (ATS >= 75) exist for the listing.

1. Copy the final `cv.pdf` and cover into `output/<company>-<role>/`.
2. Also write `output/<company>-<role>/cv-plaintext.txt` (`pdftotext -layout cv.pdf`) - many
   portals ask you to paste the CV, and this is the exact text their parser will see.
3. Build `output/<company>-<role>/checklist.md` containing:
   - Portal link and which ATS it uses (Workday / SuccessFactors / Greenhouse / Ashby / Lever).
   - Files to upload.
   - Pre-filled answers to this portal's form questions, drawn from
     `profile/experience-answers.md`. Flag any question with no canned answer as TODO.
   - Platform-specific gotchas (e.g. Workday manual field re-entry, screening/knockout
     questions, exact-keyword matching).
   - Warm-intro reminder if a contact maps to this company.
4. Print the checklist and the output path. Do NOT submit - this is my hand-off to apply by hand.
