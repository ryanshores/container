# This image installs development tools and enables PostgreSQL/Redis for boot.
# Services are not started during image build; OpenRC starts them inside each VM.
FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    git \
    openssh-client \
    python3 \
    py3-pip \
    postgresql-client \
    redis \
    postgresql \
    dbus \
    openrc

RUN install -d -o postgres -g postgres /var/lib/postgresql/data && \
    su postgres -c "initdb -D /var/lib/postgresql/data" && \
    rc-update add postgresql default && \
    rc-update add redis default && \
    rm -f /etc/machine-id /var/lib/dbus/machine-id && \
    touch /etc/machine-id && \
    mkdir -p /var/lib/dbus && \
    ln -sf /etc/machine-id /var/lib/dbus/machine-id && \
    mkdir -p /etc/local.d && \
    printf '%s\n' \
      '#!/bin/sh' \
      'if [ ! -s /etc/machine-id ]; then' \
      '  dbus-uuidgen > /etc/machine-id' \
      'fi' \
      'mkdir -p /var/lib/dbus' \
      'ln -sf /etc/machine-id /var/lib/dbus/machine-id' \
      > /etc/local.d/machine-id.start && \
    chmod +x /etc/local.d/machine-id.start && \
    rc-update add local default

EXPOSE 5432 6379

CMD ["/sbin/init"]
