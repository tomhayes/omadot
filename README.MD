# Omadot
A simple, powerful dotfile management tool built as a simple [GNU Stow](https://www.gnu.org/software/stow/) wrapper. Manage your configuration files with ease!
This tool was originally designed for use with [Omarchy](https://omarchy.org/), but it should work well on any Linux distribution or macOS. If you try it on a non-Arch-based distro or macOS, feedback is welcome!

Omadot applies Omarchy's opinionated methodology to your dotfiles. It manages them from a `~/.dotfiles` directory (which you should version control) and manages configuration discretely for each package to allow for a modular and granular approach.

## Features

- **Package-based management** - Each config is its own stow package
- **Multiple locations** - Handle both `~/.config` and `~` directory files
- **Smart exclusions** - Exclude specific packages with `--exclude`
- **Auto-skip existing** - Automatically skips packages already in `.dotfiles`
- **Simple commands** - Just `get` to move, `put` to symlink

## Installation

### Quick Install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/tomhayes/omadot/main/install.sh | bash
```
### Manual Install
```bash
clone https://github.com/tomhayes/omadot.git
cd omadot
chmod +x omadot
sudo cp omadot /usr/local/bin/
```

## Requirements

### GNU Stow - Install with your package manager:

```bash
  # Arch/Manjaro
  sudo pacman -S stow
  
  # Debian/Ubuntu
  sudo apt install stow
  
  # Fedora
  sudo dnf install stow
  
  # macOS
  brew install stow
  ```
## Usage
### Basic Commands
```bash
# Move a config to .dotfiles
omadot get nvim

# Create symlinks with stow
omadot put nvim

# List all packages in .dotfiles
omadot list

# Show help
omadot help

# Move all configs from ~/.config
omadot get --all

# Move all configs except some
omadot get --all --exclude=vivaldi,google-chrome,yay

# Stow all packages
omadot put --all

# Move files from ~/ (like .bashrc, .zshrc, etc.)
omadot get .bashrc --home
omadot get .zshrc --home
omadot get starship.toml --home

# Move all dotfiles from home
omadot get --all --home

# Stow them (no --home flag needed)
omadot put bashrc
omadot put starship
```
## How It Works
omadot organizes your dotfiles using GNU Stow's package structure:
```
~/.dotfiles/
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.lua
├── alacritty/
│   └── .config/
│       └── alacritty/
│           └── alacritty.toml
└── bashrc/
    └── .bashrc
```
When you run omadot put nvim, it creates symlinks:
```
~/.config/nvim → ~/.dotfiles/nvim/.config/nvim
```
This makes it easy to:

 - Track your configs in git
 - Restore configs on new machines
 - Manage configs individually
 - Share specific configs with others

## Examples
### Setting up a new machine
```bash
# Install omadot and stow
curl -fsSL https://raw.githubusercontent.com/tomhayes/omadot/main/install.sh | bash

# Clone your dotfiles repo
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles

# Stow everything
cd ~/.dotfiles
omadot put --all
Backing up existing configs
bash# Move all configs to .dotfiles
omadot get --all

# Initialize git repo
cd ~/.dotfiles
git init
git add .
git commit -m "Initial dotfiles commit"
git remote add origin https://github.com/yourusername/dotfiles.git
git push -u origin main
Managing individual packages
bash# Add a new config
omadot get waybar

# Stow it
omadot put waybar

# Remove a package from being managed
cd ~/.dotfiles
stow -D nvim  # Removes symlinks
rm -rf nvim   # Removes from .dotfiles
```

Tips

Start small: Begin with one or two configs to get comfortable
Use git: Keep your .dotfiles directory in version control
Selective sync: Use --exclude to avoid syncing browser configs or cache
Test first: Run omadot list to see what's already managed

Troubleshooting
Stow conflicts
If stow reports conflicts, you may have existing files. You can:

Backup the existing files
Remove them
Run omadot put <package> again

Package already exists
If you see "already exists in .dotfiles", the config is already managed. Skip it or use stow -D <package> to unstow first.
Contributing

Issues and pull requests welcome! Feel free to suggest improvements or report bugs.

Credits
Built with ❤️ using GNU Stow