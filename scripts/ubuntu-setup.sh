#!/bin/bash

# Ubuntu Ubuntu System Optimization and Setup Script
# Run this script to install additional tools and optimize your system

set -e

print_info() { echo -e "\033[34m[INFO]\033[0m $1"; }
print_success() { echo -e "\033[32m[SUCCESS]\033[0m $1"; }
print_warning() { echo -e "\033[33m[WARNING]\033[0m $1"; }

# Update system
print_info "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential packages
print_info "Installing essential packages..."
sudo apt install -y \
    curl wget git git-delta \
    zsh tmux \
    build-essential \
    python3 python3-pip python3-venv \
    nodejs npm \
    ripgrep fd-find bat eza \
    htop btop \
    neofetch \
    tree \
    jq \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Install Homebrew for Linux
if ! command -v brew &> /dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH for this session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install modern CLI tools via Homebrew and apt
print_info "Installing modern CLI tools..."
brew install \
    zoxide \
    starship \
    dust \
    procs \
    duf \
    tokei \
    hyperfine \
    bottom \
# Install Docker
if ! command -v docker &> /dev/null; then
    print_info "Installing Docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo usermod -aG docker $USER
fi

# Install VS Code (if not already installed)
if ! command -v code &> /dev/null; then
    print_info "Installing VS Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
fi

# Install Zsh plugins manually if zinit fails
print_info "Setting up Zsh..."
if [ ! -d "$HOME/.local/share/zinit" ]; then
    mkdir -p "$HOME/.local/share/zinit"
    git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.local/share/zinit/zinit.git"
fi

# Install TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    print_info "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Set up Python virtual environment
print_info "Setting up Python virtual environment..."
if [ ! -d "$HOME/.virtualenvs/venv" ]; then
    python3 -m venv ~/.virtualenvs/venv
    source ~/.virtualenvs/venv/bin/activate
    pip install virtualenvwrapper
fi

print_success "System setup completed!"
print_info "Please reboot your system to ensure all changes take effect."
print_info "After reboot, run 'tmux' and press 'Ctrl+a + I' to install tmux plugins."