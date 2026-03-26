#!/bin/bash

set -e

source ./scripts/utils.sh

step "Setting up Mise configuration..."

MISE_CONFIG_DIR="$HOME/.config/mise"
mkdir -p "$MISE_CONFIG_DIR"

if [ -f "./configs/mise.toml" ]; then
  if [ ! -f "$MISE_CONFIG_DIR/config.toml" ]; then
    cp "./configs/mise.toml" "$MISE_CONFIG_DIR/config.toml"
    print_success "Mise configuration installed"
  elif files_are_identical "$MISE_CONFIG_DIR/config.toml" "./configs/mise.toml"; then
    print_success_muted "Mise configuration already up to date"
  elif confirm_override "$MISE_CONFIG_DIR/config.toml" "./configs/mise.toml" "Mise configuration"; then
    cp "./configs/mise.toml" "$MISE_CONFIG_DIR/config.toml"
    print_success "Mise configuration installed"
  else
    print_muted "Skipping Mise configuration"
  fi
fi

step "Installing language runtimes via Mise..."
mise install
print_success "Language runtimes installed"
