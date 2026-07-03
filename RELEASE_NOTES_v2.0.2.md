## Classic v2.0.2 — maintenance bugfixes

For **new blogs**, use [version 3.0.0](https://github.com/paladini/ghost-on-github-pages/releases/latest) (no Python required).

This release is for users staying on **buster + Python 2** who want fixes without migrating to v3.

### Fixed

- Publish only your static site files to GitHub Pages (not the full Ghost install)
- Localhost links on the live site (ports 2368 and 2373)
- Broken image paths in HTML after publish
- Install order and clearer error messages
- pip2 used instead of Python 3 pip for buster

### Documentation

- [Classic getting started](https://github.com/paladini/ghost-on-github-pages/blob/classic/v2/docs/legacy/GETTING-STARTED.md)
- [Requirements (Python 2)](https://github.com/paladini/ghost-on-github-pages/blob/classic/v2/docs/legacy/REQUIREMENTS.md)

### Still limited on Classic

- Python 3 is not supported (buster limitation) — use v3
- Windows native is difficult — use WSL or v3

**Branch:** `classic/v2` · **Frozen snapshot:** [v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1)
