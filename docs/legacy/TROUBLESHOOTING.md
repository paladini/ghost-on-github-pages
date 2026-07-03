# Classic — Troubleshooting

## Publish hangs or waits forever ([#1](https://github.com/paladini/ghost-on-github-pages/issues/1))

**Cause:** Wrong site URL in Ghost settings.

**Fix:**

1. Open Ghost Admin → **Settings** → **General**
2. Set **Site URL** to `http://localhost:2373`
3. Save and run `./deploy.sh` again

If you see URLs like `http://drive/...`, the URL field is invalid.

## "Working directory is not a recognisable Ghost installation" ([#15](https://github.com/paladini/ghost-on-github-pages/issues/15), [#21](https://github.com/paladini/ghost-on-github-pages/issues/21))

1. Do not copy project files into an existing Ghost folder manually.
2. Run `install.sh` from a fresh download on branch `classic/v2`.
3. If `~/.ghost` is broken, back it up and remove it, then run `install.sh` again.

Fixed in v2.0.2+ with better install order.

## pip installs for Python 3 instead of Python 2 ([#19](https://github.com/paladini/ghost-on-github-pages/issues/19))

Use **only** `pip2` or `pip2.7`:

```
pip2 install buster
```

v2.0.2+ `install.sh` no longer runs `pip` (Python 3).

## buster / Python errors on Windows ([#13](https://github.com/paladini/ghost-on-github-pages/issues/13))

Use WSL (Linux inside Windows) or upgrade to [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest).

## Links on live site go to localhost ([#22](https://github.com/paladini/ghost-on-github-pages/issues/22))

Upgrade to **v2.0.2+** and run `./deploy.sh` again. The new `fix-links.sh` rewrites ports 2368 and 2373.

## Broken images after publish ([#17](https://github.com/paladini/ghost-on-github-pages/issues/17))

Upgrade to **v2.0.2+**. Older `sed` commands could corrupt image file names in HTML.

## Live site shows wrong files or does not load ([#9](https://github.com/paladini/ghost-on-github-pages/issues/9))

v2.0.2+ publishes only `index.html` and `static/` to GitHub, not the full Ghost installation.

## Navigation in Ghost Admin still shows localhost ([#10](https://github.com/paladini/ghost-on-github-pages/issues/10))

Ghost Admin may still display localhost for nav items. After publish, the **live site** should use your GitHub Pages URL. For a full fix, consider [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest).

## Still stuck?

[Open an issue](https://github.com/paladini/ghost-on-github-pages/issues/new) or try [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest).
