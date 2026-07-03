# Classic — Getting Started

> **Branch:** `classic/v2` · **Latest release:** [v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0)

## What you'll need

Complete [REQUIREMENTS.md](REQUIREMENTS.md) first (Node.js, **Python 2**, pip2, buster).

## Step 1 — Download Classic

Download from [releases/tag/v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0) (or checkout branch `classic/v2`).

## Step 2 — Create a GitHub repository

1. Create a **public** repository on GitHub.
2. Copy the repository URL (example: `git@github.com:you/my-blog.git`).

## Step 3 — Run install

```
chmod +x install.sh
./install.sh
```

Optional: `./install.sh --skip-deploy` to set up Ghost without publishing immediately.

Your blog folder is `~/.ghost`.

## Step 4 — Set up Ghost

Open `http://localhost:2373/ghost` and complete the setup screen.

**Important:** In Ghost Admin → Settings → General, set site URL to `http://localhost:2373` if publish ever hangs.

## Step 5 — Publish

```
cd ~/.ghost
./deploy.sh
```

Your site should appear at `https://YOUR_USERNAME.github.io/YOUR_REPO` within about 10 minutes.

## Upgrading from v2.0.1

Download v2.0.2 or v2.1.0 and copy the new scripts into `~/.ghost`, or re-run `install.sh` from the new download (back up `~/.ghost` first).

Consider [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest) for fewer dependencies.
