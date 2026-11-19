# OpenCTI platform (web UI, GraphQL API, background managers) for the OpenCTI Railway template.
# Official image, pinned by version and digest.
FROM opencti/platform:7.261119.0@sha256:26a4d10501acd962939fc93c0cef236fcdd511a48fa283885acf7393bed7cc1e

# The image defaults to a 12 GB V8 heap; 4 GB fits a normal Railway service. Raise it
# together with the service's memory if your knowledge base grows.
ENV NODE_OPTIONS="--max-old-space-size=4096"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-deps.mjs /opt/railway/wait-deps.mjs
ENTRYPOINT ["/sbin/tini", "--", "/opt/railway/start.sh"]
