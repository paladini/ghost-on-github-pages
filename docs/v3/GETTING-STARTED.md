# Getting Started (version 3)

Set up a free Ghost blog on GitHub Pages in a few steps.

**Live demo:** [paladini.github.io/ghost-on-github-pages-demo](http://paladini.github.io/ghost-on-github-pages-demo/)

## What you'll need

Complete [REQUIREMENTS.md](REQUIREMENTS.md) first (Node.js, wget, GitHub account).

## Step 1 — Download version 3

1. Download the latest release: [github.com/paladini/ghost-on-github-pages/releases/latest](https://github.com/paladini/ghost-on-github-pages/releases/latest)
2. Extract the ZIP file somewhere you will remember (for example, your Desktop).

## Step 2 — Run the install script

1. Open **Terminal**.
2. Go to the extracted folder:

   ```
   cd path/to/ghost-on-github-pages
   ```

3. Run:

   ```
   chmod +x install.sh
   ./install.sh
   ```

4. Wait — this can take several minutes. The script installs Ghost on your computer.
5. When asked, you can publish to GitHub right away or skip and publish later.

Your **blog folder** is created at `~/.ghost`.

## Step 3 — Set up Ghost

1. Open your browser.
2. Go to: **http://localhost:2373/ghost**
3. Complete the setup screen (create your admin account).
4. Write a test post or explore the editor.

## Step 4 — Publish to GitHub Pages

If you skipped publishing during install:

```
cd ~/.ghost
./deploy.sh
```

The script will ask for:

- Your GitHub **username**
- Your repository **name**
- Your repository **URL**

After publishing, wait about **10 minutes**, then open:

`https://YOUR_USERNAME.github.io/YOUR_REPO`

## How to know it worked

- [ ] `http://localhost:2373` shows your blog on your computer
- [ ] `./deploy.sh` finishes without errors
- [ ] Your GitHub repository has new files
- [ ] Your public URL loads in the browser
- [ ] Clicking a tag or post does **not** go to "localhost"

If any step fails, see [TROUBLESHOOTING.md](../TROUBLESHOOTING.md).

## Update your blog later

1. Edit posts at `http://localhost:2373/ghost`
2. Publish from Terminal:

   ```
   cd ~/.ghost
   ./deploy.sh
   ```

See [DEPLOY.md](DEPLOY.md) for more detail.

## Upgrading from Classic v2?

Use the [Migration guide](../MIGRATION.md) instead of this page.
