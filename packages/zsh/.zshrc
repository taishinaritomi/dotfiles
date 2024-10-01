eval "$(starship init zsh)"
eval "$(sheldon source)"

. $(brew --prefix asdf)/libexec/asdf.sh

autoload -Uz compinit
compinit
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt no_beep
setopt correct
