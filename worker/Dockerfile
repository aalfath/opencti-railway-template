# OpenCTI Railway template. Worker: imports queued STIX bundles into the knowledge graph.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/worker:7.261119.0@sha256:6bebc316275d93157025e4a99d7451b008ec832a859e1331cceffb6c2412da46

ENV WORKER_LOG_LEVEL="info"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python3", "worker.py"]
