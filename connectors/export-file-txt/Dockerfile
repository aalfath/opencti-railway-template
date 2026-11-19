# OpenCTI Railway template. Connector: exports to plain-text files.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-export-file-txt:7.261119.0@sha256:7be7ff4c4686c9ebafefdfdefbf2689075206690dbd7f97d0a8d828e6da1af09

ENV CONNECTOR_TYPE="INTERNAL_EXPORT_FILE"
ENV CONNECTOR_NAME="ExportFileTxt"
ENV CONNECTOR_SCOPE="text/plain"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python3", "export-file-txt.py"]
