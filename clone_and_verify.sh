#!/usr/bin/env bash
# Puzzle #47 — clone a GitHub repo locally (the operation GitHub Desktop wraps).
#
# GitHub Desktop's "Clone repository" is a GUI around `git clone` using your
# signed-in GitHub account. This script performs the identical underlying
# operation and verifies the result, so the mechanic is reproducible without
# the GUI (see README for why the GUI wasn't used this session).
#
# Usage: ./clone_and_verify.sh <repo-url-or-owner/name> [dest-dir]
set -euo pipefail

SRC="${1:-MeherAwadikian/puzzle-45-playwright-scraper}"
DEST="${2:-clone-target}"

# Normalize owner/name -> full https URL (what GitHub Desktop stores/uses).
if [[ "$SRC" != http* && "$SRC" != git@* ]]; then
  URL="https://github.com/${SRC}.git"
else
  URL="$SRC"
fi

echo "[clone] $URL -> $DEST"
rm -rf "$DEST"
git clone "$URL" "$DEST"

cd "$DEST"
echo "[verify] .git present:      $( [ -d .git ] && echo yes || echo NO )"
echo "[verify] remote origin:     $(git remote get-url origin)"
echo "[verify] HEAD commit:       $(git log --oneline -1)"
echo "[verify] tracked files:     $(git ls-files | wc -l)"
echo "[verify] connectivity:      $(git fetch --dry-run >/dev/null 2>&1 && echo 'fetch OK' || echo 'fetch FAILED')"
echo "[done] clone verified at $(pwd)"
