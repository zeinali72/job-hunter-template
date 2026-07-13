---
description: Produce a role-tailored CV from the master for one listing.
argument-hint: <listing folder name>
allowed-tools: Read, Write, Edit, Bash
---
Run pipeline step 3 (tailor) from CLAUDE.md for: $ARGUMENTS

Precondition: `jobs/$ARGUMENTS/score.md` exists and ATS >= the `ats_threshold` in
`profile/profile.yml`. If not, stop and say why.

1. Read `profile/master-cv-professional.tex`, `jobs/$ARGUMENTS/job.md`, and
   `jobs/$ARGUMENTS/score.md`.
2. Run the `cv-rewriter` skill: tailor the master to this JD. Reorder and reword to mirror the
   JD's exact keywords, and surface the missing keywords from score.md ONLY where they are
   genuinely true, following the lead-with/positioning order set in `profile/` and `CLAUDE.md`.
   Never invent experience that is not in `profile/`.
3. Write `jobs/$ARGUMENTS/cv.tex`. Keep it ATS-safe: single column, standard headers, plain
   text, no tables/columns/images.
4. Build the PDF: `latexmk -pdf -output-directory=jobs/$ARGUMENTS jobs/$ARGUMENTS/cv.tex`
   (fall back to `pdflatex`). Report build success and the keyword-coverage gain vs the master.
