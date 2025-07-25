#!/bin/bash

#dotfiles
ln -fs ~/.dotfiles/bash_aliases ~/.bash_aliases
ln -fs ~/.dotfiles/zshrc ~/.zshrc      
ln -fs ~/.dotfiles/nvimrc ~/.nvimrc

#.conf files
ln -fsr ~/.dotfiles/nvim ~/.config/
ln -fs ~/.dotfiles/init.lua ~/.config/nvim

#ohmyzsh theme
cp ~/.dotfiles/af-magic-custom.zsh-theme ~/.oh-my-zsh/themes
