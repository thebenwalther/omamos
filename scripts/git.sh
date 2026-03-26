#!/bin/bash

set -e

source ./scripts/utils.sh

step "Setting up Git configuration..."

if [ -f "./configs/git/gitconfig" ]; then
  if [ ! -f "$HOME/.gitconfig" ]; then
    cp "./configs/git/gitconfig" "$HOME/.gitconfig"
    print_success "Git configuration installed"
  elif files_are_identical "$HOME/.gitconfig" "./configs/git/gitconfig"; then
    print_success_muted "Git configuration already up to date"
  elif confirm_override "$HOME/.gitconfig" "./configs/git/gitconfig" "Git configuration"; then
    cp "./configs/git/gitconfig" "$HOME/.gitconfig"
    print_success "Git configuration installed"
  else
    print_muted "Skipping Git configuration"
  fi
else
  print_warning "Git configuration file not found"
fi
