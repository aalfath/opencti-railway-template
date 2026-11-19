# Elasticsearch 8 for the OpenCTI Railway template (OpenCTI stores its knowledge graph here).
# Official image, pinned by version and digest (same build as docker.elastic.co/elasticsearch/elasticsearch:8.19.25).
FROM elasticsearch:8.19.25@sha256:ef44866274bd7cb2c644f4f6657ce0832819f662adb66b2769d0ba5dabad77d6

# Railway volumes are owned by root. The start script runs as root only to fix the
# volume's ownership, then runs Elasticsearch as its normal user (uid 1000).
USER 0
COPY --chmod=0755 start.sh /usr/local/bin/railway-start.sh
ENTRYPOINT ["/bin/tini", "-s", "--", "/usr/local/bin/railway-start.sh"]
