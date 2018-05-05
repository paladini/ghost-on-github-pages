# Ghost on Github Pages

![image](https://user-images.githubusercontent.com/3361224/39667855-7f37e624-5095-11e8-9297-6a2e63aaac4b.png)

[Ghost](https://github.com/tryghost/Ghost) is a fully open source, adaptable platform for building and running a modern online publication - a complete professional publishing platform. **And now you can use this incredible platform for absolutely no cost.**

### Are you kidding?
No, I'm not. You can build your own Ghost blog for free in a few minutes. How you can do that? Just read this guide that compiles everything you need to know to setup and maintain your Ghost by your own, with no cost associated. 

### How it's possible?
Through some powerful automation scripts allied to Github Pages, a service that allows you to publish static sites for free. In about 20 minutes you will have a Ghost blog available to the world, with a custom design and with everything you feel comfortable to write on Internet. After that initial setup, it's very easy to maintain a fresh and modern blog.

[<h3>Check the live demo here</h3>](http://paladini.github.io/ghost-on-github-pages-demo/)

## Requirements

### Major dependencies
All packages listed below as `Major dependencies` should be installed in your computer by our own. Note that many of these dependencies are bundled with modern operating systems - if you're a lucky person, maybe you don't need to install any of the requirements bellow.

- Python 2: some Python 2.X is required because `buster` package doesn't support Python 3.
- [NodeJS](https://nodejs.org/en/): you should install a [NodeJS version that is officially supported by Ghost](http://support.ghost.org/supported-node-versions/). Node Version Manager (nvm) is recommended for many NodeJS versions on the same machine.
- [npm](https://nodejs.org/en/): NodeJS package manager.


### Minor dependencies

There's some other dependencies that should be installed in order to this script work fine, but I've made my best to automagically install these minor dependencies for you. This automated dependency installation has been tested on MacOS High Sierra and Ubuntu 16.04 and I hope that it work for you too.

**The minor dependencies are:**

- pip, the official Python package manager.
- buster, a Python package responsible for generating the static content from the Ghost server.
- knex-migrator, a Node package that serves as a database migration tool.

## Setup

**1) Download [the latest version from `ghost-on-github-pages` repository](https://github.com/paladini/ghost-on-github-pages/archive/master.zip).**
![image](https://user-images.githubusercontent.com/3361224/39668046-c66d1c90-5099-11e8-81d3-f8dd34527c58.png)

**2) Extract it anywhere. E.g: I've extract this file to `
#### 2) Extract it somewhere you'll remember. In my example, at `/home/paladini/ghost`.
![Extract the Ghost folder somewhere you'll remember](http://i.imgur.com/wFx9uEu.png)

#### 3) Open the Terminal and navigate to the extracted folder. Run `npm install`.
![Run "npm install". This step will take several minutes.](http://i.imgur.com/jUBPv3h.png)

#### 4) Now we've Ghost installed. Let's start it's localhost server running `npm start`:
![Run the Ghost server at localhost for the first time using "npm start"](http://i.imgur.com/m49izT3.png)

#### 5) Ghost now will be live at [http://localhost:2368](http://localhost:2368). Let's create your user and configure Ghost for the first time: go to [http://localhost:2368/ghost](http://localhost:2368/ghost) and follow the instructions.
![Follow the Ghost instructions for the first time install.](http://i.imgur.com/lss8Rbw.png)

#### 6) Now you are at the Ghost Administrative Panel, personalize your page and create the desired content.
![Ghost Administrative Panel](http://i.imgur.com/lXhbMJK.png)

#### 7) Go to [Github.com](http://www.github.com) and create a repository called `YOUR_USERNAME.github.io` (in my case it was [paladini.github.io](http://paladini.github.io)).
![Create a repository called "YOUR_USERNAME.github.io".](tutorial_images/ghost-at-github-create-repository.png)

#### 8) Download [this script](https://github.com/paladini/ghost-for-github-pages/blob/master/update_website.sh) and [this HTML page](https://raw.githubusercontent.com/paladini/ghost-on-github-pages/master/index.html) and put it inside Ghost folder. Open a terminal window, go the Ghost folder and run `chmod +x update_website.sh`.
![](tutorial_images/ghost-at-github-pages-for-free-index-script.png)

#### 9) Open another Terminal window and go to Ghost folder (in my case: `/home/paladini/ghost`). Run the following commands:

```sh
buster setup
buster generate
git init
git remote add origin git@github.com:YOUR_USERNAME/YOUR_USERNAME.github.io.git
git add -A
git commit -m "First commit"
git push origin master -f
```

#### 10) After about 10 minutes (according to Github Pages), your website will be live at [http://YOUR_USERNAME.github.io](http://YOUR_USERNAME.github.io). In my case, this is my page:
![](tutorial_images/ghost-at-github-pages-7.png)

## Updating the website [creating new posts, changing theme, etc.]
Whenever you want to create a new post, change the theme of the site (etc.), you should run `npm start` inside the Ghost folder to start the server at the localhost. Then you can go to [http://localhost:2368/ghost/](http://localhost:2368/ghost/) and do whatever you want to.

To send the changes to your page, just run `./update_website.sh` from the Terminal. Remember that Github takes about 10 minutes to update the website.

## About
This readme was created in less than one hour, so if it have any problems or you has some question in some topic, please contact me at fernandopalad at gmail dot com. Feel free to improve it or make any critics.

**References:**
- http://ledtechnica.com/free-ghost-hosting-on-github-pages/