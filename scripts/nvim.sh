#!/bin/bash

set -e

source ./scripts/utils.sh

if ! brew list | grep -q "^neovim$"; then
  print_error "Neovim is not installed. Please ensure it was installed via Homebrew"
  exit 1
fi

NVIM_CONFIG_DIR="$HOME/.config/nvim"

step "Setting up Neovim configuration..."
mkdir -p "$NVIM_CONFIG_DIR"

if [ -d "$NVIM_CONFIG_DIR" ] && [ "$(ls -A "$NVIM_CONFIG_DIR")" ]; then
  step "Backing up existing Neovim configuration..."
  mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
  mkdir -p "$NVIM_CONFIG_DIR"
fi

step "Installing Neovim configuration..."
cp -r configs/nvim/* "$NVIM_CONFIG_DIR/"

print_success "Neovim setup complete"
print_muted "Run 'nvim' to start Neovim and complete the LazyVim installation"
