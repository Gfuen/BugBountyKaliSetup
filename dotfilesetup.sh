#!/bin/bash

# make sure we're root
if [ "$HOME" != "/root" ]
then
    echo -e "${GREEN}[*] Please run as root.${NC}"
    exit 1
fi

#Install git if not installed
apt-get install -y git
apt-get install -y tmux
apt-get install -y vim

#Make setup folder
echo -e "${GREEN}[*] Installing BugBounty Github Dotfiles to Home Directory${NC}"
cd $HOME
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.bashrc 
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.tmux.conf 
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.vimrc 

#Back up vim file
echo -e "${GREEN}[*] Backup VIM${NC}"
if [ -e .vimrc ]; then mv .vimrc .vimrc_bak; fi
if [ -e .vim ]; then mv .vim .vim_bak; fi

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

