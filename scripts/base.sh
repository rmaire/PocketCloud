#apt-get remove --purge -y virtualbox-guest-x11* xserver-common* xserver-xorg-core* x11-* xfonts-*
#apt-get -y autoremove

apt-get update -y
apt-get upgrade --no-install-recommends -y
apt-get install --no-install-recommends -y build-essential bsdtar curl wget git-core python-software-properties unzip debconf-utils

locale-gen de_CH.utf8
update-locale LANG=de_CH.UTF-8 LC_MESSAGES=POSIX