# Requirements (version 3)

Install these **before** running `install.sh`.

## What you'll need

| Item | Why |
|------|-----|
| A computer with macOS or Linux | Windows users can try [WSL](https://learn.microsoft.com/en-us/windows/wsl/) |
| [Node.js](https://nodejs.org/) LTS (v18 or v20) | Runs Ghost |
| `wget` | Used when creating your static site |
| A free [GitHub](https://github.com) account | Hosts your blog for free |
| Internet connection | Downloads Ghost and publishing tools |

You do **not** need Python for version 3.

## Step 1 — Install Node.js

1. Go to [https://nodejs.org/](https://nodejs.org/)
2. Download the **LTS** version
3. Run the installer
4. Check it worked — open Terminal and type:

   ```
   node --version
   ```

   You should see a version number (for example `v20.x.x`).

## Step 2 — Install wget

### macOS

```
brew install wget
```

If you do not have Homebrew, install it from [brew.sh](https://brew.sh/) first.

### Ubuntu / Debian Linux

```
sudo apt-get update
sudo apt-get install -y wget
```

### Fedora Linux

```
sudo dnf install -y wget
```

Check:

```
wget --version
```

## Step 3 — Create a GitHub repository

1. Log in to GitHub
2. Click **New repository**
3. Choose a name (for example `my-blog`)
4. Set visibility to **Public**
5. Click **Create repository**
6. Copy the repository URL — you will need it during install

Example URL: `git@github.com:yourname/my-blog.git`

## Optional — Ghost version note

Version 3 uses Ghost installed via Ghost-CLI. If you hit compatibility issues, see [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) or open an issue.

## Next step

Continue to [Getting Started](GETTING-STARTED.md).
