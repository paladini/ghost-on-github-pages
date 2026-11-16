# Run Ghost with Docker Compose (version 3)

Use this if you prefer Docker instead of `install.sh` (Ghost-CLI + Node on your computer). Publishing still uses **gssg** and `deploy.sh` — Ghost itself is not rewritten.

This is the easier path on **Windows with WSL**.

## What you'll need

| Item | Why |
|------|-----|
| [Docker](https://docs.docker.com/get-docker/) with Compose v2 | Runs the official Ghost image |
| `wget` and [Node.js](https://nodejs.org/) LTS | Needed on the **host** for `gssg` when you publish |
| A free [GitHub](https://github.com) account | Hosts the static blog |

You do **not** need Ghost-CLI for this path.

### Windows (WSL)

1. Install [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/) with the **WSL 2** engine.
2. Install a Linux distro from the Microsoft Store (Ubuntu is fine) and open it.
3. In that WSL terminal, confirm:

   ```
   docker compose version
   ```

## Ghost version

`install.sh` installs Ghost via `ghost-cli@latest` (currently Ghost **6**). Compose uses the same major: **`ghost:6`** (official image).

## Step 1 — Prepare `~/.ghost`

From this project folder:

```
chmod +x scripts/compose-setup.sh
./scripts/compose-setup.sh
```

This creates your **blog folder** at `~/.ghost`, including:

| Path | Role |
|------|------|
| `~/.ghost/content/` | Themes, images, and the SQLite database (`content/data/ghost.db`) |
| `~/.ghost/current/` | Where `gssg` writes `static/` (same as the Ghost-CLI layout) |
| `~/.ghost/deploy.sh` | Same publish script as `install.sh` |
| `~/.ghost/.docker` | Tells `deploy.sh` that Ghost runs in Docker |

## Step 2 — Start Ghost

From this project folder (or from `~/.ghost`, which has a copy of `compose.yaml`):

```
docker compose up -d
```

Optional environment variables (see `.env.example`; do not commit a real `.env`):

| Variable | Default | Meaning |
|----------|---------|---------|
| `GHOST_PORT` | `2373` | Host port |
| `GHOST_URL` | `http://localhost:2373` | URL Ghost uses for links |
| `GHOST_CONTENT` | `$HOME/.ghost/content` | Bind mount for content |

If you change `GHOST_PORT`, set `GHOST_URL` to match (for example `http://localhost:2373`).

Compose uses the project name `gogp`. Starting or stopping from this folder and from `~/.ghost` controls the same stack.

The database file is `~/.ghost/content/data/ghost.db`. Posts stay there when the container is removed. This SQLite setup does not run Ghost's MySQL job outbox; those jobs use Ghost's direct-dispatch path. Publishing with `gssg` does not need MySQL.

Ghost may log a connection error while measuring an image, because inside the container it calls `http://localhost:2373` and the process itself listens on port 2368. The blog on your computer is still at that URL. `gssg` runs on the host and reads it from there.

## Step 3 — Open Ghost Admin

1. Open a browser.
2. Go to **http://localhost:2373/ghost**
3. Create your admin account and write posts.

The public preview of the local blog is **http://localhost:2373**.

## Step 4 — Publish with `deploy.sh`

Keep the container running. On the **host** (WSL or macOS/Linux):

```
cd ~/.ghost
./deploy.sh
```

`deploy.sh` calls `gssg` against `http://localhost:2373`, validates the HTML, and pushes to your GitHub Pages repository — the same flow as after `install.sh`.

To export files **without** pushing:

```
export GH_USERNAME=yourname
export GH_REPO=your-repo
cd ~/.ghost
./scripts/export-static.sh
```

Static files land in `~/.ghost/publish/`.

## Stop or remove

```
docker compose down
```

Your posts stay in `~/.ghost/content`. To uninstall, run `~/.ghost/uninstall.sh` (stops Compose; you delete the folder yourself if you want a full cleanup).

## GitHub Actions

To generate and publish the static site in CI, see [CI.md](CI.md).

## If something goes wrong

See [TROUBLESHOOTING.md](../TROUBLESHOOTING.md).
