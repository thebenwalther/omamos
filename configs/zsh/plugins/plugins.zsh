#### ---- fast-syntax-highlighting ------------------------
[ -f $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#### ---- zsh-autosuggestions ------------------------
[ -f $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Autosuggestion highlighting
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

#### ---- zsh-abbr ------------------------
[ -f $ZSH/plugins/zsh-abbr/zsh-abbr.zsh ] && source $ZSH/plugins/zsh-abbr/zsh-abbr.zsh

# Load compinit once after all plugins
autoload -U compinit
compinit
