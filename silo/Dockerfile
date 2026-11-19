# S3-compatible object storage for the OpenCTI Railway template (uploaded reports, imports, exports).
# Silo is the MinIO fork that OpenCTI's own docker-compose uses. Pinned by release tag and digest.
FROM pgsty/silo:RELEASE.2026-11-12T00-00-00Z@sha256:c20d112390b9a9ce8c11b8af95ad35bcaa62f4759663c09c936cd8d2b511f329

COPY --chmod=0755 start.sh /usr/local/bin/railway-start.sh
ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
