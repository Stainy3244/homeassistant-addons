#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# Ensure config directory exists
mkdir -p /config

# WatchState checks PUID/PGID environment variables
# Set them to 0 (root) to match the container user
export PUID=0
export PGID=0

# Fix ownership to match
chown -R 0:0 /config 2>/dev/null || true
chmod 755 /config

echo "[INFO] Starting WatchState as root (required for addon)..."

# Execute the original WatchState entrypoint
exec /usr/bin/php /app/console.php system:start
