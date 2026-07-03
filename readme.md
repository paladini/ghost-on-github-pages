# Ghost on GitHub Pages

> ## Version 3.0 is here
> v3 replaces Python and buster with a simpler Node-based tool (**gssg**).
> Fewer things to install, more reliable publishing, and fixes for long-standing bugs.
>
> - **Start a new blog (recommended):** [Getting started guide](docs/v3/GETTING-STARTED.md) · [Download v3.0.0](https://github.com/paladini/ghost-on-github-pages/releases/latest)
> - **Already using the old version?** [Migration guide](docs/MIGRATION.md) · run `./migrate.sh`
> - **Want the Classic version?** [Download v2.1.0 (latest Classic)](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0) · [Frozen v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1) · [Legacy docs](docs/legacy/README.md)

![Ghost on GitHub Pages](https://user-images.githubusercontent.com/3361224/39667855-7f37e624-5095-11e8-9297-6a2e63aaac4b.png)

**[Live demo](http://paladini.github.io/ghost-on-github-pages-demo/)** — the demo site will be re-published with v3 soon; use the [getting started guide](docs/v3/GETTING-STARTED.md) to try v3 on your own blog today.

[Ghost](https://ghost.org/) is a modern publishing platform. This project helps you run Ghost on your computer and publish a **free static blog** on [GitHub Pages](https://pages.github.com/) — no paid hosting required.

## Which version should I use?

| | **v3.0 (New — recommended)** | **v2.x (Classic — maintenance)** |
|---|---|---|
| Static site tool | gssg (installed via Node) | buster (Python 2) |
| What you need to install | Node + wget + Ghost | Node + Python 2 + pip2 + buster + Ghost |
| Support | Active (new features) | Maintenance on branch `classic/v2` |
| Open issues fixed | Yes — see [CHANGELOG](CHANGELOG.md) | Most fixes in [v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0) |
| Download | [Latest release](https://github.com/paladini/ghost-on-github-pages/releases/latest) | [v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0) · [v2.0.1 frozen](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1) · [legacy/v2.0.1 alias](https://github.com/paladini/ghost-on-github-pages/releases/tag/legacy/v2.0.1) |
| Documentation | [docs/v3/](docs/v3/) | [docs/legacy/](docs/legacy/) · [classic/v2 branch](https://github.com/paladini/ghost-on-github-pages/tree/classic/v2) |

## Quick start (version 3)

1. Install [Node.js](https://nodejs.org/) and `wget` — see [Requirements](docs/v3/REQUIREMENTS.md)
2. Create a public repository on GitHub
3. Download and extract this project
4. Run:

   ```
   chmod +x install.sh
   ./install.sh
   ```

5. Open `http://localhost:2373/ghost` and set up your blog
6. Publish with `cd ~/.ghost && ./deploy.sh`

Full walkthrough: **[Getting Started](docs/v3/GETTING-STARTED.md)**

## Documentation

| Guide | Description |
|-------|-------------|
| [docs/README.md](docs/README.md) | Documentation index |
| [Getting Started](docs/v3/GETTING-STARTED.md) | New blog setup |
| [Deploy](docs/v3/DEPLOY.md) | Publish changes |
| [Migration](docs/MIGRATION.md) | Upgrade from Classic v2 |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Common problems |
| [Glossary](docs/GLOSSARY.md) | Terms explained simply |

## How it works

```mermaid
flowchart LR
  edit["Edit in Ghost\nlocalhost:2373"] --> gssg["gssg creates\nstatic files"]
  gssg --> github["Push to GitHub"]
  github --> live["Live blog on\nGitHub Pages"]
```

## Contributing

Pull requests are welcome. Please run `bash scripts/shellcheck.sh` and `bash tests/run-validation-tests.sh` before submitting.

## About

Created to make Ghost blogs accessible on free GitHub Pages hosting. Major releases:

- **v3.0.0** (2026) — gssg, no Python, migration tool, expanded docs
- **v2.0.1** (2018) — Classic release with buster

Questions? [Open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new).

**Reference:** [Free Ghost hosting on GitHub Pages](http://ledtechnica.com/free-ghost-hosting-on-github-pages/)
