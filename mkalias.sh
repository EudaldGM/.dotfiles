#!/bin/bash

#bash
#install wl-copy and wl-clipboard
ln -fs ~/.dotfiles/bash_aliases ~/.bash_aliases
ln -fs ~/.dotfiles/zshrc ~/.zshrc      
ln -fs ~/.dotfiles/nvimrc ~/.nvimrc

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/
ln -fs ~/.dotfiles/init.lua ~/.config/nvim

#ohmyzsh theme
cp ~/.dotfiles/af-magic-custom.zsh-theme ~/.oh-my-zsh/themes


#hyprland
ln -fsr ~/.dotfiles/hypr ~/.config/

#waybar
ln -fsr ~/.dotfiles/waybar ~/.config/

#[pending] install mise
#[pending] install fzf
#[pending] install kubectl
#[pending] install waybar
#[pending] install cargo
#[pending] install go
#[pending] install python
#[pending] install 
