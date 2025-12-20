# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with **GNU Stow**, which creates symlinks from configuration files to their appropriate locations in the home directory.

## Key Commands

### Installation and Management
```bash
# Install GNU Stow (required)
brew install stow

# Stow individual packages (creates symlinks)
stow zsh nvim git wezterm starship kitty github-cli alacritty warp

# Stow all packages at once
stow */

# Remove symlinks for a package
stow -D <package_name>

# Re-stow (useful after updates)
stow -R <package_name>
```

### Testing Shell Configuration
```bash
# Reload zsh configuration
source ~/.zshrc

# Check if configuration loaded correctly
echo $PATH | tr ":" "\n"

# Verify zinit plugins loaded
zinit list
```

## Architecture

### Stow Package Structure
Each top-level directory is a "stow package" containing files that mirror the home directory structure. When stowed, files are symlinked to `$HOME`:
- `zsh/.zshrc` → `~/.zshrc`
- `nvim/.config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `git/.gitconfig` → `~/.gitconfig`

### Zsh Configuration (`zsh/`)
- **Plugin Manager**: Uses Zinit for zsh plugin management
- **Prompt**: Starship (configured separately in `starship/`)
- **Smart Directory Navigation**: zoxide (`z` command)
- **History**: Shared history across sessions with 50k lines
- **Plugins**: fast-syntax-highlighting, zsh-autosuggestions, zsh-completions, fzf-tab
- **Tool Integrations**: FZF with fd/bat preview, eza for enhanced ls, Google Cloud SDK

### Neovim Configuration (`nvim/`)
- **Plugin Manager**: lazy.nvim (auto-installs on first run)
- **Structure**: 
  - `init.lua` - Entry point that loads core and plugins
  - `lua/robert/lazy.lua` - lazy.nvim bootstrap and setup
  - `lua/robert/core/` - Core settings (options, keymaps)
  - `lua/robert/plugins/` - Individual plugin configurations
- **Plugin Pattern**: Each plugin gets its own file in `lua/robert/plugins/`
- **Dependencies**: plenary.nvim (required by many plugins)

### Terminal Emulators
Multiple terminal configurations are maintained:
- **Alacritty** (`alacritty/`) - TOML config with Catppuccin Mocha theme
- **WezTerm** (`wezterm/`) - Lua config with Catppuccin Mocha theme
- **Kitty** (`kitty/`) - Catppuccin Ristretto theme
- **Warp** (`warp/`) - Modern AI-powered terminal (this one!)

All terminals use **CaskaydiaCove Nerd Font Mono** for consistent rendering.

### Other Tools
- **Starship** (`starship/`): Custom prompt with git, python, k8s context display
- **Git** (`git/`): User identity configuration
- **GitHub CLI** (`github-cli/`): Authenticated with https protocol

## Important Patterns

### Adding New Configurations
1. Create a new directory matching the tool name
2. Mirror the home directory structure inside it (e.g., `tool/.config/tool/config.yml`)
3. Add the tool name to the stow command in README.md
4. Test with `stow -n <tool>` (dry run) before actually stowing

### Modifying Neovim Plugins
- Add new plugins by creating a file in `nvim/.config/nvim/lua/robert/plugins/`
- Each plugin file should return a table or array of plugin specs
- lazy.nvim automatically loads all files in the plugins directory
- After changes, restart nvim - lazy.nvim will auto-install new plugins

### Zsh Plugin Management
- Plugins are loaded via Zinit in `.zshrc`
- Turbo mode (`zinit wait lucid`) used for better startup performance
- To add plugins: add `zinit light <plugin-name>` or `zinit wait lucid for <plugin-name>`
- Update plugins: `zinit update`

### Color Scheme Consistency
Most configurations use **Catppuccin** theme variants (Mocha, Ristretto) for visual consistency across tools.

## Repository Conventions

- **No secrets**: Git config references robert@amdax.com but no tokens/keys
- **Symlink-based**: Files remain in the repo and are symlinked to home directory
- **Modular**: Each tool is independent and can be stowed/unstowed separately
- **macOS-centric**: Configurations assume macOS with Homebrew
