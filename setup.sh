#!/bin/bash

BACKUP_DIR=$PWD/rc_backup

ORIGINAL_BASHRC=$HOME/.bashrc
ORIGINAL_ZSHRC=$HOME/.zshrc
ORIGINAL_VIMRC=$HOME/.vimrc
ORIGINAL_DIRCOLORS=$HOME/.dircolors
ORIGINAL_PROFILE=$HOME/.profile
ORIGINAL_XPROFILE=$HOME/.xprofile
ORIGINAL_GITCONFIG=$HOME/.gitconfig
ORIGINAL_FONTS=$HOME/.fonts
ORIGINAL_GNUPGCONF=$HOME/.gnupg/gpg.conf
ORIGINAL_MUTTRC=$HOME/.muttrc
ORIGINAL_AWESOME=$HOME/.config
PACKAGES=(
vim irssi libreoffice git curl gawk firefox firefox-l10n-en-gb thunderbird thunderbird-l10n-en-gb tig tree htop build-essential cmake synapse scrot i3lock zsh newrelic-sysmond chromium-browser spotify-client gparted gnupg pcscd libccid audacity powertop zip xclip vlc valgrind unzip ipython python3 qalculate openssh-server imagemagick lxappearance pipelight-multi dropbox openjdk-7-jre openjdk-7-jdk shutter nano keepassx ctags python3-numpy nmap python-appindicator ntfs-3g awesome
)

# Move all original files to a backup dir.
mkdir -p $BACKUP_DIR
mv \
    $ORIGINAL_BASHRC \
    $ORIGINAL_ZSHRC \
    $ORIGINAL_DIRCOLORS \
    $ORIGINAL_PROFILE \
    $ORIGINAL_XPROFILE \
    $ORIGINAL_GITCONFIG \
    $ORIGINAL_GNUPGCONF \
    $ORIGINAL_VIMRC	\
    $ORIGINAL_FONTS \
    $ORIGINAL_MUTTRC \
    $BACKUP_DIR

# Ensures all directories are existing
mkdir -p $HOME/.vim $HOME/.git $HOME/.gnupg $HOME/.config/awesome

# Scripts
ln -sf $PWD/scripts $HOME
ln -sf $PWD/loginscript $HOME/.loginscript

# Setup Symlinks for all files
ln -sf $PWD/bash/bashrc $ORIGINAL_BASHRC
ln -sf $PWD/zsh/zshrc $ORIGINAL_ZSHRC
ln -sf $PWD/vim/vimrc $ORIGINAL_VIMRC
ln -sf $PWD/bash/dircolors $ORIGINAL_DIRCOLORS
ln -sf $PWD/bash/profile $ORIGINAL_PROFILE
ln -sf $PWD/bash/xprofile $ORIGINAL_XPROFILE
ln -sf $PWD/git/gitconfig $ORIGINAL_GITCONFIG
ln -sf $PWD/gnupg/gpg.conf $ORIGINAL_GNUPGCONF
ln -sf $PWD/fonts $ORIGINAL_FONTS
ln -sf $PWD/mutt/muttrc $ORIGINAL_MUTTRC
ln -sf $PWD/awesome/ $ORIGINAL_AWESOME


# Install the newest updates for already installed packages
sudo apt-get --yes --force-yes upgrade

sudo dpkg --add-architecture i386

# Spotify
sudo add-apt-repository "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59

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
    sudo sh -c 'echo "deb http://linux.dropbox.com/debian/ wheezy main" >> /etc/apt/sources.list.d/dropbox.list'
fi

# (Real) Firefox
sudo apt-add-repository "deb http://packages.linuxmint.com debian import"
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 3EE67F3D0FF405B2
sudo apt-get remove --purge iceweasel

# Own key
sudo apt-key adv --keyserver hkp://keys.techwolf12.nl:80/ --recv-keys 2F2546D8
sudo apt-key adv --keyserver hkp://keys.techwolf12.nl:80/ --recv-keys 593E5934
# Instarr packages

sudo apt-get update

for i in "${PACKAGES[@]}"
do
    sudo apt-get --yes --force-yes install $i
done

sudo pipelight-plugin --enable silverlight

# Zsh
chsh -s /bin/zsh

# Gnome-keyring-daemon fix
sudo mv /etc/xdg/autostart/gnome-keyring-gpg.desktop /etc/xdg/autostart/gnome-keyring-gpg.desktop.disabled
sudo mv /etc/xdg/autostart/gnome-keyring-ssh.desktop /etc/xdg/autostart/gnome-keyring-ssh.desktop.disabled
sudo pkill gnome-keyring-daemon

# Add certificates
sudo mkdir /usr/share/ca-certificates/CA
sudo cp $PWD/CA/* /usr/share/ca-certificates/CA/
for f in CA/*; do sudo bash -c "echo \"$f\" >>/etc/ca-certificates.conf"; done
sudo update-ca-certificates

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

