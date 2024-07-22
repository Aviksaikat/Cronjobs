#!/bin/bash

# Load environment variables from .env file
if [ -f ./.env ]; then
  export $(cat ./.env | xargs)
fi

# Define variables
SOURCE_DIR="$HOME/.config/BraveSoftware"
BACKUP_DIR="$HOME/dotfiles"
# BACKUP_FILE="$BACKUP_DIR/BraveSoftware_$(date +%Y%m%d_%H%M%S).tar.gz"
BACKUP_FILE="$BACKUP_DIR/BraveSoftware_$(date +%Y%m%d_%H%M%S).zip"
ENCRYPTED_FILE="$BACKUP_FILE.gpg"
COMMITTER_COMMAND="gitcommiter -d $HOME/dotfiles"

# Create a backup tarball and encrypt it with gpg
#tar -fczP - "$SOURCE_DIR" | gpg --batch --yes --passphrase "$PASSWORD" -c -o "$ENCRYPTED_FILE"
# Create a password-protected zip file
zip -rP "$PASSWORD" "$BACKUP_FILE" "$SOURCE_DIR"

# Run gitcommiter
#$COMMITTER_COMMAND

# Optional: Remove backups older than 7 days to save space
#find "$BACKUP_DIR" -name "BraveSoftware_*.tar.gz.gpg" -type f -mtime +7 -exec rm -f {} \;
