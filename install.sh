#!/bin/bash

# AMDAX Dotfiles Installation Script using GNU Stow

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_SUFFIX=".backup.$(date +%Y%m%d_%H%M%S)"

print_info() { echo -e "\033[34m[INFO]\033[0m $1"; }
print_success() { echo -e "\033[32m[SUCCESS]\033[0m $1"; }
print_warning() { echo -e "\033[33m[WARNING]\033[0m $1"; }
print_error() { echo -e "\033[31m[ERROR]\033[0m $1"; }

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    print_error "GNU Stow is not installed. Please install it first:"
    echo "sudo apt install stow"
    exit 1
fi

# Change to dotfiles directory
cd "$DOTFILES_DIR" || {
    print_error "Could not find dotfiles directory at $DOTFILES_DIR"
    exit 1
}

print_info "Setting up dotfiles with GNU Stow..."

# Available packages
PACKAGES=("zsh" "wezterm" "config")

# Function to backup existing files
backup_if_exists() {
    local file="$1"
    if [[ -e "$HOME/$file" && ! -L "$HOME/$file" ]]; then
        mv "$HOME/$file" "$HOME/$file$BACKUP_SUFFIX"
        print_warning "Backed up existing $file to $file$BACKUP_SUFFIX"
    fi
}

# Backup function for potential conflicts
backup_conflicts() {
    backup_if_exists ".zshrc"
    backup_if_exists ".wezterm.lua"
    backup_if_exists ".config/NuGet/nuget.config"
}

# Stow packages
stow_packages() {
    for package in "${PACKAGES[@]}"; do
        if [[ -d "$package" ]]; then
            print_info "Stowing $package..."
            if stow "$package"; then
                print_success "✓ Successfully stowed $package"
            else
                print_error "✗ Failed to stow $package"
                return 1
            fi
        else
            print_warning "Package directory '$package' not found"
        fi
    done
}

# Main installation
main() {
    print_info "Starting dotfiles installation..."
    
    # Check for conflicts and backup
    backup_conflicts
    
    # Stow all packages
    stow_packages
    
    print_success "Dotfiles installation complete!"
    print_info "Your nvim configuration is preserved and symlinked."
    
    echo
    print_info "To apply changes, restart your shell or run: source ~/.zshrc"
    print_info "To manage packages individually, use: stow <package> or stow -D <package>"
}

# Run installation
main "$@"