#!/bin/bash

set -e

REPO="tomhayes/omadot"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="omadot"

echo "Installing omadot..."

# Download the script
if command -v curl &> /dev/null; then
    curl -fsSL "https://raw.githubusercontent.com/$REPO/main/$SCRIPT_NAME" -o "/tmp/$SCRIPT_NAME"
elif command -v wget &> /dev/null; then
    wget -q "https://raw.githubusercontent.com/$REPO/main/$SCRIPT_NAME" -O "/tmp/$SCRIPT_NAME"
else
    echo "Error: curl or wget is required to install omadot"
    exit 1
fi

# Install the script
if [[ $EUID -ne 0 ]]; then
    echo "Installing to $INSTALL_DIR (requires sudo)"
    sudo install -m 755 "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
else
    install -m 755 "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
fi

# Clean up
rm "/tmp/$SCRIPT_NAME"

echo "✓ omadot installed successfully to $INSTALL_DIR/$SCRIPT_NAME"
echo ""
echo "Get started with: omadot help"
echo ""
echo "Make sure GNU Stow is installed:"
echo "  Arch: sudo pacman -S stow"
echo "  Debian/Ubuntu: sudo apt install stow"