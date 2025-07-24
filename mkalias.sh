#!/bin/bash

#dotfiles
ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/zshrc ~/.zshrc      
ln -s ~/.dotfiles/nvimrc ~/.nvimrc

#.conf files
ln -sr ~/.dotfiles/nvim .config/nvim

#ohmyzsh theme
ln -s af-magic-custom.zsh-theme ~/.oh-my-zsh/themes/af-magic-custom.zsh-theme
