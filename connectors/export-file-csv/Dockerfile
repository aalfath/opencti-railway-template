# OpenCTI Railway template. Connector: exports to CSV files.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-export-file-csv:7.261119.0@sha256:2c1a7ef45277ea1d2f1c1d63dd21fd08093c4c1552ee16b2107a7fc9fd8b6425

ENV CONNECTOR_TYPE="INTERNAL_EXPORT_FILE"
ENV CONNECTOR_NAME="ExportFileCsv"
ENV CONNECTOR_SCOPE="text/csv"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["/entrypoint.sh"]
