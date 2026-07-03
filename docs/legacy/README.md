# Ghost on GitHub Pages — Classic (v2.0.1)

> **This is the legacy documentation for version 2.0.1.**  
> It is kept here for reference only. **For new blogs, use [version 3](../v3/GETTING-STARTED.md).**  
> Download Classic v2.0.1: [GitHub Release v2.0.1](https://github.com/paladini/ghost-on-github-pages/releases/tag/v2.0.1)

---

**We need contributions via Pull Requests in order to maintain this as a working solution. Please, if possible send your contribution!**

![image](https://user-images.githubusercontent.com/3361224/39667855-7f37e624-5095-11e8-9297-6a2e63aaac4b.png)

Demo Version: [http://paladini.github.io/ghost-on-github-pages-demo/](http://paladini.github.io/ghost-on-github-pages-demo/)

[Ghost](https://github.com/tryghost/Ghost) is a fully open source, adaptable platform for building and running a modern online publication - a complete professional publishing platform. **Now you can build your own Ghost blog for free in a few minutes.** After that initial setup, it's very easy to maintain a fresh and modern blog.

## Table of Contents

  * [Requirements](#requirements)
  * [Setup](#setup)
  * [How to update your blog?](#how-to-update-your-blog)
  * [FAQ](#faq)
  * [About](#about)

## Requirements

Major dependencies should be installed on your computer. This is the only step currently done by you.

### Install [Python 2](https://www.python.org/download/releases/2.7.2/)

Install Python 2.X, because the buster package does not support Python 3.

### Install [NodeJS](https://docs.ghost.org/docs/supported-node-versions)

Install a version officially supported by Ghost, such as Node v14.x.

### Install [npm](https://nodejs.org/en/)

Node package manager, included with Node on most systems.

See [GETTING-STARTED.md](GETTING-STARTED.md) for step-by-step install instructions.

## Setup

See [GETTING-STARTED.md](GETTING-STARTED.md) for the full Classic install guide.

## How to update your blog?

Whenever you want to update your blog, open your local Ghost blog, make your changes, then run:

```
$ cd ~/.ghost
$ ./deploy.sh
```

Remember that GitHub takes about 10 minutes to update the website.

## FAQ

**1) Where are Ghost files located?**

Ghost and all scripts are placed in the `.ghost` folder inside your Home directory, i.e. `/home/YOUR_USERNAME/.ghost`.

**2) Why are branches `master` and `gh-pages` equal?**

They are mirror branches designed to facilitate GitHub Pages deploy. Avoid updating them manually — our scripts handle that for you.

**3) What does `deploy.sh` do in the background?**

It uses `buster` to generate static files from your running Ghost server, then pushes them to your GitHub repository.

**4) What's the purpose of this repository?**

This project teaches how to set up a free blog on GitHub Pages using Ghost, with no hosting costs.

## About

This project was created years ago with a major core update in May 2018. Version 2.0.1 was the last Classic release (May 2018). Version 3.0 is now the recommended release.

If you have problems with the Classic version, consider [migrating to v3](../MIGRATION.md) or see [KNOWN-ISSUES.md](KNOWN-ISSUES.md).
