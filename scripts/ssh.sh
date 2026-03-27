#!/bin/bash

set -e

source ./scripts/utils.sh

step "Setting up SSH configuration..."

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [ -f "./configs/ssh/config" ]; then
  if [ ! -f "$HOME/.ssh/config" ]; then
    cp "./configs/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
    print_success "SSH configuration installed"
  elif files_are_identical "$HOME/.ssh/config" "./configs/ssh/config"; then
    print_success_muted "SSH configuration already up to date"
  elif confirm_override "$HOME/.ssh/config" "./configs/ssh/config" "SSH configuration"; then
    cp "./configs/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
    print_success "SSH configuration installed"
  else
    print_muted "Skipping SSH configuration"
  fi
else
  print_warning "SSH configuration file not found"
fi

# Generate SSH key if one doesn't exist
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  step "Generating SSH key..."
  ssh-keygen -t ed25519 -C "thebenwalther@users.noreply.github.com" -f "$HOME/.ssh/id_ed25519" -N ""
  ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"
  print_success "SSH key generated"
  print_muted "Add this public key to GitHub: https://github.com/settings/ssh/new"
  cat "$HOME/.ssh/id_ed25519.pub"
else
  print_success_muted "SSH key already exists"
fi
