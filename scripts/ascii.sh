#!/bin/bash

set -e

ascii_art='
  ██████╗  ███╗   ███╗  █████╗  ███╗   ███╗  ██████╗   ██████╗
 ██╔═══██╗ ████╗ ████║ ██╔══██╗ ████╗ ████║ ██╔═══██╗ ██╔════╝
 ██║   ██║ ██╔████╔██║ ███████║ ██╔████╔██║ ██║   ██║ ╚█████╗
 ██║   ██║ ██║╚██╔╝██║ ██╔══██║ ██║╚██╔╝██║ ██║   ██║  ╚═══██╗
 ╚██████╔╝ ██║ ╚═╝ ██║ ██║  ██║ ██║ ╚═╝ ██║ ╚██████╔╝ ██████╔╝
  ╚═════╝  ╚═╝     ╚═╝ ╚═╝  ╚═╝ ╚═╝     ╚═╝  ╚═════╝  ╚═════╝
'

# Define the color gradient (shades of blue)
colors=(
  '\033[38;5;39m'  # Bright Blue
  '\033[38;5;45m'  # Cyan Blue
  '\033[38;5;51m'  # Light Cyan
  '\033[38;5;87m'  # Pale Cyan
  '\033[38;5;123m' # Ice Blue
  '\033[38;5;159m' # Light Ice
  '\033[38;5;195m' # Near White Blue
)

# Print each line with color
i=0
echo "$ascii_art" | while IFS= read -r line; do
  color_index=$((i % ${#colors[@]}))
  echo -e "${colors[color_index]}${line}\033[0m"
  i=$((i + 1))
done
