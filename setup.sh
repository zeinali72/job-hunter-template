#!/usr/bin/env bash
# One-time setup after cloning: creates your personal (gitignored) working files
# from the tracked examples. Safe to re-run - never overwrites existing files.
set -euo pipefail
cd "$(dirname "$0")"

mkdir -p jobs output

if [ ! -f jobs/tracker.csv ]; then
  echo "company,role,ats_score,fit_grade,status,date_applied,contact,url" > jobs/tracker.csv
  echo "created jobs/tracker.csv"
fi

for src in profile/examples/*; do
  base="$(basename "$src")"
  dest="profile/$base"
  if [ ! -e "$dest" ]; then
    cp "$src" "$dest"
    echo "created $dest"
  else
    echo "kept existing $dest"
  fi
done

echo
echo "Setup done. Everything created above is gitignored - it stays on your machine."
echo "Now fill in, in this order:"
echo "  1. profile/positioning.md   - who you are, what you're hunting"
echo "  2. profile/profile.yml      - targets, threshold, contacts, links"
echo "  3. profile/master-cv-professional.tex - your real CV"
echo "  4. profile/master-record.md, proof-points.md, experience-answers.md"
