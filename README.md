<<<<<<< HEAD
# AMDAX Dotfiles with GNU Stow

This repository contains Robert's dotfiles managed with GNU Stow for easy deployment across systems.

## Quick Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/RobertAmdax/dotfiles.git ~/dotfiles
   ```

2. Install GNU Stow:
   ```bash
   sudo apt install stow  # Ubuntu/Debian
   # or
   brew install stow      # macOS
   ```

3. Run the installation script:
   ```bash
   cd ~/dotfiles
   ./install.sh
   ```

## Manual Management

To manage packages individually:

```bash
cd ~/dotfiles

# Install a package
stow zsh

# Remove a package
stow -D zsh

# Reinstall a package
stow -R zsh
```

## Package Structure

  - **nvim/**: Neovim configuration with Lazy.nvim
  - **ripgrep/**: ripgrep configuration
  - **raycast/**: Raycast extensions and config
  - **sketchybar/**: macOS status bar configuration
  - **karabiner/**: Keyboard customization (macOS)
  - **bat/**: Better cat themes
  - **kitty/**: Terminal emulator config
  - **packer/**: Binary packer

## Current Status

✅ Successfully stowed:

⚠️ Note: Some zsh configuration paths may need adjustment for Ubuntu (originally configured for macOS with Homebrew)

## Backup Files

The installation script automatically backs up existing files with timestamps:

## Neovim Configuration

Your Neovim setup includes:

## Managing Updates

After making changes to any dotfile:

1. Git commands work from anywhere since files are symlinked
2. Changes are immediately reflected in the repository
3. Commit and push as usual:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Update configuration"
   git push
   ```

## Troubleshooting

||||||| empty tree
=======
# Dotfiles Repository

This repository contains my personal dotfiles managed with GNU Stow.

## Setup

1. Clone this repository to your home directory:
   ```bash
   git clone git@github.com:robertamdax/dotfiles.git ~/dotfiles
   ```

2. Navigate to the dotfiles directory:
   ```bash
   cd ~/dotfiles
   ```

3. Use stow to symlink configurations:
   ```bash
   # Stow individual packages
   stow zsh nvim git wezterm starship kitty github-cli alacritty warp
   
   # Or stow everything at once
   stow */
   ```

## Structure

- `zsh/` - Zsh shell configuration (.zshrc and .zprofile)
- `nvim/` - Neovim editor configuration
- `git/` - Git configuration (.gitconfig)
- `wezterm/` - WezTerm terminal configuration
- `starship/` - Starship prompt configuration
- `kitty/` - Kitty terminal configuration
- `github-cli/` - GitHub CLI configuration
- `alacritty/` - Alacritty terminal configuration
- `warp/` - Warp terminal configuration (AI-powered)

## Requirements

- GNU Stow: `brew install stow`

>>>>>>> master
