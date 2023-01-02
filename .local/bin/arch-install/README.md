# Installation
Scripts I use to automate my Arch Linux installation process.

First you need an internet connection and then you should install git
so you can clone this repo:

``` sh
# pacman -Sy git
```

Then you should modify `variables.sh` as it contains several environment
variables you should modify before running the first script.

After modifying the variables, run `pre-install.sh`. It automates Arch's
Installation Guide up until before the Installation phase.

After that finishes, run `install.sh` to continue with the process.
