#!/bin/sh
# Start script for RabbitMQ on Railway.
set -e
if [ -z "$RABBITMQ_DEFAULT_USER" ] || [ -z "$RABBITMQ_DEFAULT_PASS" ]; then
  echo "railway-template: RABBITMQ_DEFAULT_USER and RABBITMQ_DEFAULT_PASS must be set" >&2
  exit 1
fi
# A fixed node name keeps the same data directory across redeploys (the container's
# hostname changes on every deploy).
export RABBITMQ_NODENAME="${RABBITMQ_NODENAME:-rabbit01@localhost}"
DATA=/var/lib/rabbitmq
rm -rf "$DATA/lost+found"
if [ "$(id -u)" = "0" ]; then
  chown -R rabbitmq:rabbitmq "$DATA"
fi
exec docker-entrypoint.sh rabbitmq-server
