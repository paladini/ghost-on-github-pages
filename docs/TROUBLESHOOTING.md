# Troubleshooting & FAQ

Answers in plain English. If you are stuck, [open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new).

## Install problems

### "Working directory is not a recognisable Ghost installation"

**What it means:** Ghost was not installed correctly in your blog folder.

**Try this:**

1. Do **not** copy this project's files into an existing Ghost folder.
2. Run `install.sh` from a fresh download, or use [migrate.sh](../migrate.sh) if upgrading from Classic.
3. If the folder `~/.ghost` looks broken, back it up and remove it, then run `install.sh` again.

### Install stops or shows many errors

1. Check [REQUIREMENTS.md](v3/REQUIREMENTS.md) — Node.js and `wget` must be installed.
2. Make sure you have an internet connection.
3. On Linux, you may need `curl` and build tools for Ghost — see Ghost's official docs.

## Docker Compose

### `docker compose` is not found

Install Docker Desktop (Windows/macOS) or Docker Engine + the Compose plugin (Linux). In WSL, enable the Docker Desktop WSL integration. See [DOCKER.md](v3/DOCKER.md).

### Ghost never opens at http://localhost:2373

1. Run `docker compose ps` and `docker compose logs ghost`.
2. Confirm nothing else is using port **2373**.
3. If you set `GHOST_PORT`, also set `GHOST_URL` to `http://localhost:THAT_PORT`.

### Posts disappear after `docker compose down`

The database must be `~/.ghost/content/data/ghost.db`. If that file is missing, the container was not using the Compose file from this project. Run `./scripts/compose-setup.sh` again and start Ghost with `docker compose up -d` so the project name is `gogp`.

### `uninstall.sh` says the stack may still be running

Docker could not stop the `gogp` project. Run `docker compose ps` in `~/.ghost` and then `docker compose down`. Your files are still in `~/.ghost` until you delete that folder yourself.

### `deploy.sh` says the blog folder is not set up

Run `./scripts/compose-setup.sh` from this project first so `~/.ghost/.docker` and `deploy.sh` exist. Do not mix a Ghost-CLI install and Compose in the same `~/.ghost` folder.

## Publish problems

### "Static files were not created"

**What it means:** The publish tool could not read your local blog.

**Try this:**

1. Start Ghost:

   ```
   cd ~/.ghost
   ghost start
   ```

   Or, with Docker: `docker compose up -d` (see [DOCKER.md](v3/DOCKER.md)).

2. Open `http://localhost:2373` in your browser and confirm the blog loads.
3. Run `./deploy.sh` again.

### Publish says "No changes to publish"

You may not have saved/published changes in Ghost Admin, or Ghost was not running when you ran `deploy.sh`. Edit a post, publish it in Ghost, then run `./deploy.sh` again.

### Links on the live site still say "localhost"

You are probably on Classic v2. [Migrate to v3](MIGRATION.md) and publish again.

### Images look broken (extra letters in file names)

This was a Classic v2 bug (#17). [Migrate to v3](MIGRATION.md) and publish again.

### Publish hangs or waits forever (Classic / buster)

**What it means:** The blog URL in Ghost settings is wrong.

**Try this:**

1. Open Ghost Admin → **Settings** → **General**.
2. Set the site URL to `http://localhost:2373` (for local editing).
3. Try publishing again.

If you see addresses like `http://drive/...`, the URL field is invalid — fix it to `http://localhost:2373`.

## GitHub Pages

### My site shows 404

- Wait up to 10 minutes after publishing.
- Confirm your repo is **Public**.
- Your URL is `https://USERNAME.github.io/REPO` unless the repo is named `USERNAME.github.io`.

### I need to enter GitHub details every time

On v3, settings are saved in `~/.ghost/deploy.conf` after the first successful publish.

## Multiple blogs

See [MULTI-REPO.md](v3/MULTI-REPO.md).

## Still stuck?

1. Read the [Glossary](GLOSSARY.md) for unfamiliar terms.
2. [Open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new) and describe what you tried and what message you saw.

## FAQ (quick answers)

**Where is my blog on my computer?**  
In `~/.ghost` (your blog folder).

**How do I update my live blog?**  
Edit in Ghost at `http://localhost:2373/ghost`, then run `cd ~/.ghost && ./deploy.sh`.

**Do I need Python?**  
Not for v3. Classic v2 required Python 2.

**Can I use the old version?**  
Yes — [download v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1) and see [legacy docs](legacy/README.md).
