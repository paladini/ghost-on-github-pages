# Known issues — Classic v2.x

| Issue | Status in v2.1.0 | Notes |
|-------|-------------------|-------|
| [#9](https://github.com/paladini/ghost-on-github-pages/issues/9) Deploy wrong files | **Fixed in v2.0.2** | Publishes `publish/` only |
| [#17](https://github.com/paladini/ghost-on-github-pages/issues/17) Broken images | **Fixed in v2.0.2** | `fix-links.sh` |
| [#22](https://github.com/paladini/ghost-on-github-pages/issues/22) Localhost tag links | **Fixed in v2.0.2** | Ports 2368 + 2373 |
| [#19](https://github.com/paladini/ghost-on-github-pages/issues/19) pip3 vs pip2 | **Fixed in v2.0.2** | pip2 only |
| [#15](https://github.com/paladini/ghost-on-github-pages/issues/15), [#21](https://github.com/paladini/ghost-on-github-pages/issues/21) Install errors | **Fixed in v2.0.2** | Install order |
| [#1](https://github.com/paladini/ghost-on-github-pages/issues/1) Publish hangs | **Documented** | Set Ghost URL to localhost |
| [#11](https://github.com/paladini/ghost-on-github-pages/issues/11) Multiple repos | **Fixed in v2.1.0** | `sites.conf` |
| [#10](https://github.com/paladini/ghost-on-github-pages/issues/10) Admin nav localhost | **Partial** | Live site fixed; Admin may still show localhost |
| [#13](https://github.com/paladini/ghost-on-github-pages/issues/13) Windows buster | **Not fixed** | Use WSL or v3 |
| [#16](https://github.com/paladini/ghost-on-github-pages/issues/16) Python 3 | **Not fixable** | buster requires Python 2; use v3 |

**Frozen snapshot v2.0.1** does not include these fixes. Use [v2.1.0](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.1.0) or [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest).
