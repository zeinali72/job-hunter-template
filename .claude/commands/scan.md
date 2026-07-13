---
description: Sweep Indeed + public career portals + my own LinkedIn search for matching roles.
argument-hint: <search query, e.g. "flood risk modeller UK">
allowed-tools: Task, Read, Write, Edit, Glob, Grep, Bash
---
Run pipeline step 1 (scan) from CLAUDE.md for the query: $ARGUMENTS

1. Dispatch the `job-scout` subagent with this query. It sweeps, read-only: the Indeed MCP
   (when connected), my own LinkedIn `search_jobs`, and PUBLIC career portals
   (Greenhouse, Ashby, Lever, and Workday/SuccessFactors company pages for my target firms).
2. Deduplicate results against existing folders in `jobs/` and rows in `jobs/tracker.csv`
   (match on company + role). Drop anything already seen.
3. For each NEW kept listing, create `jobs/<company>-<role>/job.md` with: title, company,
   location, the full JD text, source URL, and date scanned.
4. Print a numbered summary: company, role, location, source, URL. Do not score yet.

Hard rules (CLAUDE.md): read-only sourcing only. No authenticated scraping of other people's
LinkedIn profiles. Never apply, message, or connect. Propose only; I submit.
