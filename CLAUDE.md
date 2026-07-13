# CLAUDE.md - Job Hunt

This repo runs a job search. Claude is the application engineer: it scans, scores, tailors,
and preps; the candidate reviews and submits. Claude never submits anything on the
candidate's behalf.

## Who I am (fill this in before you start)

Replace this section with your own one-line positioning: your background, the angle you
want to lead with, and any "this is positioning language, not a skills claim" caveats that
matter for your field (e.g. don't let the CV imply hands-on experience with a tool you've
only read about).

Full source material lives in `profile/`. Treat it as the single source of truth.
Never invent experience, titles, dates, or numbers that are not in `profile/`.

## What I am hunting

Replace this with your own target: industries/companies, seniority, location constraints,
and your ATS score threshold below which you don't bother prepping an application.
CV: `profile/master-cv-professional.tex`. High tailoring, manual submit, warm-intro-led
works well for low-volume, high-care job hunts - adjust if you're running high-volume
instead.

## Folder layout

- `profile/` - your CV master, proof points, reusable answers, `profile.yml`. Your stuff.
- `jobs/<company>-<role>/` - one folder per listing: `job.md` (the JD), `score.md`,
  `cv.tex`/`cv.pdf`, `cover.md`.
- `jobs/tracker.csv` - the single log. Columns:
  `company, role, ats_score, fit_grade, status, date_applied, contact, url`.
- `output/` - final submit-ready PDFs (gitignored - personal, not version-controlled).

## Tools available

- **Indeed MCP** - read-only sourcing of listings (title, keyword, location, job detail).
- **LinkedIn MCP** - READ-MOSTLY, logged into your own account. Only your own searches and
  your own profile. Do not scrape other people's profiles. Keep request volume human-paced.
  Never auto-message or auto-connect. All LinkedIn actions are done by hand.
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

## Pipeline (commands map to these steps)

1. `/scan <query>` - job-scout subagent sweeps Indeed + public portals + your LinkedIn
   search. Returns a deduplicated list. Writes `job.md` per kept listing.
2. `/score <listing>` - run `ats-scanner` (machine pass: will you get filtered) AND the fit
   rubric (A-F: should you bother). Batch via role-scorer subagents when scoring many.
   Skip anything below your ATS threshold. Write `score.md`.
3. `/tailor <listing>` - `cv-rewriter` on the master CV. Output `cv.tex` + `cv.pdf`.
4. `/cover <listing>` - tailored cover letter mirroring JD keywords. Output `cover.md`.
5. `/applypack <listing>` - assemble the submit-ready folder into `output/` and give a
   checklist (portal link, files, form questions answered from `experience-answers.md`).
6. `/track <listing> <status>` - append/update `tracker.csv`.
7. `/followup` - each morning, list stale threads (applied 7+ days, no reply) and warm
   intros to chase. Draft the chase messages for review.

## Fit rubric (the "should I bother" pass)

Score A-F across: title match, domain match, seniority fit, location (vs your base/remote
preference), must-have skills present, growth signal. Below C means deprioritise. The ATS
score and the fit grade are different questions; report both.

## Warm intros come first

Your highest-leverage channel is warm introductions, not application volume. When a scanned
role maps to a company where you have a contact (`profile/profile.yml`), flag it and draft
the intro ask, not just the application.

## Style

Plain ASCII only. No em-dashes, no fancy Unicode. Direct and honest over flattering. CVs:
`.docx`-friendly structure, no tables/columns/text-boxes/images (ATS parse killers),
standard section names, skills as plain-text lists. Adjust the language variant (British vs
US English etc.) to your own preference.

## Priority guardrail

Set your own guardrail here: how this job hunt ranks against other priorities in your life
(e.g. a thesis, a current job, health, family), so Claude reminds you to time-box if a
session sprawls.

---

## Setup checklist for a new fork

1. Fill in `profile/profile.yml` (name, location, target titles/companies, ATS threshold,
   warm-intro contacts, links).
2. Fill in `profile/master-cv-professional.tex` with your real CV content (keep the LaTeX
   structure - it's built to be ATS-safe).
3. Fill in `profile/master-record.md`, `profile/proof-points.md`, and
   `profile/experience-answers.md` with your own facts, evidence, and canned answers.
4. Replace the "Who I am" and "What I am hunting" sections above with your own positioning.
5. `jobs/` starts empty (just a header-only `tracker.csv`) - `/scan` populates it per listing.
