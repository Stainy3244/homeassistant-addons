#!/bin/bash
set -e

echo "[INFO] Setting up recordings symlink..."

mkdir -p /share/dispatcharr

if [ -d "/data/recordings" ] && [ ! -L "/data/recordings" ]; then
    echo "[INFO] Moving existing recordings and creating symlink..."
    mv /data/recordings/* /share/dispatcharr/ 2>/dev/null || true
    rm -rf /data/recordings
fi

if [ ! -L "/data/recordings" ]; then
    ln -sf /share/dispatcharr /data/recordings
    echo "[INFO] Symlink created: /data/recordings -> /share/dispatcharr"
else
    echo "[INFO] Symlink already exists"
fi

exec /app/docker/entrypoint.sh
