# Ghost for Github Pages
![Ghost is an awesome open-source blogging plataform. Now you can host it for free at Github Pages.](http://i.imgur.com/3ACSCiW.jpg)
![Ghost is an awesome open-source blogging plataform. Now you can host it for free at Github Pages.](https://cloud.githubusercontent.com/assets/120485/6626501/b2bb072c-c8ff-11e4-8e1a-2e78e68fd5c3.png)

[Ghost](https://github.com/tryghost/Ghost) is a simple, powerful publishing platform that allows you to share your stories with the world. It usually needs a paid host, but there's some ways to host your Ghost installation at Github Pages, for free. 

In order to create your own Ghost blog for free and host it at Github pages, check the following instructions. These instructions were tested within Linux, if you know how to make it work for Windows or Mac OS, please let me know and I'll add the instructions here.

**Example of working project:** https://github.com/paladini/paladini.github.io

## Prerequisites
Before we start, you need to install some prerequisites:
- *[pip](https://pip.pypa.io/en/stable/quickstart/)*, the Python package manager. Python 2.7.9 and later comes with *pip* by default, so it won't will bother you.
- *[buster](https://pypi.python.org/pypi/buster/0.1.3)*, a Python package. To install buster, open the Terminal and run `pip install buster`.
- *[npm](https://nodejs.org/en/)*, the NodeJS package manager. Download NodeJS and install it. NPM is part of NodeJS. 

## Installing for the first time
#### 1) Download the latest version of Ghost at [Ghost download page](https://ghost.org/download/).
![Download the latest version of Ghost](http://i.imgur.com/eO6a2UR.png)

#### 2) Extract it somewhere you'll remember. In my example, at `/home/paladini/ghost`.
![Extract the Ghost folder somewhere you'll remember](http://i.imgur.com/wFx9uEu.png)

#### 3) Open the Terminal and navigate to the extracted folder. Run `npm install`.
![Run "npm install". This step will take several minutes.](http://i.imgur.com/jUBPv3h.png)

#### 4) Now we've Ghost installed. Let's start it's localhost server running `npm start`:
![Run the Ghost server at localhost for the first time using "npm start"](http://i.imgur.com/m49izT3.png)

#### 5) Ghost now will be live at [http://localhost:2368](http://localhost:2368). Let's create your user and configure Ghost for the first time: go to [http://localhost:2368/ghost](http://localhost:2368/ghost) and follow the instructions.
![](http://i.imgur.com/lss8Rbw.png)

#### 6) Now you are at the Ghost Administration Panel, personalize your page and create the desired content.
![](http://i.imgur.com/lXhbMJK.png)

#### 7) Go to [Github.com](http://www.github.com) and create a repository called `YOUR_USERNAME.github.io` (in my case it was [paladini.github.io](http://paladini.github.io)). 

#### 8) Open another Terminal window and go to Ghost folder (in my case: `/home/paladini/ghost`). Run the following commands:

```sh
buster setup
buster generate
ln static/index.html index.html
git init
git remote add origin git@github.com:YOUR_USERNAME/YOUR_USERNAME.github.io.git
git add -A
git commit -m "Firs commit"
git push origin master -f
```

#### 9) Download [this script](https://gist.githubusercontent.com/paladini/8872c346c514b513dbfd/raw/b06dcf6705ee59fd6045945de87201ce6ce02faa/update_website.sh) and put it inside Ghost folder. Open a terminal window, go the Ghost folder and run `chmod +x update_website.sh`.

## Updating the website [creating new posts, changing theme, etc.]
Whenever you want to create a new post, change the theme of the site (etc.), you should run `npm start` inside the Ghost folder to start the server at the localhost. Then you can go to [http://localhost:2368/ghost/](http://localhost:2368/ghost/) and do whatever you want to.

To send the changes to your page, just run `./update_website.sh` from the Terminal. According to Github Pages, your changes will take effect after ~10 minutes. You can check your online page at [http://YOUR_USERNAME.github.io](http://YOUR_USERNAME.github.io).

## About
This readme was created in less than one hour, so if it have any problems or you has some question in some topic, please contact me at fernandopalad at gmail dot com. Feel free to improve it or make any critics.

**References:**
- http://ledtechnica.com/free-ghost-hosting-on-github-pages/
