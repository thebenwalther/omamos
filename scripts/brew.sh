#!/bin/bash

set -e

source ./scripts/utils.sh

step "Installing Homebrew packages..."

if brew bundle --file=./configs/Brewfile; then
  print_success "Homebrew packages installed"
else
  print_warning "Some packages may have failed. Check output above."
fi
