#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# Ensure config directory exists (container runs as root)
mkdir -p /config
chmod 755 /config

# WatchState expects to run as root in containers
export PUID=0
export PGID=0

echo "[INFO] Starting WatchState application..."

# Execute the original WatchState entrypoint
exec /usr/bin/php /app/console.php system:start
