# OpenCTI Railway template. Connector: fetches external reference URLs as files.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-import-external-reference:7.261119.0@sha256:847e5109c9eb6c6ae6f53e970688bee292d59273b5e777445ac74fff4e9cfb89

ENV CONNECTOR_NAME="ImportExternalReference"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["/entrypoint.sh"]
