#!/bin/bash

DIR="$HOME/Pictures/screenshot"
mkdir -p "$DIR"

FILENAME="$(date +'%Y-%m-%d_%H-%M-%S').png"
FULL_PATH="$DIR"

# Take screenshot and save to full path (no subfolders)
if [ "$1" = "region" ]; then
  hyprshot -m region -o "$FULL_PATH" -c
else
  hyprshot -m output -o "$FULL_PATH" -c
fi

# Copy image to clipboard
wl-copy <"$FULL_PATH"

# Store in cliphist
cliphist store <"$FULL_PATH"
