#!/bin/sh
# Start script for the OpenCTI platform on Railway: fixed settings, a check of the
# generated secrets, a wait for Elasticsearch, RabbitMQ, Redis and S3, then OpenCTI.
set -e

export APP__PORT="${PORT:-8080}"
export APP__ADMIN__EMAIL="${APP__ADMIN__EMAIL:-admin@opencti.io}"
export APP__APP_LOGS__LOGS_FILES="${APP__APP_LOGS__LOGS_FILES:-false}"
export APP__AUDIT_LOGS__LOGS_FILES="${APP__AUDIT_LOGS__LOGS_FILES:-false}"
export PROVIDERS__LOCAL__STRATEGY="${PROVIDERS__LOCAL__STRATEGY:-LocalStrategy}"
export ELASTICSEARCH__USERNAME="${ELASTICSEARCH__USERNAME:-elastic}"
export ELASTICSEARCH__NUMBER_OF_REPLICAS="${ELASTICSEARCH__NUMBER_OF_REPLICAS:-0}"
export MINIO__PORT="${MINIO__PORT:-9000}"
export MINIO__USE_SSL="${MINIO__USE_SSL:-false}"
export MINIO__BUCKET_NAME="${MINIO__BUCKET_NAME:-opencti-bucket}"
export RABBITMQ__PORT="${RABBITMQ__PORT:-5672}"
export RABBITMQ__PORT_MANAGEMENT="${RABBITMQ__PORT_MANAGEMENT:-15672}"
export RABBITMQ__MANAGEMENT_SSL="${RABBITMQ__MANAGEMENT_SSL:-false}"
export REDIS__PORT="${REDIS__PORT:-6379}"
# 0 = use whatever address family Railway's private DNS returns (IPv4 or IPv6).
export REDIS__HOST_IP_FAMILY="${REDIS__HOST_IP_FAMILY:-0}"

missing=""
for v in APP__BASE_URL APP__ADMIN__PASSWORD APP__ADMIN__TOKEN APP__ENCRYPTION_KEY APP__HEALTH_ACCESS_KEY \
         ELASTICSEARCH__URL ELASTICSEARCH__PASSWORD REDIS__HOSTNAME MINIO__ENDPOINT MINIO__ACCESS_KEY \
         MINIO__SECRET_KEY RABBITMQ__HOSTNAME RABBITMQ__USERNAME RABBITMQ__PASSWORD; do
  eval "val=\${$v:-}"
  [ -n "$val" ] || missing="$missing $v"
done
if [ -n "$missing" ]; then
  echo "railway-template: missing variables:$missing" >&2
  exit 1
fi

echo "railway-template: OpenCTI on port $APP__PORT, base URL $APP__BASE_URL"
node /opt/railway/wait-deps.mjs
cd /opt/opencti
exec node build/back.mjs
