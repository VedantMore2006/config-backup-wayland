#!/bin/bash
# Run swayidle to manage idle timeouts and power events
# -w ensures swayidle waits for commands to complete
swayidle -w \
  timeout 1200 'swaylock -f' \
  timeout 1260 'systemctl suspend' \
  before-sleep 'swaylock -f' \
  timeout 1200 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"'
