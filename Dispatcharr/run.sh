#!/bin/bash
set -e

# Read Home Assistant add-on configuration
CONFIG_PATH="/data/options.json"

# Get configuration values with defaults
RECORDINGS_LOCATION="share"
CUSTOM_PATH=""
LOG_LEVEL="info"

if [ -f "$CONFIG_PATH" ]; then
    RECORDINGS_LOCATION=$(jq -r '.recordings_location // "share"' "$CONFIG_PATH")
    CUSTOM_PATH=$(jq -r '.custom_path // ""' "$CONFIG_PATH")
    LOG_LEVEL=$(jq -r '.log_level // "info"' "$CONFIG_PATH")
fi

echo "[INFO] Dispatcharr Home Assistant Add-on starting..."
echo "[INFO] Log level: $LOG_LEVEL"

# Determine target directory for recordings
if [ -n "$CUSTOM_PATH" ] && [ "$CUSTOM_PATH" != "null" ]; then
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
            TARGET_DIR="/share/dispatcharr"
            echo "[WARN] Unknown location '$RECORDINGS_LOCATION', defaulting to /share/dispatcharr"
            ;;
    esac
    echo "[INFO] Using $RECORDINGS_LOCATION recordings location: $TARGET_DIR"
fi

# Ensure target directory exists
mkdir -p "$TARGET_DIR"
echo "[INFO] Created/verified recordings directory: $TARGET_DIR"

# Handle existing recordings directory
if [ -d "/data/recordings" ] && [ ! -L "/data/recordings" ]; then
    echo "[INFO] Found existing recordings directory, migrating to shared location..."
    # Count files to migrate
    FILE_COUNT=$(find /data/recordings -type f 2>/dev/null | wc -l)
    if [ "$FILE_COUNT" -gt 0 ]; then
        echo "[INFO] Moving $FILE_COUNT existing recording files..."
        mv /data/recordings/* "$TARGET_DIR/" 2>/dev/null || true
        echo "[INFO] File migration completed"
    fi
    rm -rf /data/recordings
fi

# Create symlink if not already present
if [ ! -L "/data/recordings" ]; then
    ln -sf "$TARGET_DIR" /data/recordings
    echo "[INFO] Created symlink: /data/recordings -> $TARGET_DIR"
else
    echo "[INFO] Symlink already exists: $(readlink /data/recordings)"
fi

# Verify symlink setup
if [ -L "/data/recordings" ]; then
    echo "[INFO] ✅ Recording symlink setup successful"
    echo "[INFO] Recordings will be accessible to other Home Assistant add-ons at: $TARGET_DIR"
else
    echo "[ERROR] ❌ Failed to create recording symlink"
fi

# Set log level environment variable for Dispatcharr
export LOG_LEVEL="$LOG_LEVEL"

echo "[INFO] Starting Dispatcharr application..."

# Start original Dispatcharr
exec /app/docker/entrypoint.sh