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
ORIGINAL_MUTTRC=$HOME/.muttrc
PACKAGES=(
    vim libreoffice git tig tree htop synapse zsh google-chrome-stable gparted gnupg pcscd libccid audacity powertop zip xclip vlc valgrind unrar unzip ipython python3 qalculate openssh-server keepass2 imagemagick lxappearance compizconfig-settings-manager pipelight-multi dropbox oracle-java8-installer google-talkplugin shutter skype nano keepassx ctags python3-numpy nmap python-appindicator ntfs-3g
)

# Move all original files to a backup dir.
mkdir -p $BACKUP_DIR
mv \
$ORIGINAL_BASHRC \
$ORIGINAL_ZSHRC \
$ORIGINAL_DIRCOLORS \
$ORIGINAL_PROFILE \
$ORIGINAL_GITCONFIG \
$ORIGINAL_GNUPGCONF \
$ORIGINAL_VIMRC	\
$ORIGINAL_FONTS \
$ORIGINAL_MUTTRC \
$BACKUP_DIR

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

if [[ ! -e "/etc/apt/sources.list.d/google-talkplugin.list" ]];
then
    sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google-talkplugin.list'
fi

# Skype
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

# Java
sudo add-apt-repository ppa:webupd8team/java

# Pipeline
sudo apt-add-repository ppa:pipelight/stable

# Dropbox
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
if [[ ! -e "/etc/apt/sources.list.d/dropbox.list" ]];
then
    sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ trusty main" >> /etc/apt/sources.list.d/dropbox.list'
fi

sudo apt-get update

for i in "${PACKAGES[@]}"
do
    sudo apt-get --yes --force-yes install $i
done

sudo pipelight-plugin --enable silverlight

# Zsh
chsh -s /bin/zsh

# Import GPG key
wget -o /tmp/2F2546D8.asc http://techwolf12.nl/keys/2F2546D8.asc
gpg --import /tmp/2F2546D8.asc

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Install New Relic monitor
#gpg --output /tmp/newrelic.sh --decrypt $PWD/packages/newrelic.sh.gpg
#sh /tmp/newrelic.sh

# SSH keys
mkdir $HOME/.ssh
gpg --output $HOME/.ssh/id_ecdsa --decrypt $PWD/ssh/id_ecdsa.gpg
gpg --output $HOME/.ssh/id_rsa --decrypt $PWD/ssh/id_rsa.gpg
chmod 600 $HOME/.ssh/id_*
cp $PWD/ssh/{config,id_rsa.pub,id_ecdsa.pub} $HOME/.ssh/

