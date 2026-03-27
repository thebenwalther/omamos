#!/bin/bash

set -e

source ./scripts/utils.sh

step "Setting up Ghostty configuration..."

GHOSTTY_CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_CONFIG_DIR"

if [ -f "./configs/ghostty.conf" ]; then
  if [ ! -f "$GHOSTTY_CONFIG_DIR/config" ]; then
    cp "./configs/ghostty.conf" "$GHOSTTY_CONFIG_DIR/config"
    print_success "Ghostty configuration installed"
  elif files_are_identical "$GHOSTTY_CONFIG_DIR/config" "./configs/ghostty.conf"; then
    print_success_muted "Ghostty configuration already up to date"
  elif confirm_override "$GHOSTTY_CONFIG_DIR/config" "./configs/ghostty.conf" "Ghostty configuration"; then
    cp "./configs/ghostty.conf" "$GHOSTTY_CONFIG_DIR/config"
    print_success "Ghostty configuration installed"
  else
    print_muted "Skipping Ghostty configuration"
  fi
else
  print_warning "Ghostty configuration file not found"
fi
