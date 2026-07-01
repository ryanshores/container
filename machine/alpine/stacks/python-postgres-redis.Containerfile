# Python application machine with PostgreSQL and Redis.
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
    redis \
    tzdata && \
    mkdir -p /workspace && \
    install -d -o postgres -g postgres /var/lib/postgresql/data && \
    su postgres -c "initdb -D /var/lib/postgresql/data" && \
    rc-update add postgresql default && \
    rc-update add redis default

EXPOSE 5432 6379

WORKDIR /workspace

CMD ["/sbin/init"]
