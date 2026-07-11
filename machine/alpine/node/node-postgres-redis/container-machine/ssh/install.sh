#!/bin/sh
set -eu

if ! command -v apk >/dev/null 2>&1 || ! command -v rc-update >/dev/null 2>&1; then
    echo "This SSH installer currently supports Alpine Linux with OpenRC." >&2
    exit 1
fi

# The parent image may already contain these packages. apk is idempotent.
apk add --no-cache openssh-server shadow >/dev/null

install -d -m 0755 /usr/local/bin
install -d -m 0755 /etc/ssh/sshd_config.d
install -d -m 0755 /etc/init.d
install -d -m 0755 /etc/conf.d

install -m 0755 \
    /opt/container-machine/ssh/macos-authorized-keys \
    /usr/local/bin/macos-authorized-keys

install -m 0755 \
    /opt/container-machine/ssh/prepare-apple-container-user \
    /usr/local/bin/prepare-apple-container-user

install -m 0755 \
    /opt/container-machine/ssh/prepare-apple-container-user.openrc \
    /etc/init.d/prepare-apple-container-user

install -m 0644 \
    /opt/container-machine/ssh/sshd_config.d/50-apple-container.conf \
    /etc/ssh/sshd_config.d/50-apple-container.conf

# OpenRC sources this file before launching sshd. Preserve values supplied by
# the machine environment and default only the public-key filename.
cat > /etc/conf.d/sshd <<'CONF'
SSH_KEY_NAME="${SSH_KEY_NAME:-id_ed25519}"
SSH_HOST_USER="${SSH_HOST_USER:-}"
SSH_HOST_HOME="${SSH_HOST_HOME:-}"
export SSH_KEY_NAME
export SSH_HOST_USER
export SSH_HOST_HOME
CONF

rc-update add prepare-apple-container-user default
rc-update add sshd default
