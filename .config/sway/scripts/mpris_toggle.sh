#!/usr/bin/env fish
# ~/.config/sway/scripts/mpris_toggle.sh

# Toggle play/pause for Brave
set brave_instance (playerctl -l | grep -E 'brave.instance[0-9]+' | head -n 1)
if test -n "$brave_instance" && playerctl -p $brave_instance status >/dev/null 2>&1
    playerctl -p $brave_instance play-pause
end

# Toggle play/pause for Rhythmbox
if playerctl -p rhythmbox status >/dev/null 2>&1
    playerctl -p rhythmbox play-pause
end
