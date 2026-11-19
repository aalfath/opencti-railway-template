# OpenCTI Railway template. Connector: imports STIX 2.1 JSON and XML files.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-import-file-stix:7.261119.0@sha256:5f48d95b2470b22ee16a90a5c8f31089ab4eb3db6d04a209a0071131b17ac474

ENV CONNECTOR_TYPE="INTERNAL_IMPORT_FILE"
ENV CONNECTOR_NAME="ImportFileStix"
ENV CONNECTOR_VALIDATE_BEFORE_IMPORT="true"
ENV CONNECTOR_SCOPE="application/json,text/xml"
ENV CONNECTOR_AUTO="true"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python3", "main.py"]
