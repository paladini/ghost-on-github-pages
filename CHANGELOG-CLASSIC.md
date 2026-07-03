# Changelog — Classic (v2.x)

## [2.1.0] - 2026-07-03

### Added

- Multiple GitHub repository profiles via `sites.conf` and `deploy.sh --site`
- [docs/legacy/MULTI-REPO.md](docs/legacy/MULTI-REPO.md)

## [2.0.2] - 2026-07-03

### Fixed

- [#9](https://github.com/paladini/ghost-on-github-pages/issues/9) — Publish only static files (`index.html` + `static/`), not the full Ghost install
- [#10](https://github.com/paladini/ghost-on-github-pages/issues/10), [#22](https://github.com/paladini/ghost-on-github-pages/issues/22) — Localhost links on live site (ports 2368 and 2373)
- [#17](https://github.com/paladini/ghost-on-github-pages/issues/17) — Broken image paths in srcset (safer `fix-links.sh`)
- [#19](https://github.com/paladini/ghost-on-github-pages/issues/19) — pip2 used instead of Python 3 pip
- [#15](https://github.com/paladini/ghost-on-github-pages/issues/15), [#21](https://github.com/paladini/ghost-on-github-pages/issues/21) — Install order and error messages
- [#1](https://github.com/paladini/ghost-on-github-pages/issues/1) — Documented Ghost URL setting when publish hangs

### Added

- `deploy.conf` saves GitHub settings between publishes
- `scripts/validate-static.sh` and CI on `classic/v2`
- Legacy documentation in `docs/legacy/`

### Not fixed (use v3 or WSL)

- [#16](https://github.com/paladini/ghost-on-github-pages/issues/16) — buster cannot run on Python 3
- [#13](https://github.com/paladini/ghost-on-github-pages/issues/13) — Windows native + Python 2 remains difficult

## [2.0.1] - 2018-05-06

- Last original Classic release (frozen)
