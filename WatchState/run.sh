#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# Ensure config directory exists
mkdir -p /config

# Fix ownership - WatchState expects to run as root in the container
chown -R 0:0 /config
chmod 755 /config

echo "[INFO] Starting WatchState application..."

# Execute the original WatchState entrypoint as root
exec /usr/bin/php /app/console.php system:start
