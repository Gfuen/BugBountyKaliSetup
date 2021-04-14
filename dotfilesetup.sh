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
apt-get install -y 

#Make setup folder
echo -e "${GREEN}[*] Installing BugBounty Github${NC}"
cd /home/kali/Desktop/Bug
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.bashrc >> ~/.bashrc
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.tmux.conf >> ~/.tmux.conf
wget https://raw.githubusercontent.com/Gfuen/BugBountySetup/main/.vimrc >> ~/.vimrc

#Back up vim file
echo -e "${GREEN}[*] Backup VIM${NC}"
if [ -e .vimrc ]; then mv .vimrc .vimrc_bak; fi
if [ -e .vim ]; then mv .vim .vim_bak; fi

#Link files to Root folder for use
cp -rfv .vimrc .bashrc .tmux.conf ~/
sudo ln -sfv ~/.bashrc /root/.bashrc
sudo ln -sfv ~/.vimrc /root/.vimrc
sudo ln -sfv ~/.tmux.conf /root/.tmux.conf

#Install vundle
echo -e "${GREEN}[*] Installing Vundle${NC}"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Install Tmux plugin manager
echo -e "${GREEN}[*] Installing Tmux plugin manager${NC}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#Reload source files
source ~/.bashrc
source ~/.tmux.conf

#Install Vim Plugins
echo -e "${GREEN}[*] Installing VIM Plugins${NC}"
vim +PluginInstall +qall