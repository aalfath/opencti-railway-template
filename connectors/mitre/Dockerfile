# OpenCTI Railway template. Connector: loads MITRE ATT&CK.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-mitre:7.261119.0@sha256:a1c6338413970cbb6bccfd09744198c598a4a83a7d0a908a9d9cf10307276508

ENV CONNECTOR_AUTO_CREATE_SERVICE_ACCOUNT="true"
ENV CONNECTOR_AUTO_CREATE_SERVICE_ACCOUNT_CONFIDENCE_LEVEL="75"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python", "-m", "src"]
