FROM ghcr.io/dispatcharr/dispatcharr:latest

# jq is already available in the base image, but ensure it's present
RUN apk add --no-cache jq 2>/dev/null || true

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Labels for Home Assistant
LABEL \
    io.hass.name="Dispatcharr" \
    io.hass.description="IPTV & stream management with configurable shared storage" \
    io.hass.arch="amd64|aarch64" \
    io.hass.type="addon" \
    io.hass.version="0.19.0" \
    maintainer="Stainy3244"

ENTRYPOINT ["/run.sh"]
