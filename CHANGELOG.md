# Changelog

All notable changes to this project are documented here.

## [3.0.0] - 2026-07-03

### Added

- **gssg** (ghost-static-site-generator) replaces buster for creating your static blog
- **migrate.sh** to upgrade from Classic v2 to v3 with automatic backup
- Full documentation in `docs/v3/` and `docs/legacy/` (plain English)
- **docs/GLOSSARY.md** for non-technical readers
- **docs/MIGRATION.md** step-by-step migration guide
- **docs/TROUBLESHOOTING.md** unified FAQ
- `scripts/validate-static.sh` to catch broken links and images before publish
- GitHub Actions CI (shellcheck + validation tests)
- Support for multiple GitHub repositories via `deploy.sh --site` and `sites.conf`
- Saved deploy settings in `~/.ghost/deploy.conf`

### Fixed

- [#9](https://github.com/paladini/ghost-on-github-pages/issues/9) — Publish only static site files, not the full Ghost installation
- [#10](https://github.com/paladini/ghost-on-github-pages/issues/10) — Navigation links pointing to localhost on live site
- [#13](https://github.com/paladini/ghost-on-github-pages/issues/13) — buster / Python errors on Windows and modern systems
- [#15](https://github.com/paladini/ghost-on-github-pages/issues/15), [#21](https://github.com/paladini/ghost-on-github-pages/issues/21) — "Working directory is not a recognisable Ghost installation"
- [#16](https://github.com/paladini/ghost-on-github-pages/issues/16), [#19](https://github.com/paladini/ghost-on-github-pages/issues/19) — Python 2 / pip dependency removed
- [#17](https://github.com/paladini/ghost-on-github-pages/issues/17) — Broken image paths in published HTML
- [#22](https://github.com/paladini/ghost-on-github-pages/issues/22) — Tag links pointing to localhost
- [#1](https://github.com/paladini/ghost-on-github-pages/issues/1) — Documented fix for publish hanging (wrong Ghost URL)
- [#11](https://github.com/paladini/ghost-on-github-pages/issues/11) — Multiple repository profiles

### Removed

- Python 2 and buster from the main install flow

### Legacy

- **v2.0.1** remains available: [releases/tag/v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1)
- Classic documentation archived in `docs/legacy/`

## [2.0.1] - 2018-05-06

- Bug fixes and improved documentation
- Classic release using buster and Python 2

## [2.0] - 2018-05-06

- Major core update and rewritten documentation
