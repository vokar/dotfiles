#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.local/bin` and all subdirectories to $PATH
bin_sub_dirs="$(fd -t d . $HOME/.local/bin | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$bin_sub_dirs"

# Default programs
export BROWSER="firefox"
export EDITOR="nvim"
export FILE="lf"
export PAGER="less -R"
export BAT_PAGER="less -Rs"
export MANPAGER='nvim +Man!'
export TERMINAL="st"
export READER="zathura"

# Home dir clean-up
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.local/cache"
export XDG_RUNTIME_DIR="$HOME/.local/runtime"
export XDG_CONFIG_HOME="$HOME/.config"
export XAUTHORITY="$XDG_CONFIG_HOME/Xauthority"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"

# Other programs' settings
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export LESS=-R
export LESSHISTFILE="-"

# Start graphical server on tty1 if not already running;
# otherwise switch escape and caps for comfortable work in tty
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$(pgrep -x Xorg)" ]; then
    exec startx
else
    sudo -n loadkeys ~/.local/share/ttymaps.kmap
fi
