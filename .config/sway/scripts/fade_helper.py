#!/usr/bin/env python3

from i3ipc import Connection
from time import sleep
import sys
def fade_out(ipc):
    # Fade from 1.0 (100%) to 0.1 (10%) over 0.5 seconds
    for opacity in [1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]:
        ipc.command(f"opacity {opacity}")
        sleep(0.05)  # 0.05 seconds per step, total ~0.5 seconds
    ipc.command("opacity 0.1")  # Ensure exact end value

def fade_in(ipc):
    # Fade from 0.1 (10%) to 1.0 (100%) over 0.5 seconds
    for opacity in [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]:
        ipc.command(f"opacity {opacity}")
        sleep(0.05)  # 0.05 seconds per step, total ~0.5 seconds
    ipc.command("opacity 1.0")  # Ensure exact end value

if __name__ == "__main__":
    ipc = Connection()
    if len(sys.argv) > 1 and sys.argv[1] == "out":
        fade_out(ipc)
    elif len(sys.argv) > 1 and sys.argv[1] == "in":
        fade_in(ipc)
    else:
        print("Usage: fade_helper.py [out|in]")