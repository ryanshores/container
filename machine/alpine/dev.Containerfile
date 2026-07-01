# General-purpose Alpine development image for Apple Container.
FROM alpine:latest

RUN apk add --no-cache \
    bash \
    build-base \
    ca-certificates \
    cmake \
    curl \
    git \
    go \
    jq \
    make \
    nano \
    nodejs \
    npm \
    openssh-client \
    openrc \
    pkgconf \
    py3-pip \
    python3 \
    ripgrep \
    tzdata \
    vim \
    zsh && \
    mkdir -p /workspace

WORKDIR /workspace

CMD ["/sbin/init"]
