FROM ghcr.io/dispatcharr/dispatcharr:latest

# Re-declare the argument AFTER the FROM line so the build layer can capture it
ARG BUILD_VERSION

# jq is already available in the base image, but ensure it's present
RUN apk add --no-cache jq 2>/dev/null || true

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

LABEL \
  io.hass.name="Dispatcharr" \
  io.hass.description="IPTV & stream management with configurable shared storage" \
  io.hass.arch="amd64|aarch64" \
  io.hass.type="addon" \
  io.hass.version="${BUILD_VERSION}" \
  maintainer="Stainy3244"

ENTRYPOINT ["/run.sh"]
