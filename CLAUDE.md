# CLAUDE.md - Job Hunt

This repo runs a job search. Claude is the application engineer: it scans, scores, tailors,
and preps; the candidate reviews and submits. Claude never submits anything on the
candidate's behalf.

## Candidate positioning (personal - gitignored, created by setup.sh)

@profile/positioning.md

The imported file above holds who the candidate is, what they are hunting, their warm-intro
strategy, priority guardrails, and style preferences. It lives in `profile/` which is
gitignored, so it never gets committed. If the import is missing, tell the user to run
`./setup.sh` and fill in `profile/positioning.md` before doing anything else.

Full source material lives in `profile/`. Treat it as the single source of truth.
Never invent experience, titles, dates, or numbers that are not in `profile/`.

## Folder layout

- `profile/` - the candidate's CV master, positioning, proof points, reusable answers,
  `profile.yml`. PERSONAL - gitignored except `profile/examples/` (the blank templates).
- `jobs/<company>-<role>/` - one folder per listing: `job.md` (the JD), `score.md`,
  `cv.tex`/`cv.pdf`, `cover.md`. PERSONAL - the whole `jobs/` tree is gitignored.
- `jobs/tracker.csv` - the single log. Columns:
  `company, role, ats_score, fit_grade, status, date_applied, contact, url`.
- `output/` - final submit-ready PDFs. PERSONAL - gitignored.

Only the tooling is version-controlled: `.claude/` (skills, agents, commands), `CLAUDE.md`,
`README.md`, `setup.sh`, and `profile/examples/`. Never `git add -f` anything from the
personal paths above; if the user asks to commit personal data, warn them the repo remote
is public and confirm first.

## Tools available

- **Indeed MCP** - read-only sourcing of listings (title, keyword, location, job detail).
- **LinkedIn MCP** - READ-MOSTLY, logged into the candidate's own account (`.mcp.json`
  registers the server; each user authenticates their own account on first use). Only their
  own searches and their own profile. Do not scrape other people's profiles. Keep request
  volume human-paced. Never auto-message or auto-connect.
- **Gmail + Google Calendar** - recruiter threads and scheduling calls. Draft replies,
  never send without explicit review.
- **Playwright (via job-scout agent)** - sweep PUBLIC career portals only
  (Greenhouse, Ashby, Lever, company pages). Never authenticated LinkedIn sessions.

Hard rule: Claude proposes and prepares; the candidate submits. No application, message, or
connection request is ever sent automatically.

## Skills already included (do not rebuild)

- `ats-scanner` - simulates Workday / SuccessFactors parse + 0-100 score. Run for every
  role before tailoring.
- `cv-rewriter` - produces the role-specific tailored CV from the master.
- `recruiter-coach` - interview prep and recruiter-message drafting.

All three read `profile/` at runtime and hardcode no candidate facts.

## Pipeline (commands map to these steps)

1. `/scan <query>` - job-scout subagent sweeps Indeed + public portals + the candidate's
   LinkedIn search. Returns a deduplicated list. Writes `job.md` per kept listing.
2. `/score <listing>` - run `ats-scanner` (machine pass: will you get filtered) AND the fit
   rubric (A-F: should you bother). Batch via role-scorer subagents when scoring many.
   Skip anything below the `ats_threshold` in `profile/profile.yml`. Write `score.md`.
3. `/tailor <listing>` - `cv-rewriter` on the master CV. Output `cv.tex` + `cv.pdf`.
4. `/cover <listing>` - tailored cover letter mirroring JD keywords. Output `cover.md`.
5. `/applypack <listing>` - assemble the submit-ready folder into `output/` and give a
   checklist (portal link, files, form questions answered from `experience-answers.md`).
6. `/track <listing> <status>` - append/update `tracker.csv`.
7. `/followup` - each morning, list stale threads (applied 7+ days, no reply) and warm
   intros to chase. Draft the chase messages for review.

## Fit rubric (the "should I bother" pass)

Score A-F across: title match, domain match, seniority fit, location (vs the candidate's
base/remote preference), must-have skills present, growth signal. Below C means
deprioritise. The ATS score and the fit grade are different questions; report both.

## Warm intros come first

The highest-leverage channel is warm introductions, not application volume. When a scanned
role maps to a company where the candidate has a contact (`profile/profile.yml`), flag it
and draft the intro ask, not just the application.

## Style

Plain ASCII only. No em-dashes, no fancy Unicode. Direct and honest over flattering. CVs:
`.docx`-friendly structure, no tables/columns/text-boxes/images (ATS parse killers),
standard section names, skills as plain-text lists. Language variant and tone come from
`profile/positioning.md`.
