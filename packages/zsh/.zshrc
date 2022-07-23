eval "$(starship init zsh)"

. /usr/local/opt/asdf/libexec/asdf.sh

if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit && compinit

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt no_beep
setopt correct

alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcup-dev='docker-compose -f docker-compose.dev.yml up -d'
alias dcdown="docker-compose down --rmi all --volumes --remove-orphans"
alias dcex="(){docker-compose exec $1 ash -c $2}"
alias ll='ls -l'
alias la='ls -a'
