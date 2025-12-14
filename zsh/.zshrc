# Created by newuser for 5.9

# Initialize Homebrew (cross-platform)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    # macOS (Apple Silicon)
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    # macOS (Intel) or older installs
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    # Linux (WSL/Ubuntu)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(starship init zsh)"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# ---- FZF -----
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# ---- History -----
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history hist_ignore_dups hist_expire_dups_first

# ---- Aliases -----
alias ls="eza --icons --group-directories-first"
alias cat="bat"
alias cd="z"
alias k="kubectl"
alias tf="terraform"
alias cls="clear"
alias please="sudo"
alias lg="lazygit"
alias top="btm"

# fzf quick search
alias ff="fd --type f | fzf --preview 'bat --color=always {}'"
alias fzd="fd --type d | fzf --preview 'eza --icons --tree {} | head -20'"

# Reload config
alias reload="source ~/.zshrc"

# System aliases
alias df="duf"
alias du="dust"
alias ps="procs"
alias find="fd"
alias grep="rg"

# Docker aliases
alias dps="docker ps"
alias dimg="docker images"
alias dexec="docker exec -it"
alias dlog="docker logs -f"
alias dcup="docker-compose up -d"
alias dcdown="docker-compose down"

# Network utilities
alias ip="ip -c=auto"
alias ping="prettyping"

# File operations
alias mkdir="mkdir -pv"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias realcat="/bin/cat"

# Development shortcuts
alias python="python3"
alias pip="pip3"
alias serve="python -m http.server"

# VM Management
alias vms="~/dotfiles/scripts/azure-tmux.sh"
alias vmcmd="~/dotfiles/scripts/azure-commands.sh"

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$HOME/.virtualenvs/venv/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.virtualenvs/venv/bin/virtualenv
source $HOME/.virtualenvs/venv/bin/virtualenvwrapper.sh






### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#source ~/.zinit/bin/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

eval "$(zoxide init zsh)"
# 1Password CLI - set OP_SERVICE_ACCOUNT_TOKEN environment variable externally

# Load local environment variables (not committed to git)
if [ -f ~/.env.local ]; then
    set -a  # automatically export all variables
    source ~/.env.local
    set +a
fi
