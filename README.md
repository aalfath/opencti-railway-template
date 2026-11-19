[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/opencti?utm_medium=integration&utm_source=button&utm_campaign=opencti)

# OpenCTI on Railway

A one-click [Railway](https://railway.com) template for [OpenCTI](https://github.com/OpenCTI-Platform/opencti), the open-source cyber threat intelligence platform by Filigran, with the full stack it needs.

**Version:** OpenCTI 7.261119.0. Every image is official and pinned by version and digest in the `FROM` line of its folder's `Dockerfile`.

## What it deploys

| Service | Folder | Image | Volume | What it does |
|---|---|---|---|---|
| OpenCTI | `platform/` | `opencti/platform:7.261119.0` | none | Web UI and GraphQL API (public, port 8080); health check relay on `PORT` 8081 |
| Worker | `worker/` | `opencti/worker:7.261119.0` | none | Writes queued data into the platform |
| Elasticsearch | `elasticsearch/` | `elasticsearch:8.19.25` | `/usr/share/elasticsearch/data` | Knowledge graph store |
| RabbitMQ | `rabbitmq/` | `rabbitmq:4.3.8-management` | `/var/lib/rabbitmq` | Work queues |
| Silo | `silo/` | `pgsty/silo:RELEASE.2026-11-12T00-00-00Z` | `/data` | S3-compatible file storage (as in upstream's docker-compose) |
| Redis | (Railway Redis) | `redis:8.2` | `/data` | Cache, locks, event stream |
| 10 connectors | `connectors/<name>/` | `opencti/connector-*:7.261119.0` | none | Export STIX/CSV/TXT, Import STIX/Document/YARA, Document Analysis, External Reference, OpenCTI Datasets, MITRE ATT&CK |

Services find each other over Railway's private network through reference variables. The platform waits for Elasticsearch, RabbitMQ, Redis and Silo before it starts; the worker and connectors wait for the platform's health endpoint.

## Variables

All secrets are generated at deploy; the deploy form asks for nothing.

* **OpenCTI:** `APP__ADMIN__EMAIL` (default `admin@opencti.io`), `APP__ADMIN__PASSWORD`, `APP__ADMIN__TOKEN` (UUID), `APP__ENCRYPTION_KEY`, `APP__HEALTH_ACCESS_KEY` (all generated), `APP__BASE_URL` (the public domain), plus references to Elasticsearch, Redis, RabbitMQ and Silo.
* **Elasticsearch:** `ELASTIC_PASSWORD` (generated), `ES_JAVA_OPTS` (`-Xms2g -Xmx2g`).
* **RabbitMQ:** `RABBITMQ_DEFAULT_USER`, `RABBITMQ_DEFAULT_PASS` (generated).
* **Silo:** `MINIO_ROOT_USER`, `MINIO_ROOT_PASSWORD` (generated).
* **Worker and connectors:** `OPENCTI_URL`, `OPENCTI_TOKEN`, `OPENCTI_HEALTH_ACCESS_KEY`, all referenced from the OpenCTI service. Each connector's `CONNECTOR_ID` defaults to its Railway service ID.

Sign in as `APP__ADMIN__EMAIL` with `APP__ADMIN__PASSWORD` from the OpenCTI service's Variables tab. The first start takes 5 to 10 minutes.

## Updates

Every service except Redis builds from this repo's `main` branch. When we bump the pinned versions, Railway shows an "update available" notice on your project and you choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first: OpenCTI migrates its data on start and can't be downgraded.

## Not included

From upstream's docker-compose this leaves out:

* **XTM Composer** and its `rsa-key-generator`: it starts connectors through the Docker socket or Kubernetes, which Railway services can't use. Connectors here are plain Railway services instead.
* **XTM One** and its Postgres: Filigran's optional AI assistant, which needs your own LLM API key.

Add any connector from the [OpenCTI connector catalog](https://github.com/OpenCTI-Platform/connectors) as an extra service with `OPENCTI_URL`, `OPENCTI_TOKEN` and its own `CONNECTOR_ID`.
