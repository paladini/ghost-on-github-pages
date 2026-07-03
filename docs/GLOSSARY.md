# Glossary

Short definitions for words used in this project.

**Terminal** — A text window where you type commands. On Mac, open **Terminal** from Applications. On Linux, look for **Terminal** in your apps menu.

**GitHub** — A free website where you store code and files. Your published blog lives in a GitHub **repository** (repo).

**GitHub Pages** — Free website hosting from GitHub. Your blog address looks like `https://YOUR_USERNAME.github.io/YOUR_REPO`.

**Repository (repo)** — A project folder on GitHub. You create one repo for your blog.

**Ghost** — The blogging software you use to write posts. It runs on your computer while you edit; visitors see the published static copy on GitHub Pages.

**Your blog folder (`~/.ghost`)** — A hidden folder on your computer where Ghost and the publish scripts live. `~` means your home folder (for example `/home/you` or `/Users/you`).

**Publish / deploy** — Turn your local blog into files on GitHub Pages so the world can read it. You run `./deploy.sh` from `~/.ghost`.

**gssg** — A small tool (installed automatically) that creates the static HTML files GitHub Pages serves. Version 3 uses gssg instead of the old Python tool called buster.

**Classic (v2.0.1)** — The older version of this project that required Python 2. Still available for download but no longer updated.

**Migration** — Moving from Classic v2 to v3 without losing your posts. See [MIGRATION.md](MIGRATION.md).

**localhost** — An address that means “this computer only.” Your blog editor runs at `http://localhost:2373` while you work locally.

**wget** — A small program used behind the scenes to copy web pages when building your static site. The install guide helps you install it if needed.

**Node.js (Node)** — Software Ghost needs to run. You install it once before using this project.
