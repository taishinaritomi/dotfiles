eval "$(starship init zsh)"
eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(atuin init zsh)"

autoload -Uz compinit

compinit

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt no_beep
setopt correct
