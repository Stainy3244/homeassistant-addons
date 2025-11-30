#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# Ensure config directory exists
mkdir -p /config
chmod 755 /config

echo "[INFO] Starting WatchState application..."

# Execute the original WatchState entrypoint
exec /usr/bin/php /app/console.php system:start
