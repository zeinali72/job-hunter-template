# Job Hunter

An agentic job-hunt pipeline for Claude Code: scan listings, ATS-score them, tailor a CV,
draft a cover letter, assemble a submit-ready pack, track status, and chase follow-ups -
with a human reviewing and submitting every step.

**Your personal data never leaves your machine.** The repo tracks only the shared tooling;
everything about you (`profile/`, `jobs/`, `output/`) is gitignored. Clone it, run setup,
fill in your own profile, and it becomes your own job-hunt engine - no fork required, and
`git pull` keeps bringing you tooling improvements without ever touching your data.

## Quick start

```bash
git clone https://github.com/zeinali72/job-hunter-template.git my-job-hunt
cd my-job-hunt
./setup.sh          # creates your gitignored personal files from the templates
```

Then fill in, in this order:

1. `profile/positioning.md` - who you are, what you're hunting, your guardrails.
2. `profile/profile.yml` - target titles/companies, ATS threshold, warm-intro contacts, links.
3. `profile/master-cv-professional.tex` - your real CV (keep the LaTeX structure; it is
   built to be ATS-safe: single column, no tables/images, no mid-word hyphenation).
4. `profile/master-record.md` (full fact archive), `profile/proof-points.md` (quantified
   evidence), `profile/experience-answers.md` (canned application-form answers).

Open the folder in Claude Code and start with `/scan <your search query>`.

## What's tracked vs what's yours

| Tracked (shared tooling)                  | Gitignored (yours, local only)          |
|-------------------------------------------|-----------------------------------------|
| `.claude/` skills, agents, commands        | `profile/` (except `profile/examples/`) |
| `CLAUDE.md`, `README.md`, `setup.sh`       | `jobs/` (listings, scores, tracker)     |
| `profile/examples/` (blank templates)      | `output/` (submit-ready PDFs)           |
| `.mcp.json` (MCP server definitions)       | MCP logins/sessions (live outside the repo) |

## What's in the tooling

- `CLAUDE.md` - the operating instructions Claude follows. It imports your gitignored
  `profile/positioning.md` for everything personal.
- `.claude/skills/` - `ats-scanner` (Workday/SuccessFactors parse simulation + 0-100
  score), `cv-rewriter` (role-tailored CV from your master), `recruiter-coach` (interview
  prep). All three read `profile/` at runtime and hardcode no candidate facts.
- `.claude/agents/` - `job-scout` (sourcing) and `role-scorer` (scoring), used by the
  pipeline commands.
- `.claude/commands/` - the pipeline, in order: `/scan`, `/score`, `/tailor`, `/cover`,
  `/applypack`, `/track`, `/followup`.
- `.mcp.json` - registers the LinkedIn MCP server so `/scan` can search your own LinkedIn.
  On first use you authenticate with your OWN LinkedIn account; sessions are stored by the
  server on your machine, never in this repo.

## Requirements

- [Claude Code](https://claude.com/claude-code)
- `latexmk` or `pdflatex` to build CVs/cover letters to PDF
- `uv`/`uvx` if you want the LinkedIn MCP server (`.mcp.json`) - optional; `/scan` also
  works from Indeed MCP and public career portals

## Hard rules baked into this repo

- Never invent experience, titles, dates, or numbers that are not in `profile/`.
- Claude proposes and prepares; you submit. No application, message, or connection request
  is ever sent automatically.
- Read-only sourcing only - no scraping of other people's LinkedIn profiles, no
  authenticated scraping of career portals beyond your own searches.
- Personal paths are gitignored; nothing about you should ever be committed here.

## Contributing

Tooling improvements welcome. `main` is protected - branch and open a pull request. Make
sure no personal data sneaks into a PR (the `.gitignore` guards the personal paths, but
review your diff before pushing).
