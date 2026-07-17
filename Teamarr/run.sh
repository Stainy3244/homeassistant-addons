#!/bin/sh
set -e

echo "Starting Teamarr Home Assistant add-on..."

DATA_DIR="/data/teamarr"
APP_DATA_DIR="/app/data"

mkdir -p "$DATA_DIR"

if [ -d "$APP_DATA_DIR" ] && [ ! -L "$APP_DATA_DIR" ]; then
    if [ -n "$(ls -A "$APP_DATA_DIR" 2>/dev/null)" ] && [ -z "$(ls -A "$DATA_DIR" 2>/dev/null)" ]; then
        echo "Copying initial Teamarr data..."
        cp -a "$APP_DATA_DIR"/. "$DATA_DIR"/
    fi

    rm -rf "$APP_DATA_DIR"
fi

ln -sfn "$DATA_DIR" "$APP_DATA_DIR"

echo "Persistent data directory: $DATA_DIR"
echo "Launching Teamarr..."

exec "$@"