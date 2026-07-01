# PHP web machine with Nginx, MariaDB, PHP-FPM, and Redis.
FROM alpine:latest

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    mariadb \
    mariadb-client \
    nginx \
    openrc \
    openssh-client \
    php84 \
    php84-fpm \
    php84-pdo_mysql \
    php84-pecl-redis \
    redis \
    tzdata && \
    mkdir -p /workspace /run/nginx && \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql && \
    rc-update add mariadb default && \
    rc-update add nginx default && \
    rc-update add php-fpm84 default && \
    rc-update add redis default

EXPOSE 80 3306 6379

WORKDIR /workspace

CMD ["/sbin/init"]
