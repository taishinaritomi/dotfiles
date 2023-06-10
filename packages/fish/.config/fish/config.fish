if status is-interactive
    eval (/usr/local/bin/brew shellenv)
end

starship init fish | source

source /usr/local/opt/asdf/libexec/asdf.fish
