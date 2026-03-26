#!/bin/bash

set -e

source ./scripts/utils.sh

# Set zsh as default shell
step "Setting ZSH as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  print_success "ZSH set as default shell"
else
  print_success_muted "ZSH is already the default shell"
fi
