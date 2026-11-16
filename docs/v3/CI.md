# Generate the static site in GitHub Actions (version 3)

Two supported ways to get HTML onto GitHub Pages:

1. **Local publish (default)** — run `./deploy.sh` from `~/.ghost`. This is what [DEPLOY.md](DEPLOY.md) describes.
2. **CI publish** — start Ghost in GitHub Actions with Docker Compose, run `gssg`, then deploy the artifact to GitHub Pages.

CI does **not** replace Ghost or `gssg`. It runs the same export path as `scripts/export-static.sh`.

## What the Action does

The reusable workflow [`.github/workflows/publish-static.yml`](../../.github/workflows/publish-static.yml):

1. Checks out your blog repository.
2. Starts the official **`ghost:6`** image with your `content/` folder mounted. If that folder is missing, the job fails unless `allow_empty` is true.
3. Waits until Ghost answers on `localhost:2373`.
4. Runs `gssg` with `--url` (and `--subDir` when the repo is not `USERNAME.github.io`).
5. Runs `scripts/validate-static.sh`.
6. Uploads `publish/` and deploys with official GitHub Pages actions (`upload-pages-artifact` + `deploy-pages`).

You can still push to a **separate Pages repo** with `deploy.sh` instead of GitHub Actions. That remains the original v3 pattern.

## Add the workflow to your blog repository

1. Copy [examples/github/publish-static.yml](../../examples/github/publish-static.yml) to `.github/workflows/publish-static.yml` in **your** blog repo.
2. Replace `YOUR_USERNAME` and `YOUR_REPO`.
3. In GitHub: **Settings → Pages → Source → GitHub Actions**.
4. Put a Ghost **content snapshot** in `content/` before the first deploy. The workflow stops if that folder is missing, so it does not replace your Pages site with an empty Ghost:

   ```
   content/data/          # SQLite database (ghost.db)
   content/images/
   content/themes/
   ```

   Copy from `~/.ghost/content` after you have used Ghost locally.

**Do not commit secrets.** Leave `.env` out of git. Do not put SMTP, Stripe, or Mailgun keys in `content/settings`. A local SQLite blog with no members/payment config is enough.

## Inputs

| Input | Required | Default | Meaning |
|-------|----------|---------|---------|
| `production_domain` | yes | | Public URL, e.g. `https://you.github.io/my-blog` |
| `gh_username` | yes | | Used to compute `gssg --subDir` |
| `gh_repo` | no | empty | Repository name; empty or `you.github.io` means site root |
| `content_path` | no | `content` | Folder in the **caller** repo mounted as Ghost content |
| `ghost_port` | no | `2373` | Host port inside the job |
| `deploy_pages` | no | `true` | Set `false` to export without deploying |
| `allow_empty` | no | `false` | Set `true` only when you intend to export a fresh empty Ghost |
| `scripts_repository` / `scripts_ref` | no | this project / `master` | Where to load `compose.yaml` and scripts |

No tokens beyond `GITHUB_TOKEN` (Pages permissions) are required.

## Dry-run on this project

`workflow_dispatch` on `publish-static.yml` in **this** repository exports a site without deploying (`deploy_pages` defaults to `false`, `allow_empty` defaults to `true`). CI also runs `scripts/compose-smoke.sh --start`, which fails unless `content/data/ghost.db` is written on the mount.

## Keep using `deploy.sh`

If you do not want to version `content/`, keep editing locally and run:

```
cd ~/.ghost
./deploy.sh
```

That pushes static files to the Pages repo you already use. The Action is optional.
