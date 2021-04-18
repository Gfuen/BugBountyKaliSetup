#!/bin/bash

#Colors
GREEN='\033[0;32m'
NC='\033[0m'

# make sure we're root
if [[ $(id -u) == 0 ]]; then
  echo -e "${GREEN}[*] Running with SUDO${NC}"
else  echo 'Error: Sadly you need to run me with sudo.'
  exit 1
fi

#Install git if not installed
apt-get install -y git
apt-get install -y tmux
apt-get install -y vim

#Make setup folder
echo -e "${GREEN}[*] Installing BugBounty Github Dotfiles to Home Directory${NC}"
cd /tmp
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.bashrc 
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.tmux.conf 
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.vimrc 

#Back up vim and bash config files
echo -e "${GREEN}[*] Backup VIM and Bashrc${NC}"
if [ -e .vimrc ]; then mv .vimrc .vimrc_bak; fi
if [ -e .vim ]; then mv .vim .vim_bak; fi
if [ -e .bashrc ]; then mv .bashrc .bashrc_bak; fi

#Create dotfiles Directory
dotfilesDir=$(pwd)

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

#Install Tmux plugin manager
echo -e "${GREEN}[*] Installing Dotfiles${NC}"
linkDotfile .vimrc
linkDotfile .bashrc
linkDotfile .tmux.conf

mkdir -p $dotfilesDir/.vim/bundle
cd $dotfilesDir/.vim/bundle
git clone git://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

#Install Tmux plugin manager
echo -e "${GREEN}[*] Installing Tmux plugin manager${NC}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

