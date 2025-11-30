#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# Use default UID/GID - WatchState handles this internally
export PUID=1000
export PGID=1000

# Ensure config directory exists
mkdir -p /config

echo "[INFO] Starting WatchState application..."

# Start WatchState using its native entrypoint
exec /usr/bin/php /app/console.php system:start
