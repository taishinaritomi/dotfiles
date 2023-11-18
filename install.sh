#!/bin/sh -e

cd ~

defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

which xcode-select &>/dev/null || xcode-select --install

which brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

find ~/dotfiles &>/dev/null || git clone git@github.com:taishinaritomi/dotfiles.git

find ~/.config &>/dev/null || cd ~ && mkdir -p .config

brew bundle -v --file=~/dotfiles/packages/brew/.Brewfile

for file in ~/.config/config.fish  ~/.gitconfig ~/.config/starship.toml ~/.Brewfile ~/.tool-versions ; do
  rm -rf "${file}"
done
stow -v -d ~/dotfiles/packages -t ~ fish git starship brew kitty asdf

grep -c -q '/usr/local/bin/fish' /etc/shells &>/dev/null || {
  sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
  chsh -s '/usr/local/bin/fish'
}

find ~/Library/Application\ Support/Code/User &>/dev/null || cd ~ && mkdir -p ~/Library/Application\ Support/Code/User
rm -rf ~/Library/Application\ Support/Code/User/settings.json
rm -rf ~/Library/Application\ Support/Code/User/keybindings.json
rm -rf ~/Library/Application\ Support/Code/User/snippets
stow -v -d ~/dotfiles/packages -t ~/Library/Application\ Support/Code/User/ vscode
