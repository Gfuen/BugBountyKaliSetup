#!/bin/bash
# make sure we're root
if [ "$HOME" != "/root" ]
then
    printf "Please run while logged in as root\n"
    exit 1
fi

#Colors
GREEN='\033[0;32m'
NC='\033[0m'

#Install dependencies
apt-get update

#Install xterm
apt-get install xterm

#Install pip3
apt-get install -y python3-pip

#Install venv for pipx virtual environments
apt-get install -y python3-venv

#Install pipx 
xterm -e bash -c 'python3 -m pip install pipx; python3 -m pipx ensurepath'

#Make bash default shell
chsh -s /bin/bash

# Make sure pipx is installed
if pip list | grep -F pipx &> /dev/null; then
    echo -e "${GREEN}[*] Pipx installed${NC}"
else
    echo 'uh oh. Pipx is not installed.'
    exit 1
fi

#Install rlwrap for netcat reverse shells
apt-get install rlwrap

#Install other dependencies
apt-get install -y gnome-screenshot
apt-get install -y golang
apt-get install -y powershell
apt-get install -y xclip
apt-get install -y cmake
apt-get install -y grc
apt-get install -y awscli
apt-get install -y build-essential
apt-get install -y gcc 
apt-get install -y git
apt-get install -y vim 
apt-get install -y wget 
apt-get install -y curl
apt-get install -y inetutils-ping 
apt-get install -y make 
apt-get install -y nmap 
apt-get install -y whois 
apt-get install -y python-pip 
apt-get install -y perl 
apt-get install -y nikto
apt-get install -y dnsutils 
apt-get install -y net-tools
apt-get install -y zsh
apt-get install -y nano
apt-get install -y tmux

#Need to uninstall
#sudo rm /usr/bin/lsb_release

#Install ferox buster
apt install -y feroxbuster

#Install pure-ftpd
apt install -y pure-ftpd

#Install fcrackzip for cracking zip files with passwords
apt-get install fcrackzip

#Install gnumeric for converting excel files
apt-get -y install gnumeric

#Install seclists for passwords
apt-get install seclists

#Install sshuttle
apt-get install -y sshuttle

#Install rinetd for Port forwarding and such
apt install rinetd 

#Install Python ssl module
sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

#Install fzf for CommandLine
apt-get install fzf

#Install exa
apt install exa

# enable command aliasing
shopt -s expand_aliases

#Reinstall vim 
sudo apt install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python2-dev \
python3-dev ruby-dev lua5.2 liblua5.2-dev libperl-dev git 

sudo apt remove -y vim vim-runtime gvim 
sudo apt remove -y vim-tiny vim-common vim-gui-common vim-nox 
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local


make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
cd ~/vim
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim


#Make folders
cd /home/kali/Desktop/
mkdir -p PWK

#Create Tools Dir
cd ~/
mkdir -p Tools
mkdir -p Scripts

#Add Scripts to Directory for PrivEsc 
cd ~/Scripts
git clone https://github.com/HarmJ0y/PowerUp.git
git clone https://github.com/M4ximuss/Powerless.git
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/winPEAS.git
git clone https://github.com/rasta-mouse/Watson.git
git clone https://github.com/bitsadmin/wesng.git
git clone https://github.com/diego-treitos/linux-smart-enumeration.git
git clone https://github.com/cwinfosec/revshellgen

#dont use option -e on suidenum
mkdir -p SUID
cd ~/Scripts/SUID
wget https://raw.githubusercontent.com/Anon-Exploiter/SUID3NUM/master/suid3num.py --no-check-certificate && chmod 777 suid3num.py

#Install python2to3
python3 -m pipx install 2to3

#Install tldr 
python3 -m pipx install tldr.py

#Install Impacket
python3 -m pipx install git+https://github.com/SecureAuthCorp/impacket.git
python3 -m pipx ensurepath

#Install bloodhound
python3 -m pipx install bloodhound
python3 -m pipx ensurepath

#Make setup folder
cd /home/kali/Desktop/PWK
git clone https://github.com/Gfuen/BugBounty.git

#Init Metasploit
systemctl start postgresql
systemctl enable postgresql
msfdb init

#Unzip Rockyou
gunzip /usr/share/wordlists/rockyou.txt.gz 2>/dev/null
ln -s /usr/share/wordlists ~/Downloads/wordlists 2>/dev/null

#Install packages for dirsearch
python3 -m pipx install urllib3
python3 -m pipx install chardet
python3 -m pipx install certifi

#Install dirsearch and correct requester.py
cd ~/Tools
git clone https://github.com/maurosoria/dirsearch.git

#Install Autorecon
python3 -m pipx install git+https://github.com/Tib3rius/AutoRecon.git
python3 -m pipx ensurepath

#Install Nishang
cd ~/Tools
git clone https://github.com/samratashok/nishang.git

#Install Chisel binaries
cd ~/Tools
git clone https://github.com/jpillora/chisel/releases/download/v1.7.4/chisel_1.7.4_linux_amd64.gz
git clone https://github.com/jpillora/chisel/releases/download/v1.7.4/chisel_1.7.4_windows_amd64.gz

#Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Back up vim file
if [ -e .vimrc ]; then mv .vimrc .vimrc_bak; fi
if [ -e .vim ]; then mv .vim .vim_bak; fi

#Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#Replace Config files
cd /home/kali/Desktop/PWK/Setup
dos2unix .bashrc
dos2unix .vimrc
dos2unix .tmux.conf
cp -rfv .vimrc .bashrc .tmux.conf ~/
sudo ln -sfv ~/.bashrc /root/.bashrc
sudo ln -sfv ~/.vimrc /root/.vimrc

#Install Vim Plugins
vim +PluginInstall +qall

#Refresh bash profile before installing pyenv
source ~/.bashrc

#Install pyenv
apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
