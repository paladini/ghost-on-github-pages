# Multiple GitHub repositories (optional)

Use this if you run **more than one blog** on your computer and each blog should publish to a **different GitHub repository**.

Most people only need one repository and can ignore this page.

## How it works

You create a file `~/.ghost/sites.conf` with one section per blog. Each section stores the GitHub details for that blog.

When you publish, you pass the site name:

```
cd ~/.ghost
./deploy.sh --site my-travel-blog
```

## Example sites.conf

Create the file `~/.ghost/sites.conf`:

```ini
[my-travel-blog]
gh_username=yourname
gh_repo=travel-blog
remote_url=git@github.com:yourname/travel-blog.git
production_domain=https://yourname.github.io/travel-blog

[my-tech-blog]
gh_username=yourname
gh_repo=tech-blog
remote_url=git@github.com:yourname/tech-blog.git
production_domain=https://yourname.github.io/tech-blog
```

Replace the values with your real GitHub username, repository names, and URLs.

## Steps

1. Create or edit `~/.ghost/sites.conf` as shown above.
2. Make sure Ghost is running: `cd ~/.ghost && ghost start`
3. Publish to a specific site:

   ```
   ./deploy.sh --site my-travel-blog
   ```

## Notes

- Each site profile needs its own GitHub repository.
- The default profile (without `--site`) uses `~/.ghost/deploy.conf` from your first publish.
- If you see "site profile not found", check the name in `sites.conf` matches what you pass to `--site`.

## Need help?

See [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) or [open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new).
