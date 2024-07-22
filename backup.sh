#!/bin/bash

# Running daily at 12 AM: 0 0 * * * ./backup.sh

# gupto sonket ta akta poribesh poribortonshil jinish theke portese
# using restic: https://restic.net/ create encrytped backups of brave, chrome & more
restic -r $HOME/backup/ backup "$HOME/.config/BraveSoftware/"
restic -r $HOME/backup/ backup "$HOME/.config/google-chrome/"
restic -r $HOME/backup/ backup "$HOME/Desktop/"
restic -r $HOME/backup/ backup "$HOME/.config/chromium/"
restic -r $HOME/backup/ backup "$HOME/.config/opera/"
restic -r $HOME/backup/ backup "$HOME/.config/tilix/"
restic -r $HOME/backup/ backup "$HOME/.config/terminator/"
restic -r $HOME/backup/ backup "$HOME/.config/sublime-text/"

# keep the latest 2 backups & remove the rest
restic forget -r $HOME/backup/ --keep-last 2 --prune

# git update using my tool gitcommiter
gitcommiter -d "$HOME/dotfiles" -p
gitcommiter -d "$HOME/Desktop/bug-bounty/web3" -p
