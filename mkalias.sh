#!/usr/bin/env bash

set -euo pipefail

DOTFILES="~/.dotfiles"

mkdir -p ~/.config ~/.tmux/plugins

# shell
touch ~/.bash_prompt
echo "source ~/.bash_aliases" >> ~/.bashrc
ln -fs ~/.dotfiles/zshrc ~/.zshrc
ln -fs ~/.dotfiles/bash_aliases ~/.bash_aliases

#mise
ln -fsr ~/.dotfiles/config.toml ~/.config/mise/config.toml

#nvim
ln -fsr ~/.dotfiles/nvim ~/.config/

#tmux
ln -fsr ~/.dotfiles/tmux ~/.config/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#alacritty
ln -fsr ~/.dotfiles/alacritty/ ~/.config/


#starship
ln -fsr ~/.dotfiles/starship.toml ~/.config

if ! command -v mise >/dev/null 2>&1; then
	curl -fsSL https://mise.run | sh
fi

export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"

mise use -g go node ripgrep fzf eza usage zoxide kubectl kubectx kubens lazygit neovim zls zig yazi python

sudo apt-get update
sudo apt-get install -y \
	git \
	zsh \
	tmux \
	make \
	wl-clipboard \
	curl \
	unzip \
	fontconfig

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerd"
if [ ! -d "$FONT_DIR" ]; then
	mkdir -p "$FONT_DIR"
	curl -fLo /tmp/JetBrainsMono.zip \
		https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
	unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR" >/dev/null
	rm -f /tmp/JetBrainsMono.zip
	fc-cache -f "$FONT_DIR"
fi

git config --global user.email "eudaldguillen@gmail.com"
git config --global user.name "EudaldGM"

[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

grep -qxF '[alias]' ~/.gitconfig 2>/dev/null || cat >> ~/.gitconfig <<'EOF'
[alias]
  url = !bash -c 'git config --get remote.origin.url | sed -E "s/.+:\\(.+\\)\\.git$/https:\\/\\/github\\.com\\/\\1/g"'
EOF

echo "Done."
