# Python worker/API machine with RabbitMQ, PostgreSQL, and Redis.
FROM alpine:latest

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    openrc \
    openssh-client \
    postgresql \
    postgresql-client \
    py3-pip \
    python3 \
    rabbitmq-server \
    redis \
    tzdata && \
    mkdir -p /workspace && \
    install -d -o postgres -g postgres /var/lib/postgresql/data && \
    su postgres -c "initdb -D /var/lib/postgresql/data" && \
    rc-update add postgresql default && \
    rc-update add rabbitmq-server default && \
    rc-update add redis default

EXPOSE 5432 5672 6379 15672

WORKDIR /workspace

CMD ["/sbin/init"]
