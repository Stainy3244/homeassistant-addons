FROM ghcr.io/pharaoh-labs/teamarr:latest

COPY run.sh /run.sh

RUN chmod +x /run.sh

ARG BUILD_VERSION

LABEL \
    io.hass.name="Teamarr" \
    io.hass.description="Sports channel and EPG management for Dispatcharr" \
    io.hass.arch="amd64|aarch64" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}"

ENTRYPOINT ["/run.sh"]
