# Job Hunter

An agentic job-hunt pipeline for Claude Code: scan listings, ATS-score them, tailor a CV,
draft a cover letter, assemble a submit-ready pack, track status, and chase follow-ups -
with a human reviewing and submitting every step.

This is a **template**. It ships with no one's personal data in it - you fork it, fill in
`profile/` with your own facts, and it becomes your own job-hunt engine.

## What's in here

- `CLAUDE.md` - the operating instructions Claude follows. Read it first and fill in the
  "Who I am" / "What I am hunting" / priority-guardrail sections with your own details.
- `profile/` - your CV master, fact archive, proof points, and canned answers. Empty
  templates to start; see the setup checklist below.
- `.claude/skills/` - `ats-scanner`, `cv-rewriter`, `recruiter-coach`. These read `profile/`
  at runtime and hardcode no facts about any candidate - safe to reuse as-is.
- `.claude/agents/` - `job-scout` (sourcing) and `role-scorer` (scoring), used by the
  pipeline commands.
- `.claude/commands/` - `/scan`, `/score`, `/tailor`, `/cover`, `/applypack`, `/track`,
  `/followup`: the pipeline steps, in order.
- `jobs/` - starts empty. One folder per listing gets created here as you scan/score/tailor.
- `output/` - gitignored. Submit-ready PDFs land here per listing; never committed.

## Setup checklist

1. Fill in `profile/profile.yml` (name, location, target titles/companies, ATS threshold,
   warm-intro contacts, links).
2. Fill in `profile/master-cv-professional.tex` with your real CV content - keep the LaTeX
   structure, it's built to be ATS-safe (single column, no tables/images, no mid-word
   hyphenation).
3. Fill in `profile/master-record.md` (full fact archive), `profile/proof-points.md`
   (quantified evidence), and `profile/experience-answers.md` (canned application-form
   answers).
4. Edit `CLAUDE.md`: replace the "Who I am", "What I am hunting", and priority-guardrail
   sections with your own positioning and constraints.
5. Requires `latexmk` (or `pdflatex`) to build CVs/cover letters to PDF, and a LinkedIn MCP
   server (`.mcp.json`) if you want `/scan` to search your own LinkedIn account.

## Hard rules baked into this repo

- Never invent experience, titles, dates, or numbers that are not in `profile/`.
- Claude proposes and prepares; you submit. No application, message, or connection request
  is ever sent automatically.
- Read-only sourcing only - no scraping of other people's LinkedIn profiles, no authenticated
  scraping of career portals beyond your own searches.

## Pipeline

`/scan <query>` -> `/score <listing>` -> `/tailor <listing>` -> `/cover <listing>` ->
`/applypack <listing>` -> `/track <listing> <status>`, with `/followup` run periodically to
chase stale threads and warm intros. See `CLAUDE.md` for the full detail on each step.
