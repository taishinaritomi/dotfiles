#!/bin/bash -e

set -u

cd ~

which xcode-select &>/dev/null || xcode-select --install

which brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ "$(uname -m)" = "arm64" ] ; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

find ~/Dotfiles &>/dev/null || git clone https://github.com/taishinaritomi/dotfiles.git

brew bundle -v --file=~/Dotfiles/packages/brew/.Brewfile

stow --adopt -v -d ~/Dotfiles/packages -t ~ git starship brew sheldon zsh mise

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

stow --adopt -v -d ~/Dotfiles/packages -t "$VSCODE_USER_DIR" vscode

ZSH_PATH=$(which zsh)

grep -c -q $ZSH_PATH /etc/shells &>/dev/null || {
  sudo sh -c "echo $ZSH_PATH >> /etc/shells"
}

chsh -s $ZSH_PATH

mise install
