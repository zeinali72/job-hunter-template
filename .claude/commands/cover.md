---
description: Draft a tailored cover letter for one listing.
argument-hint: <listing folder name>
allowed-tools: Read, Write, Edit, Bash
---
Run pipeline step 4 (cover) from CLAUDE.md for: $ARGUMENTS

1. Read `jobs/$ARGUMENTS/job.md`, `jobs/$ARGUMENTS/score.md`, `profile/positioning.md`,
   `profile/proof-points.md`, and `profile/profile.yml`.
2. Draft a cover letter (max one page) that mirrors the JD's language and addresses the top
   must-have skills. Warm, human, first-person voice - never template/machine tone (no "I am
   writing to apply for", no "I would welcome the chance to discuss"). Follow the lead-with
   ordering and style rules from `profile/positioning.md`. Plain ASCII, no em-dashes. Honest
   and direct, not flattering. Use only facts from `profile/`; never cite employer programmes
   or sector jargon the candidate has not actually worked with as their motivation.
3. If a warm-intro contact maps to this company (`profile/profile.yml` contacts), note it at
   the top so the candidate leads with the intro rather than a cold application.
4. Write `jobs/$ARGUMENTS/cover.md` (plain text, handy for pasting into web forms), then
   build a PDF too: `cover.tex` matching the CV typography -> `cover.pdf` via latexmk.
   Draft only - the candidate reviews and sends.
