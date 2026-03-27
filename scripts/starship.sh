#!/bin/bash

set -e

source ./scripts/utils.sh

if [ -f "./configs/starship.toml" ]; then
  step "Setting up Starship configuration..."
  mkdir -p "$HOME/.config"
  if [ ! -f "$HOME/.config/starship.toml" ]; then
    cp "./configs/starship.toml" "$HOME/.config/starship.toml"
    print_success "Starship configuration installed"
  elif files_are_identical "$HOME/.config/starship.toml" "./configs/starship.toml"; then
    print_success_muted "Starship configuration already up to date"
  elif confirm_override "$HOME/.config/starship.toml" "./configs/starship.toml" "Starship configuration"; then
    cp "./configs/starship.toml" "$HOME/.config/starship.toml"
    print_success "Starship configuration installed"
  else
    print_muted "Skipping Starship configuration"
  fi
else
  print_warning "Starship configuration file not found"
fi
