# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Shell integrations
# init fzf
eval "$(fzf --zsh)"
# init zoxide
eval "$(zoxide init --hook prompt zsh)"

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it´s not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# source zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1 

# add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair
zinit light jedahan/ripz
zinit light redxtech/zsh-kitty

zinit ice wait lucid atload"zsh-startify"
zinit load NorthIsMirror/zsh-startify
zinit load redxtech/zsh-not-vim

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Autoload completions
autoload -Uz compinit && compinit

# make all OMZ Plugins available
zinit cdreplay -q

# enable corrections for common typos
setopt correct

# startify config
zstyle ":plugin:zsh-startify:shellutils" size 5
zstyle ":plugin:zsh-startify:vim" size 5

# not vim config
zstyle :plugins:not-vim say cowsay -f vader

# zsh kitty completions
__kitty_complete

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# nvm use latest
nvm use node

# bun completions
[ -s "/Users/jay/.bun/_bun" ] && source "/Users/jay/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go binaries
export PATH="$(go env GOPATH)/bin:$PATH"

# Custom Keybinds
bindkey "^f" autosuggest-accept # CTRL + f
bindkey "^[[A" history-search-backward # Arrow Up
bindkey "^[[B" history-search-forward # Arrow Down

# History
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "eza -1 --color=always $realpath"


# Aliases
alias ls="eza --icons=always --color=always"
alias l="eza --icons=always --color=always"
alias la="eza -a --icons=always --color=always"
alias ll="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lla="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

alias c="clear"

alias vim="nvim"
alias v="nvim"

alias cd="z"
alias ..="z .."

alias stayingalive="caffeinate -d"

# Update zinit and plugins
alias update="zinit self-update && zinit update --parallel"

# Update + Upgrade Brew Apps
alias brewup="brew update && brew upgrade"

# update and build neovim
function updatenvim() {
  pfad= pwd
  cd ~/Documents/GitHub/neovim/ && git pull & rm -rf .deps/ && rm -rf build && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
  cd $pfad
}
alias nvimupdate="updatenvim"

# init Starship
eval "$(starship init zsh)"

clear


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/jay/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
export PATH="/Users/jay/Library/Application Support/Herd/bin/":$PATH

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
