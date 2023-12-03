#!/bin/sh -e

cd ~

defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

which xcode-select &>/dev/null || xcode-select --install

which brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ "$(uname -m)" = "arm64" ] ; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

find ~/dotfiles &>/dev/null || git clone git@github.com:taishinaritomi/dotfiles.git


brew bundle -v --file=~/dotfiles/packages/brew/.Brewfile

find ~/.config &>/dev/null || cd ~ && mkdir -p .config

for file in ~/.config/config.fish  ~/.gitconfig ~/.config/starship.toml ~/.Brewfile ~/.tool-versions ; do
  rm -rf "${file}"
done
stow -v -d ~/dotfiles/packages -t ~ fish git starship brew kitty asdf

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
find "$VSCODE_USER_DIR" &>/dev/null || mkdir -p "$VSCODE_USER_DIR"
rm -rf "$VSCODE_USER_DIR/settings.json"
rm -rf "$VSCODE_USER_DIR/keybindings.json"
rm -rf "$VSCODE_USER_DIR/snippets"
stow -v -d ~/dotfiles/packages -t "$VSCODE_USER_DIR" vscode


if [[ $(uname -m) == "arm64" ]]; then
    FISH_PATH="/opt/homebrew/bin/fish"
else
    FISH_PATH="/usr/local/bin/fish"
fi

grep -c -q $FISH_PATH /etc/shells &>/dev/null || {
  sudo sh -c "echo $FISH_PATH >> /etc/shells"
}

chsh -s $FISH_PATH
