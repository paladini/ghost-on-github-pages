# Contributing to Ghost on GitHub Pages

Thank you for helping improve this project. Whether you write code, fix a typo, or report a bug, your contribution matters.

## Ways to contribute (no coding required)

### Report a problem

[Open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new/choose) and include:

- What you were trying to do
- What happened instead (error message, screenshot if possible)
- Your operating system (Mac, Linux, or Windows)
- Which version you use (**v3** or **Classic v2**)

The more detail you provide, the faster we can help.

### Improve documentation

Clear docs help everyone — especially people new to Ghost and GitHub Pages.

- Fix typos or confusing steps in [`docs/`](docs/)
- Add plain-language definitions to the [Glossary](docs/GLOSSARY.md)
- Suggest better examples or screenshots

You can edit files directly on GitHub (pencil icon) or send a pull request.

### Test a release

Follow the [Getting Started guide](docs/v3/GETTING-STARTED.md) on a clean machine (or virtual machine) and report anything that does not work. This catches problems before they reach hundreds of users.

## Contributing code

### Before you start

1. Fork the repository and create a branch from `master`.
2. Make your changes in a focused scope (one fix or feature per pull request).

### Run the checks locally

CI runs the same checks on every pull request. Run them before submitting:

```bash
bash scripts/shellcheck.sh
bash tests/run-validation-tests.sh
```

- **shellcheck** — catches common mistakes in shell scripts (`install.sh`, `deploy.sh`, `migrate.sh`, and related files).
- **Validation tests** — verify that published HTML does not contain broken `localhost` links or image paths. These tests protect users from bugs that only show up after publishing.

If you do not have `shellcheck` installed, the script skips that step with a warning. On Ubuntu/Debian: `sudo apt-get install shellcheck`.

### Pull request checklist

- [ ] `bash scripts/shellcheck.sh` passes (or only warns that shellcheck is missing)
- [ ] `bash tests/run-validation-tests.sh` passes
- [ ] Documentation updated if behavior or user-facing steps changed
- [ ] Commit message explains **why** the change helps users

### Where to look in the codebase

| Area | Purpose |
|------|---------|
| `install.sh` | First-time setup |
| `migrate.sh` | Upgrade from Classic v2 to v3 |
| `includes/deploy.sh` | Publish blog to GitHub Pages |
| `includes/lib/common.sh` | Shared helpers |
| `scripts/validate-static.sh` | Pre-publish HTML checks |
| `docs/` | User-facing guides |

## Questions?

Not sure where to start? [Open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new) and ask. We are happy to point you in the right direction.
