FROM ghcr.io/arabcoders/watchstate:latest

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Labels for Home Assistant
LABEL \
    io.hass.name="WatchState" \
    io.hass.description="Self-hosted service to sync Plex, Jellyfin and Emby play state" \
    io.hass.arch="amd64|aarch64" \
    io.hass.type="addon" \
    io.hass.version="1.0.2" \
    maintainer="Stainy3244"

ENTRYPOINT ["/run.sh"]
