ZIM_HOME=~/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/include:~/Library/Python/3.7/bin:$PATH
export PATH="/Users/jordanmilford/apps/elasticsearch/bin:$PATH"

# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

export XDG_CONFIG_HOME="$HOME/.config"
export DISABLE_AUTO_TITLE='true'

# ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   git
#   vagrant
#   wd
#   postgres
#   npm
#   yarn
#   ruby
#   rails
#   zsh-autosuggestions
#   copyfile
#   macos
#   heroku
# )

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
# else
  # export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# replace string widget
autoload replace-string
zle -N replace-string
zle -N replace-string-again
bindkey '\eg' replace-string-again
bindkey '\er' replace-string

# Set personal aliases, overriding those provided by oh-my-zsh libs
alias c="clear"
alias vim="nvim"
alias vimr="nvim -R"
alias grep="rg"
alias f="rg -F"
alias ls="ls -a"
alias ll="ls -la"
alias dr="doppler run --"
alias zshrc="vim ~/.zshrc"
alias tmuxrc="vim ~/.tmux.conf"
alias vimrc="vim ~/.config/nvim/init.lua"
alias db-backup-fast="pg_restore -L <(pg_restore -l /Users/jordanmilford/Downloads/latest.dump | grep -ivE 'TABLE DATA public (versions|state_transitions)') --verbose --clean --no-acl --no-owner -h localhost -U jordanmilford -d popular_pays_suite_development /Users/jordanmilford/Downloads/latest.dump"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Rbenv
eval "$(rbenv init -)"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# added by travis gem
[ ! -s /Users/jordanmilford/.travis/travis.sh ] || source /Users/jordanmilford/.travis/travis.sh

# comment elasticsearch spec helper
function comment_es() {
  sed -i '' '163 s/^/#/' spec/spec_helper.rb; sed -i '' '171 s/^/#/' spec/spec_helper.rb
}

# uncomment elasticsearch spec helper
function uncomment_es() {
  sed -i '' '163 s/^##*//' spec/spec_helper.rb; sed -i '' '171 s/^##*//' spec/spec_helper.rb
}


eval "$(starship init zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
