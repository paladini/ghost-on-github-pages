# Ghost on GitHub Pages

<p align="center">
  <img src="https://user-images.githubusercontent.com/3361224/39667855-7f37e624-5095-11e8-9297-6a2e63aaac4b.png" alt="Ghost on GitHub Pages" width="640">
</p>

<p align="center">
  <strong>Write in Ghost. Publish a free blog on GitHub Pages.</strong><br>
  No paid hosting. Set up in minutes.
</p>

<p align="center">
  <a href="https://github.com/paladini/ghost-on-github-pages/actions/workflows/ci.yml"><img src="https://github.com/paladini/ghost-on-github-pages/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
  <a href="https://github.com/paladini/ghost-on-github-pages/releases/latest"><img src="https://img.shields.io/github/v/release/paladini/ghost-on-github-pages?label=release" alt="Latest release"></a>
  <a href="https://github.com/paladini/ghost-on-github-pages/blob/master/LICENSE"><img src="https://img.shields.io/github/license/paladini/ghost-on-github-pages" alt="MIT License"></a>
  <a href="https://github.com/paladini/ghost-on-github-pages/stargazers"><img src="https://img.shields.io/github/stars/paladini/ghost-on-github-pages?style=social" alt="GitHub stars"></a>
</p>

<p align="center">
  <a href="docs/v3/GETTING-STARTED.md"><strong>Get started</strong></a> ·
  <a href="https://paladini.github.io/ghost-on-github-pages-demo/"><strong>v3 demo</strong></a> ·
  <a href="docs/MIGRATION.md">Upgrading from Classic?</a>
</p>

[Ghost](https://ghost.org/) is a modern publishing platform. This project helps you run Ghost on your computer and publish a **free static blog** on [GitHub Pages](https://pages.github.com/) — no paid hosting required.

**Live demos:** [v3 (current)](https://paladini.github.io/ghost-on-github-pages-demo/) · [Classic v2 (archive)](https://paladini.github.io/ghost-on-github-pages-demo/legacy/v2/static/) — see the [demo repository](https://github.com/paladini/ghost-on-github-pages-demo) for details.

## What's new in version 3

- **Simpler setup** — Node.js and wget only (no Python)
- **Reliable publishing** — fixes broken images and localhost links ([#9](https://github.com/paladini/ghost-on-github-pages/issues/9)–[#22](https://github.com/paladini/ghost-on-github-pages/issues/22))
- **Safe upgrade path** — `./migrate.sh` with automatic backup from Classic v2
- **Plain-English guides** in the [`docs/`](docs/) folder

**Full details:** [Release notes](RELEASE_NOTES_v3.0.0.md) · [Changelog](CHANGELOG.md)

## How your blog gets online

```mermaid
flowchart LR
  edit["Edit in Ghost\nlocalhost:2373"] --> gssg["gssg creates\nstatic files"]
  gssg --> github["Push to GitHub"]
  github --> live["Live blog on\nGitHub Pages"]
```

## Start here

| I want to… | Start here |
|------------|------------|
| Set up a **new** blog | [Getting Started](docs/v3/GETTING-STARTED.md) |
| **Upgrade** from Classic v2 | [Migration guide](docs/MIGRATION.md) |
| Fix a **problem** | [Troubleshooting](docs/TROUBLESHOOTING.md) |
| Understand a **term** | [Glossary](docs/GLOSSARY.md) |

## Documentation

Step-by-step guides for install, publishing, migration, and more live in **[docs/README.md](docs/README.md)**.

## Community

Questions and ideas are welcome — [open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new).

Want to help? You do not need to be a developer. See **[CONTRIBUTING.md](CONTRIBUTING.md)** for ways to contribute (docs, bug reports, testing, and code).

## About

Created to make Ghost blogs accessible on free GitHub Pages hosting. Licensed under [MIT](LICENSE).

**Reference:** [Free Ghost hosting on GitHub Pages](http://ledtechnica.com/free-ghost-hosting-on-github-pages/)

<details>
<summary><strong>Using Classic v2 (buster / Python 2)?</strong></summary>

Classic is in maintenance on branch [`classic/v2`](https://github.com/paladini/ghost-on-github-pages/tree/classic/v2).

- Download [v2.1.0 (latest Classic)](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0)
- [Legacy documentation](docs/legacy/README.md)
- [Classic v2 live demo (archive)](https://paladini.github.io/ghost-on-github-pages-demo/legacy/v2/static/)

</details>
