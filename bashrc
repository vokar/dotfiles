#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="[\[$(tput sgr0)\]\[\033[38;5;104m\]\t\[$(tput sgr0)\]\[\033[38;5;15m\]] \[\033[38;5;186m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n  \[$(tput sgr0)\]\[\033[38;5;104m\]λ\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
