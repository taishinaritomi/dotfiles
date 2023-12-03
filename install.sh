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

find ~/.config &>/dev/null || cd ~ && mkdir -p .config

brew bundle -v --file=~/dotfiles/packages/brew/.Brewfile

for file in ~/.config/config.fish  ~/.gitconfig ~/.config/starship.toml ~/.Brewfile ~/.tool-versions ; do
  rm -rf "${file}"
done
stow -v -d ~/dotfiles/packages -t ~ fish git starship brew kitty asdf

if [[ $(uname -m) == "arm64" ]]; then
    FISH_PATH="/opt/homebrew/bin/fish"
else
    FISH_PATH="/usr/local/bin/fish"
fi

grep -c -q $FISH_PATH /etc/shells &>/dev/null || {
  sudo sh -c "echo $FISH_PATH >> /etc/shells"
}

chsh -s $FISH_PATH

find ~/Library/Application\ Support/Code/User &>/dev/null || cd ~ && mkdir -p ~/Library/Application\ Support/Code/User
rm -rf ~/Library/Application\ Support/Code/User/settings.json
rm -rf ~/Library/Application\ Support/Code/User/keybindings.json
rm -rf ~/Library/Application\ Support/Code/User/snippets
stow -v -d ~/dotfiles/packages -t ~/Library/Application\ Support/Code/User/ vscode
