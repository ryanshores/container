# Apple Container Machine Images

Custom Containerfiles for development machine images with Apple's [`container`](https://github.com/apple/container) CLI. Build images with `container build`; manage booted machines with `container machine <command>`.

## Base Images

| Image | File | Purpose |
| --- | --- | --- |
| `local/alpine-base:latest` | `machine/alpine/Containerfile` | Small Alpine machine with shell, Git, curl, SSH client, and OpenRC. |
| `local/alpine-dev:latest` | `machine/alpine/dev.Containerfile` | General development image with compilers, Python, Node.js, Go, editors, and CLI utilities. |

## Stack Images

Stack image files live in `machine/alpine/stacks/` and use descriptive names instead of acronyms. Each stack registers its services in the OpenRC `default` runlevel so they start when the machine boots with `/sbin/init`.

| Image | Services |
| --- | --- |
| `local/alpine-python-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-node-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-go-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-rust-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-ruby-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-java-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-dotnet-postgres-redis:latest` | PostgreSQL, Redis |
| `local/alpine-php-nginx-mariadb-redis:latest` | Nginx, PHP-FPM, MariaDB, Redis |
| `local/alpine-python-rabbitmq-postgres-redis:latest` | RabbitMQ, PostgreSQL, Redis |
| `local/alpine-node-rabbitmq-postgres-redis:latest` | RabbitMQ, PostgreSQL, Redis |

## Build

Start Apple Container services, then build images from the repository root:

```sh
sh scripts/build-stacks.sh
```

## Run

These files produce machine images. Use the Apple Container machine namespace to create, start, stop, inspect, and remove machines:

```sh
container machine --help
container machine <command>
```

For fast image-only smoke checks, override the image command with a one-shot shell:

```sh
container run --rm -it local/alpine-dev:latest /bin/zsh
```

Images do not create a hardcoded development user. Use the user/session behavior provided by Apple Container machines, or run as root when the image needs `/sbin/init` and OpenRC.

Smoke-check service registration without starting long-running services:

```sh
container run --rm local/alpine-python-postgres-redis:latest /bin/bash -lc 'postgres --version; redis-server --version; rc-update show'
```

Use `/workspace` as the working directory for project files.
