---
description: Draft a tailored cover letter for one listing.
argument-hint: <listing folder name>
allowed-tools: Read, Write, Edit
---
Run pipeline step 4 (cover) from CLAUDE.md for: $ARGUMENTS

1. Read `jobs/$ARGUMENTS/job.md`, `jobs/$ARGUMENTS/score.md`, `profile/proof-points.md`, and
   `profile/profile.yml`.
2. Draft a cover letter (max one page) that mirrors the JD's language and addresses the top
   must-have skills. Warm, human, first-person voice - never template/machine tone (no "I am
   writing to apply for", no "I would welcome the chance to discuss"). Lead with the PhD as
   the headline work; earlier items (e.g. the MSc ICM model) support it as the foundation it
   grew out of. British English, plain ASCII, no em-dashes. Honest and direct, not
   flattering. Use only facts from `profile/`; never cite employer programmes or sector
   terms I have not worked on (e.g. AMP8) as my motivation.
3. If a warm-intro contact maps to this company (`profile/profile.yml` contacts), note it at
   the top so I lead with the intro rather than a cold application.
4. Write `jobs/$ARGUMENTS/cover.md` (plain text, handy for pasting into web forms), then
   build a PDF too: `cover.tex` matching the CV typography -> `cover.pdf` via latexmk.
   Draft only - I review and send.
