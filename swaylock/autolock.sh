#!/bin/bash
# Run swayidle to manage idle timeouts and power events
# -w ensures swayidle waits for commands to complete
swayidle -w \
  timeout 600 'swaylock -f' \
  timeout 660 'systemctl suspend' \
  before-sleep 'swaylock -f' \
  timeout 600 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"'
