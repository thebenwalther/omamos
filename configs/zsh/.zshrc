### ---- ZSH HOME -----------------------------------
export ZSH=$HOME/.zsh

### ---- Completion options and styling -----------------------------------
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

export WORDCHARS=${WORDCHARS//[\/]}

### ---- Source other configs -----------------------------------
[[ -f $ZSH/config/envs.zsh ]]    && source $ZSH/config/envs.zsh
[[ -f $ZSH/config/init.zsh ]]    && source $ZSH/config/init.zsh
[[ -f $ZSH/config/aliases.zsh ]] && source $ZSH/config/aliases.zsh
[[ -f $ZSH/config/history.zsh ]] && source $ZSH/config/history.zsh

### ---- Source plugins -----------------------------------
[[ -f $ZSH/plugins/plugins.zsh ]] && source $ZSH/plugins/plugins.zsh

### ---- Add local bin to path -----------------------------------
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

### ---- Load Starship -----------------------------------
eval "$(starship init zsh)"

### ---- Open with CotEditor -----------------------------------
export VISUAL="/Applications/CotEditor.app"
