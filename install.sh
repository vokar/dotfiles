#!/bin/sh

# Determine the right directory even if ran through symlink
DOTFILES="$(dirname "$(readlink -f "$0")")"
DOTFILES_SRC="$DOTFILES/src"
CURRENT_DATE="$(date "+%Y_%m_%d-%H_%M_%S")"
DOTFILES_BACKUP="$DOTFILES/backup/$CURRENT_DATE"
BACKUP_SUFFIX=".dotfiles-$CURRENT_DATE"

print_header() { printf "\n\033[1m%s\033[0m\n" "$*"; }

print_header "Using $DOTFILES_SRC as the source directory containing the following:"
cd "$DOTFILES_SRC" || exit
// exa -aT
tree -a

print_header "Creating necessary directories in $HOME"
fdfind --hidden --type directory --exec-batch mkdir -pv "$HOME/{}"

print_header "Creating symlinks and backing up existing files"
fdfind --hidden --type file --exec ln -srbv -S "$BACKUP_SUFFIX" {} "$HOME/{}"

print_header "Removing broken symlinks"
fdfind --hidden --type symlink --exec-batch rm -v {} \; "$BACKUP_SUFFIX" "$HOME"

print_header "Moving backups to the backup directory"
mkdir -pv "$DOTFILES_BACKUP"
fdfind --hidden --type file --exec-batch mv -v {} "$DOTFILES_BACKUP" \; "$BACKUP_SUFFIX" "$HOME"

print_header "Removing backups' suffix"
fdfind --hidden --type file --exec-batch rename -v "$BACKUP_SUFFIX" '' {} \; . "$DOTFILES_BACKUP"

# Install packages
# sudo xbps-install $(xsv select NAME packages.csv | tail -n +2 | tr '\n' ' ')
