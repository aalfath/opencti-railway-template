# OpenCTI Railway template. Connector: loads OpenCTI's reference datasets (sectors, countries, markings).
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-opencti:7.261119.0@sha256:b14e0edb17a3a92958ba9789e15f2212e999fdaf5077805d39d2c2105c89edb0

ENV CONNECTOR_NAME="OpenCTI Datasets"
ENV CONNECTOR_SCOPE="marking-definition,identity,location"
ENV CONNECTOR_AUTO_CREATE_SERVICE_ACCOUNT="true"
ENV CONNECTOR_AUTO_CREATE_SERVICE_ACCOUNT_CONFIDENCE_LEVEL="100"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python", "main.py"]
