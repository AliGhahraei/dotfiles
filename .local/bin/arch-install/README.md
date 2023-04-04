# Installation
Scripts I use to automate my Arch Linux installation process.

First you need an internet connection and then you should install git
so you can clone this repo:

``` sh
# pacman -Sy git
```

Then you should modify `variables.sh` as it contains several environment
variables you should modify before running the first script.

After modifying the variables, run `entrypoint.sh`. It automates Arch's
Installation Guide and does a few extra tasks like setting up a user.

