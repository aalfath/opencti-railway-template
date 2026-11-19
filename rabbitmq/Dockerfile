# RabbitMQ for the OpenCTI Railway template (work queues between the platform, workers and connectors).
# Official image with the management plugin (OpenCTI reads queue stats from its API), pinned by version and digest.
FROM rabbitmq:4.3.8-management@sha256:f86495bb946ec52c4fa1a115ac88c31c9b999b453f3da3835f6efa25f3578a02

COPY --chmod=0644 rabbitmq.conf /etc/rabbitmq/conf.d/90-opencti-railway.conf
COPY --chmod=0755 start.sh /usr/local/bin/railway-start.sh
ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
