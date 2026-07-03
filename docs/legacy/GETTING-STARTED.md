# Classic (v2.0.1) — Getting Started

> **Legacy version only.** Download [v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1).  
> **New users:** use the [v3 Getting Started guide](../v3/GETTING-STARTED.md) instead.

## What you'll need

- A computer running macOS or Linux (Windows may work with extra setup)
- [Python 2](https://www.python.org/download/releases/2.7.2/)
- [Node.js](https://nodejs.org/) (v14.x was tested with Classic)
- A free [GitHub](https://github.com) account

## Step 1 — Download Classic v2.0.1

1. Go to [releases/tag/v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1).
2. Download the **Source code (zip)** file.
3. Extract it somewhere you will remember (for example, your Desktop).

## Step 2 — Create a GitHub repository

1. Log in to GitHub and click **New repository**.
2. Name it (for example, `my-blog`).
3. Leave it **Public**.
4. Copy the repository URL (SSH or HTTPS). You will need it during install.

Example: `git@github.com:YOUR_USERNAME/my-blog.git`

## Step 3 — Run the install script

1. Open **Terminal** (Mac) or your terminal app (Linux).
2. Go to the folder where you extracted the files:

   ```
   cd path/to/ghost-on-github-pages
   ```

3. Make the script runnable and run it:

   ```
   chmod +x install.sh
   ./install.sh
   ```

4. Follow the prompts. Enter your GitHub repository URL when asked.

Everything installs into your **blog folder** at `~/.ghost` (a hidden folder in your home directory).

## Step 4 — Set up your blog

1. Open your browser and go to: `http://localhost:2373/ghost`
2. Complete the Ghost setup screen (create your admin account).
3. Explore the Ghost editor and customize your blog.

## Step 5 — Publish to GitHub Pages

From Terminal:

```
cd ~/.ghost
./deploy.sh
```

Your blog should appear at `http://YOUR_USERNAME.github.io/YOUR_REPO` within about 10 minutes.

## Known limitations

The Classic version has known bugs that are **not** fixed in v2. See [KNOWN-ISSUES.md](KNOWN-ISSUES.md).

To fix these issues, [migrate to v3](../MIGRATION.md).
