#!/usr/bin/env bash

set -e

command -v curl >/dev/null 2>&1 || { echo "curl is required but not installed." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip is required but not installed." >&2; exit 1; }

REPO_URL="https://github.com/thebenwalther/omamos/archive/refs/heads/main.zip"
INSTALL_DIR="$HOME/omamos"

echo "Downloading Omamos..."
curl -L "$REPO_URL" -o /tmp/omamos.zip
unzip -q /tmp/omamos.zip -d /tmp/
mv /tmp/omamos-main "$INSTALL_DIR"
rm /tmp/omamos.zip

echo "Starting setup..."
cd "$INSTALL_DIR"
bash setup.sh
