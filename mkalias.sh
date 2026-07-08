#!/bin/bash

#install wl-clipboard
#install zsh
#install tmux
#install make
#install starship
#install gtklock
#install waybar
#install vicinae
#install swaybg
#install mako
#install git
#install gh
#install rustup

touch ~/.bash_prompt
echo "source ~/.bash_aliases" >> ~/.bashrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc
ln -fs ~/.dotfiles/bash_aliases ~/.bash_aliases

#Mise
if ! command -v mise >/dev/null 2>&1
then
	curl -fsSL https://mise.run | sh
fi

#git
git config --global user.email "eudaldguillen@gmail.com"
git config --global user.name "EudaldGM"

mise use -g go node ripgrep fzf eza usage zoxide kubectl kubectx kubens lazygit neovim zls zig yazi python

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#alacritty
ln -fsr ~/.dotfiles/alacritty/ ~/.config/


#starship
ln -fsr ~/.dotfiles/starship.toml ~/.config

#waybar
ln -fsr ~/.dotfiles/waybar ~/.config

#vicinae
ln -fsr ~/.dotfiles/vicinae ~/.config

#mako
ln -fsr ~/.dotfiles/mako ~/.config
systemctl --user add-wants niri.service mako.service
systemctl --user add-wants niri.service waybar.service


#misc
echo "[alias]
  url = !bash -c 'git config --get remote.origin.url | sed -E \"s/.+:\\(.+\\)\\.git$/https:\\/\\/github\\.com\\/\\1/g\"'
" >> ~/.gitconfig
