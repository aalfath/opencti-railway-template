# OpenCTI Railway template. Connector: imports YARA rules.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-import-file-yara:7.261119.0@sha256:e45c9bd77403ed914af73b9ab6a6aa9fb65c64fa1d1b3ece62eecf5733e8f633

ENV CONNECTOR_NAME="ImportFileYARA"
ENV CONNECTOR_VALIDATE_BEFORE_IMPORT="true"
ENV CONNECTOR_SCOPE="text/yara+plain"
ENV CONNECTOR_AUTO="false"
ENV YARA_IMPORT_FILE_SPLIT_RULES="true"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["/entrypoint.sh"]
