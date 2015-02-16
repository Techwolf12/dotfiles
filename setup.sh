#!/bin/bash

BACKUP_DIR=$PWD/rc_backup

ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_ZSHRC=$HOME/.zshrc
ORIGINAL_VIMRC=$HOME/.vimrc
ORIGINAL_DIRCOLORS=$HOME/.dircolors
ORIGINAL_PROFILE=$HOME/.profile
ORIGINAL_GITCONFIG=$HOME/.gitconfig
ORIGINAL_FONTS=$HOME/.fonts
ORIGINAL_GNUPGCONF=$HOME/.gnupg/gpg.conf
ORIGINAL_MUTTRC=$HOME/.muttrc
ORIGINAL_IRSSI=$HOME/.irssi/irssi.conf
PACKAGES=(
    vim thunderbird irssi libreoffice git tig tree htop synapse scrot i3lock zsh newrelic-sysmond google-chrome-stable spotify-client gparted gnupg pcscd libccid audacity powertop zip xclip vlc valgrind unrar unzip ipython python3 qalculate openssh-server keepass2 imagemagick lxappearance compizconfig-settings-manager pipelight-multi dropbox oracle-java8-installer shutter nano keepassx ctags python3-numpy nmap python-appindicator ntfs-3g
)

# Move all original files to a backup dir.
mkdir -p $BACKUP_DIR
mv \
$ORIGINAL_BASHRC \
$ORIGINAL_IRSSI \
$ORIGINAL_ZSHRC \
$ORIGINAL_DIRCOLORS \
$ORIGINAL_PROFILE \
$ORIGINAL_GITCONFIG \
$ORIGINAL_GNUPGCONF \
$ORIGINAL_VIMRC	\
$ORIGINAL_FONTS \
$ORIGINAL_MUTTRC \
$BACKUP_DIR

# Ensures all directories are existing
mkdir -p $HOME/.vim $HOME/.git $HOME/.gnupg $HOME/.irssi

# Scripts
ln -sf $PWD/scripts $HOME
ln -sf $PWD/loginscript $HOME/.loginscript

# Setup Symlinks for all files
ln -sf $PWD/bash/bashrc $ORIGINAL_BASHRC
ln -sf $PWD/zsh/zshrc $ORIGINAL_ZSHRC
ln -sf $PWD/vim/vimrc $ORIGINAL_VIMRC
ln -sf $PWD/bash/dircolors $ORIGINAL_DIRCOLORS
ln -sf $PWD/bash/profile $ORIGINAL_PROFILE
ln -sf $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -sf $PWD/gnupg/gpg.conf $ORIGINAL_GNUPGCONF
ln -sf $PWD/fonts $ORIGINAL_FONTS
ln -sf $PWD/mutt/muttrc $ORIGINAL_MUTTRC

# Copy some files
cp $PWD/irssi/irssi.conf $HOME/.irssi/config

# Ask some finetuning questions
read -p "Do you wish to install the C/C++ compiler? [yn]" yn
    case $yn in
        [Yy]* ) packages+=(build-essential cmake); break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac

# Install the newest updates for already installed packages
sudo apt-get --yes --force-yes upgrade

sudo dpkg --add-architecture i386

# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
if [[ ! -e "/etc/apt/sources.list.d/google-chrome.list" ]];
then
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
fi
# Spotify
sudo add-apt-repository "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59


# Java
sudo add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"
sudo add-apt-repository "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# Pipelight
wget -O- http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Debian_7.0/Release.key | sudo apt-key add -
sudo apt-add-repository "deb http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Debian_7.0/ ./"

# Newrelic
sudo add-apt-repository "deb http://apt.newrelic.com/debian/ newrelic non-free"
wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -

# Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
if [[ ! -e "/etc/apt/sources.list.d/dropbox.list" ]];
then
    sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ trusty main" >> /etc/apt/sources.list.d/dropbox.list'
fi

# Own key
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 2F2546D8

# Instarr packages

sudo apt-get update

for i in "${PACKAGES[@]}"
do
    sudo apt-get --yes --force-yes install $i
done

sudo pipelight-plugin --enable silverlight

# Zsh
chsh -s /bin/zsh

# Import GPG key
gpg --card-edit / fetch quit

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# SSH keys
mkdir -p $HOME/.ssh
cp $PWD/ssh/{config,id_rsa.pub,id_ecdsa.pub} $HOME/.ssh/

# Install all secrets
gpg --output /tmp/secrets.sh --decrypt $PWD/secrets/secrets.sh.gpg
sh /tmp/secrets.sh

