# Migration guide — Classic v2 to v3

This guide helps you move from the **Classic (v2.0.1)** setup to **version 3** without losing your blog posts.

## Do I need to migrate?

**Stay on Classic if:**

- Your blog publishes fine today, and
- You are happy with how it works.

**Migrate to v3 if:**

- Images look broken on your live site,
- Links on your live site go to “localhost” instead of your real address,
- You see Python or buster errors when installing or publishing, or
- You are setting up a new computer and do not want to install Python 2.

## What changes for me?

**Stays the same:**

- Ghost on your computer
- Your blog folder at `~/.ghost`
- You still run `./deploy.sh` to publish

**Gets better:**

- No Python 2 required
- Links and images should work correctly on GitHub Pages
- Clearer messages during install and publish

## Before you start

Check each item:

- [ ] I can open my blog at `http://localhost:2373` in my browser (start it with `cd ~/.ghost && ghost start` if needed)
- [ ] I know my GitHub username and repository name
- [ ] I downloaded the latest v3 files from [GitHub](https://github.com/paladini/ghost-on-github-pages/archive/master.zip) and extracted them

## Easy way (recommended)

1. Open **Terminal**.
2. Go to the folder where you extracted the new v3 files:

   ```
   cd path/to/ghost-on-github-pages
   ```

3. Run the migration script:

   ```
   chmod +x migrate.sh
   ./migrate.sh
   ```

4. Read each message. The script will:
   - Check your current setup
   - **Back up** your blog folder automatically
   - Install the new publishing tool
   - Update your scripts

5. When asked, publish your blog with the new version (recommended).

Your backup is saved as `~/.ghost.backup.YYYYMMDD-HHMMSS` in your home folder.

### Dry run (see what would happen)

```
./migrate.sh --dry-run
```

No files are changed.

## If the script does not work

### Step 1 — Make sure Ghost is running

```
cd ~/.ghost
ghost start
```

Open `http://localhost:2373` in your browser.

### Step 2 — Install the new publishing tool

```
npm install -g ghost-static-site-generator
```

### Step 3 — Copy new scripts

From the v3 folder you downloaded:

```
cp includes/deploy.sh ~/.ghost/
cp includes/uninstall.sh ~/.ghost/
mkdir -p ~/.ghost/lib
cp includes/lib/common.sh ~/.ghost/lib/
mkdir -p ~/.ghost/scripts
cp scripts/validate-static.sh ~/.ghost/scripts/
chmod +x ~/.ghost/deploy.sh ~/.ghost/uninstall.sh ~/.ghost/scripts/validate-static.sh
```

### Step 4 — Publish

```
cd ~/.ghost
./deploy.sh
```

## After migration

1. Wait about **10 minutes** for GitHub Pages to update.
2. Open your live blog URL (for example `https://YOUR_USERNAME.github.io/YOUR_REPO`).
3. Click a few posts, tags, and images to confirm they work.

If something looks wrong, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Go back to the old setup

If you need to undo the migration:

1. Find your backup folder in your home directory: `~/.ghost.backup.YYYYMMDD-HHMMSS`
2. Remove the current folder:

   ```
   mv ~/.ghost ~/.ghost.failed-migration
   ```

3. Restore the backup:

   ```
   cp -a ~/.ghost.backup.YYYYMMDD-HHMMSS ~/.ghost
   ```

Replace `YYYYMMDD-HHMMSS` with the date shown when you migrated.

You can continue using Classic v2 scripts from your backup. For long-term fixes, complete the migration to v3 when you are ready.
