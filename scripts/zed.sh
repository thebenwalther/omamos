#!/bin/bash

set -e

source ./scripts/utils.sh

step "Setting up Zed configuration..."

ZED_CONFIG_DIR="$HOME/.config/zed"
mkdir -p "$ZED_CONFIG_DIR"

if [ -f "./configs/zed/settings.json" ]; then
  if [ ! -f "$ZED_CONFIG_DIR/settings.json" ]; then
    cp "./configs/zed/settings.json" "$ZED_CONFIG_DIR/settings.json"
    print_success "Zed configuration installed"
  elif files_are_identical "$ZED_CONFIG_DIR/settings.json" "./configs/zed/settings.json"; then
    print_success_muted "Zed configuration already up to date"
  elif confirm_override "$ZED_CONFIG_DIR/settings.json" "./configs/zed/settings.json" "Zed configuration"; then
    cp "./configs/zed/settings.json" "$ZED_CONFIG_DIR/settings.json"
    print_success "Zed configuration installed"
  else
    print_muted "Skipping Zed configuration"
  fi
else
  print_warning "Zed configuration file not found"
fi
