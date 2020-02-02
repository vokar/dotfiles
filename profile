#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.local/bin` and all subdirectories to $PATH
bin_sub_dirs="$(fd -t d . $HOME/.local/bin | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$bin_sub_dirs"

# Default programs:
export BROWSER="firefox"
export EDITOR="nvim"
export FILE="lf"
export PAGER="less -R"
export BAT_PAGER="less -Rs"
export MANPAGER='bat -l man -p'
export TERMINAL="st"
export READER="zathura"
export STATUSBAR="i3blocks"

# ~/ Clean-up:
export XAUTHORITY="$HOME/.config/Xauthority"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export INPUTRC="$HOME/.config/inputrc"
export ZDOTDIR="$HOME/.config/zsh"

# Other program settings:
export TERMINFO="$HOME/.config/terminfo"
export LARBSWM="i3"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export SKIM_DEFAULT_OPTIONS='--height 40% --layout=reverse'
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '')"
export LESS_TERMCAP_md="$(printf '%b' '')"
export LESS_TERMCAP_me="$(printf '%b' '')"
export LESS_TERMCAP_so="$(printf '%b' '')"
export LESS_TERMCAP_se="$(printf '%b' '')"
export LESS_TERMCAP_us="$(printf '%b' '')"
export LESS_TERMCAP_ue="$(printf '%b' '')"

mpd >/dev/null 2>&1 &

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ~/.local/share/larbs/ttymaps.kmap 2>/dev/null

export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf="
