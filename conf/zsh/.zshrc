# --- Homebrew (must be early for tools like starship, rbenv) ---
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# --- Zim Framework Initialization ---
ZIM_HOME=~/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# Add local user binaries
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# Add application-specific paths
export PATH="/Users/jordanmilford/apps/elasticsearch/bin:$PATH"
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.nvm"
export EDITOR='nvim'

# Lazy-load nvm (saves ~1.2s startup)
_nvm_lazy_load() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
nvm() { _nvm_lazy_load; nvm "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm() { _nvm_lazy_load; npm "$@"; }
npx() { _nvm_lazy_load; npx "$@"; }

# --- Plugin and Framework Configuration ---
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
eval "$(starship init zsh)"

# --- Custom Functions ---
autoload replace-string
zle -N replace-string
zle -N replace-string-again
bindkey '\eg' replace-string-again
bindkey '\er' replace-string
function comment_es() {
  sed -i '' '163 s/^/#/' spec/spec_helper.rb; sed -i '' '171 s/^/#/' spec/spec_helper.rb
}
function uncomment_es() {
  sed -i '' '163 s/^##*//' spec/spec_helper.rb; sed -i '' '171 s/^##*//' spec/spec_helper.rb
}

# --- Aliases ---
alias c="clear"
alias vim="nvim"
alias vimr="nvim -R"
alias f="rg -F"
alias ls="ls -a"
alias ll="ls -la"
alias zshrc="vim ~/.zshrc"
alias tmuxrc="vim ~/.tmux.conf"
alias vimrc="vim ~/.config/nvim/init.lua"
alias vimlsp="vim ~/.config/nvim/lua/lsp.lua"
alias ca="cursor-agent"
alias claudemd="vim ~/.claude/CLAUDE.md"
alias clauderc="vim ~/.claude/settings.json"

# --- History Settings ---
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS     # Ignore duplicated commands history list
setopt HIST_IGNORE_SPACE
DISABLE_AUTO_TITLE='true'    # Ensure to uncomment if needed

# --- Local Config ---
[[ -f ~/.zshrc_ltx ]] && source ~/.zshrc_ltx

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
