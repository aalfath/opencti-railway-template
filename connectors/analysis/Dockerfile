# OpenCTI Railway template. Connector: content analysis of PDF, text and HTML reports.
# Official image, pinned by version and digest. Settings below match OpenCTI's docker-compose;
# a Railway variable with the same name overrides them.
FROM opencti/connector-import-document:7.261119.0@sha256:230f11dfac7f6913ee6f8143ec0c9df33bf805dd279dc9c49ce027864b2f2305

ENV CONNECTOR_TYPE="INTERNAL_ANALYSIS"
ENV CONNECTOR_NAME="ImportDocumentAnalysis"
ENV CONNECTOR_VALIDATE_BEFORE_IMPORT="false"
ENV CONNECTOR_SCOPE="application/pdf,text/plain,text/html"
ENV CONNECTOR_AUTO="true"
ENV CONNECTOR_ONLY_CONTEXTUAL="false"

COPY --chmod=0755 start.sh /opt/railway/start.sh
COPY --chmod=0644 wait-opencti.py /opt/railway/wait-opencti.py
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["python3", "main.py"]
