#!/usr/bin/env bash

set -e

source ./scripts/utils.sh

step "Customizing macOS system preferences..."

# Set computer name
COMPUTER_NAME="Bizarro"
sudo scutil --set ComputerName "${COMPUTER_NAME}"
sudo scutil --set HostName "${COMPUTER_NAME}"
sudo scutil --set LocalHostName "${COMPUTER_NAME}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${COMPUTER_NAME}"

# Keyboard settings
step "Setting faster keyboard repeat rates..."
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
print_success_muted "Keyboard repeat rates configured"

# Finder preferences
step "Configuring Finder settings..."
defaults write com.apple.finder AppleShowAllFiles YES
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FinderSpawnTab -bool false
print_success_muted "Finder preferences configured"

# System preferences
step "Configuring system and trackpad settings..."
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
print_success_muted "System preferences configured"

# UI and appearance settings
step "Configuring UI and appearance settings..."
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true
defaults write NSGlobalDomain AppleReduceDesktopTinting -bool true
print_success_muted "UI and appearance settings configured"

# Display settings
step "Configuring display settings..."
sudo defaults write /Library/Preferences/com.apple.CoreBrightness.user TrueTone -bool false 2>/dev/null || print_muted "True Tone setting may require manual configuration"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false 2>/dev/null || print_muted "Auto brightness may require manual configuration"
sudo pmset -b lessbright 0 2>/dev/null || print_muted "Battery dimming may require manual configuration"
print_success_muted "Display settings configured"

# Spaces and Mission Control
step "Configuring Spaces and Mission Control..."
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0
print_success_muted "Spaces and Mission Control configured"

# Language & Region
step "Configuring Language & Region settings..."
defaults write NSGlobalDomain AppleFirstWeekday '{ gregorian = 2; }'
print_success_muted "First day of week set to Monday"

# Text and input preferences
step "Configuring text and input settings..."
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain NSTextMovementDefaultKeyTimeout -float 0.03
print_success_muted "Text input preferences configured"

# Disable Apple Intelligence
step "Disabling Apple Intelligence..."
defaults write NSGlobalDomain AppleIntelligenceEnabled -bool false 2>/dev/null || true
defaults write com.apple.CloudSubscriptionFeatures.optIn "706DE269-03A2-4A28-A650-B34CB1CD3905" -bool false 2>/dev/null || true
print_success_muted "Apple Intelligence disabled"

# Save and print dialogs
step "Expanding save and print dialogs by default..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
print_success_muted "Save and print dialogs configured"

# Performance and UI enhancements
step "Optimizing window and UI performance..."
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
print_success_muted "Performance optimizations configured"

# Screenshot settings
step "Configuring screenshot settings..."
mkdir -p ~/Documents/Screenshots
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture "include-date" -bool "true"
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool true
print_success_muted "Screenshot settings configured"

# .DS_Store settings
step "Preventing .DS_Store file creation on network and USB volumes..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
print_success_muted ".DS_Store settings configured"

# Show Library folder
step "Making Library folder visible..."
chflags nohidden ~/Library
print_success_muted "Library folder made visible"

# Dock settings
step "Configuring Dock..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock springboard-show-duration -int 0
defaults write com.apple.dock springboard-hide-duration -int 0
defaults write com.apple.dock springboard-page-duration -int 0
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock "show-recents" -bool false
print_success_muted "Dock preferences configured"

# Screen lock
step "Configuring screen lock security..."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
print_success_muted "Screen lock configured"

# Display sleep
step "Setting display sleep to 10 minutes..."
sudo pmset -b displaysleep 10
sudo pmset -c displaysleep 10
print_success_muted "Display sleep configured (10 min battery/power)"

# Restart affected applications
step "Applying changes by restarting system components..."
print_warning "Dock, Finder, and SystemUIServer will be restarted to apply settings."
sleep 1
killall Dock
killall Finder
killall SystemUIServer

echo ""
print_success "macOS settings configured!"
