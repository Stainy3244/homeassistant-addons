#!/bin/bash
set -e

CONFIG_PATH="/data/options.json"

# Get configuration values with defaults
RECORDINGS_LOCATION="media"
CUSTOM_PATH=""
LOG_LEVEL="info"

if [ -f "$CONFIG_PATH" ]; then
    RECORDINGS_LOCATION=$(jq -r '.recordings_location // "media"' "$CONFIG_PATH")
    CUSTOM_PATH=$(jq -r '.custom_path // ""' "$CONFIG_PATH")
    LOG_LEVEL=$(jq -r '.log_level // "info"' "$CONFIG_PATH")
fi

echo "[INFO] Dispatcharr Home Assistant Add-on starting..."
echo "[INFO] Log level: $LOG_LEVEL"

# Determine target directory for recordings
if [ -n "$CUSTOM_PATH" ] && [ "$CUSTOM_PATH" != "null" ] && [ "$CUSTOM_PATH" != '""' ]; then
    TARGET_DIR="$CUSTOM_PATH"
    echo "[INFO] Using custom recordings path: $TARGET_DIR"
else
    case "$RECORDINGS_LOCATION" in
        "share")
            TARGET_DIR="/share/dispatcharr"
            ;;
        "media")
            TARGET_DIR="/media/dispatcharr"
            ;;
        "config")
            TARGET_DIR="/config/dispatcharr"
            ;;
        *)
            TARGET_DIR="/media/dispatcharr"
            echo "[WARN] Unknown location '$RECORDINGS_LOCATION', defaulting to /media/dispatcharr"
            ;;
    esac
    echo "[INFO] Using $RECORDINGS_LOCATION recordings location: $TARGET_DIR"
fi

# Ensure target directory exists
mkdir -p "$TARGET_DIR"
echo "[INFO] Created/verified recordings directory: $TARGET_DIR"

# Handle existing recordings directory or symlink
if [ -L "/data/recordings" ]; then
    CURRENT_TARGET=$(readlink /data/recordings)
    if [ "$CURRENT_TARGET" != "$TARGET_DIR" ]; then
        echo "[INFO] Symlink points to wrong location ($CURRENT_TARGET), recreating..."
        rm /data/recordings
        ln -sf "$TARGET_DIR" /data/recordings
        echo "[INFO] Symlink updated: /data/recordings -> $TARGET_DIR"
    else
        echo "[INFO] Symlink already correct: /data/recordings -> $TARGET_DIR"
    fi
elif [ -d "/data/recordings" ]; then
    echo "[INFO] Found existing recordings directory, migrating to shared location..."
    FILE_COUNT=$(find /data/recordings -type f 2>/dev/null | wc -l)
    if [ "$FILE_COUNT" -gt 0 ]; then
        echo "[INFO] Moving $FILE_COUNT existing recording files..."
        mv /data/recordings/* "$TARGET_DIR/" 2>/dev/null || true
        echo "[INFO] File migration completed"
    fi
    rm -rf /data/recordings
    ln -sf "$TARGET_DIR" /data/recordings
    echo "[INFO] Created symlink: /data/recordings -> $TARGET_DIR"
else
    ln -sf "$TARGET_DIR" /data/recordings
    echo "[INFO] Created symlink: /data/recordings -> $TARGET_DIR"
fi

# Verify symlink setup
if [ -L "/data/recordings" ]; then
    echo "[INFO] ✅ Recording symlink setup successful"
    echo "[INFO] Recordings will be accessible at: $TARGET_DIR"
else
    echo "[ERROR] ❌ Failed to create recording symlink"
fi

export LOG_LEVEL="$LOG_LEVEL"
echo "[INFO] Starting Dispatcharr application..."

exec /app/docker/entrypoint.sh
