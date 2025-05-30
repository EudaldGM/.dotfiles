#!/bin/bash

#dotfiles
ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/zshrc ~/.zshrc      
ln -s ~/.dotfiles/nvimrc ~/.nvimrc

#.conf files
ln -sr ~/.dotfiles/nvim .config/nvim
