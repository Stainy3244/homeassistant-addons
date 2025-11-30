#!/bin/bash
set -e

echo "[INFO] WatchState Home Assistant Add-on starting..."

# WatchState expects /config to be writable by UID 1000
# Home Assistant addons get /data directory that they own
# Symlink /config to /data so WatchState can write there
rm -rf /config
ln -s /data /config

echo "[INFO] WatchState data directory: /data (symlinked to /config)"
echo "[INFO] Starting WatchState application..."

# Run WatchState - it will write to /config which is actually /data
exec /usr/bin/php /app/console.php system:start
