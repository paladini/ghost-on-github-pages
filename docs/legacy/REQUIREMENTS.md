# Classic — Requirements

Install these **before** running `install.sh` on the Classic (v2.x) line.

## What you'll need

| Item | Why |
|------|-----|
| macOS or Linux (or [WSL](https://learn.microsoft.com/en-us/windows/wsl/) on Windows) | Bash scripts and Ghost-CLI |
| [Node.js](https://nodejs.org/) LTS | Runs Ghost |
| **Python 2.7** | Required by buster (Classic only) |
| **pip2** or **pip2.7** | Installs buster — **not** Python 3 pip |
| buster | Installed automatically via pip2 during `install.sh` |
| Free [GitHub](https://github.com) account | Hosts your blog |

Classic **cannot** use Python 3 for buster. For Python 3-only systems, use [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest).

## Node.js

Install LTS from [nodejs.org](https://nodejs.org/). Check:

```
node --version
```

## Python 2 and pip2

### macOS

```
brew install python@2
pip2 install buster
```

Python 2 is deprecated on modern macOS; WSL or [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest) may be easier.

### Ubuntu / Debian

```
sudo apt-get update
sudo apt-get install -y python2.7 python-pip
pip2 install buster
```

### Fedora

```
sudo dnf install -y python2 python2-pip
pip2 install buster
```

### Windows

Native Windows is **not recommended** for Classic ([#13](https://github.com/paladini/ghost-on-github-pages/issues/13)).

1. Install [WSL](https://learn.microsoft.com/en-us/windows/wsl/)
2. Follow the Linux steps inside WSL

Or use [version 3](https://github.com/paladini/ghost-on-github-pages/releases/latest) on Windows with WSL.

## Verify buster

```
buster --help
```

If the command is not found, run `./install.sh` again or `pip2 install buster`.

## Next step

[Getting started](GETTING-STARTED.md)
