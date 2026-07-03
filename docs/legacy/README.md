# Ghost on GitHub Pages — Classic (v2.x)

> **Classic line** uses **buster** and **Python 2** (branch [`classic/v2`](https://github.com/paladini/ghost-on-github-pages/tree/classic/v2)).  
> **New blogs:** use [version 3](../v3/GETTING-STARTED.md) (no Python required).

**Classic demo (archive):** [paladini.github.io/ghost-on-github-pages-demo/legacy/v2/static/](https://paladini.github.io/ghost-on-github-pages-demo/legacy/v2/static/) — preserved from 2018, including known localhost URL bugs for comparison with v3.

## Downloads

| Release | When to use |
|---------|-------------|
| **[v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0)** (latest Classic) | Staying on buster with bugfixes and multi-repo support |
| [v2.0.2](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.2) | Bugfixes only (subset of v2.1.0) |
| [v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1) / [legacy/v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/legacy/v2.0.1) | Frozen 2018 snapshot — no fixes |

Full Classic docs on the [`classic/v2` branch](https://github.com/paladini/ghost-on-github-pages/tree/classic/v2/docs/legacy):

- [Getting started](https://github.com/paladini/ghost-on-github-pages/blob/classic/v2/docs/legacy/GETTING-STARTED.md)
- [Requirements](https://github.com/paladini/ghost-on-github-pages/blob/classic/v2/docs/legacy/REQUIREMENTS.md)
- [Troubleshooting](https://github.com/paladini/ghost-on-github-pages/blob/classic/v2/docs/legacy/TROUBLESHOOTING.md)
- [Multi-repo (v2.1.0+)](https://github.com/paladini/ghost-on-github-pages/blob/classic/v2/docs/legacy/MULTI-REPO.md)

## Quick summary

1. Download [v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0) or checkout branch `classic/v2`
2. Install Python 2, pip2, Node.js (see Requirements on `classic/v2`)
3. Run `./install.sh`
4. Publish with `cd ~/.ghost && ./deploy.sh`

## Migrate to v3?

If Classic is too hard to maintain on your system, see the [Migration guide](../MIGRATION.md).

See [KNOWN-ISSUES.md](KNOWN-ISSUES.md) for what each Classic release fixes.
