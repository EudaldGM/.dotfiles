#!/bin/bash

#bash
#install wl-copy and wl-clipboard
touch ~/.bash_prompt
echo "source ~/.bash_aliases" >> ~/.bashrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc      
ln -fs ~/.dotfiles/nvimrc ~/.nvimrc

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/

#hyprland to omarchy
echo "source ~/.dotfiles/hyprland.conf" >> ~/.config/hypr/hyprland.conf

#[pending] install kubectl
#[pending] install go
#[pending] install npm
