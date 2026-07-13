---
description: Append or update a row in jobs/tracker.csv for a listing.
argument-hint: <listing folder name> <status>
allowed-tools: Read, Write, Edit, Bash
---
Run pipeline step 6 (track) from CLAUDE.md for: $ARGUMENTS

Columns: company,role,ats_score,fit_grade,status,date_applied,contact,url

1. Parse the listing folder name and the new status from the arguments.
2. Pull company, role, url from `jobs/<listing>/job.md`; ats_score and fit_grade from
   `jobs/<listing>/score.md`; contact from `profile/profile.yml` if one maps to the company.
3. If a row for this company+role already exists in `jobs/tracker.csv`, update its status
   (and set date_applied when status becomes "applied", using `date +%F`); otherwise append a
   new row. Leave date_applied blank until status is "applied".
4. Show the updated row.

Status values: scanned, scored, tailored, packed, applied, interview, offer, rejected, dropped.
