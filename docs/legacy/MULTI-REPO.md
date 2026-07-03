# Classic — Multiple GitHub repositories (v2.1.0+)

Optional: publish different blogs to different GitHub repositories using `sites.conf`.

## Example

Create `~/.ghost/sites.conf`:

```ini
[travel-blog]
gh_username=yourname
gh_repo=travel-blog
remote_url=git@github.com:yourname/travel-blog.git
production_domain=https://yourname.github.io/travel-blog

[tech-blog]
gh_username=yourname
gh_repo=tech-blog
remote_url=git@github.com:yourname/tech-blog.git
production_domain=https://yourname.github.io/tech-blog
```

See [examples/sites.conf](../../examples/sites.conf) in the repository.

## Publish to a specific site

```
cd ~/.ghost
ghost start
./deploy.sh --site travel-blog
```

## Default site

Without `--site`, `deploy.sh` uses settings in `~/.ghost/deploy.conf` from your first publish.

## Need help?

[Troubleshooting](TROUBLESHOOTING.md)
