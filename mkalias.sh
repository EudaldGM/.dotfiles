#!/bin/bash

#install wl-clipboard
#install zsh
#install tmux

touch ~/.bash_prompt
echo "source ~/.bash_aliases" >> ~/.bashrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc      

#Mise
if ! command -v mise >/dev/null 2>&1
then
	curl -fsSL https://mise.run | sh
fi
mise use -g go node ripgrep fzf eza usage zoxide kubectl lazygit nvim

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#kitty
ln -fsr ~/.dotfiles/kitty/ ~/.config/

#Custom theme
cp ~/.dotfiles/af-magic-custom.zsh-theme ~/.oh-my-zsh/custom/themes/

#hyprland to omarchy
echo "source ~/.dotfiles/hyprland.conf" >> ~/.config/hypr/hyprland.conf

if ! command -v mise >/dev/null 2>&1
then
	curl -fsSL https://mise.run | sh
fi
mise use -g go node ripgrep fzf eza usage zoxide kubectl lazygit

#starship
ln -fsr ~/.dotfiles/starship ~/.config
