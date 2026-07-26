#!/bin/bash

# Path to the QML script
CONFIG_PATH="$HOME/.config/quickshell/shell.qml"

# Check if our specific quickshell popup is currently running
if pgrep -f "quickshell.*shell.qml" > /dev/null; then
    # Close it gracefully
    pkill -f "quickshell.*shell.qml"
else
    # Launch it
    quickshell -p "$CONFIG_PATH" &
fi
