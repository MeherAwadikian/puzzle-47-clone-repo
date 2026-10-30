# Puzzle #47 — clone a GitHub repo locally via GitHub Desktop

Brief (Task Forge puzzle tracker): clone a GitHub repo locally via GitHub Desktop — GitHub.

## What actually happened (honest account)

**GitHub Desktop is installed (v3.5.3) but was not usable this session, so the
real underlying operation was performed via the CLI it wraps — and verified.**

- GitHub Desktop 3.5.3 is registered as installed, but its install location
  (`C:\Users\h\AppData\Local\GitHubDesktop`) is a **junction to
  `D:\tools\appdata\GitHubDesktop`** — and the external **D: drive is
  disconnected** right now (same intermittently-flaky drive that has broken
  Docker, the npm cache, and Playwright's browser path earlier in this work).
  With D: down, the GitHub Desktop binary is literally unreachable, so the GUI
  can't launch.
- GitHub Desktop's "Clone repository" is a GUI wrapper around `git clone` using
  your signed-in GitHub account. So the real, verifiable operation — *clone a
  GitHub repo locally* — was done with git directly (authenticated via the same
  `gh`/GitHub account GitHub Desktop uses). `clone_and_verify.sh` reproduces it.

## Verified (real clone, real checks)

Cloned `MeherAwadikian/puzzle-45-playwright-scraper` locally and verified:

```
files:         README.md  products.csv  requirements.txt  scraper.py
.git present:  yes
remote origin: https://github.com/MeherAwadikian/puzzle-45-playwright-scraper.git
HEAD commit:   8219f5c Puzzle #45: Python + Playwright product scraper -> CSV
connectivity:  git fetch --dry-run -> OK (up to date with remote)
file integrity: scraper.py present, products.csv = 101 lines
```

That's the identical end state GitHub Desktop's clone produces (working tree +
`.git` + origin remote), confirmed end to end.

## Reproduce

```
./clone_and_verify.sh <owner/name | repo-url> [dest-dir]
# e.g. ./clone_and_verify.sh MeherAwadikian/puzzle-45-playwright-scraper
```

## To do it in the GitHub Desktop GUI (when D: is reconnected)
File → Clone repository → URL tab → paste the repo URL → choose a local path →
Clone. (It runs the same `git clone` underneath.) Not demonstrable this session
because the app's files are on the disconnected D: drive.
