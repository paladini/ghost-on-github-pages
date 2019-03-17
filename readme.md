# Ghost on Github Pages

![image](https://user-images.githubusercontent.com/3361224/39667855-7f37e624-5095-11e8-9297-6a2e63aaac4b.png)

Demo Version: [http://paladini.github.io/ghost-on-github-pages-demo/](http://paladini.github.io/ghost-on-github-pages-demo/)

[Ghost](https://github.com/tryghost/Ghost) is a fully open source, adaptable platform for building and running a modern online publication - a complete professional publishing platform. **Now you can build your own Ghost blog for free in a few minutes.** After that initial setup, it's very easy to maintain a fresh and modern blog. 

<div align="center">
<h3>Let's make a Ghost blog go live right now?</h3>
</div>

That was made possible because we've created some powerful automation scripts to deploy your Ghost blog as static content on Github Pages. Interested? Join us throughout this guide, but first [check out the live demo here](http://paladini.github.io/ghost-on-github-pages-demo/).

## Table of Contents

  * [Requirements](#requirements)
  * [Setup](#setup)
    + [1) Download and extract `ghost-on-github-pages`](#1-download-and-extract-ghost-on-github-pages)
    + [2) Create a new Github repository](#3-create-a-new-github-repository)
    + [3) Install](#4-install)
    + [4) Deploying to Github Pages](#5-deploying-to-github-pages)
  * [How to update your blog?](#how-to-update-your-blog)
  * [FAQ](#faq)
  * [About](#about)

## Requirements

Major dependencies should be installed in your computer. This is only step currently done by your own.


### Install [Python 2](https://www.python.org/download/releases/2.7.2/)
Install Python 2.X, because buster package doesn't support Python 3.
```
# Debian-based systems
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python2.7
```

### Install [NodeJS](https://docs.ghost.org/docs/supported-node-versions)
Install a version that is officially supported by Ghost, just like Node v6.9 or Node v8.9.
```
# Debian-based systems
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Install [npm](https://nodejs.org/en/)
NodeJS package manager from `https://nodejs.org/en/`
```
# Debian-based systems
sudo apt install npm
```

Besides that, there's some minor dependencies too, but they should be automatically installed for you (tested on  MacOS High Sierra and Ubuntu 16.04). If needed, [check out the minor dependencies here](https://github.com/paladini/ghost-on-github-pages/wiki/Minor-dependencies) and install by yourself.

## Setup

### 1) Download and extract `ghost-on-github-pages`
Download the latest version of this repository code [by clicking here](https://github.com/paladini/ghost-on-github-pages/archive/master.zip). After downloading the project, extract it anywhere you'll remember later. E.g: I've extract the .zip file to `/home/1doctecnologia/ghost-on-github-pages`:

![image](https://user-images.githubusercontent.com/3361224/39670056-92682f46-50d2-11e8-9c78-2bee3fcb0cb2.png)

### 2) Create a new Github repository
Create a new repository that is going to store your Ghost blog and also give you a free Github Pages domain. I've created a public Github repo called [`ghost-on-github-pages-demo`](https://github.com/paladini/ghost-on-github-pages-demo) to use as example throughout this guide.

**[IMPORTANT]** Copy the repository remote URL to your clipboard (SSH or HTTPS), because you will be asked to provide this later. E.g: `git@github.com:paladini/ghost-on-github-pages-demo.git`.


### 3) Install

Now we are ready to install everything needed using the script called `install.sh`. Open a new Terminal window, navigate to the previous extract folder and then run:

```
$ chmod +x install.sh
$ ./install.sh
```

During the process you will be asked to enter the repository remote URL that was copied to your clipboard in the previous step.

Everything will be installed at `/home/YOUR_USERNAME/.ghost/` (e.g: `/home/paladini/.ghost`). _Everything_ means the local Ghost server, a few static files required by GH Pages and some useful scripts for deploying your blog on Github Pages.

In the end, the script will start Ghost server and then make a first deploy to Github. All the static files generated from default Ghost blog will be commited to your Github repository. However it can take up to 10 minutes to your Ghost blog go live at [http://YOUR_USERNAME.github.io/YOUR_REPOSITORY](http://YOUR_USERNAME.github.io/YOUR_REPOSITORY). It should look like this:

![image](https://user-images.githubusercontent.com/3361224/39674582-58571054-5124-11e8-8326-0fe6c4747620.png)

[You can see my Ghost blog here](http://paladini.github.io/ghost-on-github-pages-demo/).

### 4) Deploying to Github Pages
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

## How to update your blog?
Whenever you want to update your blog (e.g: create a new article, change the blog theme, etc.), just open your local Ghost blog and make all desired modifications. When finished, open a Terminal window and run the following commands to deploy your changes from the local Ghost blog to Github Pages:

```
$ cd ~/.ghost
$ ./deploy.sh
```

Remember that Github takes about 10 minutes to update the website.

### Example

I wrote and published a test article on my local Ghost blog:

![image](https://user-images.githubusercontent.com/3361224/39675360-86527190-5130-11e8-9537-eb50723c554c.png)

After that, I opened a Terminal window, go to the Ghost installation folder (`$HOME/.ghost`) and then run the following command:

```
$ ./deploy.sh
```

Running the script, my updates on blog are sent to my blog on Github Pages. A few moments later I refreshed the [home page of my blog](http://paladini.github.io/ghost-on-github-pages-demo/static/index.html) and then find out my new article:

![image](https://user-images.githubusercontent.com/3361224/39675421-4c9d4ef6-5131-11e8-96b1-10a99129d08c.png)

And that's all :) 


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
