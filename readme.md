# Ghost on Github Pages

![image](https://user-images.githubusercontent.com/3361224/39667855-7f37e624-5095-11e8-9297-6a2e63aaac4b.png)

[Ghost](https://github.com/tryghost/Ghost) is a fully open source, adaptable platform for building and running a modern online publication - a complete professional publishing platform. **Now you can build your own Ghost blog for free in a few minutes.** After that initial setup, it's very easy to maintain a fresh and modern blog. 

<div align="center">
<h3>Let's make a Ghost blog go live right now?</h3>
</div>

That was made possible because we've created some powerful automation scripts to deploy your Ghost blog as static content on Github Pages. Interested? Join us throughout this guide, but first [check out the live demo here](http://paladini.github.io/ghost-on-github-pages-demo/).

## Table of Contents
  * [Requirements](#requirements)
  * [Setup](#setup)
  * [Updating your blog](#updating-your-blog)
  * [FAQ](#faq)
  * [About](#about)

## Requirements

Major dependencies should be installed in your computer. This is only step currently done by your own.

- [Python 2](https://www.python.org/download/releases/2.7.2/): install some of Python 2.X, because `buster` package doesn't support Python 3.
- [NodeJS](https://nodejs.org/en/): [install a version that is officially supported by Ghost](https://docs.ghost.org/docs/supported-node-versions), just like Node v6.9 or Node v8.9.
- [npm](https://nodejs.org/en/): NodeJS package manager.

Besides that, there's some minor dependencies too, but they should be automatically installed for you (tested on  MacOS High Sierra and Ubuntu 16.04). If needed, [check out the minor dependencies here](https://github.com/paladini/ghost-on-github-pages/wiki/Minor-dependencies) and install by yourself.

## Setup

### 1) Download latest version from `ghost-on-github-pages`
Download the latest version of this repository code [by clicking here](https://github.com/paladini/ghost-on-github-pages/archive/master.zip).**

![image](https://user-images.githubusercontent.com/3361224/39668046-c66d1c90-5099-11e8-81d3-f8dd34527c58.png)

**2) Extract it anywhere. E.g: I've extract this file to `/home/1doctecnologia/ghost-on-github-pages`:**

![image](https://user-images.githubusercontent.com/3361224/39670056-92682f46-50d2-11e8-9c78-2bee3fcb0cb2.png)

**3) Open a new Terminal window and navigate to the extracted folder. After that, make the script executable by running:**

```
$ chmod +x install.sh
```

**4) Create a new repository that is going to store your Ghost blog and also give you a free Github Pages domain.** I've created a public Github repo called [`ghost-on-github-pages-demo`](https://github.com/paladini/ghost-on-github-pages-demo) to use as example throughout this guide.

#### IMPORTANT!
Copy the repository remote URL to your clipboard (SSH or HTTPS), because you will be asked to provide this later. E.g: `git@github.com:paladini/ghost-on-github-pages-demo.git`.

**5) Run the installation script:**

```
$ ./install.sh
```

During the process you will be asked to enter the repository remote URL that was copied to your clipboard in previous step.

**6) First Deploy: a default Ghost blog is going to be live .**

It's important to know that installation process will create a new folder located at `/home/YOUR_USERNAME/.ghost/`. This folder will contain the local Ghost server and some useful scripts for deploying your blog on Github Pages.

In the end, the installation script will make a first deploy to Github, so all the static files generated from  default Ghost installation were commited to your recently created repository. However it can take up to 10 minutes to your Ghost blog go live at [http://YOUR_USERNAME.github.io/YOUR_REPOSITORY](http://YOUR_USERNAME.github.io/YOUR_REPOSITORY). You can see [my Ghost blog live at GH Pages by clicking here](http://paladini.github.io/ghost-on-github-pages-demo/).

**7) Second Deploy: your custom blog will go live.**
Let's customize your Ghost blog for the first time. To do that, we are going to access the administrative panel that's running at [http://localhost:2373/ghost](http://localhost:2373/ghost).

A Ghost initial setup screen will appear and you should complete the setup to continue. After that, you can explore the beautiful Ghost Administrative Panel and change whatever you like:

![image](https://user-images.githubusercontent.com/3361224/39673575-541ac008-5115-11e8-86f8-8e2984884cde.png)

With some changes, you may want to see the new version of your blog online at Github Pages. Just run the script `deploy.sh` (located at`/home/YOUR_USERNAME/.ghost/deploy.sh`):

```
# Only for the first time
$ chmod +x ~/.ghost/deploy.sh

# Anytime you want to deploy new updates to your blog on Github Pages:
$ cd ~/.ghost
$ ./deploy.sh
```

The `deploy.sh` script will make a push to your Github repository, modifying both `master` and `gh-pages` branches with the changes you've made. The updated blog should go live very soon at the same address ([http://YOUR_USERNAME.github.io/YOUR_REPOSITORY](http://YOUR_USERNAME.github.io/YOUR_REPOSITORY)).

## Updating your blog
Whenever you want to create a new article, change the blog theme or any other modification on your Ghost blog, just open a new Terminal window and run the following commands:

```
$ cd ~/.ghost
$ ./deploy.sh
```

Remember that Github takes about 10 minutes to update the website.

## FAQ

**1) Where is located Ghost files?**
Ghost and all scripts you may need will be placed at `.ghost` folder inside your Home directory, i.e: `/home/YOUR_USERNAME/.ghost`.

**2) Why branches `master` and `gh-pages` are equal?**
Currently they are mirror branches and are designed that way to facilitate GH Pages deploy. You should avoid updating them manually - our scripts handle that for you. Soon I'll be developing a lightweight version for branch `gh-pages` that will make it contain only static files.

**3) What `deploy.sh` do in the background?**
This script is responsible for deploying updates from your local Ghost blog to your online blog at Github Pages. The general logic of the script can be read below:

If there's no Git repository at Ghost installation directory (`~/.ghost/current`), a new one will be created for you with all needed branches. At the same time, `buster` will be configured to generate static files from the running Ghost server. After that, a commit will be made to the remote repository at Github (our _first deploy_) containing default Ghost blog theme and configurations.

If a Git repository was found at Ghost installation path, then `buster` will be called to generate static files and a new commit will be pushed to remote branches on Github (`master` and `gh-pages`).

**4) What's the purpose of this repository?**
This repository is a guide that compiles everything you need to know in order to setup and maintain your Ghost by your own, with no costs associated. It's purpose is to teach any people interested on how to setup in 20 minutes a free blog under Github Pages using Ghost blogging platform.  

## About
This project was created some years ago and I've made a major update on it's core in May 2018. Besides that, the documentation/guide has been almost rewritten from scratch. If you have any problems or would like to ask some questions, [feel free to open an issue anytime](https://github.com/paladini/ghost-on-github-pages/issues/new).

**References:**
- http://ledtechnica.com/free-ghost-hosting-on-github-pages/