# OpenCTI Railway template. Connector: exports to STIX 2.1 files.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-export-file-stix:7.261119.0@sha256:7d8f032cbb98896f7bbd9e910b8d4bb6890ae5310fec3afa7fc9f758e397a571

ENV CONNECTOR_TYPE="INTERNAL_EXPORT_FILE"
ENV CONNECTOR_NAME="ExportFileStix2"
ENV CONNECTOR_SCOPE="application/json"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python3", "export-file-stix.py"]
