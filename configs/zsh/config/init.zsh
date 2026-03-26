# Initialize mise (version manager)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# Initialize zoxide (smart cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Initialize fzf (fuzzy finder)
if command -v fzf &> /dev/null; then
  if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/completion.zsh
  fi
  if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  fi
fi
