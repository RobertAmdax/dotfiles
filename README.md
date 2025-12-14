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

- **zsh/**: Shell configuration (`.zshrc`)
- **wezterm/**: Terminal emulator configuration (`.wezterm.lua`)
- **tmux/**: Terminal multiplexer configuration (`.tmux.conf`)
- **git/**: Git configuration (`.gitconfig`)
- **ssh/**: SSH client configuration (`.ssh/config`)
- **config/**: All `.config` directory contents including:
  - **nvim/**: Neovim configuration with Lazy.nvim
  - **ripgrep/**: ripgrep configuration
  - **raycast/**: Raycast extensions and config
  - **sketchybar/**: macOS status bar configuration
  - **karabiner/**: Keyboard customization (macOS)
- **env/**: Environment variable templates
- **scripts/**: Utility scripts for system setup
  - **bat/**: Better cat themes
  - **kitty/**: Terminal emulator config
  - **packer/**: Binary packer

## Current Status

✅ Successfully stowed:
- zsh configuration
- wezterm configuration  
- config package (including preserved nvim settings)

⚠️ Note: Some zsh configuration paths may need adjustment for Ubuntu (originally configured for macOS with Homebrew)

## Backup Files

The installation script automatically backs up existing files with timestamps:
- `.zshrc.backup.YYYYMMDD_HHMMSS`
- `.config/NuGet/nuget.config.backup`

## Neovim Configuration

Your Neovim setup includes:
- Lazy.nvim plugin manager
- Custom lua configuration structure
- Telescope, treesitter, lualine, and more plugins
- All settings preserved from original dotfiles

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

- If stow reports conflicts, check for existing files and back them up
- Use `stow -D package` to remove symlinks before reinstalling
- Check symlinks: `ls -la ~/ | grep "->"`