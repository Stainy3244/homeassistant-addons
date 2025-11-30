#!/bin/bash
set -e

CONFIG_PATH="/data/options.json"

# Get configuration values with defaults
UID=1000
GID=1000

if [ -f "$CONFIG_PATH" ]; then
    UID=$(jq -r '.UID // 1000' "$CONFIG_PATH")
    GID=$(jq -r '.GID // 1000' "$CONFIG_PATH")
fi

echo "[INFO] WatchState Home Assistant Add-on starting..."
echo "[INFO] Running as UID: $UID, GID: $GID"

# Set the user and group for WatchState
export PUID=$UID
export PGID=$GID

# Ensure config directory exists
mkdir -p /config

echo "[INFO] Starting WatchState application..."

# Start WatchState using its native entrypoint
exec /usr/bin/php /app/console.php system:start
