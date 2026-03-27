#!/bin/bash

set -e

source ./scripts/utils.sh

step "Setting up Zsh configuration..."

ZSH_DIR="$HOME/.zsh"
mkdir -p "$ZSH_DIR/config" "$ZSH_DIR/plugins"

# ~/.zshenv — tells zsh where ZDOTDIR is (must be in ~, not ZDOTDIR)
if [ ! -f "$HOME/.zshenv" ]; then
  cp "./configs/zshenv" "$HOME/.zshenv"
  print_success ".zshenv installed"
elif files_are_identical "$HOME/.zshenv" "./configs/zshenv"; then
  print_success_muted ".zshenv already up to date"
elif confirm_override "$HOME/.zshenv" "./configs/zshenv" ".zshenv"; then
  cp "./configs/zshenv" "$HOME/.zshenv"
  print_success ".zshenv installed"
else
  print_muted "Skipping .zshenv"
fi

# ~/.zshrc — bootstrap only, sources $ZDOTDIR/.zshrc
if [ ! -f "$HOME/.zshrc" ]; then
  cp "./configs/zshrc" "$HOME/.zshrc"
  print_success ".zshrc (bootstrap) installed"
elif files_are_identical "$HOME/.zshrc" "./configs/zshrc"; then
  print_success_muted ".zshrc already up to date"
elif confirm_override "$HOME/.zshrc" "./configs/zshrc" ".zshrc"; then
  cp "./configs/zshrc" "$HOME/.zshrc"
  print_success ".zshrc (bootstrap) installed"
else
  print_muted "Skipping .zshrc"
fi

# ~/.zsh/.zprofile — Homebrew init
if [ ! -f "$ZSH_DIR/.zprofile" ]; then
  cp "./configs/zsh/.zprofile" "$ZSH_DIR/.zprofile"
  print_success ".zprofile installed"
elif files_are_identical "$ZSH_DIR/.zprofile" "./configs/zsh/.zprofile"; then
  print_success_muted ".zprofile already up to date"
elif confirm_override "$ZSH_DIR/.zprofile" "./configs/zsh/.zprofile" ".zprofile"; then
  cp "./configs/zsh/.zprofile" "$ZSH_DIR/.zprofile"
  print_success ".zprofile installed"
else
  print_muted "Skipping .zprofile"
fi

# ~/.zsh/.zshrc — main config
if [ ! -f "$ZSH_DIR/.zshrc" ]; then
  cp "./configs/zsh/.zshrc" "$ZSH_DIR/.zshrc"
  print_success ".zsh/.zshrc installed"
elif files_are_identical "$ZSH_DIR/.zshrc" "./configs/zsh/.zshrc"; then
  print_success_muted ".zsh/.zshrc already up to date"
elif confirm_override "$ZSH_DIR/.zshrc" "./configs/zsh/.zshrc" ".zsh/.zshrc"; then
  cp "./configs/zsh/.zshrc" "$ZSH_DIR/.zshrc"
  print_success ".zsh/.zshrc installed"
else
  print_muted "Skipping .zsh/.zshrc"
fi

# Config files
for config_file in envs.zsh init.zsh aliases.zsh history.zsh; do
  src="./configs/zsh/config/$config_file"
  dest="$ZSH_DIR/config/$config_file"
  if [ ! -f "$dest" ]; then
    cp "$src" "$dest"
    print_success "$config_file installed"
  elif files_are_identical "$dest" "$src"; then
    print_success_muted "$config_file already up to date"
  elif confirm_override "$dest" "$src" "$config_file"; then
    cp "$src" "$dest"
    print_success "$config_file installed"
  else
    print_muted "Skipping $config_file"
  fi
done

# plugins.zsh
if [ ! -f "$ZSH_DIR/plugins/plugins.zsh" ]; then
  cp "./configs/zsh/plugins/plugins.zsh" "$ZSH_DIR/plugins/plugins.zsh"
  print_success "plugins.zsh installed"
elif files_are_identical "$ZSH_DIR/plugins/plugins.zsh" "./configs/zsh/plugins/plugins.zsh"; then
  print_success_muted "plugins.zsh already up to date"
elif confirm_override "$ZSH_DIR/plugins/plugins.zsh" "./configs/zsh/plugins/plugins.zsh" "plugins.zsh"; then
  cp "./configs/zsh/plugins/plugins.zsh" "$ZSH_DIR/plugins/plugins.zsh"
  print_success "plugins.zsh installed"
else
  print_muted "Skipping plugins.zsh"
fi

# Clone plugins if not already present
step "Installing Zsh plugins..."

clone_plugin() {
  local name="$1"
  local url="$2"
  local dest="$ZSH_DIR/plugins/$name"
  if [ -d "$dest" ]; then
    print_success_muted "$name already installed"
  else
    git clone --depth=1 "$url" "$dest"
    print_success "$name installed"
  fi
}

clone_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting"
clone_plugin "zsh-autosuggestions"      "https://github.com/zsh-users/zsh-autosuggestions"
clone_plugin "zsh-abbr"                 "https://github.com/olets/zsh-abbr"
