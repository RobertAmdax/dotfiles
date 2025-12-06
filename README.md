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
   stow zsh
   stow nvim
   
   # Or stow everything at once
   stow */
   ```

## Structure

- `zsh/` - Zsh shell configuration
- `nvim/` - Neovim editor configuration

## Requirements

- GNU Stow: `brew install stow`

