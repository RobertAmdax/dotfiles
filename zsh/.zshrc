eval "$(starship init zsh)"

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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
#

# ---- Paths ----
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ---- Shell ----
export SHELL=$(which zsh)
export EDITOR="nvim"

# Core plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# =====================================================================
#  🔍 FZF + FD Integration
# =====================================================================

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# =====================================================================
#  🧠 History Configuration
# =====================================================================

HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_verify

# =====================================================================
#  💡 Zoxide (Better cd)
# =====================================================================

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# =====================================================================
#  🧰 TheFuck (Command Auto-Correct)
# =====================================================================

if command -v thefuck >/dev/null 2>&1; then
  eval $(thefuck --alias)
fi

# =====================================================================
#  🔧 Aliases & Shortcuts
# =====================================================================

alias ls="eza --icons --group-directories-first"
alias cat="bat"
alias cd="z"
alias k="kubectl"
alias tf="terraform"
alias cls="clear"
alias please="sudo"
alias lg="lazygit"
alias top="btop"

# FZF file finder with preview
alias ff="fd --type f | fzf --preview 'bat --color=always {}'"

# Reload ZSH configuration
alias reload="source ~/.zshrc"

# =====================================================================
#  ☁️ Azure + Kubernetes CLI Setup
# =====================================================================

# Kubernetes tab completion
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# Azure CLI autocomplete
if command -v az >/dev/null 2>&1; then
  source /usr/share/bash-completion/completions/az 2>/dev/null || true
fi

# =====================================================================
#  🧮 Prompt / Appearance Customization
# =====================================================================

# Starship configuration path
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Terminal colors
autoload -U colors && colors

# =====================================================================
#  🧠 Quality-of-Life Defaults
# =====================================================================

setopt auto_cd               # Allow 'cd' by typing directory name
setopt correct_all           # Suggest corrections for mistyped commands
setopt interactive_comments  # Allow comments in interactive shell
setopt prompt_subst          # Allow variables in prompt

# =====================================================================
#  🐍 Python Virtualenvwrapper (Optional)
# =====================================================================

if command -v virtualenvwrapper.sh >/dev/null 2>&1; then
  export WORKON_HOME=$HOME/.virtualenvs
  export VIRTUALENVWRAPPER_PYTHON=$(which python3)
  source $(which virtualenvwrapper.sh)
fi

# =====================================================================
#  ✅ End of File
# =====================================================================



