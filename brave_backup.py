import os
import tarfile
from datetime import datetime
from rich.console import Console

import gnupg
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv(os.path.expanduser("./.env"))
console = Console()

PASSWORD = os.getenv("PASSWORD")
SOURCE_DIR = os.path.expanduser("~/.config/BraveSoftware")
BACKUP_DIR = os.path.expanduser("~/dotfiles")
BACKUP_FILE = os.path.join(
    BACKUP_DIR, f"BraveSoftware_{datetime.now().strftime('%Y%m%d_%H%M%S')}.tar.gz"
)
ENCRYPTED_FILE = BACKUP_FILE + ".gpg"


def do_the_work():
    # Create a tar.gz archive of the SOURCE_DIR
    with tarfile.open(BACKUP_FILE, "w:gz") as tar:
        tar.add(SOURCE_DIR, arcname=os.path.basename(SOURCE_DIR))

    # Encrypt the tar.gz archive using gnupg
    gpg = gnupg.GPG()
    with open(BACKUP_FILE, "rb") as f:
        status = gpg.encrypt_file(
            f, recipients=None, symmetric=True, passphrase=PASSWORD, output=ENCRYPTED_FILE
        )

    # Check if encryption was successful
    if status.ok:
        os.remove(BACKUP_FILE)  # Remove the unencrypted tar.gz file

        # Run gitcommiter
        os.system(f"gitcommiter -d {BACKUP_DIR}")

        # Optional: Remove backups older than 7 days to save space
        now = datetime.now()
        for filename in os.listdir(BACKUP_DIR):
            if filename.startswith("BraveSoftware_") and filename.endswith(".tar.gz.gpg"):
                file_path = os.path.join(BACKUP_DIR, filename)
                file_time = datetime.fromtimestamp(os.path.getmtime(file_path))
                if (now - file_time).days > 7:
                    os.remove(file_path)
    else:
        print("Encryption failed:", status.stderr)


if __name__=="__main__":
    with console.status("[green]Working..."):
        #do_the_work()
        print("Not Working!!")