#!/bin/bash
set -e

CONFIG_PATH="/data/options.json"

# Get configuration values with defaults
WS_UID=1000
WS_GID=1000

if [ -f "$CONFIG_PATH" ]; then
    WS_UID=$(jq -r '.UID // 1000' "$CONFIG_PATH")
    WS_GID=$(jq -r '.GID // 1000' "$CONFIG_PATH")
fi

echo "[INFO] WatchState Home Assistant Add-on starting..."
echo "[INFO] Running as UID: $WS_UID, GID: $WS_GID"

# Set the user and group for WatchState
export PUID=$WS_UID
export PGID=$WS_GID

# Ensure config directory exists
mkdir -p /config

echo "[INFO] Starting WatchState application..."

# Start WatchState using its native entrypoint
exec /usr/bin/php /app/console.php system:start
