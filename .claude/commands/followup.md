---
description: List stale applications and warm intros to chase; draft follow-up messages.
argument-hint: (no arguments)
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
---
Run pipeline step 7 (followup) from CLAUDE.md.

1. Read `jobs/tracker.csv`. Flag rows where status is "applied" and date_applied is 7+ days
   ago with no later status. Compute "today" with `date +%F`.
2. List warm-intro contacts from `profile/profile.yml` whose companies are in the pipeline but
   have not been chased yet. Warm intros come first.
3. For each, draft a short, polite follow-up with the `recruiter-coach` skill - British
   English, plain ASCII, specific to the role.
4. Output a table (company, role, days since applied, suggested action) followed by the draft
   messages.

Hard rule (CLAUDE.md): draft only. I send every message by hand. Never auto-send.
