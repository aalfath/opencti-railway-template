#!/bin/sh
# Start script for an OpenCTI worker or connector on Railway: default CONNECTOR_ID to
# this Railway service's ID (a stable UUIDv4), wait for the platform, then run the image's
# own command.
set -e
if [ -z "${CONNECTOR_ID:-}" ] && [ -n "${RAILWAY_SERVICE_ID:-}" ]; then
  export CONNECTOR_ID="$RAILWAY_SERVICE_ID"
fi
PY=$(command -v python3 || command -v python)
"$PY" /opt/railway/wait-opencti.py
exec "$@"
