#!/bin/sh
# Start script for Silo (S3 API) on Railway: data on the volume at /data, S3 API on PORT (9000).
set -e
if [ -z "$MINIO_ROOT_USER" ] || [ -z "$MINIO_ROOT_PASSWORD" ]; then
  echo "railway-template: MINIO_ROOT_USER and MINIO_ROOT_PASSWORD must be set" >&2
  exit 1
fi
rm -rf /data/lost+found
export MINIO_BROWSER="${MINIO_BROWSER:-off}"
exec /usr/bin/docker-entrypoint.sh silo server /data --address ":${PORT:-9000}" --console-address ":9001"
