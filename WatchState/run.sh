#!/usr/bin/with-contenv bashio

# Get configuration options
UID=$(bashio::config 'UID')
GID=$(bashio::config 'GID')

bashio::log.info "Starting WatchState..."
bashio::log.info "Running as UID: ${UID}, GID: ${GID}"

# Set the user and group
export PUID=${UID}
export PGID=${GID}

# Start WatchState
exec /usr/bin/php /app/console.php system:start
