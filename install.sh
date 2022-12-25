#!/bin/sh -e

cd ~

which brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

find ~/dotfiles &>/dev/null || git clone git@github.com:taishinaritomi/dotfiles.git

find ~/.config &>/dev/null || cd ~ && mkdir -p .config

brew bundle -v --file=~/dotfiles/packages/brew/.Brewfile

for file in ~/.zshrc ~/.gitconfig ~/.config/starship.toml ~/.Brewfile ~/.tool-versions ~/.vscode_extensions ; do
  rm -rf "${file}"
done
stow -v -d ~/dotfiles/packages -t ~ zsh git starship brew vscode_extensions kitty asdf

grep -c -q '/usr/local/bin/zsh' /etc/shells &>/dev/null || {
  sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s '/usr/local/bin/zsh'
}

find ~/Library/Application\ Support/Code/User &>/dev/null || cd ~ && mkdir -p ~/Library/Application\ Support/Code/User
rm -rf ~/Library/Application\ Support/Code/User/settings.json
rm -rf ~/Library/Application\ Support/Code/User/keybindings.json
rm -rf ~/Library/Application\ Support/Code/User/snippets
stow -v -d ~/dotfiles/packages -t ~/Library/Application\ Support/Code/User/ vscode
cat ~/dotfiles/packages/vscode_extensions/.vscode_extensions | while read line
do
  code --install-extension $line
done
