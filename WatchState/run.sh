#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# Use a subdirectory inside /config for WatchState data
CONFIG_DIR="/config/watchstate"

# Ensure directory exists and is writable by UID 1000
mkdir -p "$CONFIG_DIR"
chmod 775 "$CONFIG_DIR"

echo "[INFO] WatchState data directory: $CONFIG_DIR"

# Start WatchState and point it to the data directory
exec /usr/bin/php /app/console.php system:start --data-dir "$CONFIG_DIR"
