# How to publish changes (version 3)

After you edit your blog locally, use `deploy.sh` to send updates to GitHub Pages.

## Every time you publish

1. Make sure Ghost is running:

   ```
   cd ~/.ghost
   ghost start
   ```

2. Edit your blog at **http://localhost:2373/ghost**

3. Publish to the web:

   ```
   cd ~/.ghost
   ./deploy.sh
   ```

4. Wait about **10 minutes** for GitHub Pages to update.

## First publish vs later publishes

- **First time:** The script asks for your GitHub username, repository name, and URL. These are saved in `~/.ghost/deploy.conf` so you are not asked every time.
- **Later:** The script uses your saved settings automatically.

## What the script does (simple explanation)

1. Reads your local blog from `http://localhost:2373`
2. Creates static HTML files your visitors will see
3. Checks that links do not point to "localhost"
4. Uploads the files to your GitHub repository

## Your live blog address

| Repository name | Your blog URL |
|-----------------|---------------|
| `my-blog` | `https://USERNAME.github.io/my-blog` |
| `USERNAME.github.io` | `https://USERNAME.github.io` |

## If something goes wrong

See [TROUBLESHOOTING.md](../TROUBLESHOOTING.md).

Common fixes:

- Run `ghost start` before `deploy.sh`
- Check your internet connection
- Confirm your GitHub repository still exists and is public

## Multiple repositories

If you publish to more than one GitHub repo, see [MULTI-REPO.md](MULTI-REPO.md).
