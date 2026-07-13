---
description: ATS-score and fit-grade a scanned listing (or every unscored listing).
argument-hint: <listing folder name, or "all">
allowed-tools: Task, Read, Write, Edit, Glob, Grep
---
Run pipeline step 2 (score) from CLAUDE.md for: $ARGUMENTS

If the argument is "all", score every `jobs/*/job.md` that has no `score.md` yet, dispatching
`role-scorer` subagents IN PARALLEL (one per listing) for batch throughput.

For each listing:
1. Read `jobs/<listing>/job.md`.
2. Machine pass: run the `ats-scanner` skill. Score the PARSED CV text - what a Workday /
   SuccessFactors parser would actually read from the master CV - against the JD keywords.
   Output a 0-100 ATS score and the missing keywords.
3. Recruiter skim pass: run Step 5b of `ats-scanner` (the 10-second human skim after the
   filter): PASS / BORDERLINE / FAIL, what the reader learns in 10 seconds, what they should
   learn but don't.
4. Fit pass: apply the A-F rubric from CLAUDE.md (title match, domain match, seniority fit,
   location, must-have skills present, growth signal). The ATS score, skim verdict and fit
   grade answer different questions; report all three.
5. Write `jobs/<listing>/score.md`: ATS score, recruiter-skim verdict, per-criterion fit
   grades, overall fit grade, missing keywords, target ATS platform (if known), and a
   one-line verdict.
6. If ATS is below the `ats_threshold` in `profile/profile.yml`, mark "SKIP - below
   threshold" and stop. If the
   fit grade is B+ or better despite a low ATS score, flag "manual-route candidate" instead of
   skipping silently (warm intro / direct approach may beat the portal).

Report one summary line per listing: `<listing> | ATS xx | Fit X | keep/skip`.
