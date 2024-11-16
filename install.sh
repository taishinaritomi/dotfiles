#!/bin/sh -e

cd ~

which xcode-select &>/dev/null || xcode-select --install

which brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ "$(uname -m)" = "arm64" ] ; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

find ~/dotfiles &>/dev/null || git clone https://github.com/taishinaritomi/dotfiles.git

brew bundle -v --file=~/dotfiles/packages/brew/.Brewfile

stow --adopt -v -d ~/dotfiles/packages -t ~ fish git starship brew asdf sheldon zsh wezterm

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

stow --adopt -v -d ~/dotfiles/packages -t "$VSCODE_USER_DIR" vscode

FISH_PATH=$(which fish)

grep -c -q $FISH_PATH /etc/shells &>/dev/null || {
  sudo sh -c "echo $FISH_PATH >> /etc/shells"
}

ZSH_PATH=$(which zsh)

grep -c -q $ZSH_PATH /etc/shells &>/dev/null || {
  sudo sh -c "echo $ZSH_PATH >> /etc/shells"
}

chsh -s $ZSH_PATH
