#!/bin/bash

#bash
#install wl-copy and wl-clipboard
touch ~/.bash_prompt
ln -fs ~/.dotfiles/bash_aliases ~/.bash_aliases
ln -fs ~/.dotfiles/zshrc ~/.zshrc      
ln -fs ~/.dotfiles/nvimrc ~/.nvimrc

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/

#hyprland to omarchy
echo "source ~/.dotfiles/hyprland.conf" >> ~/.config/hypr/hyprland.conf
#[pending] setuo fzf and fzf tooling
#[pending] install mise
#[pending] install fzf
#[pending] install kubectl
#[pending] install waybar
#[pending] install cargo
#[pending] install go
#[pending] install python
#[pending] install btop
#[pending] install nerdfonts
#[pending] install 
