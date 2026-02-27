#!/bin/bash

#install wl-clipboard
#install zsh
#install tmux
#install gtklock
#install waybar
#install vicinae

touch ~/.bash_prompt
echo "source ~/.bash_aliases" >> ~/.bashrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc      
ln -fs ~/.dotfiles/bash_aliases ~/.bash_aliases

#Mise
if ! command -v mise >/dev/null 2>&1
then
	curl -fsSL https://mise.run | sh
fi

mise use -g go node ripgrep fzf eza usage zoxide kubectl kubectx kubens lazygit nvim zls zig yazi

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#alacritty
ln -fsr ~/.dotfiles/alacritty/ ~/.config/


#starship
ln -fsr ~/.dotfiles/starship ~/.config

#waybar
ln -fsr ~/.dotfiles/waybar ~/.config

#vicinae
ln -fsr ~/.dotfiles/vicinae ~/.config
