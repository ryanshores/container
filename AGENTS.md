# Repository Guidelines

## Project Structure & Module Organization

This repository stores machine image definitions for Apple Container (`apple/container`). Source files live under `machine/`, grouped by base distribution.

- `machine/alpine/Containerfile`: minimal Alpine image with shell, Git, curl, SSH client tools, and OpenRC.
- `machine/alpine/dev.Containerfile`: general development image with compilers, Python, Node.js, Go, editors, and CLI utilities.
- `machine/alpine/stacks/*.Containerfile`: named service stacks such as `python-postgres-redis.Containerfile`.

There are no application source, test, or asset directories yet. Keep new definitions in distribution-specific folders such as `machine/debian/`.

## Build, Test, and Development Commands

Use Apple Container from the repository root. Start its service before building or running images:

```sh
container system start
sh scripts/build-stacks.sh
```

Manage booted machines with the Apple Container machine namespace:

```sh
container machine --help
container machine <command>
```

Use `container run` only for fast image smoke checks:

```sh
container run --rm -it local/alpine-base:latest /bin/bash
container run --rm -it local/alpine-dev:latest /bin/zsh
```

For service stacks, verify service registration with `rc-update show`.

## Coding Style & Naming Conventions

Use `Containerfile` for the base image, `<purpose>.Containerfile` for variants, and descriptive stack names like `node-postgres-redis.Containerfile`. Apple Container builds Dockerfile/Containerfile-style definitions; keep them OCI-compatible unless a change is intentionally Apple Container-specific. Keep Alpine packages one per line and use `apk add --no-cache`. Add comments only for boot-time behavior or non-obvious setup.

## Testing Guidelines

There is no automated test suite. Treat successful `container build` runs as the baseline check. For service images, include a smoke check in the pull request description, such as `rc-update show`, `postgres --version`, or `redis-server --version`. Clean up detached tests with `container stop <name>`.

## Commit & Pull Request Guidelines

The Git history only contains an initial commit, so no detailed convention is established. Use short, imperative commit messages such as `Add Alpine Redis image` or `Update PostgreSQL boot setup`.

Pull requests should describe the image change, list affected files, include Apple Container build or smoke-test output, and call out exposed ports, default commands, or service startup changes. Link related issues when available.

## Security & Configuration Tips

Do not commit credentials, private keys, or host-specific configuration. Avoid secrets in `ENV`; prefer runtime injection with `container run --env` or `--env-file`. Keep exposed ports explicit. Do not add hardcoded interactive users unless an image requires a stable UID/GID contract.
