#!/bin/bash

#install wl-clipboard
#install zsh
#install ohmyzsh
#install tmux

touch ~/.bash_prompt
echo "source ~/.bash_aliases" >> ~/.bashrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc      
ln -fs ~/.dotfiles/nvimrc ~/.nvimrc

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#Custom theme
cp ~/.dotfiles/af-magic-custom.zsh-theme ~/.oh-my-zsh/custom/themes/

#hyprland to omarchy
echo "source ~/.dotfiles/hyprland.conf" >> ~/.config/hypr/hyprland.conf

if ! command -v <the_command> >/dev/null 2>&1
then
	curl https://mise.run | sh
fi
mise use -g go node ripgrep fzf eza usage zoxide kubectl lazygit

